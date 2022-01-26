Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0422D49C93C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiAZMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:05:29 -0500
Received: from foss.arm.com ([217.140.110.172]:35170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233883AbiAZMF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:05:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C3BD6E;
        Wed, 26 Jan 2022 04:05:28 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843A73F793;
        Wed, 26 Jan 2022 04:05:27 -0800 (PST)
Message-ID: <bf7fdba2-7850-9d38-157d-7a1e726512a5@arm.com>
Date:   Wed, 26 Jan 2022 12:05:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] add cpu frequency to cpuinfo in arm64
Content-Language: en-GB
To:     Chao Liu <liuchao173@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hewenliang4@huawei.com, zhoukang7@huawei.com
References: <20220126092349.285642-1-liuchao173@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220126092349.285642-1-liuchao173@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 09:23, Chao Liu wrote:
> There is cpu frequency in /proc/cpuinfo in x86 but not in arm64

arm64 cpuinfo also doesn't show the APIC ID or microcode version. 
Different architectures are different.

Besides, x86 cpuinfo only shows MHz if the CPU has X86_FEATURE_TSC, so 
for compatibility we should only do this on AArch64 CPUs which have 
X86_FEATURE_TSC.

Robin.

> Signed-off-by: Chao Liu <liuchao173@huawei.com>
> ---
> Change in v2:
> - fix spelling errors and remove remove redundant blank line
> 
>   arch/arm64/kernel/cpuinfo.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 591c18a889a5..39a36e6e8079 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -24,6 +24,7 @@
>   #include <linux/sched.h>
>   #include <linux/smp.h>
>   #include <linux/delay.h>
> +#include <linux/cpufreq.h>
>   
>   /*
>    * In case the boot CPU is hotpluggable, we record its initial state and
> @@ -144,6 +145,7 @@ static int c_show(struct seq_file *m, void *v)
>   	for_each_online_cpu(i) {
>   		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
>   		u32 midr = cpuinfo->reg_midr;
> +		unsigned int freq = cpufreq_quick_get(i);
>   
>   		/*
>   		 * glibc reads /proc/cpuinfo to determine the number of
> @@ -159,6 +161,10 @@ static int c_show(struct seq_file *m, void *v)
>   			   loops_per_jiffy / (500000UL/HZ),
>   			   loops_per_jiffy / (5000UL/HZ) % 100);
>   
> +		if (freq)
> +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
> +				   freq / 1000, (freq % 1000));
> +
>   		/*
>   		 * Dump out the common processor features in a single line.
>   		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
