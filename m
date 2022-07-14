Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B57575523
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiGNSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiGNSfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:35:52 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15598FD34;
        Thu, 14 Jul 2022 11:35:51 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31d7db3e6e5so25753677b3.11;
        Thu, 14 Jul 2022 11:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHq4FivBRDqio2MK2JR/7z4GELOdE0oSwokqcIS93UU=;
        b=ze+6RZc7OknrWPNCznO6jNKXYQX8fppVp3XBvTYRGVjx24+eUWJJU8gTlHjKG9VHSO
         Nom5FfVOXx40AbVhhZ2/Uo1rK2B/fG+q1Abx9LCe/wVdg8+s0ec+M3cfPZAbH3im+L7a
         YqC7fKxsdUi+iH8RleUGUiHC3C/vdDD9HgL7Ep/0u0u4Hch8AAglaSSyK5hGitY5tOmF
         NcDiNszUTSZI0/fHg045LfzgxzC2whpEM4X92aBmp6Q9Db83BokcPZ/xE8LeMynhVnCY
         3Y0F6A0B5H0URX09plOzhtbRC405tS5z/sVALCG8mtBfmBoxUHfAB3jQV994k9A3e/6l
         uzpQ==
X-Gm-Message-State: AJIora9Mlc6XKR+Bkgx1E3pTdflccysF6GNzTgh4B/hp4h3cyYGzIE+I
        XQcU1gN07EBQS6ITszxHEE+j2tdfRVhgKRMWWxE=
X-Google-Smtp-Source: AGRyM1uqMjbspLYzydo7ah0VRMq5a3BBd59Xj2U/uwoJAcUZZi3BSYXnXKX+tBStevaZPedkbLqj9wbbCO8hdlXm+sM=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr10983181ywb.326.1657823750063; Thu, 14
 Jul 2022 11:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220712020058.90374-1-gch981213@gmail.com>
In-Reply-To: <20220712020058.90374-1-gch981213@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 20:35:39 +0200
Message-ID: <CAJZ5v0jjyvWniC8ReZqAgnaoaRm4cr_Vs3pXhddKf9B6+zONLw@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 4:01 AM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> IRQ override isn't needed on modern AMD Zen systems.
> There's an active low keyboard IRQ on AMD Ryzen 6000 and it will stay
> this way on newer platforms. This IRQ override breaks keyboards for
> almost all Ryzen 6000 laptops currently on the market.
>
> Skip this IRQ override for all AMD Zen platforms because this IRQ
> override is supposed to be a workaround for buggy ACPI DSDT and we can't
> have a long list of all future AMD CPUs/Laptops in the kernel code.
> If a device with buggy ACPI DSDT shows up, a separated list containing
> just them should be created.
>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

I need an ACK from Mario here.

> ---
> Change sice v5: reworked
>
>  drivers/acpi/resource.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index c2d494784425..510cdec375c4 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -416,6 +416,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>  {
>         int i;
>
> +#ifdef CONFIG_X86
> +       /*
> +        * IRQ override isn't needed on modern AMD Zen systems and
> +        * this override breaks active low IRQs on AMD Ryzen 6000 and
> +        * newer systems. Skip it.
> +        */
> +       if (boot_cpu_has(X86_FEATURE_ZEN))
> +               return false;
> +#endif
> +
>         for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
>                 const struct irq_override_cmp *entry = &skip_override_table[i];
>
> --
> 2.36.1
>
