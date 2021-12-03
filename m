Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72A2467B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382108AbhLCQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbhLCQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:43:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13BFC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:40:02 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 71so3605118pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzSi1tupIbZkFi0UfocPlqtMyRurN+AU97a561lGfSg=;
        b=Zgbr2YIqdOhynKybaNnprHbnokcq2D+tK9HEbPMElZSSk0x6jKzZ+YWq+SwMdxxdGg
         99HBQqOE1MRIGvNs8Bv2WUVSqJW0YREqj3PtTCsIgslRpeqNLQ0tU9QLQ6HwBJ3hDkXi
         uWN/n/JyE7fLMRB7E4WZ9pNfxXf39zd7tPg5rdL8bLkuKzzo7SwaifSBA4CAHcz51qpP
         N9LzPtl9/kuigULaH3eTDzEACUeGbIBoBKJWwThNkM1FzRSX/KqVfeMjNkWHWSHmCqCy
         fzVqyQGMXLReEIgsyfvO0dD8kA63pVNMMVEIyfejUTNpWs2Cti04mfQ3CtPc380vaDLo
         qWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzSi1tupIbZkFi0UfocPlqtMyRurN+AU97a561lGfSg=;
        b=LQOaASJm95VUI7/6v64W+RZY0eA+mPSHTy0VJmeJinzEiDXsxowFp1iMb9WstNNh8T
         RLfvwSlk33GuYgtHd9UWCIDXgXHIiOCD7TkkESZkggsaCtJgZz1KqSm5d1JvFAlSkTqH
         2fTRll5cUHVBo+Xl2pv6HYY1oCFtBEQAJ7VwBY2tXMYFsHNCAbYypnNPdmvHnfmmGTii
         mLYehsvIjFAyAy3kz6IeYOt8mYffiUGcrftCaSarC2u5s7m34YsoYdHEMQotdOW7P3Mj
         jz7FACgK507bmEhokisX7nxvoOEK34T1E4pJsKslLkFMOt5lmGbrxaBXOw7cqaqFqpKf
         mLFQ==
X-Gm-Message-State: AOAM533YexTAGzD6CD71/+RauOZxUIGWXcqZTU5u/nzSsIsU5JSk3iSZ
        25DhSmO7wX5JbN3igvaKz9pWedWHu9hemn+FEWY=
X-Google-Smtp-Source: ABdhPJybVcL5RCbZQeTQkzNV6CttzUfLqTTbS/hyn00ZF6L5sMQrj+WdKA3v+tcWEnX1SFX0XpcBCt5Bpn1fKZcpeh8=
X-Received: by 2002:a63:b608:: with SMTP id j8mr5102543pgf.519.1638549602519;
 Fri, 03 Dec 2021 08:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20211203051157.2160-1-jszhang@kernel.org> <20211203051157.2160-6-jszhang@kernel.org>
In-Reply-To: <20211203051157.2160-6-jszhang@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Fri, 3 Dec 2021 17:39:51 +0100
Message-ID: <CANBLGcw0-OLMM5H_GGwsWS5J2UZd38aNNrHWke9JkzhSDkNj+w@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Fri, 3 Dec 2021 at 06:22, Jisheng Zhang <jszhang@kernel.org> wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_BLK_DEV_INITRD)", to simplify the

The patch looks fine, but I think you mean
IS_ENABLED(CONFIG_KEXEC_CORE) here, not CONFIG_BLK_DEV_INITRD.

/Emil

> code and increase compile coverage.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm/kernel/setup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 284a80c0b6e1..f9a054a344c0 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -973,7 +973,6 @@ static int __init init_machine_late(void)
>  }
>  late_initcall(init_machine_late);
>
> -#ifdef CONFIG_KEXEC
>  /*
>   * The crash region must be aligned to 128MB to avoid
>   * zImage relocating below the reserved region.
> @@ -1001,6 +1000,9 @@ static void __init reserve_crashkernel(void)
>         unsigned long long total_mem;
>         int ret;
>
> +       if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> +               return;
> +
>         total_mem = get_total_mem();
>         ret = parse_crashkernel(boot_command_line, total_mem,
>                                 &crash_size, &crash_base);
> @@ -1056,9 +1058,6 @@ static void __init reserve_crashkernel(void)
>                 insert_resource(&iomem_resource, &crashk_boot_res);
>         }
>  }
> -#else
> -static inline void reserve_crashkernel(void) {}
> -#endif /* CONFIG_KEXEC */
>
>  void __init hyp_mode_check(void)
>  {
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
