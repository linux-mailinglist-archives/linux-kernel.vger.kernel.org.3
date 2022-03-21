Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884604E275A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbiCUNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiCUNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:19:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D3DC2180B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:18:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6ADE1042;
        Mon, 21 Mar 2022 06:18:11 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09BE3F73D;
        Mon, 21 Mar 2022 06:18:10 -0700 (PDT)
Message-ID: <9159dd7d-0c5a-10a3-be47-7fb4a30a234b@arm.com>
Date:   Mon, 21 Mar 2022 13:18:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: assembler: Fine-tune code to improve code
 readability
Content-Language: en-GB
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <1647831274-3555-1-git-send-email-daizhiyuan@phytium.com.cn>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1647831274-3555-1-git-send-email-daizhiyuan@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-21 02:54, Zhiyuan Dai wrote:
> This patch tweaks the code to improve readability.

...but it also changes what the code actually does :(

> Defined values are:
>   PMUVer == 0b0000 : Performance Monitors Extension not implemented.

Plus all the other values, but crucially up to:

"0b1111 IMPLEMENTATION DEFINED form of performance monitors supported, 
PMUv3 not supported."

> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>   arch/arm64/include/asm/assembler.h | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 6ebdc0f..efd43a1 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -489,11 +489,10 @@
>    */
>   	.macro	reset_pmuserenr_el0, tmpreg
>   	mrs	\tmpreg, id_aa64dfr0_el1
> -	sbfx	\tmpreg, \tmpreg, #ID_AA64DFR0_PMUVER_SHIFT, #4

This extracts a *signed* 4-bit field...

> -	cmp	\tmpreg, #1			// Skip if no PMU present

...so this rejects values of both 0 and -1.

> -	b.lt	9000f
> -	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
> -9000:
> +	ubfx	\tmpreg, \tmpreg, #ID_AA64DFR0_PMUVER_SHIFT, #4
> +	cbz	\tmpreg, .Lskip_pmu_\@		// Skip if no PMU present
> +	msr_s   SYS_PMUSERENR_EL0, xzr	// Disable PMU access from EL0

How confident are you that it's safe to touch a PMUv3 register in an 
unknown implementation which explicitly *isn't* PMUv3?

Thanks,
Robin.

> +.Lskip_pmu_\@:
>   	.endm
>   
>   /*
