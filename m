Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54548C4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353552AbiALNTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353591AbiALNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:19:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2C7C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wuLuorQddbjw7aEhgglMwfq2kolodZvhyU9YfeKEDlw=; b=aVYltdtWanBX6X8xSwk6SPyle3
        tlRiwa4UDEYoJHfluSKWkVweUGxDuhE+dCOczq0y//Kp8VGoZm4Yze+w31skTMOQX0SHpZpZe82Yo
        8O4T9/Euk1DD/Vn85fkHquBSFUJMZzZ9ifRSeAODHScHfZswB4OfSGS9U/V8bPbME/llCAPQiuDNC
        MzsfROrKwgPHWlUlVuFjbb9PsY70Nj3RuwkNk1gj2nUT1zSrB/0CvW5kLBjfdcqjDMFTeimcXE/NR
        yy660pYl4GRxkt0hgMSt7wyLaOjn6ipXwaIUIijHp/kOl7JdDdsTSXKpxTeiyHL0kSV2BeKqECfhg
        6YEqloKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7dXI-0047p3-5B; Wed, 12 Jan 2022 13:19:32 +0000
Date:   Wed, 12 Jan 2022 13:19:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Mark Hemment <markhemm@googlemail.com>, hughd@google.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com, surenb@google.com,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement
 POSIX_FADV_[WILL|DONT]NEED for shmem
Message-ID: <Yd7VZId4IlKd4VpC@casper.infradead.org>
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UipVZRZeWqzXezacPaVb9UeC6a_ZhQp8GkrvftbRktotg@mail.gmail.com>
 <2c66ba2e-1c65-3bdd-b91e-eb8391ec6dbf@quicinc.com>
 <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:51:55PM +0530, Charan Teja Kalla wrote:
> >>> +       rcu_read_lock();
> >>> +       xas_for_each(&xas, page, end) {
> >>> +               if (!xa_is_value(page))
> >>> +                       continue;
> >>> +               xas_pause(&xas);
> >>> +               rcu_read_unlock();
> >>> +
> >>> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
> >>> +               if (!IS_ERR(page))
> >>> +                       put_page(page);
> >>> +
> >>> +               rcu_read_lock();
> >>> +               if (need_resched()) {
> >>> +                       xas_pause(&xas);
> >>> +                       cond_resched_rcu();
> >>> +               }
> >>> +       }
> >>> +       rcu_read_unlock();
> > Even the xarray documentation says that: If most entries found during a
> > walk require you to call xas_pause(), the xa_for_each() iterator may be
> > more appropriate.

Yes.  This should obviously be an xa_for_each() loop.

> > Since every value entry found in the xarray requires me to do the
> > xas_pause(), I do agree that xa_for_each() is the appropriate call here.
> > Will switch to this in the next spin. Waiting for further review
> > comments on this patch.
> 
> I also found the below documentation:
> xa_for_each() will spin if it hits a retry entry; if you intend to see
> retry entries, you should use the xas_for_each() iterator instead.
> 
> Since retry entries are expected, I should be using the xas_for_each()
> with the corrections you had pointed out. Isn't it?

No.  You aren't handling retry entries at all; you clearly don't
expect to see them.  Just let the XArray code handle them itself.
