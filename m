Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686D957A659
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiGSSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiGSSTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:19:07 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D0752DE8;
        Tue, 19 Jul 2022 11:19:05 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id j67so5414181ybb.3;
        Tue, 19 Jul 2022 11:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbNTOKbao1e8ZUyoBAhHzMW32PEnP+e69owespR4fKw=;
        b=kyatzOoFsD6ob1pXndrBLczTAow5blFfnAdB3l5EFhKTKTsGX1kb/FLAHGmGpIgx+/
         8HJx3OTeREJzFmCUceWbJImZfKr/KuGxA5bBr6IiTNIX0rBdNrk4zHhTeBWX7oDPhjsS
         5eXZXuvStUR8fy2Qab1c+SHEC9W8XmRHMePAFhLm6dTEcw3gDmc2IVHiq+yERLxpe/2U
         3sHdiZXdVFpYRfK8CMNH+aEVyC66eCIORLdzF2AawNrwrfu7M07RzwGzhjcRTRk/qKC4
         gdWGTSLbNAz8W5cNIoOvR62LYUjsxHZkAkryEVuXd08+MVzCL23cXWCvbzw3iN7rTEA2
         2QtA==
X-Gm-Message-State: AJIora85aSacFtrePEktDlsV5Y8vydN/9MwFk1kchDYgDmXNuoc+rzew
        OO1p1VBiheS7nTvDIqHXbcXpdkNx6viCS/ySsj0=
X-Google-Smtp-Source: AGRyM1vgi+IyezsRRUw8FfUHz1dtFKAMtmhq9UKGxwEHBlqaJUozAmNS3yiCuuOmSx/eVaRZh8X6OsqM6vlckwEnSd4=
X-Received: by 2002:a5b:202:0:b0:66f:aab4:9c95 with SMTP id
 z2-20020a5b0202000000b0066faab49c95mr32218969ybl.81.1658254744897; Tue, 19
 Jul 2022 11:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org> <20220710123512.1714714-10-daniel.lezcano@linexp.org>
In-Reply-To: <20220710123512.1714714-10-daniel.lezcano@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jul 2022 20:18:54 +0200
Message-ID: <CAJZ5v0iT8w7APyNKDQ-Q-vO33-BN4_vh_HtiCxpCJZu_QzC4Ug@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] thermal/core: Add thermal_trip in thermal_zone
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 2:35 PM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:
>
> The thermal trip points are properties of a thermal zone and the
> different sub systems should be able to save them in the thermal zone
> structure instead of having their own definition.
>
> Give the opportunity to the drivers to create a thermal zone with
> thermal trips which will be accessible directly from the thermal core
> framework.
>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_core.h | 10 ++++++++++
>  include/linux/thermal.h        |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index c991bb290512..a4e730391cab 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
>  /* Helpers */
>  void thermal_zone_set_trips(struct thermal_zone_device *tz);
>
> +static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone_device *tz)
> +{
> +       return tz->trips;
> +}
> +
> +static inline int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> +{
> +       return tz->num_trips;
> +}

I'm not sure if these are really useful.

> +
>  /* sysfs I/F */
>  int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
>  void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 03e968d61471..c7fcb9e2a4fc 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -125,6 +125,7 @@ struct thermal_cooling_device {
>   * @trip_hyst_attrs:   attributes for trip points for sysfs: trip hysteresis
>   * @mode:              current mode of this thermal zone
>   * @devdata:   private pointer for device private data
> + * @trips:     an array of struct thermal_trip
>   * @num_trips: number of trip points the thermal zone supports
>   * @trips_disabled;    bitmap for disabled trips
>   * @passive_delay_jiffies: number of jiffies to wait between polls when
> @@ -165,6 +166,7 @@ struct thermal_zone_device {
>         struct thermal_attr *trip_hyst_attrs;
>         enum thermal_device_mode mode;
>         void *devdata;
> +       struct thermal_trip *trips;

And I would fold this change into the patch introducing its first user.

>         int num_trips;
>         unsigned long trips_disabled;   /* bitmap for disabled trips */
>         unsigned long passive_delay_jiffies;
> --
> 2.25.1
>
