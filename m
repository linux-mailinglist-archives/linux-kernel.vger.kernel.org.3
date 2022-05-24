Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03225532A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiEXMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiEXMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:08:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7C69732
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:08:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o9so2791542wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1kHWNn2FlYrScuJpDzEvYfxEoq+6pgVlJajpmZJO8Q=;
        b=MitxO5noWfkkjrDtLTJi13ymJxmHezjD+E5DuEVPaVncx1oma+enD3jH1aVLkhwzkJ
         WdhemjXMo9QnDd93aMDo5dczJ+gAgCXTKvK9tITNSJlL3EXbOBNrPilYk9cilRodPtN2
         exoqg6Mte3n0BWMUbvjN3CpXMDiyJeu+0LwBs3jA3AWr0iTJ9quRBpYLVwp3Qy3MVfE5
         891W6liT9KNXxCx/9BOVZ+sS9plpdPcOGqglhZKvUIVP4vir7ldZ/lnawF9GayTEebzX
         Fv1tgUQE3asHoYQ2lcPQK7Xs76PjxyOSreGfpXpZGeFLNpmt2PE8l432dCQSkWRSelLV
         ppnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1kHWNn2FlYrScuJpDzEvYfxEoq+6pgVlJajpmZJO8Q=;
        b=3nUsmTHmwChqXAjK+Z0EmyRDCGTwT6hOZYu3+Js1RmA0ADnt16RQuEjbCw5nO4wvsj
         ixI+yF/Yu6WxquW/oM1VQRMhJa5xFYPIK+HAifCfWUSR2Kt5eFSn/EY7CxWVIrtrTuDP
         trkuSaE2kIDGBYRObNtRh9uzyjhe04TcFq5mpyCr9b29cYpz/cOJBjeJ65gTqs89KAER
         lr3qJYCIdpjyUYXLacACH3R2ILnsCpLTEA3ktTe9JdPiJNNELEXdGtKwgk5zM55cpsAF
         rEBrFn/cVJjvM7Bkrc+rvaIWO3ho10sEu0Qvf8omuLZGzhT9wPb2O34zE/o/YkBY0Cas
         nHFw==
X-Gm-Message-State: AOAM533QTYQcx5mqEXeH/vgxy8nQZUl2nWwFFqaQF/i25M0S3x7FHI0I
        LJyp/Klg6nwBXSMRC8lQ6rFc4wdsSAytyrTq2mSWhQ==
X-Google-Smtp-Source: ABdhPJzCjSjJu5FZr9HKDJXj80WuWPTLIslId0a/UEE5mngDqDBNme5tGWlgfcoenQV71EZpI9dNoJlf1rYo3x49IaQ=
X-Received: by 2002:a05:600c:1d28:b0:397:65ab:4b3e with SMTP id
 l40-20020a05600c1d2800b0039765ab4b3emr38103wms.137.1653394119857; Tue, 24 May
 2022 05:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112408.155561-1-apatel@ventanamicro.com>
In-Reply-To: <20220420112408.155561-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 24 May 2022 17:38:28 +0530
Message-ID: <CAAhSdy15v3-_2bbJuCVm5zp1nNHHLjtypAESOoPkcChjgFsssw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Apr 20, 2022 at 4:54 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Currently, the range and default value of NR_CPUS is too restrictive
> for high-end RISC-V systems with large number of HARTs. The latest
> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> restrictive for QEMU as well. Other major architectures (such as
> ARM64, x86_64, MIPS, etc) have a much higher range and default
> value of NR_CPUS.
>
> This patch increases NR_CPUS range to 2-512 and default value to
> XLEN (i.e. 32 for RV32 and 64 for RV64).
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Can this PATCH be considered for 5.19 ?

Thanks,
Anup

> ---
> Changes since v2:
>  - Rebased on Linux-5.18-rc3
>  - Use a different range when SBI v0.1 is enabled
> Changes since v1:
>  - Updated NR_CPUS range to 2-512 which reflects maximum number of
>    CPUs supported by QEMU virt machine.
> ---
>  arch/riscv/Kconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 00fd9c548f26..1823f281069f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -275,10 +275,13 @@ config SMP
>           If you don't know what to do here, say N.
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-32)"
> -       range 2 32
> +       int "Maximum number of CPUs (2-512)"
>         depends on SMP
> -       default "8"
> +       range 2 512 if !SBI_V01
> +       range 2 32 if SBI_V01 && 32BIT
> +       range 2 64 if SBI_V01 && 64BIT
> +       default "32" if 32BIT
> +       default "64" if 64BIT
>
>  config HOTPLUG_CPU
>         bool "Support for hot-pluggable CPUs"
> --
> 2.25.1
>
