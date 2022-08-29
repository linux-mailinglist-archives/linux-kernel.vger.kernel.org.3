Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE16D5A4545
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiH2IiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2IiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:38:13 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2F57E02
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:38:12 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3413ad0640dso22315197b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mK4rg30aTYEASjNFzr6HKKVbPhWWXO7rNvgLsCU003E=;
        b=PGNuleX37vDR6dOY0fMMebPTnPZ1XM8BvngSnofhx4oo7AfrJ8BCfLOiBV8TDw2TZP
         cTH/rajG5+vCdjIsy+Ydpuf4qa9Hr502L0HZqHlRJT8qltGhZWPoxzzzdG3tzJ0dZGL+
         QAm6/LbNOMZHQwf+AMrqWC07OgKKKIfTCaAZZ/SUCXm7/X4WmzUxj30QigHFBL4mKHGi
         eDGSu9HbapVr6lx8UGADsY44ruVqs54cOMZEZ2i+xVYRpWON4c+zqedcMtIMSeuJb/vw
         pXf+SjhCRQ+G0aSAuG6TEoMXWvzaOvTP7/77JUO3tjYfeKfDP0zVxN4xmO+L7cGEanNZ
         i5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mK4rg30aTYEASjNFzr6HKKVbPhWWXO7rNvgLsCU003E=;
        b=QmOZPLotOMO6oX1spfdxPJrQgrjBJ1QBRSC+jVO+lEuNFQORwzGtlATK8TatyAD+dG
         q6zgHWC89CIDGxHrxFPX8S09K3W2lBdHd/G5wR5BKIoVO+GKWWfgKyGn424q8/NPSFjm
         EciGWzZQ2HIHN9qZ1ESwVRcqGSfFo4mpgglijZcrI12wlA50Im/ZnkrAoGH6jjbmXNEi
         5kfGIb/6Dt3yhn2L8+AhPaQ0K+4BS7I86YhGc4p+mV3oREl9A0Z8bV/CHwTd0LwkQ396
         rbKexegutK4otgrYr/JfUb5RWEr5RVYQrSAaVoJqdKQB/f4zR2jNx1PEOHS6Oukx+L+v
         CjWQ==
X-Gm-Message-State: ACgBeo3lGQMsAt18IuZuo45NpsGvC5ZNv4iwJzq9NNxppEGICHEAptG7
        s+BJsh/jDKmjIIfG+6I+1caIkLvUDB7Fl2Ah7nrpVg==
X-Google-Smtp-Source: AA6agR6NdQQdI+j2k9zFaYZtFdhtE4xru7weApQHoj/gdV8ZfU2z17o0wqu4xl5EcEcB2xm1CEIvGYCG+IgANG2FVWM=
X-Received: by 2002:a0d:ca90:0:b0:337:e1b4:93f7 with SMTP id
 m138-20020a0dca90000000b00337e1b493f7mr9143765ywd.153.1661762291640; Mon, 29
 Aug 2022 01:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220819140250.3892995-1-ajones@ventanamicro.com> <20220819140250.3892995-4-ajones@ventanamicro.com>
In-Reply-To: <20220819140250.3892995-4-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Aug 2022 14:07:59 +0530
Message-ID: <CAAhSdy0d8mjr5-5Um2DpLgnhPb3UnGggXvbu_=oqEHWYzMP1SQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: KVM: Apply insn-def to hfence encodings
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
> Introduce hfence instruction encodings and apply them to KVM's use.
> With the self-documenting nature of the instruction encoding macros,
> and a spec always within arm's reach, it's safe to remove the
> comments, so we do that too.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/insn-def.h |   8 ++
>  arch/riscv/kvm/tlb.c              | 117 ++++--------------------------
>  2 files changed, 21 insertions(+), 104 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index 4cd0208068dd..cd1c0d365f47 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -79,4 +79,12 @@
>  #define RS1(v)         __REG(v)
>  #define RS2(v)         __REG(v)
>
> +#define OPCODE_SYSTEM  OPCODE(115)
> +
> +#define HFENCE_VVMA(vaddr, asid)       \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17), RD(0), vaddr, asid)
> +
> +#define HFENCE_GVMA(gaddr, vmid)       \
> +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49), RD(0), gaddr, vmid)
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 1a76d0b1907d..f742a0d888e1 100644
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
> @@ -41,31 +26,14 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
>         }
>
>         for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
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
> +               asm volatile (HFENCE_GVMA("%0", "%1")
> +               : : "r" (pos >> 2), "r" (vmid) : "memory");

You can drop the for-loop braces "{ }"

>         }
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
> +       asm volatile(HFENCE_GVMA("zero", "%0") : : "r" (vmid) : "memory");
>  }
>
>  void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
> @@ -79,45 +47,16 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
>         }
>
>         for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
> -               /*
> -                * rs1 = a0 (GPA >> 2)
> -                * rs2 = zero
> -                * HFENCE.GVMA a0
> -                * 0110001 00000 01010 000 00000 1110011
> -                */
> -               asm volatile ("srli a0, %0, 2\n"
> -                             ".word 0x62050073\n"
> -                             :: "r" (pos) : "a0", "memory");
> +               asm volatile(HFENCE_GVMA("%0", "zero")
> +               : : "r" (pos >> 2) : "memory");

You can drop the for-loop braces "{ }"

>         }
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
> +       asm volatile(HFENCE_GVMA("zero", "zero") : : : "memory");
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
> @@ -134,17 +73,8 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
>         hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
>
>         for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
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
> +               asm volatile(HFENCE_VVMA("%0", "%1")
> +               : : "r" (pos), "r" (asid) : "memory");

You can drop the for-loop braces "{ }"

>         }
>
>         csr_write(CSR_HGATP, hgatp);
> @@ -157,15 +87,7 @@ void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
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
> +       asm volatile(HFENCE_VVMA("zero", "%0") : : "r" (asid) : "memory");
>
>         csr_write(CSR_HGATP, hgatp);
>  }
> @@ -184,15 +106,8 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
>         hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
>
>         for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
> -               /*
> -                * rs1 = a0 (GVA)
> -                * rs2 = zero
> -                * HFENCE.VVMA a0
> -                * 0010001 00000 01010 000 00000 1110011
> -                */
> -               asm volatile ("add a0, %0, zero\n"
> -                             ".word 0x22050073\n"
> -                             :: "r" (pos) : "a0", "memory");
> +               asm volatile(HFENCE_VVMA("%0", "zero")
> +               : : "r" (pos) : "memory");
>         }
>
>         csr_write(CSR_HGATP, hgatp);
> @@ -204,13 +119,7 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
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
> +       asm volatile(HFENCE_VVMA("zero", "zero") : : : "memory");
>
>         csr_write(CSR_HGATP, hgatp);
>  }
> --
> 2.37.1
>

Apart from a few nits above, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
