Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF151F3E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiEIFiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiEIF3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:29:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD78261B
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:25:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso10103430wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5XQ3hyloMLLLndWdB5WuxNpqTy9IY4sqDd7KReZqGs=;
        b=8RiGiBo+uASe2nrpMeEYKuUlERVz2sxygUTXvTS8ZfE21z62USL/imBvv9O1oDc/KK
         HafKoNK0ndDOWOsrPW2HXF2zZ1Xc4dK+zU6TiAXakwPyB1rEJAIrdpMW9/+V/KZdkGVv
         Nkpcqhmg5TsD7CHqGQukBZ14MgdwAtzWy228sARUW/+86BivOJ/K0oyKdoEdxQEidxjH
         vW095C/5DO/vWVCVodXsGKTPYNKms03cv2Zn+FAVLNSW5qMz9NXxlyliStrX81KD0p9n
         /XmWLZ5tHOrfEdD/ro+T6jQ21AoX6Wz8O8zwnxgJJ5nGyZiU0K9YHc/kWVeTK8XidRKh
         u6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5XQ3hyloMLLLndWdB5WuxNpqTy9IY4sqDd7KReZqGs=;
        b=LaDqqTm4YI7TjU0PKW0rChNl4CdHY3cBCAnHEgwMEMGRvQFCc82ALaJK4nc4EGKwrO
         MMXSDl8vq2zhAgwJw3EJhUP7450M+zUN+qSSPJ9TBnF3PtW7nSxWPfEFuiK/gytsejcl
         FsGF+bnULmbykefO20dtgfxZhvqGipUpycp+wMesWjaxsMqFq67dzs/J355Qsyr0CXET
         9cb9rFEtuCW1QAGTskCdKv1uzX16bPodznaAF+H1nx4Ov4MaJg/RtJkAp8KuopQpPy1U
         nmO83goTB15NSGughxWclEin2kPMSXUIfGSNKcWa2jCv8C4ZV4ynHx7RkIB6vKTIvIOj
         E+bA==
X-Gm-Message-State: AOAM533IjGGyo3Dn6DFIZJpm6+1Azt5hK+VQdmUCzlYf1f/Ay+f2u2Ve
        pkGlPEgZ1fT4XUmuSGix2+4QQxT7FTiFIOQCRDMTkQ==
X-Google-Smtp-Source: ABdhPJxHSZExdSWviiroriTDm831/Jlr/IS7vqQiuq680DL3bLAGu7DJ3UApThrZkmb5ekR7dSqjOv0IKm/PinsyNQE=
X-Received: by 2002:a05:600c:4fd5:b0:394:55ae:32c7 with SMTP id
 o21-20020a05600c4fd500b0039455ae32c7mr20935325wmq.73.1652073937743; Sun, 08
 May 2022 22:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150519.3818093-1-atishp@rivosinc.com>
