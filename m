Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DF56655D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiGEIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiGEIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:47:02 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F9DF70
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1657010819; bh=bcPVtZXhJ8U6tcwRs69D2ygTpn/9qa0uoHQou6i7Ay8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vaCz/z+f7Gw12g+vnXmTA+N7jbm5F0jneEY+0o4E1jsrpdNXZuRqC0Xg78GlUgHC4
         pCTilYw7pYsWAw4lup3VFS/bOvyyvlUWM/4E7LS42SI3iBkgoH7hvqITxjIlbJ6Yiy
         uIeYqTM3TN3oKC7UChqR6uWvmJIkf74H5corQeOk=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 05C506010B;
        Tue,  5 Jul 2022 16:46:58 +0800 (CST)
Message-ID: <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
Date:   Tue, 5 Jul 2022 16:46:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     Qi Hu <huqi@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220704153612.314112-1-huqi@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220704153612.314112-1-huqi@loongson.cn>
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

Hi,

I just noticed that the subject line is in Chinglish too. It should 
probably be just "LoongArch: remove mentions of vcsr" and without the 
trailing period.

On 2022/7/4 23:36, Qi Hu wrote:
> The `vcsr` is not used anymore. Remove this member from `loongarch_fpu`.
>
>  From 3A5000(LoongArch), `vcsr` is removed in hardware. FP and LSX/LASX
> both use `fcsr` as their csr.
>
> Particularly, fcsr from $r16 to $r31 are reserved for LSX/LASX, and
> using the registers in this area will cause SXD/ASXD if LSX/LASX is
> not enabled.

Actually I'm still not very satisfied with the explanation; the code 
must be written with *something* in mind, since GS464V/LA464 is the only 
LoongArch implementation so far, it must have a VCSR to begin with. And 
you can't magically melt the VCSR on the tens of thousands of 
3A5000/3C5000's already shipped, because the old-world kernel obviously 
comes with LSX/LASX and it most likely utilizes the VCSR. In addition, 
you didn't mention what will happen if LSX/LASX *is* enabled on this 
new-world kernel, *and* fcsr16 is being accessed.

I think maybe you just want to remove the mentions of VCSR since they 
are dead code right now, as I don't believe it's gone in shipped 
hardware, as explained above. Except if there's magically a way to 
implement LSX/LASX without touching the said-to-have-disappeared VCSR, 
which I don't know of, and can't know because the LSX/LASX ISA manual is 
still not publicly accessible; so I don't feel comfortable approving 
this patch.

(BTW, the $rXX-style reference to the FCSRs is obviously an 
implementation wart of the toolchain, the FCSR is nothing like GPR so it 
obviously shouldn't be referred to as one. Binutils patch will be out 
shortly.)

>
> Signed-off-by: Qi Hu <huqi@loongson.cn>
> ---
> V2:
> - Add more details in the commit message.
> ---
>   arch/loongarch/include/asm/fpregdef.h  |  1 -
>   arch/loongarch/include/asm/processor.h |  2 --
>   arch/loongarch/kernel/asm-offsets.c    |  1 -
>   arch/loongarch/kernel/fpu.S            | 10 ----------
>   4 files changed, 14 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
> index adb16e4b4..b6be52783 100644
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
> index 1d63c934b..57ec45aa0 100644
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
> index bfb65eb28..20cd9e16a 100644
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
> index 75c6ce068..a631a7137 100644
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
