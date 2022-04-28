Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233805139EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350082AbiD1Qha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbiD1Qh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4A7B18B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651163652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnyhoc/cjBYTIjG859/Q+ADC9xE0V02YdHx7bZpU3Gc=;
        b=R/wYKj73xZk35NJmnxWP4GK4YkeTkvGjbMnoB0kP9vc32rYOUurgFy17UbKvcKH+oB+RCl
        3cazThQTSnq4XgFvLv8Gshogzhecc7mU0djvYY+aAv4AGXbvQ8og4mlTc/tPHZiqZXxY1i
        w9A8wCtPRXdvCUnXjrBDDT+z4cl4ad4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-cRiwa-VfOJ2A7gXoma6G1w-1; Thu, 28 Apr 2022 12:34:10 -0400
X-MC-Unique: cRiwa-VfOJ2A7gXoma6G1w-1
Received: by mail-il1-f197.google.com with SMTP id h28-20020a056e021d9c00b002cc403e851aso2070085ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dnyhoc/cjBYTIjG859/Q+ADC9xE0V02YdHx7bZpU3Gc=;
        b=wC15eSQl1bFjGFBHv+Ke9sssfPtJacAhr0nPhcp4J5Teu+p7tVubMLMijc7OndoItX
         KHDHLhzi7YHYdl4KfLFW2T3iiS19T8+NmIUlArU2hS9YWjnTleUngl/w2bYC5c0R/lFw
         SEzNm4C9FVjuvm4p66udHnLPNE2D0Rcw/EhvAgnUBL/g0KfJp5yct6BqmFlh8dUi+0mM
         XVCgSZqD423OVjPb1pu4bQlSXN1E6cofwkL9f1hPoa6H60BfGvxg4IqBCwiPRjNf4AoN
         w+iaCrzpxOMljO1Y4pjTO5Ejfa9683uEwcuYuGdCGkk7tbkKkzaG0dVOPJ3Xs5CPNAoT
         8rAQ==
X-Gm-Message-State: AOAM531wLI6e4BU7D0v1PxdIhkHcNc40BZk/8v6GV3Hp1LrJBOlIdzpX
        JVG5mZcbkYW/h0R6p+jlIShQXuTTI+e2lKmjdDd40dBD86NFLaD1yfRjzV9w47fQU1M1IjwuJVZ
        rWyUmapUwzeOvgWXs8CGux4P1
X-Received: by 2002:a05:6638:1306:b0:326:33da:c673 with SMTP id r6-20020a056638130600b0032633dac673mr15510974jad.270.1651163649738;
        Thu, 28 Apr 2022 09:34:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxtoPvNh2i+CT27XPlF1bYSAsfyfPsfyIrKSmugUrpy5xhGvlUArte8ycYE6V0fBJY5+ZhkA==
X-Received: by 2002:a05:6638:1306:b0:326:33da:c673 with SMTP id r6-20020a056638130600b0032633dac673mr15510963jad.270.1651163649459;
        Thu, 28 Apr 2022 09:34:09 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id i1-20020a6b5401000000b00657c9b6e5c6sm195868iob.43.2022.04.28.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:34:08 -0700 (PDT)
Date:   Thu, 28 Apr 2022 12:34:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Message-ID: <YmrB/7ehG2kj2RMn@xz-m1.local>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
 <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:17:07PM +0200, David Hildenbrand wrote:
> On 17.03.22 07:50, Bibo Mao wrote:
> > collapse huge page will copy huge page from general small pages,
> > dest node is calculated from most one of source pages, however
> > THP daemon is not scheduled on dest node. The performance may be
> > poor since huge page copying across nodes, also cache is not used
> > for target node. With this patch, khugepaged daemon switches to
> > the same numa node with huge page. It saves copying time and makes
> > use of local cache better.
> > 
> > With this patch, specint 2006 base performance is improved with 6%
> > on Loongson 3C5000L platform with 32 cores and 8 numa nodes.
> 
> If it helps, that's nice as long as it doesn't hurt other cases.
> 
> > 
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> > changelog:
> > V2: remove node record for thp daemon
> > V3: remove unlikely statement
> > ---
> >  mm/khugepaged.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 131492fd1148..b3cf0885f5a2 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1066,6 +1066,7 @@ static void collapse_huge_page(struct mm_struct *mm,
> >  	struct vm_area_struct *vma;
> >  	struct mmu_notifier_range range;
> >  	gfp_t gfp;
> > +	const struct cpumask *cpumask;
> >  
> >  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >  
> > @@ -1079,6 +1080,13 @@ static void collapse_huge_page(struct mm_struct *mm,
> >  	 * that. We will recheck the vma after taking it again in write mode.
> >  	 */
> >  	mmap_read_unlock(mm);
> > +
> > +	/* sched to specified node before huage page memory copy */
> 
> huage? I assume "huge"
> 
> > +	if (task_node(current) != node) {
> > +		cpumask = cpumask_of_node(node);
> > +		if (!cpumask_empty(cpumask))
> > +			set_cpus_allowed_ptr(current, cpumask);
> > +	}
> 
> I wonder if that will always be optimized out without NUMA and if we
> want to check for IS_ENABLED(CONFIG_NUMA).
> 
> 
> Regarding comments from others, I agree: I think what we'd actually want
> is something like "try to reschedule to one of these CPUs immediately.
> If they are all busy, just stay here.
> 
> 
> Also, I do wonder if there could already be scenarios where someone
> wants to let khugepaged run only on selected housekeeping CPUs (e.g.,
> when pinning VCPUs in a VM to physical CPUs). It might even degrade the
> VM performance in that case if we schedule something unrelated on these
> CPUs. (I don't know which interfaces we might already have to configure
> housekeeping CPUs for kthreads).
> 
> I can spot in kernel/kthread.c:kthread()
> 
> set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
> 
> Hmmmmm ...

Yes that's a valid point, for RT afaik many users tunes the kernel threads
specifically on demand by pinning them.  So I'm not sure how this new
algorithm could break some users already, by either (1) trying to pin
khugepaged onto some isolated cores (which can cause spikes?), or (2) mess
up with the admin's previous pin settings on the khugepagd kthread.

The other thing is the khugepaged movement on the cores seems to be quite
random, because the pages it scans can be unpredictably stored on different
numa nodes, so logically it can start bouncing easily on some hosts and
that does sound questionalbe.. as I raised the (pure) question previously
on the 2nd point irrelevant of the benchmark result.

-- 
Peter Xu

