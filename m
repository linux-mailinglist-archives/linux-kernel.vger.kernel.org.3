Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539D4A6FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiBBLVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiBBLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:21:45 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B097C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:21:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f17so37710812wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLpBWpR4AdxV5k5a9SzxOwC4Is5G/R+GFZUj0OPG68E=;
        b=0GzZnB6+OCeckMUkTJmkIO5sfwKHCblMsvuWqQfWsqJAhSN7p5my9G/QCBoR6UwdAi
         jN/c7wPi23GCh/djF3RvdTynngxkjgI4Ct6t3wl5Qt/YFhFpU4FSATeju5bRLe6Xi05M
         6Q0voGGh4CpnD/whLpVbYzlLvBThs1p5AscZe1PUEtOENxlUTOZHWuQNPb/orkrS7CZq
         CKaZWk2Uxa89CqefqP9gdaLI9gb+wBBgh8QjhHLgzuCgCg3kGVjB6nLc5EgLxPRciSUN
         LU8GAoJvu9GdmAQPYgNnbPKtbIz0BgB+3D25b0wmvSaAL7w7c/ZFbRsKj8Ymy+C8GdWW
         Wkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLpBWpR4AdxV5k5a9SzxOwC4Is5G/R+GFZUj0OPG68E=;
        b=eeHeCeZDzOtomJtLVz8wPMW6Ajm6epWod0Y41wlzHcs40+eqi8Rc2OBx1qqLN8Gmm8
         5iARIu9GkYAwWuZQKBFcnCgux8SAavMXqwWwo48/B2Lho8TiVq6PDNs8TbL7gwyXT6ic
         9bMIZZt3eEQ/R8+Daaun49UGNvv2GOtm2+iarpHraO/TqZ+jiJC1njRKN0OBaG+H1FbB
         vzoUd767S2jAeNaH3lzo5ki2l17dmtLOw/jOjOEqIPGeCFo8UtCvSyWfKqvHBQOGe7p0
         LpEY5utKfAdOjDRTYXDVQsFDeCb3AWIdpoB/5c8KU0n6wqtClarLs0VHi4M4hTOwUj7G
         Krhw==
X-Gm-Message-State: AOAM532SLmdoeXm5lZ+++8AOzo8vG2a9tAxba+djX4q95kS0LZxAohq0
        ZsoXVEh/KMEtai3eb5peb0stQUvH4SBl24JhxW3+Vg==
X-Google-Smtp-Source: ABdhPJzlXdO1QshYnBgRMzXJ2ivnlrYwpOvle2NHmkETsqwszvU55uwzYT90mGUVAB/9xurup36pfFR95cYb5rz617U=
X-Received: by 2002:adf:d08c:: with SMTP id y12mr25480446wrh.346.1643800903609;
 Wed, 02 Feb 2022 03:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20220131164232.295585-1-apatel@ventanamicro.com>
In-Reply-To: <20220131164232.295585-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 2 Feb 2022 16:51:30 +0530
Message-ID: <CAAhSdy3ReL2cJXZ+0YMcEeWJg02p86Sr-dNXKXm7GMMaqUZJiA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix SBI implementation version
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:13 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The SBI implementation version returned by KVM RISC-V should be the
> Host Linux version code.
>
> Fixes: c62a76859723 ("RISC-V: KVM: Add SBI v0.2 base extension")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Thanks, I have queued this for fixes.

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index 4ecf377f483b..48f431091cdb 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -9,6 +9,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> +#include <linux/version.h>
>  #include <asm/csr.h>
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_timer.h>
> @@ -32,7 +33,7 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                 *out_val = KVM_SBI_IMPID;
>                 break;
>         case SBI_EXT_BASE_GET_IMP_VERSION:
> -               *out_val = 0;
> +               *out_val = LINUX_VERSION_CODE;
>                 break;
>         case SBI_EXT_BASE_PROBE_EXT:
>                 if ((cp->a0 >= SBI_EXT_EXPERIMENTAL_START &&
> --
> 2.25.1
>
