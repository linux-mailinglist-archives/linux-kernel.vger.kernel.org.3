Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F84C05A9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiBVX5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBVX5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:57:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1142716F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:56:41 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b35so16827808ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mllQGFC3WEKp6XzrSESCPgbl5djA3qBbKDbZz6ohprU=;
        b=b3f8otBFJYUqBdQ5FOW9Khjl/pgCWSsFZtcnO6RW/TELNG0zf6paeKnMOXYsHc4JcO
         WWFVwCwn9FIt8lJsazJR1HEzCfWexKUT00gLWv4j9Sw9je3WTvIBSGJFDgXd4DiyWo4U
         F6afkvMCMwoXlSe2lriyUrildW9AQJwwJcVVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mllQGFC3WEKp6XzrSESCPgbl5djA3qBbKDbZz6ohprU=;
        b=v4DZlo8K11v79vw04RmOohrudXF+FYlwgrBB/3TMoqMz51U60UVmm6KwWs2PzEsI3O
         Gla7NtT0H5h8/Cm75oE7TlRPVc8oDjAYCXQzTOnGN9QHqhlFR1nXVDfoaCvudEKDafD/
         uSXinv28tlU9cOX48I1gfhobKcEs1JEEtTG04EE5FGanUDBIMgnCnkkgktNGyqQDTtLL
         Ebi81ROi9egEHvHrezYb/Ycsyu7ajkkcPW7bGBzWy9trIF2PeyXNoe6i5CcpBqQpZ8JH
         qtlfXvUKvLECd6V4JoNVCdZ0y8Ha4EfNy3uBMqDoOVRxogbt0OnlD8lku0PHvKlfqIJJ
         uoHA==
X-Gm-Message-State: AOAM530S0hNBNsG5PQAeRje9NjRnZqUBPIlPXPoeHoLIL02yR43PPYxB
        3oHMa+xVytzywog521D0O5ldfVYA2LE2zGxX9p+A
X-Google-Smtp-Source: ABdhPJxsoD0Z8T2CTk4jVbbagwhfA7izzMw0d3AiTk0jpyHcRUq6W3KAAWums7n1VjTy5jsG0KgnVmM55gDHETLRu00=
X-Received: by 2002:a25:d294:0:b0:61d:9809:9917 with SMTP id
 j142-20020a25d294000000b0061d98099917mr25651792ybg.289.1645574200901; Tue, 22
 Feb 2022 15:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20220201082227.361967-1-apatel@ventanamicro.com> <20220201082227.361967-4-apatel@ventanamicro.com>
In-Reply-To: <20220201082227.361967-4-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 22 Feb 2022 15:56:30 -0800
Message-ID: <CAOnJCUKPw-kiYZWAECPU5z9QS600s1AUREon=WuB+gPG+rprvw@mail.gmail.com>
Subject: Re: [PATCH 3/6] RISC-V: KVM: Implement SBI v0.3 SRST extension
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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

On Tue, Feb 1, 2022 at 12:23 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The SBI v0.3 specification defines SRST (System Reset) extension which
> provides a standard poweroff and reboot interface. This patch implements
> SRST extension for the KVM Guest.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_sbi.c         |  2 ++
>  arch/riscv/kvm/vcpu_sbi_replace.c | 44 +++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 11ae4f621f0d..a09ecb97b890 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -45,6 +45,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_time;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_ipi;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
> @@ -55,6 +56,7 @@ static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
>         &vcpu_sbi_ext_time,
>         &vcpu_sbi_ext_ipi,
>         &vcpu_sbi_ext_rfence,
> +       &vcpu_sbi_ext_srst,
>         &vcpu_sbi_ext_hsm,
>         &vcpu_sbi_ext_experimental,
>         &vcpu_sbi_ext_vendor,
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> index 1bc0608a5bfd..0f217365c287 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -130,3 +130,47 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence = {
>         .extid_end = SBI_EXT_RFENCE,
>         .handler = kvm_sbi_ext_rfence_handler,
>  };
> +
> +static int kvm_sbi_ext_srst_handler(struct kvm_vcpu *vcpu,
> +                                   struct kvm_run *run,
> +                                   unsigned long *out_val,
> +                                   struct kvm_cpu_trap *utrap, bool *exit)
> +{
> +       struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> +       unsigned long funcid = cp->a6;
> +       u32 reason = cp->a1;
> +       u32 type = cp->a0;
> +       int ret = 0;
> +
> +       switch (funcid) {
> +       case SBI_EXT_SRST_RESET:
> +               switch (type) {
> +               case SBI_SRST_RESET_TYPE_SHUTDOWN:
> +                       kvm_riscv_vcpu_sbi_system_reset(vcpu, run,
> +                                               KVM_SYSTEM_EVENT_SHUTDOWN,
> +                                               reason);
> +                       *exit = true;
> +                       break;
> +               case SBI_SRST_RESET_TYPE_COLD_REBOOT:
> +               case SBI_SRST_RESET_TYPE_WARM_REBOOT:
> +                       kvm_riscv_vcpu_sbi_system_reset(vcpu, run,
> +                                               KVM_SYSTEM_EVENT_RESET,
> +                                               reason);
> +                       *exit = true;
> +                       break;
> +               default:
> +                       ret = -EOPNOTSUPP;
> +               }
> +               break;
> +       default:
> +               ret = -EOPNOTSUPP;
> +       }
> +
> +       return ret;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst = {
> +       .extid_start = SBI_EXT_SRST,
> +       .extid_end = SBI_EXT_SRST,
> +       .handler = kvm_sbi_ext_srst_handler,
> +};
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
