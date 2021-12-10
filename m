Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7B470CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbhLJVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhLJVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:40:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A03C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r1GOSqF9LX3YAa7tf5XoV1Dfily/re1QRyoWvPyqJ4s=; b=EWi/cCEc8iqOeu3vDyYPmNnOiW
        U5OPCyLe4kqUZfNOKxGP33iIzq+B+64pFZxJ8EovPawYqDFqgMVJ/KPgQnS1ykluiqHVUWvFXFrzd
        opabBqWqYfHw/KAc5LGWLycgw4NjkYzWU7xZB9JEtrGhPNkPNC1LPkgtR+0WbzezNU00j6doHOteH
        TJBNnDBYa35Sqerr8LMlKBYknUrq8eny4/e30nHDYbCh1LSnFIihEen6rLwUa0TOrncDn5WdNTrKv
        65RUsHh3AJSUrL9d5LLrqZQR3wMa5pjn3+Y/uG3KtpOPYWF7lQ9KRHbBqH3bzQ5SVZp3UdG2ueAsH
        t0uhjq4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvnZB-000cwL-Az; Fri, 10 Dec 2021 21:36:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCFF73002C5;
        Fri, 10 Dec 2021 22:36:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD2592C555170; Fri, 10 Dec 2021 22:36:32 +0100 (CET)
Date:   Fri, 10 Dec 2021 22:36:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Manjong Lee <mj0123.lee@samsung.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, nanich.lee@samsung.com,
        yt0928.kim@samsung.com, junho89.kim@samsung.com,
        jisoo2146.oh@samsung.com
Subject: Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi unregister
Message-ID: <YbPIYBsbpO7154id@hirez.programming.kicks-ass.net>
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
 <20211021161942.5983-1-mj0123.lee@samsung.com>
 <YXFMJJ3u+x34iNy0@infradead.org>
 <YXFWmo9v65kJWVWC@casper.infradead.org>
 <20211021194530.1fabf4fa45cfe3bee6598484@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021194530.1fabf4fa45cfe3bee6598484@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:45:30PM -0700, Andrew Morton wrote:
> On Thu, 21 Oct 2021 13:01:30 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Oct 21, 2021 at 04:16:52AM -0700, Christoph Hellwig wrote:
> > > On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
> > > > Because when sdcard is removed, bdi_min_ratio value will remain.
> > > > Currently, the only way to reset bdi_ min_ratio is to reboot.
> > > 
> > > But bdis that are unregistered are never re-registered.  What is
> > > the problem you're trying to solve?
> > 
> > The global bdi_min_ratio needs to be adjusted.  See
> > bdi_set_min_ratio() in mm/page-writeback.c.
> 
> I added cc:stable to this and tweaked the comment & coding style a bit:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> --- a/mm/backing-dev.c~mm-bdi-initialize-bdi_min_ratio-when-bdi-unregister-fix
> +++ a/mm/backing-dev.c
> @@ -947,10 +947,12 @@ void bdi_unregister(struct backing_dev_i
>  	wb_shutdown(&bdi->wb);
>  	cgwb_bdi_unregister(bdi);
>  
> -	/* if min ratio doesn't 0, it has to set 0 before unregister */
> -	if (bdi->min_ratio) {
> +	/*
> +	 * If this BDI's min ratio has been set, use bdi_set_min_ratio() to
> +	 * update the global bdi_min_ratio.
> +	 */
> +	if (bdi->min_ratio)
>  		bdi_set_min_ratio(bdi, 0);
> -	}
>  
>  	if (bdi->dev) {
>  		bdi_debug_unregister(bdi);
> _
> 
