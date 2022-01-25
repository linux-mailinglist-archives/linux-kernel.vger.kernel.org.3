Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9331349BB79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiAYSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiAYSqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:46:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC84C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MfUIdHxxyECsMt00Zm7D5VcUUlj+oDrAaABP9HhL1lQ=; b=cB/gfuQAE//Ww1smWMXp5Ty/1I
        NRhexO0MY5ZmqJXDsq719SCEa+5tSkzWpK+X3/Q5CG2mCcPx2lSmZsfu3oaXhMjbVdaeDwkaglaXM
        ZMhFElcFRAqCWUv8Pe+/4eujvtCAZVMvRqiasFDe9ZctxJZWbhYKoYezgqGYqjH2ooNKL01Stg24k
        WYAxeXLXnAf4WvMqpEiaoJez3G1x5uUP57XnpCg0YGTAYp6WdZEjO9X6Jm+wUVIpL5MtZ3PhrSt89
        ye9e8iYc3nk9wqoW/fvOsCmvl5WY8nCMyum4k/eu2+QEDtf/niGEDnEErxoDpDnIpx6yif2XkJrdy
        EoHVWJYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCQpv-003FQ2-VX; Tue, 25 Jan 2022 18:46:36 +0000
Date:   Tue, 25 Jan 2022 18:46:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] mm/vmalloc: Move draining areas out of caller
 context
Message-ID: <YfBFi5IqC0MtLADf@casper.infradead.org>
References: <20220125163912.2809-1-urezki@gmail.com>
 <YfAqRrGD2UKrZHfJ@casper.infradead.org>
 <YfAvkKZlVQYukays@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfAvkKZlVQYukays@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:12:48PM +0100, Uladzislau Rezki wrote:
> On Tue, Jan 25, 2022 at 04:50:14PM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 25, 2022 at 05:39:12PM +0100, Uladzislau Rezki (Sony) wrote:
> > > @@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> > >  
> > >  	/* After this point, we may free va at any time */
> > >  	if (unlikely(nr_lazy > lazy_max_pages()))
> > > -		try_purge_vmap_area_lazy();
> > > +		if (!atomic_xchg(&drain_vmap_work_in_progress, 1))
> > > +			schedule_work(&drain_vmap_work);
> > >  }
> > 
> > Is it necessary to have drain_vmap_work_in_progress?  The documentation
> > says:
> > 
> >  * This puts a job in the kernel-global workqueue if it was not already
> >  * queued and leaves it in the same position on the kernel-global
> >  * workqueue otherwise.
> > 
> > and the implementation seems to use test_and_set_bit() to ensure this
> > is true.
> >
> It checks pending state, if the work is in run-queue you can place it
> one more time. The motivation of having it is to prevent the drain work
> of being placed several times at once what i see on my stress testing.
> 
> CPU_1: invokes vfree() -> queues the drain work -> TASK_RUNNING
> CPU_2: invokes vfree() -> queues the drain work one more time since it was not pending

But why not unconditionally call schedule_work() here?
