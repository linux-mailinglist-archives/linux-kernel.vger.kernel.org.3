Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8220523B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbiEKRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiEKRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:30:20 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD242317E0;
        Wed, 11 May 2022 10:30:18 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id r11so5333662ybg.6;
        Wed, 11 May 2022 10:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kA5LUrg9FEK6lcfS6hSBAItDCTrYCnHyDwxKH4zNPeE=;
        b=km5I3gSzIbTEWdHVVIN/zKLWy7PIJJa/NA7/y5zfX2YPaCmEgmyO5F9Hwrw5ybagmO
         PhBW/ZhVHk7m0xNMPd9FSDZqRMoa49N8oqiLdq6eYVx2Zj99qhUqPhzyqza+ujOPWIXH
         VBF8DxZAOrLfWUYfVeEqwIY2tOhS68mUiTmJ4cpWVjCqlupo+xaOwQGhIFYVEDTYWH1d
         G6uMiVZymvDlMoeURi2KHrBUaQJgC4kEAq/5LbaepN6NM2b6hJhmVQKx7TSgm3rO4LRV
         7Fi+FWm4gG8j3x3zycrjPJ+DSu24DcPNJrEsyRrgPo7PiymLLJfrBZ7apTsT/E8SPrJb
         2qjQ==
X-Gm-Message-State: AOAM531zzEIWUC23Cm4UovjyBr56UnnWJNiA3vUSJfOC+yh2Xwd1ylwD
        u/BQTPcQ4pmn6EAlWfadInp4oHoXLscWHsuZ7TQ=
X-Google-Smtp-Source: ABdhPJzx10oGXmjUdrgRFpSf2JnlUCQLWprnfw47qR/sZ08uGzJzbPZal4vP3IN9LVYQ/6ChRXKsf3TVio6AaBZyTuw=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr24694201ybh.482.1652290218179; Wed, 11
 May 2022 10:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220511051605.103574-1-kunyu@nfschina.com>
In-Reply-To: <20220511051605.103574-1-kunyu@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:30:07 +0200
Message-ID: <CAJZ5v0hmHjjUx1+aWxph2aqh4jv=FQBTtc1ccH-thtD4G-iG9A@mail.gmail.com>
Subject: Re: [PATCH] x86: The return type of the function could be void
To:     Li kunyu <kunyu@nfschina.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 7:16 AM Li kunyu <kunyu@nfschina.com> wrote:
>
> perhaps the return value of the function is not used.
> it may be possible to optimize the execution instructions.
>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 0d01e7f5078c..7e32e33d52fa 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -375,7 +375,7 @@ static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
>         isa_irq_to_gsi[bus_irq] = gsi;
>  }
>
> -static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
> +static void mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>                         int polarity)
>  {
>  #ifdef CONFIG_X86_MPPARSE
> @@ -387,9 +387,9 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>         u8 pin;
>
>         if (!acpi_ioapic)
> -               return 0;
> +               return;
>         if (!dev || !dev_is_pci(dev))
> -               return 0;
> +               return;
>
>         pdev = to_pci_dev(dev);
>         number = pdev->bus->number;
> @@ -408,7 +408,6 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>
>         mp_save_irq(&mp_irq);
>  #endif
> -       return 0;
>  }
>
>  static int __init mp_register_ioapic_irq(u8 bus_irq, u8 polarity,
> --

Applied as 5.19 material with rewritten subject and changelog, thanks!
