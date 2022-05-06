Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345EC51DF3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381679AbiEFSrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:46:57 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C491562F4;
        Fri,  6 May 2022 11:43:14 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7c57ee6feso90984317b3.2;
        Fri, 06 May 2022 11:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahozwA6JR5T2cdvT7X6332oCeq+rsm8ghW3MnqhOLVQ=;
        b=NiHH0BweiFoPVnDwANIlKnelwo5Qb51GmVdjG+c48HkTU6/RcipXw99p7NoFkz9ERf
         fVY+vgr0MzNlJfKVp0Lvlu7P3Gtucjr8Uj1nQaswSCiRe/4GjQNYIAHDliKDtgmS6Tfm
         ncEq7lHxbzLp87YFrS5ac9xoSILfiiLZZoe9+3OFD58BfNGatpsFCVg/cggr3kBwVl+o
         DlBaeYUVOkhRbCBPmwstgKbb9N62eHBFUqNJuBmY6qRKrCu2OlnPrXfROGMHeJJ4NR7m
         ZMC0VHaKfuTILNKukOlkLyIMIFleGCmu47Bp8p5LAUaajw6RAZdhySJb7SZe12jL5SZj
         hNQA==
X-Gm-Message-State: AOAM533fyFV7OGis1JRs6oOS5lAvvm0DJKFOm5JjgwIc3/7QU9Rjbw+0
        jarsWo5pYjKLSBle8zSQmE+dw8gUUyNaNV9VFow=
X-Google-Smtp-Source: ABdhPJxyhio+VMd91Op4H0BgZTrwq0+91VU5XeN+Yn1ssNSy/OzKsrOvBfqsnVQsz3+4YWU8uo5xJG5Q4m7XGbHnucY=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr3879863ywm.149.1651862593459; Fri, 06
 May 2022 11:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220429174114.1277799-1-luzmaximilian@gmail.com>
In-Reply-To: <20220429174114.1277799-1-luzmaximilian@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:43:02 +0200
Message-ID: <CAJZ5v0hoE0vn5BX586Ag4oLFRn3WoZJCUQZ1+jM1O6Vm+yyc4A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Add "Not Charging" quirk for Microsoft
 Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>
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

On Fri, Apr 29, 2022 at 7:41 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Microsoft Surface devices have a limiter that sets a fixed maximum
> charge capacity for the battery. When that maximum capacity has been
> reached, charging stops. In that case, _BST returns a battery state
> field with both "charging" and "discharging" bits cleared. The battery
> driver, however, returns "unknown" as status.
>
> This seems to be the same behavior as observed on the ThinkPads, so
> let's use the same quirk to handle that.
>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>
> For what it's worth, I don't think the ACPI spec explicitly states that
> any of the status bits need to be set, or that there are only the
> "charging" and "discharging" states. As far as I can tell, ACPI only
> states:
>
>     Notice that the Charging bit and the Discharging bit are mutually
>     exclusive and must not both be set at the same time. Even in
>     critical state, hardware should report the corresponding
>     charging/discharging state.
>
> But that does not exclude the case that no bit is set. So, strictly
> going by spec, I don't think it's necessary to put all of this behind a
> quirk.

I think that this should be covered by the patch I've just applied:

https://patchwork.kernel.org/project/linux-acpi/patch/20220427154053.499203-1-wse@tuxedocomputers.com/

Shouldn't it?

> ---
>  drivers/acpi/battery.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index dc208f5f5a1f..1c88504aae5b 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1152,6 +1152,19 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
>                 },
>         },
> +       {
> +               /*
> +                * Microsoft Surface devices have an optional "battery
> +                * limiter". Due to this, there is a "Not Charging" state
> +                * similar to the one on the Lenovo ThinkPads, described above.
> +                */
> +               .callback = battery_quirk_not_charging,
> +               .ident = "Microsoft Surface",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Surface"),
> +               },
> +       },
>         {
>                 /* Microsoft Surface Go 3 */
>                 .callback = battery_notification_delay_quirk,
> --
> 2.36.0
>
