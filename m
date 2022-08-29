Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69745A455F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiH2Iop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH2Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:44:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C635852A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:44:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-33dc345ad78so178268637b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1yW+bhE9+ZFac5QeY281cS30MjpG8faRBPP5xaLH1ik=;
        b=QlgzppbUe2lymOGkvPwg+0AeCbLuxdihrHKCrgRIrwnUqdBLm3t1ZAIk9uHBYcOp31
         BDz+A1fB2qoonPf0GNlPTKEPz3qHg+jPB6dzaYaAE9tb0pB1ZCFmQqEA0LNVnETv+eMT
         1MVrXM9mJ1LAmiVlGA2pcq/kVdtRstHVexIUxFcOkg+0IlnCxYxlLmrKMHStVLNZEmki
         7v8h3YEQh00wLEwXVtKA8sf3ndOUVgzIaFLrN6RTrLTU7eoGaDs0jioDlkOpMK1fc8jS
         AH9F9/9TLDjVIFImCoSerqcbu5gBtWrMw9hgoUVFCScD8zHJZFFIYYbf8iLMPqs63pgk
         miMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1yW+bhE9+ZFac5QeY281cS30MjpG8faRBPP5xaLH1ik=;
        b=As99bEFV3OYz5ndTE3sPOSRn9ND30M+HSL1R2SgovC/WFkkl3CqCt35gEqmz3S2pGN
         oaZ1WcaRf4X8/q9jskZKrpNtHKdahDT3wnytfDyEbDChbsLm32zdE0fJzCwzrfX6P1pn
         37qUI/N9luI56JkIv/2R7Mo64BEoplvuTSZC+G1KU6MKIixvA1iZUKieUN1LO1uh8A+Q
         rDO+R9UEsWz00wiW9/vukXsLe4xTBWOkKTRiQucZ9LxbhIo7EDotSYI/9RY0vrnTfiLJ
         9cOdCz+Vss0tGi19I7Gmyr6uMT40hcRy/2bjPl0/un57ghjRbpxMkc8bm3D9YOIM3Vsx
         /aJw==
X-Gm-Message-State: ACgBeo3vF3dOFt0NdKKIsorrrMHgBImZV1AfBzyJYqQspiLOcg2Ly4sj
        D23O9nvI3XEFWHoUto3i58vXrcg36cfR9X/mGUk1JQ==
X-Google-Smtp-Source: AA6agR6xQlUeyzZ565/n3/dG5B76qdPOm3hNh3tVEJe93vgFGTVmrP1dbEMeHGNNG+po4+lFLfdz+JltfSHm/Besd1Q=
X-Received: by 2002:a25:234a:0:b0:696:435f:df06 with SMTP id
 j71-20020a25234a000000b00696435fdf06mr7510246ybj.180.1661762681311; Mon, 29
 Aug 2022 01:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220819140250.3892995-1-ajones@ventanamicro.com> <20220819140250.3892995-5-ajones@ventanamicro.com>
In-Reply-To: <20220819140250.3892995-5-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Aug 2022 14:14:29 +0530
Message-ID: <CAAhSdy1W4fxNtyF5pqi3Riv3bXv3v+6t7cdf8z_3YGGB7xBEEQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: KVM: Apply insn-def to hlv encodings
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

On Fri, Aug 19, 2022 at 7:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> Introduce hlv instruction encodings and apply them to KVM's use.
> We're careful not to introduce hlv.d to 32-bit builds. Indeed,
> we ensure the build fails if someone tries to use it.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/insn-def.h | 14 ++++++++++++++
>  arch/riscv/kvm/vcpu_exit.c        | 29 +++++------------------------
>  2 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index cd1c0d365f47..c66d5745c5b4 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -87,4 +87,18 @@
>  #define HFENCE_GVMA(gaddr, vmid)       \
>         INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49), RD(0), gaddr, vmid)
>
> +#define HLVX_HU(dest, addr)    \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(50), dest, addr, RS2(3))
> +
> +#define HLV_W(dest, addr)      \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(52), dest, addr, RS2(0))
> +
> +#ifdef CONFIG_64BIT
> +#define HLV_D(dest, addr)      \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(54), dest, addr, RS2(0))
> +#else
> +#define HLV_D(dest, addr)      \
> +       __ASM_STR(.error "hlv.d requires 64-bit support")
> +#endif
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index d5c36386878a..9cb075e72799 100644
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
> +                       HLVX_HU("%[val]", "%[addr]")
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
> +                       HLVX_HU("%[tmp]", "%[addr]")
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
> +                       HLV_D("%[val]", "%[addr]")
>  #else
> -                       /*
> -                        * HLV.W %[val], (%[addr])
> -                        * HLV.W t0, (t2)
> -                        * 0110100 00000 00111 100 00101 1110011
> -                        */
> -                       ".word 0x6803c2f3\n"
> +                       HLV_W("%[val]", "%[addr]")
>  #endif
>                         ".option pop"
>                 : [val] "=&r" (val),
> --
> 2.37.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
