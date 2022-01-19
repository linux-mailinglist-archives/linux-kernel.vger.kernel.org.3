Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA64493519
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351841AbiASGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:41:11 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31104 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351825AbiASGlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:41:01 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jdwt14BbSz1FCt8;
        Wed, 19 Jan 2022 14:37:13 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 19 Jan 2022 14:40:58 +0800
Subject: Re: [PATCH] arm64: entry: Save some nops when CONFIG_ARM64_PSEUDO_NMI
 is not set
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <marcan@marcan.st>, <maz@kernel.org>,
        <joey.gouly@arm.com>, <pcc@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220107085536.214501-1-heying24@huawei.com>
 <20220112032410.29231-1-heying24@huawei.com>
From:   He Ying <heying24@huawei.com>
Message-ID: <e6293ec4-7c56-194a-95f9-98b102d80b31@huawei.com>
Date:   Wed, 19 Jan 2022 14:40:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220112032410.29231-1-heying24@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Ping. Any comments?

ÔÚ 2022/1/12 11:24, He Ying Ð´µÀ:
> Arm64 pseudo-NMI feature code brings some additional nops
> when CONFIG_ARM64_PSEUDO_NMI is not set, which is not
> necessary. So add necessary ifdeffery to avoid it.
>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>   arch/arm64/kernel/entry.S | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 2f69ae43941d..ffc32d3d909a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -300,6 +300,7 @@ alternative_else_nop_endif
>   	str	w21, [sp, #S_SYSCALLNO]
>   	.endif
>   
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>   	/* Save pmr */
>   alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>   	mrs_s	x20, SYS_ICC_PMR_EL1
> @@ -307,6 +308,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>   	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
>   	msr_s	SYS_ICC_PMR_EL1, x20
>   alternative_else_nop_endif
> +#endif
>   
>   	/* Re-enable tag checking (TCO set on exception entry) */
>   #ifdef CONFIG_ARM64_MTE
> @@ -330,6 +332,7 @@ alternative_else_nop_endif
>   	disable_daif
>   	.endif
>   
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>   	/* Restore pmr */
>   alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>   	ldr	x20, [sp, #S_PMR_SAVE]
> @@ -339,6 +342,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>   	dsb	sy				// Ensure priority change is seen by redistributor
>   .L__skip_pmr_sync\@:
>   alternative_else_nop_endif
> +#endif
>   
>   	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
>   
