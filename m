Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D951572ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiGMBXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiGMBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:23:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC732ADF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:23:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31c89653790so98331787b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ie5knz6Z7le3iq/Y674AyR+LGN3gRnAoNdlxx7P/y9I=;
        b=RTsKcNxUJJz87MBB2H9d50Uc3Goi8S+lsi1B77YpCFUTLx1Nh7BPBDKPacVZBx1ejr
         zB71wkVArXOsLKhg66kDL+hNE8ZWZrist3SWBobyvIPmFKQNb2Kfb3/5ZFAtHlnL46Lk
         mCo7oVRGdLcynpPypBb3qpQ5njCXRRIxrqPdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ie5knz6Z7le3iq/Y674AyR+LGN3gRnAoNdlxx7P/y9I=;
        b=3MaJydHxS6FZbcfxbVngst37foWzNyeQmZT8NHsQBRcr71gUor4KH24+3ethd0UrMI
         8BU8K5ztIkb9FzUMxfehdu990wlNQeCmeQ54wwQSNi5bKWNkXuJc8X2iI2ZoaNvvadBh
         bpO7dM4ZDKBmaGjKXBo1DvvjzbQ4p0kiN6IENQR6t8xbcqAktzF8rl6sW6GvGKVb6H5s
         b7/C1NEo3tLFH/+wbDpOdsMDs7PtRjelXIwLCzW6Gff1crWEP2nGUbzWoSiwNK6Ezg+v
         4DQ+SpiXw0dVJ51is/gs2pAMoA+xl7AT37tSagEP+24XK+3ZEY7j/LlD8DduHW75Uo/e
         fw6A==
X-Gm-Message-State: AJIora8YoLTWv8+9rDy+4rW4Daxv7JzmBTUk16CX7SWmO5mR8U2DIcmu
        uEtUMi5zSIcULc8MiS90yxaNgmYlPjjINQVA+UIQ
X-Google-Smtp-Source: AGRyM1tqyP71llyjRs2TrZupwm5NzJqxWxkUC/TBWrNYs7b2AbEUEKsjzxC+kLWriHpNto4Ma84s+Tf/oDKV492vYnI=
X-Received: by 2002:a81:1514:0:b0:31c:a84b:350a with SMTP id
 20-20020a811514000000b0031ca84b350amr1426871ywv.400.1657675414441; Tue, 12
 Jul 2022 18:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220707145248.458771-1-apatel@ventanamicro.com> <20220707145248.458771-5-apatel@ventanamicro.com>
In-Reply-To: <20220707145248.458771-5-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 12 Jul 2022 18:23:23 -0700
Message-ID: <CAOnJCUKjFMMsrNWR=hzB+qbw4SECWS3+DOJDun90emnM-Vkpiw@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: KVM: Use PAGE_KERNEL_IO in kvm_riscv_gstage_ioremap()
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        KVM General <kvm@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>,
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

On Thu, Jul 7, 2022 at 7:53 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> When the host has Svpbmt extension, we should use page based memory
> type 2 (i.e. IO) for IO mappings in the G-stage page table.
>
> To achieve this, we replace use of PAGE_KERNEL with PAGE_KERNEL_IO
> in the kvm_riscv_gstage_ioremap().
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index f7862ca4c4c6..bc545aef6034 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -361,7 +361,7 @@ int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t gpa,
>         pfn = __phys_to_pfn(hpa);
>
>         for (addr = gpa; addr < end; addr += PAGE_SIZE) {
> -               pte = pfn_pte(pfn, PAGE_KERNEL);
> +               pte = pfn_pte(pfn, PAGE_KERNEL_IO);
>
>                 if (!writable)
>                         pte = pte_wrprotect(pte);
> --
> 2.34.1
>

LGTM.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
