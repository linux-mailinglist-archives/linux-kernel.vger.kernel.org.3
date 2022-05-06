Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FB51DF33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354528AbiEFSmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:42:37 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664A64DF42;
        Fri,  6 May 2022 11:38:53 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f16645872fso90724337b3.4;
        Fri, 06 May 2022 11:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auhiPQv1lYR9Q5MFCpDzMVbrDqp/vwNsOHEdI7ynv1U=;
        b=OaCsiiupHY0hyFqfCAxsfmWx9gU4uMJ7C2ZkhwrvC76GgNez5lHb7GSWd9PehK6MVm
         2oETudbXYOPEuVvGiPa+9kfTfhX/3HzSb8B3yG4PFfxauoBLUV86qNcXgRzGfHET+2QV
         HZf8gir/ncni82YD1doiw/+wqLweWQ9Iv+WQHTeKU4RD1L1tlEngNgL8yhgUGR4QwNJg
         QGU1TsTeeVRZjO7FXdk7KAo8Db8nWGz+WfB5TZXOCTxB18O3MMDCCGm/OzvmBNG03PcF
         74WyiWUP7Fmr/1gbn5+Ki7MAl9Fm+OF+h8keBeM6UQngmnnFSdCOqHTW4l7xSyEiZLKU
         aLmw==
X-Gm-Message-State: AOAM53123naBwLoArMx4Riv+95y/HbzjPd15M0oZ82WZ4XsVRhqwcaEU
        /a9/1x4V64HYHNoMz1CbWkPq0bVheKegvoG+VqU=
X-Google-Smtp-Source: ABdhPJwVHwu5moQPalMK9kwA1AM/aWQwrf04idnFgZxzIWhPxT5w/dk93wqA1WChRBw3J2oG8BIdse4QVDS+zn35TvY=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr3864745ywm.149.1651862332715; Fri, 06
 May 2022 11:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220427154053.499203-1-wse@tuxedocomputers.com>
In-Reply-To: <20220427154053.499203-1-wse@tuxedocomputers.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:38:41 +0200
Message-ID: <CAJZ5v0i7nkMb1BK+XtLJLPa1X1rboMyNs2PtFU-r9-CkULtRSQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/battery: Make "not-charging" the default on no
 charging or full info
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 5:41 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> When the battery is neither charging or discharging and is not full,
> "not-charging" is a useful status description for the case in general.
> Currently this state is set as "unknown" by default, expect when this is
> explicitly replaced with "not-charging" on a per device or per vendor
> basis.
>
> A lot of devices have this state without a BIOS specification available
> explicitly describing it. e.g. some current Clevo barebones have a BIOS
> setting to stop charging at a user defined battery level.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/acpi/battery.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index dc208f5f5a1f..306513fec1e1 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -52,7 +52,6 @@ static bool battery_driver_registered;
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
>  static int battery_ac_is_broken;
> -static int battery_quirk_notcharging;
>  static unsigned int cache_time = 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -216,10 +215,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
>                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
>                         val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (battery_quirk_notcharging)
> -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else
> -                       val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 break;
>         case POWER_SUPPLY_PROP_PRESENT:
>                 val->intval = acpi_battery_present(battery);
> @@ -1105,12 +1102,6 @@ battery_ac_is_broken_quirk(const struct dmi_system_id *d)
>         return 0;
>  }
>
> -static int __init battery_quirk_not_charging(const struct dmi_system_id *d)
> -{
> -       battery_quirk_notcharging = 1;
> -       return 0;
> -}
> -
>  static const struct dmi_system_id bat_dmi_table[] __initconst = {
>         {
>                 /* NEC LZ750/LS */
> @@ -1139,19 +1130,6 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
>                         DMI_MATCH(DMI_BIOS_DATE, "08/22/2014"),
>                 },
>         },
> -       {
> -               /*
> -                * On Lenovo ThinkPads the BIOS specification defines
> -                * a state when the bits for charging and discharging
> -                * are both set to 0. That state is "Not Charging".
> -                */
> -               .callback = battery_quirk_not_charging,
> -               .ident = "Lenovo ThinkPad",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
> -               },
> -       },
>         {
>                 /* Microsoft Surface Go 3 */
>                 .callback = battery_notification_delay_quirk,
> --

Applied as 5.19 material, thanks!
