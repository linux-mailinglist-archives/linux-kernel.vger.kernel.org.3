Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98A576E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiGPOME convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 16 Jul 2022 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGPOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:12:03 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB78210
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:12:00 -0700 (PDT)
Received: from p508fdc54.dip0.t-ipconnect.de ([80.143.220.84] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oCiWP-0000Zy-Tj; Sat, 16 Jul 2022 16:11:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dao Lu <daolu@rivosinc.com>, linux-kernel@vger.kernel.org,
        Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
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
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
Date:   Sat, 16 Jul 2022 16:11:41 +0200
Message-ID: <8823276.lOV4Wx5bFT@phil>
In-Reply-To: <18a1126c-393e-9c52-4b30-caee01975ad1@conchuod.ie>
References: <20220620201530.3929352-1-daolu@rivosinc.com> <18a1126c-393e-9c52-4b30-caee01975ad1@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. Juli 2022, 22:44:21 CEST schrieb Conor Dooley:
> On 20/06/2022 21:15, Dao Lu wrote:
> > [PATCH v4] arch/riscv: add Zihintpause support
> 
> A little ornery/pedantic maybe, but the "arch/" isn't needed.
> Guess it can easily be fixed on application or if there's a
> v5 so there's prob no need to resend.

I noticed that the patch prefix on riscv is all over the place
in a lot of cases. There are

- RISC-V:
-riscv:
- now arch/riscv:

and probably even more.

I guess someone should just decide on one prefix that then
gets used (and slightly enforced) all the time.

Even just modifying applied patches to one specific prefix should
already solve the issue in a short time, as I guess most people will
just get the appicable prefix from a "git log" ;-) .


Heiko

> > Implement support for the ZiHintPause extension.
> > 
> > The PAUSE instruction is a HINT that indicates the current hart’s rate
> > of instruction retirement should be temporarily reduced or paused.
> > 
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > ---
> > 
> > v1 -> v2:
> >  Remove the usage of static branch, use PAUSE if toolchain supports it
> > v2 -> v3:
> >  Added the static branch back, cpu_relax() behavior is kept the same for
> > systems that do not support ZiHintPause
> > v3 -> v4:
> >  Adopted the newly added unified static keys for extensions
> > ---
> >  arch/riscv/Makefile                     |  4 ++++
> >  arch/riscv/include/asm/hwcap.h          |  5 +++++
> >  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
> >  arch/riscv/kernel/cpu.c                 |  1 +
> >  arch/riscv/kernel/cpufeature.c          |  1 +
> >  5 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 34cf8a598617..6ddacc6f44b9 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
> >  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
> >  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
> >  
> > +# Check if the toolchain supports Zihintpause extension
> > +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> > +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> > +
> >  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
> >  KBUILD_AFLAGS += -march=$(riscv-march-y)
> >  
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index e48eebdd2631..dc47019a0b38 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -8,6 +8,7 @@
> >  #ifndef _ASM_RISCV_HWCAP_H
> >  #define _ASM_RISCV_HWCAP_H
> >  
> > +#include <asm/errno.h>
> >  #include <linux/bits.h>
> >  #include <uapi/asm/hwcap.h>
> >  
> > @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
> >  enum riscv_isa_ext_id {
> >  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> >  	RISCV_ISA_EXT_SVPBMT,
> > +	RISCV_ISA_EXT_ZIHINTPAUSE,
> >  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> >  };
> >  
> > @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
> >   */
> >  enum riscv_isa_ext_key {
> >  	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
> > +	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> >  	RISCV_ISA_EXT_KEY_MAX,
> >  };
> >  
> > @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
> >  		return RISCV_ISA_EXT_KEY_FPU;
> >  	case RISCV_ISA_EXT_d:
> >  		return RISCV_ISA_EXT_KEY_FPU;
> > +	case RISCV_ISA_EXT_ZIHINTPAUSE:
> > +		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> > index 134388cbaaa1..1e4f8b4aef79 100644
> > --- a/arch/riscv/include/asm/vdso/processor.h
> > +++ b/arch/riscv/include/asm/vdso/processor.h
> > @@ -4,15 +4,30 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > +#include <linux/jump_label.h>
> >  #include <asm/barrier.h>
> > +#include <asm/hwcap.h>
> >  
> >  static inline void cpu_relax(void)
> >  {
> > +	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
> >  #ifdef __riscv_muldiv
> > -	int dummy;
> > -	/* In lieu of a halt instruction, induce a long-latency stall. */
> > -	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> > +		int dummy;
> > +		/* In lieu of a halt instruction, induce a long-latency stall. */
> > +		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >  #endif
> > +	} else {
> > +		/*
> > +		 * Reduce instruction retirement.
> > +		 * This assumes the PC changes.
> > +		 */
> > +#ifdef __riscv_zihintpause
> > +		__asm__ __volatile__ ("pause");
> > +#else
> > +		/* Encoding of the pause instruction */
> > +		__asm__ __volatile__ (".4byte 0x100000F");
> > +#endif
> > +	}
> >  	barrier();
> >  }
> >  
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index fba9e9f46a8c..a123e92b14dd 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >  static struct riscv_isa_ext_data isa_ext_arr[] = {
> >  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> >  
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 1b3ec44e25f5..708df2c0bc34 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
> >  			} else {
> >  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> >  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> > +				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> >  			}
> >  #undef SET_ISA_EXT_MAP
> >  		}
> 




