Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B825B4806AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhL1GU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhL1GU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:20:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B0C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 22:20:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o30so8438102wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 22:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5m6I1+e/fTravXWaM/DR1a+IZkwqzGyxUYHprrFJVo=;
        b=bnLjTnAxvgWOVF84U5Yxqqzb7N8OpgqFseDIG18DsC2weLGdpYeiorRfvLme+3H3Wj
         e9z4Uph6f+N+cbnzqXE6ZU87HGt5QGpfcIRaMGKpUWTm7EQVOzEL6R/P11zFFmFGFlNY
         KRj+nMBRPsd/qw3NAET7uXBMsQggbAhusGYeUEekhMIN5jUmR1AdJY/1SkHlxNn3pD07
         7GJC9WMCyBwenw3fpzAglpT8U7ceZENxBx1hpoosIJnnCUcusNkimv8wRDVrAqrsB41p
         bvbvOibSS1DHL0SqeWZGbBkxK/sKTfqmAukEjBHp/jrShKjZvwbPJf5m5YulHz6hzEcJ
         CSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5m6I1+e/fTravXWaM/DR1a+IZkwqzGyxUYHprrFJVo=;
        b=TcUMpwv2uX172M5/YNlmpf9UmmsOJWc+brS3Vblao2ceKIg6Gb7v+M141lYGty2KrW
         /S9zBQRHPNxqqK8O9F+KkyURFErKsSt3BTbbvec34tp+ADKvZJMDQuX9dpIrcCeafZeg
         WJgMExwqVLLToJj3z//3VQRYXdk+irDPnoWjwTJ5+gxbwfqekwAB/PuS3nLvZdNaZOin
         kvbP7/4MdT4LKNq10k0lmU0mAVxCrO6wUIk2cLO7S0va1+ufQmuMBdFeoCg+sWlsMcvV
         YVf88uK3TZ7aTQJyxCe/cXvoUXlYOYJz9XDhvOWkvKwF2VGw4bXHau+2iEZ1aKXbjf3k
         4RGQ==
X-Gm-Message-State: AOAM531FShiL8YvN8/QFjiJlBNzr2IhxAKv2a9XAul/9kJd/Z27dwTmX
        Q1J2hR/qyZ6uG4fM0tBOPdkhJS01rPQ0L3ptp2xobw==
X-Google-Smtp-Source: ABdhPJxShEPXSHMDLpX+ZXACyVmaSjYjAuKiTpyen4bSDSjamxzNsqKq6fBZdoR4fZD7LmMdF4bKoMIrXSZydRh8fKs=
X-Received: by 2002:a7b:c243:: with SMTP id b3mr15737850wmj.61.1640672425557;
 Mon, 27 Dec 2021 22:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20211224073604.1085464-1-anup.patel@wdc.com> <20211224073604.1085464-2-anup.patel@wdc.com>
In-Reply-To: <20211224073604.1085464-2-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 28 Dec 2021 11:50:12 +0530
Message-ID: <CAAhSdy2MGEhn+Mbg=rKZO9nkHcV28Fro-sL3YH_9+S-ZCzXgqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 1:06 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The SBI experimental extension space is for temporary (or experimental)
> stuff whereas SBI vendor extension space is for hardware vendor specific
> stuff. Both these SBI extension spaces won't be standardized by the SBI
> specification so let's blindly forward such SBI calls to the userspace.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-and-tested-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for 5.17

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi.c      |  4 ++++
>  arch/riscv/kvm/vcpu_sbi_base.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index f62d25bc9733..78aa3db76225 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -46,6 +46,8 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_time;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_ipi;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
>  static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
>         &vcpu_sbi_ext_v01,
> @@ -54,6 +56,8 @@ static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
>         &vcpu_sbi_ext_ipi,
>         &vcpu_sbi_ext_rfence,
>         &vcpu_sbi_ext_hsm,
> +       &vcpu_sbi_ext_experimental,
> +       &vcpu_sbi_ext_vendor,
>  };
>
>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index d1ec08fe7289..4ecf377f483b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -70,3 +70,30 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
>         .extid_end = SBI_EXT_BASE,
>         .handler = kvm_sbi_ext_base_handler,
>  };
> +
> +static int kvm_sbi_ext_forward_handler(struct kvm_vcpu *vcpu,
> +                                       struct kvm_run *run,
> +                                       unsigned long *out_val,
> +                                       struct kvm_cpu_trap *utrap,
> +                                       bool *exit)
> +{
> +       /*
> +        * Both SBI experimental and vendor extensions are
> +        * unconditionally forwarded to userspace.
> +        */
> +       kvm_riscv_vcpu_sbi_forward(vcpu, run);
> +       *exit = true;
> +       return 0;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
> +       .extid_start = SBI_EXT_EXPERIMENTAL_START,
> +       .extid_end = SBI_EXT_EXPERIMENTAL_END,
> +       .handler = kvm_sbi_ext_forward_handler,
> +};
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
> +       .extid_start = SBI_EXT_VENDOR_START,
> +       .extid_end = SBI_EXT_VENDOR_END,
> +       .handler = kvm_sbi_ext_forward_handler,
> +};
> --
> 2.25.1
>
