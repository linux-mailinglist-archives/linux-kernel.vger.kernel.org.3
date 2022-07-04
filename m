Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C517564EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGDH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiGDH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:28:07 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9A65E7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1656919682; bh=kaLh3zXYVaHL4R8erG3gOGPF0Omnf3NJzFTyx4+2o6Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mQvYX2AAGbJyw6O/ov0WduYizcZckh39qF+S5WVGIGKTCs5tBRxTjKiKwTLDtlExY
         ZSd9gTaDC+8qBIxeatvRo4j09u18sRPomEXei2/8pi4LfOvuLd6oMtn1Vv/GZ6gIZ9
         r6RpTTAa9kGsam1N7BMGk29QikmFjT93U3ufJQhA=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4167560114;
        Mon,  4 Jul 2022 15:28:02 +0800 (CST)
Message-ID: <1470d272-e148-c600-f759-a1e2dac776e1@xen0n.name>
Date:   Mon, 4 Jul 2022 15:28:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     huqi <huqi@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220704061402.683762-1-huqi@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220704061402.683762-1-huqi@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/4 14:14, huqi wrote:
> From: Qi Hu <huqi@loongson.cn>
>
> The `vcsr` do not use anymore. Remove this member from `loongarch_fpu`.
"The VCSR is not used any more."
>
> Signed-off-by: Qi Hu <huqi@loongson.cn>
> ---
>   arch/loongarch/include/asm/fpregdef.h  |  1 -
>   arch/loongarch/include/asm/processor.h |  2 --
>   arch/loongarch/kernel/asm-offsets.c    |  1 -
>   arch/loongarch/kernel/fpu.S            | 10 ----------
>   4 files changed, 14 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
> index adb16e4b43b0..b6be527831dd 100644
> --- a/arch/loongarch/include/asm/fpregdef.h
> +++ b/arch/loongarch/include/asm/fpregdef.h
> @@ -48,6 +48,5 @@
>   #define fcsr1	$r1
>   #define fcsr2	$r2
>   #define fcsr3	$r3
> -#define vcsr16	$r16
>   
>   #endif /* _ASM_FPREGDEF_H */
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 1d63c934b289..57ec45aa078e 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -80,7 +80,6 @@ BUILD_FPR_ACCESS(64)
>   
>   struct loongarch_fpu {
>   	unsigned int	fcsr;
> -	unsigned int	vcsr;
>   	uint64_t	fcc;	/* 8x8 */
>   	union fpureg	fpr[NUM_FPU_REGS];
>   };
> @@ -161,7 +160,6 @@ struct thread_struct {
>   	 */							\
>   	.fpu			= {				\
>   		.fcsr		= 0,				\
> -		.vcsr		= 0,				\
>   		.fcc		= 0,				\
>   		.fpr		= {{{0,},},},			\
>   	},							\
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> index bfb65eb2844f..20cd9e16a95a 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
>   
>   	OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
>   	OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
> -	OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
>   	BLANK();
>   }
>   
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index 75c6ce0682a2..a631a7137667 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -146,16 +146,6 @@
>   	movgr2fcsr	fcsr0, \tmp0
>   	.endm
>   
> -	.macro sc_save_vcsr base, tmp0
> -	movfcsr2gr	\tmp0, vcsr16
> -	EX	st.w \tmp0, \base, 0
> -	.endm
> -
> -	.macro sc_restore_vcsr base, tmp0
> -	EX	ld.w \tmp0, \base, 0
> -	movgr2fcsr	vcsr16, \tmp0
> -	.endm
> -
>   /*
>    * Save a thread's fp context.
>    */

The original code was written with future LSX/LASX support in mind; the 
code is dead currently, but expected to get utilized Soon (TM).

So, I'd like to confirm if future LoongArch models would *not* feature 
LSX/LASX in its current form, and that the Loongson Corporation is not 
going to upstream LSX/LASX support, given you are apparently a Loongson 
employee with the first-hand information? We'd like to avoid code churn 
in general, so if the LSX/LASX support is to be eventually mainlined, 
removing them now would only lead to them being introduced later.

