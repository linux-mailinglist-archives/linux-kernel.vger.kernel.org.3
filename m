Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CA5AA862
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiIBGxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiIBGxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:53:41 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0507B6D65
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:53:40 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l196so1834694ybl.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wIY3Cp70hOwu5cFFqibpP3VvX84nHcY+aOjHPogHvC8=;
        b=dFiTkme8yhUBNTEDn/G5bfjKQV3zaMBemnKrGUidQPKV73pDDm0/O3rJikO7OmNcNC
         CeyZyBAPE6BNDl84ueflTzvDXws9uQTiHGpC6U7SCxiQTzHS2x/K1hHERhe66PPfCJyI
         Un61ZDQS0+93PiwFOIHD8Y2h0Kye6B0H7KZnEJzwx6MSPMfjybPR0bKEj88gbK2GhCua
         z+WsdwqScNbnpT6r20Mp1aiyHVYdN5Pje/2wplBqCKg9w9ygdDLhNdIaHwlV3Bwm2l01
         qcZDo7tCyFT4KSll1wtj3WiScdDPj1Pwx3D5G5V3VC84M+2kc1igW61TifKII3lrDeW2
         3Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wIY3Cp70hOwu5cFFqibpP3VvX84nHcY+aOjHPogHvC8=;
        b=lDNS7zO1/YOr1sb0K4u8Mc+WQV/ISN0pXqBgNFcF++e0k/ZcIyUxNcKTqZfT3R3gZW
         X08wYiWcb+yvaqZGRlG3mE4qxutAF8rjNUWs9cqwJKFtWrKr9x8JtYBA+QjnpEE3yK5N
         HIH7TsrJVWTawhzN8Q2KFXVOZHhjFXFFRtCKp0uFw4J5sqJecD7ajlBf1FWKPKARqSq7
         ANGFU0vsd8ZsWrsYTb7rh2rtUxMC30Od5FCHZMiJBKpeSy9rWp30jUGWaakVaW+iv2sC
         EJcRfcTgatPkE03nP2/7daOCBOO/9XsgyuFwXkd/hONoSULaRzjtZamSl2sMMAt6Wf4n
         s1iA==
X-Gm-Message-State: ACgBeo2MtSZ5lYNizAoC5bMvjM9yXlpMX/oSup9BITss/pn/VXIbPKhe
        WhOzPsjZ/zIWerE2/NhjXXXxBf63y8Qxyyt16jhBPg==
X-Google-Smtp-Source: AA6agR6MuE7RB8+w12z3VJ7uoIW/RDkmfJPN4yb5SS8a3RCWRegG5J0V5LcMVfNFMSF7X6Sauts4+68neHFzBxdb7ss=
X-Received: by 2002:a25:234a:0:b0:696:435f:df06 with SMTP id
 j71-20020a25234a000000b00696435fdf06mr21650473ybj.180.1662101619673; Thu, 01
 Sep 2022 23:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172500.752195-1-ajones@ventanamicro.com> <20220831172500.752195-5-ajones@ventanamicro.com>
In-Reply-To: <20220831172500.752195-5-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Sep 2022 12:23:27 +0530
Message-ID: <CAAhSdy1746pbZKBuFizhv6e8_ivSd4ePNkN_OG6X0NEhcrVRfw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: KVM: Apply insn-def to hlv encodings
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mchitale@ventanamicro.com, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:55 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> Introduce hlv instruction encodings and apply them to KVM's use.
> We're careful not to introduce hlv.d to 32-bit builds. Indeed,
> we ensure the build fails if someone tries to use it.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

I have queued this patch for Linux-6.1

Thanks,
Anup

> ---
>  arch/riscv/include/asm/insn-def.h | 17 +++++++++++++++++
>  arch/riscv/kvm/vcpu_exit.c        | 29 +++++------------------------
>  2 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index 86c1f602413b..8fe9036efb68 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -93,4 +93,21 @@
>         INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49),              \
>                __RD(0), RS1(gaddr), RS2(vmid))
>
> +#define HLVX_HU(dest, addr)                                    \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(50),              \
> +              RD(dest), RS1(addr), __RS2(3))
> +
> +#define HLV_W(dest, addr)                                      \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(52),              \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#ifdef CONFIG_64BIT
> +#define HLV_D(dest, addr)                                      \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(54),              \
> +              RD(dest), RS1(addr), __RS2(0))
> +#else
> +#define HLV_D(dest, addr)      \
> +       __ASM_STR(.error "hlv.d requires 64-bit support")
> +#endif
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index d5c36386878a..da793f113a72 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/kvm_host.h>
>  #include <asm/csr.h>
> +#include <asm/insn-def.h>
>
>  static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                              struct kvm_cpu_trap *trap)
> @@ -82,22 +83,12 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
>                         ".option push\n"
>                         ".option norvc\n"
>                         "add %[ttmp], %[taddr], 0\n"
> -                       /*
> -                        * HLVX.HU %[val], (%[addr])
> -                        * HLVX.HU t0, (t2)
> -                        * 0110010 00011 00111 100 00101 1110011
> -                        */
> -                       ".word 0x6433c2f3\n"
> +                       HLVX_HU(%[val], %[addr])
>                         "andi %[tmp], %[val], 3\n"
>                         "addi %[tmp], %[tmp], -3\n"
>                         "bne %[tmp], zero, 2f\n"
>                         "addi %[addr], %[addr], 2\n"
> -                       /*
> -                        * HLVX.HU %[tmp], (%[addr])
> -                        * HLVX.HU t1, (t2)
> -                        * 0110010 00011 00111 100 00110 1110011
> -                        */
> -                       ".word 0x6433c373\n"
> +                       HLVX_HU(%[tmp], %[addr])
>                         "sll %[tmp], %[tmp], 16\n"
>                         "add %[val], %[val], %[tmp]\n"
>                         "2:\n"
> @@ -121,19 +112,9 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
>                         ".option norvc\n"
>                         "add %[ttmp], %[taddr], 0\n"
>  #ifdef CONFIG_64BIT
> -                       /*
> -                        * HLV.D %[val], (%[addr])
> -                        * HLV.D t0, (t2)
> -                        * 0110110 00000 00111 100 00101 1110011
> -                        */
> -                       ".word 0x6c03c2f3\n"
> +                       HLV_D(%[val], %[addr])
>  #else
> -                       /*
> -                        * HLV.W %[val], (%[addr])
> -                        * HLV.W t0, (t2)
> -                        * 0110100 00000 00111 100 00101 1110011
> -                        */
> -                       ".word 0x6803c2f3\n"
> +                       HLV_W(%[val], %[addr])
>  #endif
>                         ".option pop"
>                 : [val] "=&r" (val),
> --
> 2.37.2
>
