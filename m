Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B724E5691
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiCWQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbiCWQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:36:03 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923575C19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:34:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d07ae0b1c4so23341937b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsarPkHuGeFkbQel0o4+0RcyfI8xstErqBIS8KS/Ntw=;
        b=Ie9SURJ+WwJExRiIyK+Wr/0sZ31m21FhWNtFkjAiPuYrXfg/1kGtv3rrpUc8L/PpQO
         9mhZWwld3idegmmwzni7iu0rGwkANjHHgWT9El38MUc2WK4v6I7h4jvkNiFS4FcaAgty
         CSgjTPJCYcrLiZbJsZhFM1DKvWB5ldTAiwUD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsarPkHuGeFkbQel0o4+0RcyfI8xstErqBIS8KS/Ntw=;
        b=n0E58dGyEHriK4k8cYAXRmrg0NZVl4jHMuymffDKcIvcoEIdjROpTC5LVmBSdSmAxQ
         Y1kTRlXnBgbeFBpNiTIKWuWhSHM+iO9QFWCiaBJIRO3W9/vDrrjjko+3KQ6Vgogqaz25
         MNGRk50uY/T8GBK4rhmt4HtdlB17slLbOteu/UvotqMx25+AadNKq5uP+F1iWDDNAzIR
         idiZiYMllFTxTAcJLolur205OFaODers/UKQwhQZ3vDS8EGCc57EE013aeni5ElFriWU
         khYhXLTbUNzNtiSyBLJFwu6cxLioDFNQT20FjAjpJY/xaTGRnxjdm4HXnTReG2rd6BEE
         k9jw==
X-Gm-Message-State: AOAM532iIT/dgA6knAFa0grhmfohYSSzJjmbJyXYF4AGONyVHLHmvSSI
        AzB2+A0i3DC8HIZ/PTkfzi6sNiGbS3noUDRaRNl6
X-Google-Smtp-Source: ABdhPJxaM+MZkmiR0g3HVuavrnd/W8psTlbP613L1+wgEjxxagwXshb/UYlewlXEuonm84qo2hfaDwDCG+8xangS4T0=
X-Received: by 2002:a81:19d7:0:b0:2e3:aa2:2b0e with SMTP id
 206-20020a8119d7000000b002e30aa22b0emr716227ywz.249.1648053272611; Wed, 23
 Mar 2022 09:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220323090025.546808-1-apatel@ventanamicro.com>
In-Reply-To: <20220323090025.546808-1-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 23 Mar 2022 09:34:22 -0700
Message-ID: <CAOnJCUJnc3VJq3PRn+wTMTbf2N5VdJs_uPjRyWTs-EKuC_190w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable perf events by default
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
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

On Wed, Mar 23, 2022 at 2:00 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Let us enable perf events by default in RV32 and RV64 defconfigs
> so that we can use RISC-V PMU drivers on various RISC-V platforms.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f120fcc43d0a..57aaedc7cf74 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_PERF_EVENTS=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 8b56a7f1eb06..21d422e740d5 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_PERF_EVENTS=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
> --
> 2.25.1
>

I think it is better to enable perf events by adding CONFIG_PROFILING
to the defconfig similar to other ISAs.

-- 
Regards,
Atish