In-Reply-To: <20220422150519.3818093-1-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 10:55:26 +0530
Message-ID: <CAAhSdy0QW7o9f0_Nqx7KwHtn2Kh4Z-zURZQ2qt--L7Dc8cYnTg@mail.gmail.com>
Subject: Re: [v2 PATCH] RISC-V: KVM: Introduce ISA extension register
To:     Atish Patra <atishp@rivosinc.com>
Cc:     KVM General <kvm@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 8:38 PM Atish Patra <atishp@rivosinc.com> wrote:
>
> Currently, there is no provision for vmm (qemu-kvm or kvmtool) to
> query about multiple-letter ISA extensions. The config register
> is only used for base single letter ISA extensions.
>
> A new ISA extension register is added that will allow the vmm
> to query about any ISA extension one at a time. It is enabled for
> both single letter or multi-letter ISA extensions. The ISA extension
> register is useful to if the vmm requires to retrieve/set single
> extension while the config register should be used if all the base
> ISA extension required to retrieve or set.
>
> For any multi-letter ISA extensions, the new register interface
> must be used.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Changes from v1->v2:
> 1. Sending the patch separate from sstc series as it is unrelated.
> 2. Removed few redundant lines.
>
> The kvm tool patches can be found here.
>
> https://github.com/atishp04/kvmtool/tree/sstc_v2
>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 20 +++++++
>  arch/riscv/kvm/vcpu.c             | 98 +++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index f808ad1ce500..92bd469e2ba6 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -82,6 +82,23 @@ struct kvm_riscv_timer {
>         __u64 state;
>  };
>
> +/**
> + * ISA extension IDs specific to KVM. This is not the same as the host ISA
> + * extension IDs as that is internal to the host and should not be exposed
> + * to the guest. This should always be contiguous to keep the mapping simple
> + * in KVM implementation.
> + */
> +enum KVM_RISCV_ISA_EXT_ID {
> +       KVM_RISCV_ISA_EXT_A = 0,
> +       KVM_RISCV_ISA_EXT_C,
> +       KVM_RISCV_ISA_EXT_D,
> +       KVM_RISCV_ISA_EXT_F,
> +       KVM_RISCV_ISA_EXT_H,
> +       KVM_RISCV_ISA_EXT_I,
> +       KVM_RISCV_ISA_EXT_M,
> +       KVM_RISCV_ISA_EXT_MAX,
> +};
> +
>  /* Possible states for kvm_riscv_timer */
>  #define KVM_RISCV_TIMER_STATE_OFF      0
>  #define KVM_RISCV_TIMER_STATE_ON       1
> @@ -123,6 +140,9 @@ struct kvm_riscv_timer {
>  #define KVM_REG_RISCV_FP_D_REG(name)   \
>                 (offsetof(struct __riscv_d_ext_state, name) / sizeof(__u64))
>
> +/* ISA Extension registers are mapped as type 7 */
> +#define KVM_REG_RISCV_ISA_EXT          (0x07 << KVM_REG_RISCV_TYPE_SHIFT)
> +
>  #endif
>
>  #endif /* __LINUX_KVM_RISCV_H */
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index aad430668bb4..93492eb292fd 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -365,6 +365,100 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
>         return 0;
>  }
>
> +/* Mapping between KVM ISA Extension ID & Host ISA extension ID */
> +static unsigned long kvm_isa_ext_arr[] = {
> +       RISCV_ISA_EXT_a,
> +       RISCV_ISA_EXT_c,
> +       RISCV_ISA_EXT_d,
> +       RISCV_ISA_EXT_f,
> +       RISCV_ISA_EXT_h,
> +       RISCV_ISA_EXT_i,
> +       RISCV_ISA_EXT_m,
> +};
> +
> +static int kvm_riscv_vcpu_get_reg_isa_ext(struct kvm_vcpu *vcpu,
> +                                         const struct kvm_one_reg *reg)
> +{
> +       unsigned long __user *uaddr =
> +                       (unsigned long __user *)(unsigned long)reg->addr;
> +       unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
> +                                           KVM_REG_SIZE_MASK |
> +                                           KVM_REG_RISCV_ISA_EXT);
> +       unsigned long reg_val = 0;
> +       unsigned long host_isa_ext;
> +
> +       if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
> +               return -EINVAL;
> +
> +       if (reg_num >= KVM_RISCV_ISA_EXT_MAX || reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
> +               return -EINVAL;
> +
> +       host_isa_ext = kvm_isa_ext_arr[reg_num];
> +       if (__riscv_isa_extension_available(NULL, host_isa_ext))

This should be "__riscv_isa_extension_available(vcpu->arch.isa, host_isa_ext)".

> +               reg_val = 1; /* Mark the given extension as available */
> +
> +       if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_vcpu *vcpu,
> +                                         const struct kvm_one_reg *reg)
> +{
> +       unsigned long __user *uaddr =
> +                       (unsigned long __user *)(unsigned long)reg->addr;
> +       unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
> +                                           KVM_REG_SIZE_MASK |
> +                                           KVM_REG_RISCV_ISA_EXT);
> +       unsigned long reg_val;
> +       unsigned long host_isa_ext;
> +       unsigned long host_isa_ext_mask;
> +
> +       if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
> +               return -EINVAL;
> +
> +       if (reg_num >= KVM_RISCV_ISA_EXT_MAX || reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
> +               return -EINVAL;
> +
> +       if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
> +               return -EFAULT;
> +
> +       host_isa_ext = kvm_isa_ext_arr[reg_num];
> +       if (!__riscv_isa_extension_available(NULL, host_isa_ext))
> +               return  -EOPNOTSUPP;
> +
> +       if (host_isa_ext >= RISCV_ISA_EXT_BASE &&
> +           host_isa_ext < RISCV_ISA_EXT_MAX) {
> +               /** Multi-letter ISA extension. Currently there is no provision
> +                * to enable/disable the multi-letter ISA extensions for guests.
> +                * Return success if the request is to enable any ISA extension
> +                * that is available in the hardware.
> +                * Return -EOPNOTSUPP otherwise.
> +                */

Use double-winged comment-block for multi-line comments.

> +               if (!reg_val)
> +                       return -EOPNOTSUPP;
> +               else
> +                       return 0;
> +       }
> +
> +       /* Single letter base ISA extension */
> +       if (!vcpu->arch.ran_atleast_once) {
> +               host_isa_ext_mask = BIT_MASK(host_isa_ext);
> +               if (!reg_val && (host_isa_ext_mask & KVM_RISCV_ISA_DISABLE_ALLOWED))
> +                       vcpu->arch.isa &= ~host_isa_ext_mask;
> +               else
> +                       vcpu->arch.isa |= host_isa_ext_mask;
> +               vcpu->arch.isa &= riscv_isa_extension_base(NULL);
> +               vcpu->arch.isa &= KVM_RISCV_ISA_ALLOWED;
> +               kvm_riscv_vcpu_fp_reset(vcpu);
> +       } else {
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
>  static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
>                                   const struct kvm_one_reg *reg)
>  {
> @@ -382,6 +476,8 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
>         else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
>                 return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_D);
> +       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
> +               return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
>
>         return -EINVAL;
>  }
> @@ -403,6 +499,8 @@ static int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
>         else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
>                 return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_D);
> +       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
> +               return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
>
>         return -EINVAL;
>  }
> --
> 2.25.1
>

Regards,
Anup
