Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE54573B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGMQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbiGMQcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:32:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 618662CDF2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:32:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F6615A1;
        Wed, 13 Jul 2022 09:32:50 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B3873F792;
        Wed, 13 Jul 2022 09:32:48 -0700 (PDT)
Date:   Wed, 13 Jul 2022 17:32:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     alvinzhan1234@gmail.com
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: Prevent offline CPU handling IRQs.
Message-ID: <Ys7zqo4pWbfoUr6R@FVFF77S0Q05N.cambridge.arm.com>
References: <20220713132843.49693-1-alvinzhan1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713132843.49693-1-alvinzhan1234@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:28:43PM +0800, alvinzhan1234@gmail.com wrote:
> From: Alvin Zhan <alvinzhan1234@gmail.com>
> 
> Migrate all of the IRQs on this CPU after setting it offline may still cause
> the IRQs to be dispatched to this CPU.

I was under the impression that __cpu_disable() was called with interrupts
masked, since it's called via stop_machine_cpuslocked(), and hence interrupts
cannot be taken here (ignoring pseudo-NMIs for the moment).

Have you ever seen that actually happen?

Mark.

> To prevent offline CPU handling IRQs, we should migrate the IRQs away from
> this CPU before it is powered off.
> 
> Signed-off-by: Alvin Zhan <alvinzhan1234@gmail.com>
> ---
>  arch/arm64/kernel/smp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 62ed361a4..c4c3c5ed5 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -302,6 +302,11 @@ int __cpu_disable(void)
>  	remove_cpu_topology(cpu);
>  	numa_remove_cpu(cpu);
>  
> +	/*
> +	 * Migrate IRQs away from this CPU first.
> +	 */
> +	irq_migrate_all_off_this_cpu();
> +
>  	/*
>  	 * Take this CPU offline.  Once we clear this, we can't return,
>  	 * and we must not schedule until we're ready to give up the cpu.
> @@ -309,11 +314,6 @@ int __cpu_disable(void)
>  	set_cpu_online(cpu, false);
>  	ipi_teardown(cpu);
>  
> -	/*
> -	 * OK - migrate IRQs away from this CPU
> -	 */
> -	irq_migrate_all_off_this_cpu();
> -
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
