Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768364C8EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiCAPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiCAPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:11:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC590254
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:10:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D88E861678
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B641C340EE;
        Tue,  1 Mar 2022 15:10:30 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:10:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, frederic@kernel.org,
        tglx@linutronix.de, mtosatti@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/isolation: use raw_smp_processor_id() in
 housekeeping_any_cpu()
Message-ID: <20220301101028.1f510bf5@gandalf.local.home>
In-Reply-To: <20220301113053.141514-1-nsaenzju@redhat.com>
References: <20220301113053.141514-1-nsaenzju@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Mar 2022 12:30:52 +0100
Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:

> housekeeping_any_cpu() will return a housekeeping CPU. That's it. It'll
> try to optimize for NUMA locality and to use the local CPU, but it's not
> a requisite.
> 
> So let's use raw_smp_processor_id() instead of its vanilla counterpart
> in order to allow users to query for housekeeping CPUs without having to
> disable preemption.

Peter, care to ACK this, and I can take it through my tree?

-- Steve

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  include/linux/sched/isolation.h | 2 +-
>  kernel/sched/isolation.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 8c15abd67aed..0c09ff1e4599 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -31,7 +31,7 @@ extern void __init housekeeping_init(void);
>  
>  static inline int housekeeping_any_cpu(enum hk_type type)
>  {
> -	return smp_processor_id();
> +	return raw_smp_processor_id();
>  }
>  
>  static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index b4d10815c45a..c2c1f6d8bb5f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -43,14 +43,14 @@ int housekeeping_any_cpu(enum hk_type type)
>  
>  	if (static_branch_unlikely(&housekeeping_overridden)) {
>  		if (housekeeping.flags & BIT(type)) {
> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
> +			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], raw_smp_processor_id());
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
>  			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
>  		}
>  	}
> -	return smp_processor_id();
> +	return raw_smp_processor_id();
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>  

