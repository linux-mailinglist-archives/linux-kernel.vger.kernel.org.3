Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214A24A6FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiBBLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiBBLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:14:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008DCC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:14:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so4321503wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+Ou2Ig8ojG1Q4rpLhdtlRjQ2QYsf4tk9df7vvSqqRQ=;
        b=HG7pcW+bWSzCh9vAOoccHchduY1ExRfO/ZCl7GAs6q/Yy6zXSNA9QzaaJMyArPE/Ol
         Reu9Rg03Kq/hheJ9HMRhTkj+C8RViQoXugdWycbhyvY2HTpWsHQCzKxApaVH/qWpKjXb
         OteVz8qFVQK7ihQiirPEjYh5N6xFhmJpOcnr5hj1zzh2PG5qGY+Qo48SVaa9Oc8vyYl2
         7fRoiGGG65RdE1bfofNDXBBAXnswoOmIUbszqbAlYO2EIsdkCsis7sXHcp3U31UTL6pX
         8BwG2UOVY7O5KZ3CS7JWue5Nb2QkwYfMe3F0ZNw49cLUYq+LY8uutBrXnZ5Z+akLOV2T
         8Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+Ou2Ig8ojG1Q4rpLhdtlRjQ2QYsf4tk9df7vvSqqRQ=;
        b=wC/S3XQbEx/QfhDLAJgzbXORO7EXeZYsmAwzasA1esHQrDJihcg/MU3o66zrUOYjkL
         VLO0E+nudBJscUYZ8lPpiFRCUjxL7YfKl4TjfznmnauXRgkuEzZpwgKBz6zFNhOEfJei
         p1k6xsm5rkWmf+a+H77OEvnvwe+TYlo4UzWch55FVI5lzQY/qKLhF+KFuC3syQi3X5IH
         uXdDJhiLEMMUcN68hsroeR8ACsKdQaEcyAoeeELJiavfVC8JOmvkFpTLmweYAhMReSeI
         aXDYjWBN0Wnoghe02Vdisb1bNJXm+8AUk7/mYnw+BvN5m/ZU7Pfy2Ke7MMut2Z1xpils
         Ncag==
X-Gm-Message-State: AOAM532qGgGWdYnlsLiC2EFAveZ0EH6SGxqQkLxIlzPNCw/DctJRFWoe
        NZdBhOBXk3yEi/NLxMYdadkPS7B+kM2eaSO5ZYCIyQ==
X-Google-Smtp-Source: ABdhPJwfKpQBfo85BYAHZ/tEJa3QnknYF8q5UcmzvqGAKCRaiqIgFBdfTdXirLuIv3sy03Hv3xEsI0lLuc0gj6VQHwo=
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5689397wmj.59.1643800460371;
 Wed, 02 Feb 2022 03:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20220131110307.1684739-1-mchitale@ventanamicro.com>
In-Reply-To: <20220131110307.1684739-1-mchitale@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 2 Feb 2022 16:44:08 +0530
Message-ID: <CAAhSdy2wX7Re4yepV7ReNQazF9jb-eqSUDE7rLCarr3iUchzkQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: make CY, TM, and IR counters accessible in
 VU mode
To:     Mayuresh Chitale <mchitale@ventanamicro.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 4:33 PM Mayuresh Chitale
<mchitale@ventanamicro.com> wrote:
>
> Those applications that run in VU mode and access the time CSR cause
> a virtual instruction trap as Guest kernel currently does not
> initialize the scounteren CSR.
>
> To fix this, we should make CY, TM, and IR counters accessibile
> by default in VU mode (similar to OpenSBI).
>
> Fixes: a33c72faf2d73 ("RISC-V: KVM: Implement VCPU create, init and
> destroy functions")
> Cc:stable@vger.kernel.org
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>

Thanks, I have queued this for fixes.

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 0c5239e05721..caaf824347b9 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -90,6 +90,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_cpu_context *cntx;
> +       struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
>
>         /* Mark this VCPU never ran */
>         vcpu->arch.ran_atleast_once = false;
> @@ -106,6 +107,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>         cntx->hstatus |= HSTATUS_SPVP;
>         cntx->hstatus |= HSTATUS_SPV;
>
> +       /* By default, make CY, TM, and IR counters accessible in VU mode */
> +       reset_csr->scounteren=0x7;
> +
>         /* Setup VCPU timer */
>         kvm_riscv_vcpu_timer_init(vcpu);
>
> --
> 2.25.1
>
