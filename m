Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B153B2EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFBFZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFBFZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:25:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5381EA85A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:25:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3966779pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 22:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nelGoRK+fUlDKeet8T6l+sbmUXeRjWjPVssTQWUr0Ig=;
        b=vy3yfyw9SSoKqKUSG57P5OxTHOUY0U58Reiri26Ry2fbin3EOFn9+OMZRlJPFsxqdS
         YR7e4cJWsWrfEYJk0S28SJdXVJWDQ7D0rSroeuZf8t5mc8lR1vmpReLG4xpqV9GOzxRt
         wuvlSQlvWOimcQL03fXEcHpkFkR995r446bETmFN47vO6yPUXm2bALrmR0JrNLafZghM
         uM7meFZsKE13WCTsTDPB/nRSUJP244sgpBfuXabsLjbEm6bKapJt32prrTCM9sOObgCL
         NHaSBr38dhMAXqsqY85ED+a9L+UfsJgVbCpkErO7DgXoBjKxliNsA8J7F1zUfyxPezBb
         4cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nelGoRK+fUlDKeet8T6l+sbmUXeRjWjPVssTQWUr0Ig=;
        b=U0ahsoXBPbgoJY+CeO1QK+121xPMWXsarfk1GBWn8FOxlSW+D19P2PSRFSnkGpkaMW
         DN1QUJGtRxZPkGkV/kPNING2nGT0IflAq31lkuH8bqbRa9UsK8yvf3FSKd7fqBoJ1GXK
         KiO1swOdhQrTaCg8a6j5pkj5O7o0yRAUyLNhCcDFMWxrHEPmyLiPFN+rGWBjOt0/GHZu
         lIg674heE0yitI0o97vpmMEh/0i0eyCYRLPwVWcuDml4NBDhzB1cvlJCeqXBjTo15nGu
         0ydwH/cR1Ch0//8+0DONtnlwtV1NeAMJ6iiN3I/+IOMKxhTnht/1MVQm6AAWpp4i2zpq
         ef7w==
X-Gm-Message-State: AOAM530hdMwDNs2rZQ9Acez/kiYIM+y2OnumSt9XcGYk651aBoe9b+pf
        dQtnn8xw8un2M6oQAbjL4v081BEuGNhR/w==
X-Google-Smtp-Source: ABdhPJzMXV9QJAtuK5pym+rv06ZhuwstBd4WZB8JJPd7lfWyo0CdXpHHu3SEHpum9mdsVWX+p+JXbg==
X-Received: by 2002:a17:902:ea0b:b0:164:81f:682f with SMTP id s11-20020a170902ea0b00b00164081f682fmr3115061plg.39.1654147516250;
        Wed, 01 Jun 2022 22:25:16 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00163b66d90b2sm2518364plg.126.2022.06.01.22.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 22:25:15 -0700 (PDT)
Date:   Wed, 01 Jun 2022 22:25:15 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 22:25:06 PDT (-0700)
Subject:     Re: [PATCH v2] arch/riscv: add Zihintpause support
In-Reply-To: <20220524211954.1936117-1-daolu@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, daolu@rivosinc.com, heiko@sntech.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        rdunlap@infradead.org, robh@kernel.org,
        alexandre.ghiti@canonical.com, panqinglin2020@iscas.ac.cn,
        research_trasio@irq.a4lg.com, jszhang@kernel.org,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     daolu@rivosinc.com
Message-ID: <mhng-62ce3647-fc60-42ce-bff0-9436c7e15028@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 14:19:50 PDT (-0700), daolu@rivosinc.com wrote:
> Implement support for the ZiHintPause extension.
>
> The PAUSE instruction is a HINT that indicates the current hart’s rate of
> instruction retirement should be temporarily reduced or paused.
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
>
> v1 -> v2:
>  Remove the usage of static branch, use PAUSE if toolchain supports it

Sorry for the back and forth here, but IMO we do want to probe for this 
at runtime: sure there's no issue executing the pause (aside from that 
PC silliness, but we've all agreed to ignore that) but we still need to 
execute the div on platforms that predate Zihintpause otherwise we 
regress on cpu_relax() there.  IIUC there's still no hardware with 
Zihintpause, so regressing on real hardware in favor of an unimplemented 
extension is the wrong way to go.

Should be pretty easy to do this with the alternatives mechanism.

>
>  arch/riscv/Makefile                     | 4 ++++
>  arch/riscv/include/asm/hwcap.h          | 1 +
>  arch/riscv/include/asm/vdso/processor.h | 8 +++++++-
>  arch/riscv/kernel/cpu.c                 | 1 +
>  arch/riscv/kernel/cpufeature.c          | 2 ++
>  5 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7d81102cffd4..900a8fda1a2d 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
>  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>
> +# Check if the toolchain supports Zihintpause extension
> +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> +
>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>  KBUILD_AFLAGS += -march=$(riscv-march-y)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0734e42f74f2..caa9ee5459b4 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
>   */
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 134388cbaaa1..4de911a25051 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -8,7 +8,13 @@
>
>  static inline void cpu_relax(void)
>  {
> -#ifdef __riscv_muldiv
> +#ifdef __riscv_zihintpause
> +	/*
> +	 * Reduce instruction retirement.
> +	 * This assumes the PC changes.
> +	 */
> +	__asm__ __volatile__ ("pause");
> +#elif __riscv_muldiv
>  	int dummy;
>  	/* In lieu of a halt instruction, induce a long-latency stall. */
>  	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..89e563e9c4cc 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..37ff06682ae6 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -25,6 +25,7 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
>
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -192,6 +193,7 @@ void __init riscv_fill_hwcap(void)
>  				set_bit(*ext - 'a', this_isa);
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> +				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
