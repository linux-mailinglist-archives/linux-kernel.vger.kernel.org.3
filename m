Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B584DC79A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiCQNcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiCQNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:32:20 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E861D78A7;
        Thu, 17 Mar 2022 06:31:03 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id j2so10325511ybu.0;
        Thu, 17 Mar 2022 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrVPm0cGVD9kw1HlnBFNiKgwq9G5aMTytWTYTGiKmXw=;
        b=uv8yOYu2ytWMndmlbnn3FhKljp4ukI4pS47K1qEa2F2qqeLaxREqBLuEMlTH3w3CUs
         m+oRDsZjRNcdrStOR1KNBS1djzqNwaEPuWkL7isptU/fvtDvOPveYRNPOFXxZAOHQRjP
         Swh0n1n6/9sktTyOXf61e2X5c92kmAnUiHABw95FF5SK4k21fE3lTIDrAbsgHehNmUlL
         /q+haTg8fcScduLtdt1uk6LGQg0GI0BhhEdzpRUGxtDD/f/g1QScCom7oUQcm12kcRCY
         9u2qgWZeXsn9tfl7w/ZSWHqn2bnlf5y3zSn8G5CB4hTIxPD8EDTHJOHQt6soGbMFRsyy
         4Eag==
X-Gm-Message-State: AOAM530gK0S0S7Zv1uqQdZ1grqI2RQNln6k1FokSTHI3j2IVm6V+Q5C1
        dc7fhBDiOYkqdrH0sNgeNSwvHL2nvSr282ij/s8D9lsE
X-Google-Smtp-Source: ABdhPJz7J/aJd3dvSnoV0MmKuPJxIcSLx0gIqciaNk0QNBKxZmepSvnxdfbNNZ5QTdyZMVpWHnvAA5H1hteIFbxLku0=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr4785672ybe.365.1647523862378; Thu, 17
 Mar 2022 06:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220315190228.1503866-1-wse@tuxedocomputers.com> <20220315190228.1503866-2-wse@tuxedocomputers.com>
In-Reply-To: <20220315190228.1503866-2-wse@tuxedocomputers.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 14:30:51 +0100
Message-ID: <CAJZ5v0iV5FvDxmYgoyQo_r39LYT2XL8wTujo_u=hu2n2BWdCRQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI/backlight: Force backlight native for Clevo NL5xRU
 and NL5xNU
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Tue, Mar 15, 2022 at 8:02 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a working
> native and video interface. However the default detection mechanism first
> registers the video interface before unregistering it again and switching
> to the native interface during boot. This results in a dangling SBIOS
> request for backlight change for some reason, causing the backlight to
> switch to ~2% once per boot on the first power cord connect or disconnect
> event. Setting the native interface explicitly circumvents this buggy
> behaviour by avoiding the unregistering process.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/acpi/video_detect.c | 75 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 4f64713e9917..becc198e4c22 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -415,6 +415,81 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
>                 },
>         },
> +       /*
> +        * Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a
> +        * working native and video interface. However the default detection
> +        * mechanism first registers the video interface before unregistering
> +        * it again and switching to the native interface during boot. This
> +        * results in a dangling SBIOS request for backlight change for some
> +        * reason, causing the backlight to switch to ~2% once per boot on the
> +        * first power cord connect or disconnect event. Setting the native
> +        * interface explicitly circumvents this buggy behaviour, by avoiding
> +        * the unregistering process.
> +        */
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xRU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +               DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xRU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +               DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xRU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +               DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xRU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +               DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xRU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +               DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xNU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +               DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xNU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +               DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "Clevo NL5xNU",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +               DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
> +               },
> +       },
>
>         /*
>          * Desktops which falsely report a backlight and which our heuristics
> --

Applied as 5.18 material, thanks!
