Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CF519566
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbiEDCSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiEDCRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:17:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A9E29CA8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:14:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f16645872fso1872377b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHVfBZ+ZbG4jO46Y3xTAJPGI1FCH2/0sdEc6UgyZ1v8=;
        b=FAjHBA3DYZrjCcFJ6SRJYEfqXCfuaP++2tcA5MdxVcnYV4gcDkdMhPq+5V+nwRn/LB
         BPMK6R1GX5gCsG+Nlz2u1xpC+BwbzLmN1BsOC3quRE/uMcT3rOlEdtmyarUKmSP4Xf5U
         CNGi2Y+hFXf66WgcBSOmRixHtd49iCwN7waBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHVfBZ+ZbG4jO46Y3xTAJPGI1FCH2/0sdEc6UgyZ1v8=;
        b=0eN3unMMZO0xlY2hsUC/q/1TCl+/kMy605+mPcaNni3MyMz4A17/GcPZnsnCzr5SeO
         V3ejwCch7fXKZsuFpablIfAG4RSRNZwBJgviRf0DmVVTjlYinYPfm3dmqHRjf2wJoy/D
         +ErjW1WF0F/hEu8C1904r3dTRA2sF9nv0we1dGqp8QEKXGyoW4/GwJOgggG3YvVW6s0d
         jhzvFRFyOTKUF+BEmprpTbTQWcj6D9gOE14WZipwQF81B1aOPeBoo8wWaaITsAohG0su
         2AddDRNVlY1dE2Ou5Op2AnI2b32/Xvo/Fwk6lcsePtUnt2Od3zFAotxetPDZJAZuuokV
         Eonw==
X-Gm-Message-State: AOAM53133Z+Db+Yh+7vvvEe1HgomKK4d6BWQXa0OwL2CAcsmpeUus3+X
        pSmZXgkzfu9k6sCuWDgGbG6b3nsAPJqDFcUK95rT
X-Google-Smtp-Source: ABdhPJx28wVb5nvO0Q4bF9Y1heyPsITBVA6bFMutIrXSBzsNvCfUhWRbPdwTu3TgiqzvQ05aDm7AlJtEWBwikALsKOg=
X-Received: by 2002:a81:20c1:0:b0:2f8:5dcd:91d4 with SMTP id
 g184-20020a8120c1000000b002f85dcd91d4mr17984573ywg.443.1651630457801; Tue, 03
 May 2022 19:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112450.155624-1-apatel@ventanamicro.com> <20220420112450.155624-3-apatel@ventanamicro.com>
In-Reply-To: <20220420112450.155624-3-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 May 2022 19:14:07 -0700
Message-ID: <CAOnJCUJ3KzJdqLa3zXUd+YEa00_W1P7aNWY0ibpvO9jaqarOtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] RISC-V: KVM: Add Sv57x4 mode support for G-stage
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 4:25 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Latest QEMU supports G-stage Sv57x4 mode so this patch extends KVM
> RISC-V G-stage handling to detect and use Sv57x4 mode when available.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/csr.h |  1 +
>  arch/riscv/kvm/main.c        |  3 +++
>  arch/riscv/kvm/mmu.c         | 11 ++++++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index e935f27b10fd..cc40521e438b 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -117,6 +117,7 @@
>  #define HGATP_MODE_SV32X4      _AC(1, UL)
>  #define HGATP_MODE_SV39X4      _AC(8, UL)
>  #define HGATP_MODE_SV48X4      _AC(9, UL)
> +#define HGATP_MODE_SV57X4      _AC(10, UL)
>
>  #define HGATP32_MODE_SHIFT     31
>  #define HGATP32_VMID_SHIFT     22
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index c374dad82eee..1549205fe5fe 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -105,6 +105,9 @@ int kvm_arch_init(void *opaque)
>         case HGATP_MODE_SV48X4:
>                 str = "Sv48x4";
>                 break;
> +       case HGATP_MODE_SV57X4:
> +               str = "Sv57x4";
> +               break;
>         default:
>                 return -ENODEV;
>         }
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index dc0520792e31..8823eb32dcde 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -751,14 +751,23 @@ void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu)
>  void kvm_riscv_gstage_mode_detect(void)
>  {
>  #ifdef CONFIG_64BIT
> +       /* Try Sv57x4 G-stage mode */
> +       csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
> +       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
> +               gstage_mode = (HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
> +               gstage_pgd_levels = 5;
> +               goto skip_sv48x4_test;
> +       }
> +
>         /* Try Sv48x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
>                 gstage_mode = (HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>                 gstage_pgd_levels = 4;
>         }
> -       csr_write(CSR_HGATP, 0);
> +skip_sv48x4_test:
>
> +       csr_write(CSR_HGATP, 0);
>         __kvm_riscv_hfence_gvma_all();
>  #endif
>  }
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
