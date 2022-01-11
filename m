Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6B248AC77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349495AbiAKLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349484AbiAKLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:31:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DAEC06173F;
        Tue, 11 Jan 2022 03:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7+j+AxKostCxVUtXLZt7JDj+KZ88UAuuQ1PDCxlP8hs=; b=dGAndzN2gj9PDgu88wWrGeBQ0K
        p9d9PTKyO0my3R4SYNnYNovGZyA9hXogQzdIo0H7dfkVLJQcLF8tql5VgEmCCNTzujVad5+fRmDfl
        GxCdFJ+fJDKkheapfviCTJPFXk2VUmZSSJPq/1N3I1fFl93H4NfNFZbHqERgjtrrZug70tSHCARjm
        DKw75CfgLtjbV2+2uPSavB05qgp1J0c9Vl9twyiD0T8Pi2YYwKS9Eok0KevWd2oaKB6CxraMr+Ao2
        PvSAeMbXM/qacraFN7mKhkqvTAVWA+TmqaPdaEXaGJF3uOkpUK59yRKm29gX26LGDtATQZq0qG5z4
        4YeAIWiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7FMR-000bDY-Mg; Tue, 11 Jan 2022 11:30:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94D033000E6;
        Tue, 11 Jan 2022 12:30:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E8C2201BD824; Tue, 11 Jan 2022 12:30:42 +0100 (CET)
Date:   Tue, 11 Jan 2022 12:30:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110193158.31e1eaea@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 07:31:58PM -0500, Steven Rostedt wrote:
> On Mon, 10 Jan 2022 23:46:15 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Jan 10, 2022 at 09:23:54AM +0800, Xiu Jianfeng wrote:
> > > Make use of struct_size() helper instead of an open-coded calculation.
> > > There is no functional change in this patch.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/160
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > > ---
> > >  kernel/sched/fair.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 095b0aa378df..af933a7f9e5d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -2437,9 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
> > >  	int i;
> > >  
> > >  	if (unlikely(!deref_curr_numa_group(p))) {
> > > -		unsigned int size = sizeof(struct numa_group) +
> > > -				    NR_NUMA_HINT_FAULT_STATS *
> > > -				    nr_node_ids * sizeof(unsigned long);
> > > +		unsigned int size = struct_size(grp, faults,
> > > +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);  
> > 
> > Again, why?! The old code was perfectly readable, this, not so much.
> 
> Because it is unsafe,

Unsafe how? Changelog doesn't mention anything, nor do you. In fact,
Changelog says there is no functional change, which makes me hate the
thing for obscuring something that was simple.

> And to be honest, the new change is a lot easier to read than the original
> code.

I find it the other way around, because now I need to find and untangle
the unholy mess that is struct_size(), whereas currently it is trivial
C.
