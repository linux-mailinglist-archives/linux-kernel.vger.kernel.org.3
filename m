Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE365AA861
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiIBGxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiIBGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:53:06 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03606B2484
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:53:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e71so1858317ybh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=G4A/KxhpCFYxGgLtJzP/rzUH1ZO/06KwbZC0QMdlckM=;
        b=cHfRRMW/Eb25FS9/fCim4TINWhtTRCwemGgambdIWTG5jxgCd6qG5ittvJQjhvVe/C
         ZLyCVEp7xC7OwF9qA/Q9Ys2y1nlB3aNt7/4feUMoGBvmZ/93yJajC78H04Z0LYSJl9dC
         bA2qe/Ba6sHO3Y9aENbh6LDNQy2abVD0FtRhvc2PkTZSkLD9TX5+HZNAa75HtOa8JFXb
         ms/O4r0sJcSiVT6OIt5ruX2dVYUMibHGNmx0DMEfI7gnqjz7P6AK8zch+Bk9KBLWtRIq
         TSysTVU7zBoFlnlZs/k1n2CFz8FaqCfj/IY9As/n8scS7Q4Ty+gM+tNNH5zBCfWWqdRg
         yNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G4A/KxhpCFYxGgLtJzP/rzUH1ZO/06KwbZC0QMdlckM=;
        b=GA1PVRtT8wL1bXZtkgCSxeLgVRq4tAL9zZMhDUR3xvOUXEGTmHJcXkQiQOz+TaTcQ6
         Edn+P76H6RK85JyeSS+M4jVHml6nNWTga/fuxgC1eZ4PjxlwjbknTq8g9w9r/D426Yn8
         DzKz8XSR/+eCVdkH74UVp0LjQX51uoco3Sm0Z4rfBqaA+mA+wy0mFKDtHI1gFQIJWuWC
         8SmhzrBuDL1+HvvkP7uk6hmG3mzO50OUnoA8ClqtEav2nJnL3YXgT8IXGPaJQeAyfZpr
         WtKHL4XF0dgrPM38MZOD6B3YIYwyVPVi4uhP6jUB0Jce8j7MEVyil6X6j80+yrvz3DjT
         E1Yg==
X-Gm-Message-State: ACgBeo3Tqke+sCgWLpteAmtetFWMUhtIA7LIcrw1Llm7Ok0SdcsyIkvc
        am2ezdX/KiKSLdz2LMsPkhcubvmQ+Wo5bYxjSuIkNaozq4Yy4Wpd
X-Google-Smtp-Source: AA6agR5s8vHN5eZuS218v2kQcW4DXQxxnHryP8igjGVcfD3C014mvhVGtuj6XB963SU0LJvrora+3bLOuclIn1CKsS4=
X-Received: by 2002:a5b:850:0:b0:68c:5798:a927 with SMTP id
 v16-20020a5b0850000000b0068c5798a927mr21602190ybq.8.1662101581741; Thu, 01
 Sep 2022 23:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172500.752195-1-ajones@ventanamicro.com> <20220831172500.752195-4-ajones@ventanamicro.com>
In-Reply-To: <20220831172500.752195-4-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Sep 2022 12:22:49 +0530
Message-ID: <CAAhSdy2584T0GD7JFZfT1_mUFrqHOk10NLH=5ipcgkfi2SHNiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] riscv: KVM: Apply insn-def to hfence encodings
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
> Introduce hfence instruction encodings and apply them to KVM's use.
> With the self-documenting nature of the instruction encoding macros,
> and a spec always within arm's reach, it's safe to remove the
> comments, so we do that too.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

I have queued this patch for Linux-6.1

Thanks,
Anup

