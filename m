Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B97F475A05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbhLONzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhLONzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:55:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A4C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a013eJX1aHtsqswhayydKikJ5V9/pgFksAiCn8UNcqg=; b=HXsoY3erz1u5qJvYJzxMOoLb50
        k76ad25a8Hv7gm+b8J7PS3w5muOIIuFR6IPB+rknQMpp650BvH6phl0c2sLSDnHk6rG82QS4yO7uk
        +yczrPEsFzvkZeI6JPTRgIL8ibL39mJ4qgexFOKesT9Rn5iY67GEbYQm+CxrM5ANPlIJfV+zlNBMS
        qHUGCkHVitvQ9/8F+8Z8IHuP67e81UR79iUDtjKAigfBdI/19yyyvCQOmxwMCFandPrHw36ZjG6BI
        f7DwHlDahpjULAKLrmDKJ/rPbbJjgGBhGeGnaJd8jSc5mkJlI7nn0tl5hVCAkOI2AgaZPmK98DunU
        CN7JPeJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxUkp-00EhGu-An; Wed, 15 Dec 2021 13:55:35 +0000
Date:   Wed, 15 Dec 2021 13:55:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, surenb@google.com,
        vbabka@suse.cz, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: elevate page refcount while isolating in
 process_madvise()
Message-ID: <Ybnz1+Ljn38cZAlA@casper.infradead.org>
References: <1639571019-30043-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639571019-30043-1-git-send-email-quic_charante@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 05:53:39PM +0530, Charan Teja Reddy wrote:
> The documentation of isolate_lru_page() says that, "it must be called
> with an elevated refcount on the page", which is not followed while
> isolating pages in process_madvise() system call with advise
> MADV_PAGEOUT. Fix it.

We hold the mmap_lock over the call to this function, so the reference
to the page from the page tables cannot go away.  There's no need to
grab an extra reference here.

