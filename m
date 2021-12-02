Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773F2466750
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359272AbhLBP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359268AbhLBP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:57:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C2C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nISvdc0rk0mqJv1dMg3hZ3+TKFJZuCZ9z2wVt5ec1Mc=; b=l5NqpvD2VQ7QdSqyI6T+fY/p2S
        0WDKb5SwGMMHCgZQiIkKFWlORVOOzry/QUBLcsxS0HFvGRw7uXcrY1i3Ylkkvjvv+GyZzQnh/jn9J
        UKbvN+1ZOkOloWQr0zyEDCFuqXp0DZLSZj8gfi7jSYPu+f4Pc488AqaCIERUKG643OI59st5b81Gn
        i18Iz5JVCy+IpkyBXNm0eHQnDt0UFFjTM1bOZryaiUlIoWQPJapnOC1boBM1+G/3ydWv+ZgmLaJll
        qy+s8o4IaW1YVDVKVnrc4x2vmfyGlz13jRhLDn6uleIFV0JS0BHOzvCRo/hLYOv0DLUT4mAUEgXdX
        cXz05Row==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msoPV-004aWo-Dj; Thu, 02 Dec 2021 15:54:13 +0000
Date:   Thu, 2 Dec 2021 15:54:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     Charan Teja Reddy <quic_charante@quicinc.com>, hughd@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        david@redhat.com, mhocko@suse.com, surenb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
Message-ID: <YajsJSejHlx8n11U@casper.infradead.org>
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
 <YajJqY2ByC8uwa46@casper.infradead.org>
 <a88a3708-cdb6-589c-5828-0a4721c683d7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88a3708-cdb6-589c-5828-0a4721c683d7@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:59:52PM +0530, Charan Teja Kalla wrote:
> > What part of the XArray documentation led you to believe that this is a
> > safe thing to do?  Because it needs to be rewritten immediately!
> 
> The above code changes made from my understanding of both the
> Documentation and the implementation of xa_for_each(). The Locking
> section of the document[1] says that xa_for_each() takes the rcu lock
> thus can be used without any explicit locking and the "Advanced API"
> section says that users need to take xa_lock/rcu lock as no locking done
> for you.
> 
> Further I have looked at the xa_for_each() implementation details,
> where, it is taking the rcu_lock just across xas_find() in both
> xa_find() and xa_find_after() which made me to think that it just needs
> to take the rcu lock just across the xas_find().
> 
> But a comment from you saying that this implementation is wrong making
> me to think that I lack very trivial understanding about xarray usage.

Would this change to the documentation have prevented you from making
this mistake?

 The advanced API is based around the xa_state.  This is an opaque data
 structure which you declare on the stack using the XA_STATE()
 macro.  This macro initialises the xa_state ready to start walking
 around the XArray.  It is used as a cursor to maintain the position
 in the XArray and let you compose various operations together without
-having to restart from the top every time.
+having to restart from the top every time.  The contents of the xa_state
+are protected by the rcu_read_lock() or the xas_lock().  If you need to
+drop whichever of those locks is protecting your state and tree, you must
+call xas_pause() so that future calls do not rely on the parts of the
+state which were left unprotected.