> ---
>  arch/riscv/include/asm/insn-def.h |  10 +++
>  arch/riscv/kvm/tlb.c              | 129 ++++--------------------------
>  2 files changed, 27 insertions(+), 112 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index 2dcd1d4781bf..86c1f602413b 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -83,4 +83,14 @@
>  #define __RS1(v)       __REG(v)
>  #define __RS2(v)       __REG(v)
>
> +#define OPCODE_SYSTEM  OPCODE(115)
> +
> +#define HFENCE_VVMA(vaddr, asid)                               \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),              \
> +              __RD(0), RS1(vaddr), RS2(asid))
> +
> +#define HFENCE_GVMA(gaddr, vmid)                               \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49),              \
> +              __RD(0), RS1(gaddr), RS2(vmid))
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 1a76d0b1907d..1ce3394b3acf 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -12,22 +12,7 @@
>  #include <linux/kvm_host.h>
>  #include <asm/cacheflush.h>
>  #include <asm/csr.h>
> -
> -/*
> - * Instruction encoding of hfence.gvma is:
> - * HFENCE.GVMA rs1, rs2
> - * HFENCE.GVMA zero, rs2
> - * HFENCE.GVMA rs1
> - * HFENCE.GVMA
> - *
> - * rs1!=zero and rs2!=zero ==> HFENCE.GVMA rs1, rs2
> - * rs1==zero and rs2!=zero ==> HFENCE.GVMA zero, rs2
> - * rs1!=zero and rs2==zero ==> HFENCE.GVMA rs1
> - * rs1==zero and rs2==zero ==> HFENCE.GVMA
> - *
> - * Instruction encoding of HFENCE.GVMA is:
> - * 0110001 rs2(5) rs1(5) 000 00000 1110011
> - */
> +#include <asm/insn-def.h>
>
>  void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
>                                           gpa_t gpa, gpa_t gpsz,
> @@ -40,32 +25,14 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
>                 return;
>         }
>
> -       for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
> -               /*
> -                * rs1 = a0 (GPA >> 2)
> -                * rs2 = a1 (VMID)
> -                * HFENCE.GVMA a0, a1
> -                * 0110001 01011 01010 000 00000 1110011
> -                */
> -               asm volatile ("srli a0, %0, 2\n"
> -                             "add a1, %1, zero\n"
> -                             ".word 0x62b50073\n"
> -                             :: "r" (pos), "r" (vmid)
> -                             : "a0", "a1", "memory");
> -       }
> +       for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
> +               asm volatile (HFENCE_GVMA(%0, %1)
> +               : : "r" (pos >> 2), "r" (vmid) : "memory");
>  }
>
>  void kvm_riscv_local_hfence_gvma_vmid_all(unsigned long vmid)
>  {
> -       /*
> -        * rs1 = zero
> -        * rs2 = a0 (VMID)
> -        * HFENCE.GVMA zero, a0
> -        * 0110001 01010 00000 000 00000 1110011
> -        */
> -       asm volatile ("add a0, %0, zero\n"
> -                     ".word 0x62a00073\n"
> -                     :: "r" (vmid) : "a0", "memory");
> +       asm volatile(HFENCE_GVMA(zero, %0) : : "r" (vmid) : "memory");
>  }
>
>  void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
> @@ -78,46 +45,16 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
>                 return;
>         }
>
> -       for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
> -               /*
> -                * rs1 = a0 (GPA >> 2)
> -                * rs2 = zero
> -                * HFENCE.GVMA a0
> -                * 0110001 00000 01010 000 00000 1110011
> -                */
> -               asm volatile ("srli a0, %0, 2\n"
> -                             ".word 0x62050073\n"
> -                             :: "r" (pos) : "a0", "memory");
> -       }
> +       for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
> +               asm volatile(HFENCE_GVMA(%0, zero)
> +               : : "r" (pos >> 2) : "memory");
>  }
>
>  void kvm_riscv_local_hfence_gvma_all(void)
>  {
> -       /*
> -        * rs1 = zero
> -        * rs2 = zero
> -        * HFENCE.GVMA
> -        * 0110001 00000 00000 000 00000 1110011
> -        */
> -       asm volatile (".word 0x62000073" ::: "memory");
> +       asm volatile(HFENCE_GVMA(zero, zero) : : : "memory");
>  }
>
> -/*
> - * Instruction encoding of hfence.gvma is:
> - * HFENCE.VVMA rs1, rs2
> - * HFENCE.VVMA zero, rs2
> - * HFENCE.VVMA rs1
> - * HFENCE.VVMA
> - *
> - * rs1!=zero and rs2!=zero ==> HFENCE.VVMA rs1, rs2
> - * rs1==zero and rs2!=zero ==> HFENCE.VVMA zero, rs2
> - * rs1!=zero and rs2==zero ==> HFENCE.VVMA rs1
> - * rs1==zero and rs2==zero ==> HFENCE.VVMA
> - *
> - * Instruction encoding of HFENCE.VVMA is:
> - * 0010001 rs2(5) rs1(5) 000 00000 1110011
> - */
> -
>  void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
>                                           unsigned long asid,
>                                           unsigned long gva,
> @@ -133,19 +70,9 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
>
>         hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
>
> -       for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
> -               /*
> -                * rs1 = a0 (GVA)
> -                * rs2 = a1 (ASID)
> -                * HFENCE.VVMA a0, a1
> -                * 0010001 01011 01010 000 00000 1110011
> -                */
> -               asm volatile ("add a0, %0, zero\n"
> -                             "add a1, %1, zero\n"
> -                             ".word 0x22b50073\n"
> -                             :: "r" (pos), "r" (asid)
> -                             : "a0", "a1", "memory");
> -       }
> +       for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
> +               asm volatile(HFENCE_VVMA(%0, %1)
> +               : : "r" (pos), "r" (asid) : "memory");
>
>         csr_write(CSR_HGATP, hgatp);
>  }
> @@ -157,15 +84,7 @@ void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
>
>         hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
>
> -       /*
> -        * rs1 = zero
> -        * rs2 = a0 (ASID)
> -        * HFENCE.VVMA zero, a0
> -        * 0010001 01010 00000 000 00000 1110011
> -        */
> -       asm volatile ("add a0, %0, zero\n"
> -                     ".word 0x22a00073\n"
> -                     :: "r" (asid) : "a0", "memory");
> +       asm volatile(HFENCE_VVMA(zero, %0) : : "r" (asid) : "memory");
>
>         csr_write(CSR_HGATP, hgatp);
>  }
> @@ -183,17 +102,9 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
>
>         hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
>
> -       for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
> -               /*
> -                * rs1 = a0 (GVA)
> -                * rs2 = zero
> -                * HFENCE.VVMA a0
> -                * 0010001 00000 01010 000 00000 1110011
> -                */
> -               asm volatile ("add a0, %0, zero\n"
> -                             ".word 0x22050073\n"
> -                             :: "r" (pos) : "a0", "memory");
> -       }
> +       for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
> +               asm volatile(HFENCE_VVMA(%0, zero)
> +               : : "r" (pos) : "memory");
>
>         csr_write(CSR_HGATP, hgatp);
>  }
> @@ -204,13 +115,7 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
>
>         hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
>
> -       /*
> -        * rs1 = zero
> -        * rs2 = zero
> -        * HFENCE.VVMA
> -        * 0010001 00000 00000 000 00000 1110011
> -        */
> -       asm volatile (".word 0x22000073" ::: "memory");
> +       asm volatile(HFENCE_VVMA(zero, zero) : : : "memory");
>
>         csr_write(CSR_HGATP, hgatp);
>  }
> --
> 2.37.2
>
