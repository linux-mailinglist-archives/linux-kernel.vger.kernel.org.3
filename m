Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE705AC0E8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiICSqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiICSqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:46:16 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2457422FC;
        Sat,  3 Sep 2022 11:46:14 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-33dc31f25f9so41474257b3.11;
        Sat, 03 Sep 2022 11:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wq+M/cmv2nYDSAnE2wx973kH4NeialiY550lY7nDP7A=;
        b=0x3S5UEJPVt16xNr8WAqqyN3zI9FBxRYOZpsYXm63y49voKrFSuWdgZWal9tf3CDr4
         ujMzVs3PPd4f44n7QS5paau1LsqhCIhVUGn8/XTiJXHuMgDvV4uRohZJYoWF7G/bplE5
         n/EzVdNGDN2JmQLmP7Zvar0zhHBPK30IRpTar0tH+8OK4x8gHQB+7ipkPcP+YEYuDKA4
         Kymf5un38NKwWhE4bAT9DKXzB2mBMKiG6MNI6wlH1GzXbNZcvD8fdCLdzFyeSro6iigG
         IoHXxck/hRpSoP1TXHo/HghvqJHY61sT/VAR+V+0X4s2M+lk9ZR+QYUxUWgqmHP3lXCK
         uJyg==
X-Gm-Message-State: ACgBeo3F0Gvmw1vzNLJ9JmvGtuuQJJWkMnFaTnkkW1FXj6e7tXBYkNxO
        FTh94VfsbRlejfAceglm93XZSwbb9kuJULivejg=
X-Google-Smtp-Source: AA6agR4HN7NGCN+5Nm3o5ZPI11wFeHZd019hreDKcfy13HBWYfkBqLWiTBP5Gb8rjKPC7hh0p1MPaVxKbegKid9+kUA=
X-Received: by 2002:a0d:df92:0:b0:340:b90d:fb75 with SMTP id
 i140-20020a0ddf92000000b00340b90dfb75mr31609069ywe.149.1662230773761; Sat, 03
 Sep 2022 11:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220829030417.236471-1-tamim@fusetak.com>
In-Reply-To: <20220829030417.236471-1-tamim@fusetak.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:46:02 +0200
Message-ID: <CAJZ5v0h-zAWPaHSw+9JNxYLLKMBaMFwuU2ffJ3FedG0Xw+1JEg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA
To:     Tamim Khan <tamim@fusetak.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hui Wang <hui.wang@canonical.com>,
        Sunand <sunandchakradhar@gmail.com>
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

On Mon, Aug 29, 2022 at 5:08 AM Tamim Khan <tamim@fusetak.com> wrote:
>
> In the ACPI DSDT table for Asus VivoBook K3402ZA/K3502ZA
> IRQ 1 is described as ActiveLow; however, the kernel overrides
> it to Edge_High. This prevents the internal keyboard from working
> on these laptops. In order to fix this add these laptops to the
> skip_override_table so that the kernel does not override IRQ 1 to
> Edge_High.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216158
> Reviewed-by: Hui Wang <hui.wang@canonical.com>
> Tested-by: Tamim Khan <tamim@fusetak.com>
> Tested-by: Sunand <sunandchakradhar@gmail.com>
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
> This patch is very similar to the fix implemented for keyboards on
> Medion laptops in 892a012699fc0b91a2ed6309078936191447f480
> (ACPI: resources: Add DMI-based legacy IRQ override quirk) and
> 1b26ae40092b43bb6e9c5df376227382b390b953 (ACPI: resources: Add one
> more Medion model in IRQ override quirk) and has been reviewed by the
> author of those commits. It has also been tested by myself on a K3502ZA
> and by someone else with a K3402ZA to verify that this patch allows
> the internal keyboard to work.
>
>  drivers/acpi/resource.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 510cdec375c4..2ebc85233bac 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -399,6 +399,24 @@ static const struct dmi_system_id medion_laptop[] = {
>         { }
>  };
>
> +static const struct dmi_system_id asus_laptop[] = {
> +       {
> +               .ident = "Asus Vivobook K3402ZA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
> +               },
> +       },
> +       {
> +               .ident = "Asus Vivobook K3502ZA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
> +               },
> +       },
> +       { }
> +};
> +
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
> @@ -409,6 +427,7 @@ struct irq_override_cmp {
>
>  static const struct irq_override_cmp skip_override_table[] = {
>         { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
> +       { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --

Applied as 6.1 material, thanks!
