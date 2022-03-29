Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742D54EAEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiC2OEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiC2OEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:04:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83889206ED1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:02:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 380F723A;
        Tue, 29 Mar 2022 07:02:26 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44C63F73B;
        Tue, 29 Mar 2022 07:02:24 -0700 (PDT)
Message-ID: <1a546197-872b-7762-68ac-d5e6bb6d19aa@arm.com>
Date:   Tue, 29 Mar 2022 16:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arch/arm64: Fix topology initialization for core
 scheduling
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220322160304.26229-1-pauld@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220322160304.26229-1-pauld@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 17:03, Phil Auld wrote:
> Some arm64 rely on store_cpu_topology() to setup the real topology.
> This needs to be done before the call to notify_cpu_starting() which
> tell the scheduler about the cpu otherwise the core scheduling data
> structures are setup in a way that does not match the actual topology.
> 
> Without this change stress-ng (which enables core scheduling in its prctl 
> tests) causes a warning and then a crash (trimmed for legibility):
> 
> [ 1853.805168] ------------[ cut here ]------------
> [ 1853.809784] task_rq(b)->core != rq->core
> [ 1853.809792] WARNING: CPU: 117 PID: 0 at kernel/sched/fair.c:11102 cfs_prio_less+0x1b4/0x1c4
> ...
> [ 1854.015210] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> ...
> [ 1854.231256] Call trace:
> [ 1854.233689]  pick_next_task+0x3dc/0x81c
> [ 1854.237512]  __schedule+0x10c/0x4cc
> [ 1854.240988]  schedule_idle+0x34/0x54
> 
> Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
> This is a similar issue to 
>   f2703def339c ("MIPS: smp: fill in sibling and core maps earlier") 
> which fixed it for MIPS.

I assume this is for a machine which relies on MPIDR-based setup
(package_id == -1)? I.e. it doesn't have proper ACPI/(DT) data for
topology setup.

Tried on a ThunderX2 by disabling parse_acpi_topology() but then I end
up with a machine w/o SMT, so `stress-ng --prctl N` doesn't show this issue.

Which machine were you using?

>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 27df5c1e6baa..3b46041f2b97 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -234,6 +234,7 @@ asmlinkage notrace void secondary_start_kernel(void)
>  	 * Log the CPU info before it is marked online and might get read.
>  	 */
>  	cpuinfo_store_cpu();
> +	store_cpu_topology(cpu);
>  
>  	/*
>  	 * Enable GIC and timers.
> @@ -242,7 +243,6 @@ asmlinkage notrace void secondary_start_kernel(void)
>  
>  	ipi_setup(cpu);
>  
> -	store_cpu_topology(cpu);
>  	numa_add_cpu(cpu);
>  
>  	/*

