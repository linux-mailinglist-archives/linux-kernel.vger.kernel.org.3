Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBB57A679
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiGSS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGSS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:26:35 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B06459AA;
        Tue, 19 Jul 2022 11:26:34 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31e45527da5so51606657b3.5;
        Tue, 19 Jul 2022 11:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JtDJaLqSgYtOGoa4GJ8SZbye3wc7l/W81QRe6hhnmg=;
        b=mNXVvnpZqyUnn6VA0pCFCgDknsVeYzB2SRjxrx9QV0g/6WR9MDWw4Vy5Dw7cPJMpwk
         FG+jCufC9arEnD3bRwupTNojLO7FRr3i+M+oIoaXGxGwt+PchYrMj5SKbgTpcscs8Wyf
         wbVBDVnFj2JBYnKUljLkQkUU46E7ppOcwOH5Es5Wam18ZQ+yf/4vl7qJoILJTj0MdkXC
         RXhqc54JcGCN/V6P8BRUMBqq4OYVS3SfVR71KmWRene0ZcXP6qsDs5T1hG1pbsdHPDs9
         D9ozvd5jyWUmyfrO81VwLoiKmi7td96Y2bTAAO4UGLPIEodOwrz660sIYkiQtXA+2by+
         xIjA==
X-Gm-Message-State: AJIora9/h5pwNm0mrz+8gwWa6LRWQBlGlzjJ6vXYtCc9VHPKaBcW7853
        1IRndPFTcltiQE816rplFbz51eNJEUJ4o/CvxOs=
X-Google-Smtp-Source: AGRyM1tTR22wDct2zKvE5yhbMLj8gnI6dzLMbq9/SO7urOimkKqPutBk5GNf1EYtqTRfIFQmfPs2jUsugkfe9yB+AdY=
X-Received: by 2002:a81:1a11:0:b0:31e:4549:d667 with SMTP id
 a17-20020a811a11000000b0031e4549d667mr8803476ywa.196.1658255193549; Tue, 19
 Jul 2022 11:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org> <20220710123512.1714714-13-daniel.lezcano@linexp.org>
In-Reply-To: <20220710123512.1714714-13-daniel.lezcano@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jul 2022 20:26:22 +0200
Message-ID: <CAJZ5v0hTQBXbKNurR0p8_MWmcW-EtezUg1oSNLVEYEAdzpeyBA@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
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
> Now that we have the thermal trip stored in the thermal zone in a
> generic way, we can rely on them and remove one indirection we found
> in the thermal_of code and do one more step forward the removal of the
> duplicated structures.
>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
>  1 file changed, 16 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index e187461dd396..601552c55d0b 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
>   */
>  int of_thermal_get_ntrips(struct thermal_zone_device *tz)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (!data || IS_ERR(data))
> -               return -ENODEV;
> -
> -       return data->ntrips;
> +       return tz->ntrips;

Hasn't this been renamed to num_trips?

>  }
>  EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
>
> @@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
>   */
>  bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (!data || trip >= data->ntrips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return false;
>
>         return true;
> @@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
>  const struct thermal_trip *
>  of_thermal_get_trip_points(struct thermal_zone_device *tz)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (!data)
> -               return NULL;
> -
> -       return data->trips;
> +       return tz->trips;
>  }
>  EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
>
> @@ -281,12 +269,10 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
>  static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
>                                     enum thermal_trip_type *type)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (trip >= data->ntrips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return -EDOM;
>
> -       *type = data->trips[trip].type;
> +       *type = tz->trips[trip].type;
>
>         return 0;
>  }
> @@ -294,12 +280,10 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
>  static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
>                                     int *temp)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (trip >= data->ntrips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return -EDOM;
>
> -       *temp = data->trips[trip].temperature;
> +       *temp = tz->trips[trip].temperature;
>
>         return 0;
>  }
> @@ -309,7 +293,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
>  {
>         struct __thermal_zone *data = tz->devdata;
>
> -       if (trip >= data->ntrips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return -EDOM;
>
>         if (data->ops && data->ops->set_trip_temp) {
> @@ -321,7 +305,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
>         }
>
>         /* thermal framework should take care of data->mask & (1 << trip) */
> -       data->trips[trip].temperature = temp;
> +       tz->trips[trip].temperature = temp;
>
>         return 0;
>  }
> @@ -329,12 +313,10 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
>  static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
>                                     int *hyst)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (trip >= data->ntrips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return -EDOM;
>
> -       *hyst = data->trips[trip].hysteresis;
> +       *hyst = tz->trips[trip].hysteresis;
>
>         return 0;
>  }
> @@ -342,13 +324,11 @@ static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
>  static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
>                                     int hyst)
>  {
> -       struct __thermal_zone *data = tz->devdata;
> -
> -       if (trip >= data->ntrips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return -EDOM;
>
>         /* thermal framework should take care of data->mask & (1 << trip) */
> -       data->trips[trip].hysteresis = hyst;
> +       tz->trips[trip].hysteresis = hyst;
>
>         return 0;
>  }
> @@ -356,12 +336,11 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
>  static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
>                                     int *temp)
>  {
> -       struct __thermal_zone *data = tz->devdata;
>         int i;
>
> -       for (i = 0; i < data->ntrips; i++)
> -               if (data->trips[i].type == THERMAL_TRIP_CRITICAL) {
> -                       *temp = data->trips[i].temperature;
> +       for (i = 0; i < tz->ntrips; i++)
> +               if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
> +                       *temp = tz->trips[i].temperature;
>                         return 0;
>                 }
>
> --
> 2.25.1
>
