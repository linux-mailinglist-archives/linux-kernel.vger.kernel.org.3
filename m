Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10D658FF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiHKPRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiHKPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:17:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129286B664
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:17:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g13so10246189plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=p+0Ss2uNSq7fjLq1VET4nazGOVqQ83BUqbunc7XQPBI=;
        b=Pz8T+gq1EEvdr/AXym9QKtEPRsBzJ7wamCO9/rxJ9T58QnrbvEhJqL47pyjPp5+pOP
         HZKV75NLQZxP83HqO8/BDSJrC3hBgHbtfLB/Yc/kl22yAvtsjU/E1YsYnCJdav/tyTGq
         17QhpzUMgrRn64ec576mjL4z+ocLIjtsGkNjbhPtSVQ2ki3Rw6qsslte2wqN5KZI+3YN
         Ekp+WLdXcfSjhn50Px73/RDsWgsW/whsB716cmJuKoWrLjBJmE7Y2/lC3ykag9+cA/kr
         oRFFdyF9oDwL0+HqKOOeTYvVz98M/N1u+M9cMupuCJ40QIAQKiVUnjCbsQggWqDP5QIL
         ElVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=p+0Ss2uNSq7fjLq1VET4nazGOVqQ83BUqbunc7XQPBI=;
        b=V3LpFCg2lMg1HB8cuqx6YsPt93pw5S1NE3QHSkr0EGZ3otEHuwazcAygyj/4ln54ig
         IXQ+EgKOUkEJBcKMHJv42eiXRONHCAC/K9MiOqHEdTwAr6CVcdnPlpR39op3ivA7tE81
         FHog1ZDY1d2vOVj+2Nz6qV+Qi2KDU2iSTU8fgru24XSCseIP1YAOKgyo1BrRNV1KUMA4
         yJhYJmSA72q3Fmg7OdrxDibys17BHlwK2Xyd9lwE4EUKa9Y+9aUSoIPi3FxefqJxfGa2
         mRIBnwTzk2q3Nb524ehhlW377MikavmtTy6zawyiNflECBW5P98l4Fi/2mrq4bDfY1lg
         aCWw==
X-Gm-Message-State: ACgBeo30SlBK5/ThWNNt5ZlHS0RqENwE/NTmf9AIEvwOHSMcyvRPX31/
        EJZX2X0BQD5bK6u+RTABB1duRD52WcLuXQ==
X-Google-Smtp-Source: AA6agR7mrmvdJicd/jfZ7zcQH1uf7vuoabl74bIZiNFfsk6sDeWlUQ/ihhQlxFbhCJHeq1ZfPWT7GQ==
X-Received: by 2002:a17:902:6509:b0:170:960d:ca5e with SMTP id b9-20020a170902650900b00170960dca5emr22529848plk.118.1660231053193;
        Thu, 11 Aug 2022 08:17:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b0052e6d5ee183sm4141099pfb.129.2022.08.11.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:17:32 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:17:32 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 08:12:34 PDT (-0700)
Subject:     Re: [PATCH v4] arch/riscv: add Zihintpause support
In-Reply-To: <20220620201530.3929352-1-daolu@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, daolu@rivosinc.com, heiko@sntech.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        guoren@kernel.org, jszhang@kernel.org, rdunlap@infradead.org,
        niklas.cassel@wdc.com, panqinglin2020@iscas.ac.cn,
        alexandre.ghiti@canonical.com, Rob Herring <robh@kernel.org>,
        research_trasio@irq.a4lg.com, yury.norov@gmail.com,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     daolu@rivosinc.com
Message-ID: <mhng-381981dd-6fb1-48bc-bdd7-5b613160ef0f@palmer-mbp2014>
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

On Mon, 20 Jun 2022 13:15:25 PDT (-0700), daolu@rivosinc.com wrote:
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

Thanks, this is on for-next.  It needs a sparse patch, which I put in as a link.
