Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66BF570C26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiGKUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGKUo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:44:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3141D01
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:44:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so5668994wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NszzDZbzIBuzddjjLcc7vBaxX8gjDVh0ornBGpIQwwk=;
        b=ehl0wMadrdZh+hOsLTT0aerkVfKNk9R0W/YoHZTdNuhwlsa31MQQzwOuXyYXep0Sqi
         age01vgGJEUJop/eumchgnOeElE9sjKOMy+8yAuIDM/wX90sMlX28wcyqmwMByus47PI
         dz8YIBSPqUm6yaDplyZig0FuqVfU5GHqpnEAd9uJiMT04oh7Q5NCA5ywCh2I/h4u4XO9
         THnP8ZAEynmbw91bRdhq+d1yN58IpqJzbGDBhEfFjRSc3Gc+v35PLcH/LQoZKOdyuGdd
         rs7FbqsMWD5Wis64hii8iZ2Ll+JADsfHLnMeUyx7+lOttE/y+fyTGekaHwe6merdEF9s
         dZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NszzDZbzIBuzddjjLcc7vBaxX8gjDVh0ornBGpIQwwk=;
        b=T5FOIDS7St70iv5NG69unQ47Ix+hO3o14H0Sa1AMTqRdLL8lLDQcqSozw7AOcfloV1
         wWyjiQWhrkd46G9SRErAeSBpxxldeoawzg6WGuB1MnwvDKTixtEEc5xOq+HKyDhilzNs
         m42PLqCWKwZWYYfYbabB4cFxGbkj3rVu8/fpuBV/cMtWa+NdmQri+IhXOx2qJjOc+gjl
         yNJ6oxa/O7usvbiPyr9AWUZlJFtB+RSr+NAQWtA/IeFddnQgTj/yROJICRhNNrx2EnXG
         fVuMn2fqhpBm+1XW09ix+lMv059biWKWxf5ONDOXA5OpJ3h1SnTDA4BefCgrEl0/YbsQ
         vtrA==
X-Gm-Message-State: AJIora9RQHbdFVSBGFMlCFTZNo2Z0qw1fOCT3yrJfaGOM8vwsUNKlkOQ
        OkelSc/1kuBb+AaL0v+WvHw3Og==
X-Google-Smtp-Source: AGRyM1tzq1LrSO5VxsyCr4+uiBUAZz48qCILZwNlSzykzx/99rzNyEwJEl7IBWxVzVTx6rCcwpFNwQ==
X-Received: by 2002:a05:600c:28d:b0:3a2:d06d:3894 with SMTP id 13-20020a05600c028d00b003a2d06d3894mr189007wmk.51.1657572263586;
        Mon, 11 Jul 2022 13:44:23 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm6556110wrr.39.2022.07.11.13.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 13:44:23 -0700 (PDT)
Message-ID: <18a1126c-393e-9c52-4b30-caee01975ad1@conchuod.ie>
Date:   Mon, 11 Jul 2022 21:44:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
Content-Language: en-US
To:     Dao Lu <daolu@rivosinc.com>, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Yury Norov <yury.norov@gmail.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
References: <20220620201530.3929352-1-daolu@rivosinc.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220620201530.3929352-1-daolu@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 21:15, Dao Lu wrote:
> [PATCH v4] arch/riscv: add Zihintpause support

A little ornery/pedantic maybe, but the "arch/" isn't needed.
Guess it can easily be fixed on application or if there's a
v5 so there's prob no need to resend.

> Implement support for the ZiHintPause extension.
> 
> The PAUSE instruction is a HINT that indicates the current hart’s rate
> of instruction retirement should be temporarily reduced or paused.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
> 
> v1 -> v2:
>  Remove the usage of static branch, use PAUSE if toolchain supports it
> v2 -> v3:
>  Added the static branch back, cpu_relax() behavior is kept the same for
> systems that do not support ZiHintPause
> v3 -> v4:
>  Adopted the newly added unified static keys for extensions
> ---
>  arch/riscv/Makefile                     |  4 ++++
>  arch/riscv/include/asm/hwcap.h          |  5 +++++
>  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
>  arch/riscv/kernel/cpu.c                 |  1 +
>  arch/riscv/kernel/cpufeature.c          |  1 +
>  5 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..6ddacc6f44b9 100644
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
> index e48eebdd2631..dc47019a0b38 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_RISCV_HWCAP_H
>  #define _ASM_RISCV_HWCAP_H
>  
> +#include <asm/errno.h>
>  #include <linux/bits.h>
>  #include <uapi/asm/hwcap.h>
>  
> @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
>  	RISCV_ISA_EXT_SVPBMT,
> +	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
>   */
>  enum riscv_isa_ext_key {
>  	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
> +	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_KEY_MAX,
>  };
>  
> @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
>  		return RISCV_ISA_EXT_KEY_FPU;
>  	case RISCV_ISA_EXT_d:
>  		return RISCV_ISA_EXT_KEY_FPU;
> +	case RISCV_ISA_EXT_ZIHINTPAUSE:
> +		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 134388cbaaa1..1e4f8b4aef79 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -4,15 +4,30 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/jump_label.h>
>  #include <asm/barrier.h>
> +#include <asm/hwcap.h>
>  
>  static inline void cpu_relax(void)
>  {
> +	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
>  #ifdef __riscv_muldiv
> -	int dummy;
> -	/* In lieu of a halt instruction, induce a long-latency stall. */
> -	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> +		int dummy;
> +		/* In lieu of a halt instruction, induce a long-latency stall. */
> +		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>  #endif
> +	} else {
> +		/*
> +		 * Reduce instruction retirement.
> +		 * This assumes the PC changes.
> +		 */
> +#ifdef __riscv_zihintpause
> +		__asm__ __volatile__ ("pause");
> +#else
> +		/* Encoding of the pause instruction */
> +		__asm__ __volatile__ (".4byte 0x100000F");
> +#endif
> +	}
>  	barrier();
>  }
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..a123e92b14dd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b3ec44e25f5..708df2c0bc34 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
