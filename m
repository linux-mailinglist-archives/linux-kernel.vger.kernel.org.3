Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D6357DBC9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiGVIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:10:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF71B7C7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658477413; bh=7RpSAvZylmlQvIgOHNKJSQidLiu4U2SrT35oA9jPT5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QO4c6vKSeKYUwpFE5glVJmKsnedCP2Fz72+PtMrcKtiEFu3VrHmgCA9eDqJO5JPl3
         YLqwStkXOOGaZFJ3RJENeqvGAeFwY3IqF2iBcnxXcNt000Sj/P5iGHhRYAB7f7aquk
         H01S/NrmeE1XgP18U5wZ5vmaLXFhkJhwNZXpgeew=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 191A86061B;
        Fri, 22 Jul 2022 16:10:13 +0800 (CST)
Message-ID: <3324feed-e158-8c51-9915-85b0498f1888@xen0n.name>
Date:   Fri, 22 Jul 2022 16:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH 1/2] LoongArch: Remove clock setting during cpu hotplug
 stage
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220720072152.3894559-1-maobibo@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220720072152.3894559-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/20 15:21, Bibo Mao wrote:
> On physical machine we can save power by disabling clock of hot removed cpu.
> However there will be problem, since different platforms have different clock
> setting methods, the code is platform relative. Also it can be in firmware/pmu
> compoments or cpu regulator driver, rather than general loongarch cpu booting
> flow.
>
> Also on qemu virt machine, device clock/freq setting is not
> emulated, there is no such registers.
>
> This patch removes hard-coded register accessing in generic
> loongarch cpu boot flow.

Improving a little on the wording (mostly fixing eyesore Chinglish):

"On physical machine we can save power by disabling clock of hot removed 
cpu. However as different platforms require different methods to 
configure clocks, the code is platform-specific, and probably belongs to 
firmware/pmu or cpu regulator, rather than generic arch/loongarch code.

Also, there is no such register on QEMU virt machine since the 
clock/frequency regulation is not emulated.

This patch removes the hard-coded clock register accesses in generic 
loongarch cpu hotplug flow."

>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   arch/loongarch/kernel/smp.c | 29 -----------------------------
>   include/linux/cpuhotplug.h  |  1 -
>   2 files changed, 30 deletions(-)
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 73cec62504fb..98b3e059d344 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -359,35 +359,6 @@ void play_dead(void)
>   	play_dead_uncached(state_addr);
>   }
>   
> -static int loongson3_enable_clock(unsigned int cpu)
> -{
> -	uint64_t core_id = cpu_data[cpu].core;
> -	uint64_t package_id = cpu_data[cpu].package;
> -
> -	LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
> -
> -	return 0;
> -}
> -
> -static int loongson3_disable_clock(unsigned int cpu)
> -{
> -	uint64_t core_id = cpu_data[cpu].core;
> -	uint64_t package_id = cpu_data[cpu].package;
> -
> -	LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
> -
> -	return 0;
> -}
> -
> -static int register_loongson3_notifier(void)
> -{
> -	return cpuhp_setup_state_nocalls(CPUHP_LOONGARCH_SOC_PREPARE,
> -					 "loongarch/loongson:prepare",
> -					 loongson3_enable_clock,
> -					 loongson3_disable_clock);
> -}
> -early_initcall(register_loongson3_notifier);
> -
>   #endif
>   
>   /*
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 19f0dbfdd7fe..b66c5f389159 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -130,7 +130,6 @@ enum cpuhp_state {
>   	CPUHP_ZCOMP_PREPARE,
>   	CPUHP_TIMERS_PREPARE,
>   	CPUHP_MIPS_SOC_PREPARE,
> -	CPUHP_LOONGARCH_SOC_PREPARE,
>   	CPUHP_BP_PREPARE_DYN,
>   	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
>   	CPUHP_BRINGUP_CPU,

Seems good. I should have noticed earlier the fact the clock control 
registers are, in every regard, model-specific, thus not appropriate for 
arch/loongarch. Proper drivers should be added afterwards, though I 
assume you must internally have something like that already.

Reviewed-by: WANG Xuerui <git@xen0n.name>

