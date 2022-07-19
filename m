Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C057A6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiGSS4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiGSS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:56:39 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B429C83;
        Tue, 19 Jul 2022 11:56:38 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 75so28191589ybf.4;
        Tue, 19 Jul 2022 11:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBfw2Uykz5W8jj6CdHDl6Ft+X5d3/T7HGjVh8IfPI8Y=;
        b=fD1nipFQH9ilzgALEFysny3najhnCiO9jKOePilaZt4YWVZxYlN0umymzIeK3WcDaN
         3yne7vPHgh2mfgXc3FGKCx9bCDIn+v824iuAiJuLcuunobh3m/qoCBaXvx4YjkOKmmxw
         QNezu6oWR/SNbysphk8qnxqSHEsU6Q41hKA8Ax8dtBIOLcrVapCJVS7mPYLTsQaW4EKi
         yhx3dS0rq6fQmI7mwRWHJDH8P+72rnjNHljWwX33lXyKyFyRbR1bn0JMPBxn8YfW6rlx
         l64Y8oTNoSnq5L2ObaaZsW85gPKy8nYo42QZf8dboiqobk0syRxP3aUIr3mFQMx2Shul
         lkPQ==
X-Gm-Message-State: AJIora+vXUbB+tkMNqb4mlHEYkUJsXV6ekXoW2MWe6iaYaeNxZfYRYGD
        gtQa2upv0JFXIXibCuI/5vugsK35QUjmrJpewvm7pnXEKfw=
X-Google-Smtp-Source: AGRyM1uvAu/b0PuuozCqjCbvm1sPWKyBibGgMLZiamG00bJ/u5MCeWy+qodEOpbnFGVIIW2erbn18Llz63P42+Tfu1I=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr33229468ybg.633.1658256997247; Tue, 19
 Jul 2022 11:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org> <20220718145038.1114379-3-daniel.lezcano@linaro.org>
In-Reply-To: <20220718145038.1114379-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jul 2022 20:56:26 +0200
Message-ID: <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jul 18, 2022 at 4:50 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> By convention the trips points are declared in the ascending
> temperature order. However, no specification for the device tree, ACPI
> or documentation tells the trip points must be ordered this way.
>
> In the other hand, we need those to be ordered to browse them at the

s/In/On/

> thermal events.

What if they are all inspected every time?

> But if we assume they are ordered and change the code
> based on this assumption, any platform with shuffled trip points
> description will be broken (if they exist).
>
> Instead of taking the risk of breaking the existing platforms, use an
> array of temperature ordered trip identifiers and make it available
> for the code needing to browse the trip points in an ordered way.

Well, having ops->get_trip_temp() suggests that the trip temperatures
can be dynamic.  Is the ordering guaranteed to be preserved in that
case?

Anyway, if they need to be sorted, why don't we just sort them
properly instead of adding this extra array?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>
> V4:
>   - Fix conflicts due to tz->trips renamed to tz->num_trips
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 63 +++++++++++++++++++++++++++-------
>  include/linux/thermal.h        |  2 ++
>  2 files changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index fc6ccc5edbfb..f274dc7d9c48 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -355,7 +355,8 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  }
>
>  static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
> -                                       int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
> +                                       int trip_temp, int trip_hyst,
> +                                       enum thermal_trip_type trip_type)
>  {
>         if (tz->last_temperature == THERMAL_TEMP_INVALID)
>                 return;
> @@ -1171,6 +1172,47 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>         if (delay_ms > 1000)
>                 *delay_jiffies = round_jiffies(*delay_jiffies);
>  }
> +
> +static void sort_trips_indexes(struct thermal_zone_device *tz)
> +{
> +       int i, j;
> +
> +       for (i = 0; i < tz->num_trips; i++)
> +               tz->trips_indexes[i] = i;
> +
> +       for (i = 0; i < tz->num_trips; i++) {
> +
> +               for (j = i + 1; j < tz->num_trips; j++) {
> +                       int t1, t2;
> +
> +                       tz->ops->get_trip_temp(tz, tz->trips_indexes[i], &t1);
> +                       tz->ops->get_trip_temp(tz, tz->trips_indexes[j], &t2);
> +
> +                       if (t1 > t2)
> +                               swap(tz->trips_indexes[i], tz->trips_indexes[j]);
> +               }
> +       }
> +}
> +
> +static int thermal_zone_device_trip_init(struct thermal_zone_device *tz)
> +{
> +       enum thermal_trip_type trip_type;
> +       int trip_temp, i;
> +
> +       tz->trips_indexes = kzalloc(tz->num_trips * sizeof(int), GFP_KERNEL);
> +       if (!tz->trips_indexes)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < tz->num_trips; i++) {
> +               if (tz->ops->get_trip_type(tz, i, &trip_type) ||
> +                   tz->ops->get_trip_temp(tz, i, &trip_temp) || !trip_temp)
> +                       set_bit(i, &tz->trips_disabled);
> +       }
> +
> +       sort_trips_indexes(tz);
> +
> +       return 0;
> +}
>
>  /**
>   * thermal_zone_device_register_with_trips() - register a new thermal zone device
> @@ -1204,11 +1246,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                                         int polling_delay)
>  {
>         struct thermal_zone_device *tz;
> -       enum thermal_trip_type trip_type;
> -       int trip_temp;
>         int id;
>         int result;
> -       int count;
>         struct thermal_governor *governor;
>
>         if (!type || strlen(type) == 0) {
> @@ -1281,12 +1320,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         if (result)
>                 goto release_device;
>
> -       for (count = 0; count < num_trips; count++) {
> -               if (tz->ops->get_trip_type(tz, count, &trip_type) ||
> -                   tz->ops->get_trip_temp(tz, count, &trip_temp) ||
> -                   !trip_temp)
> -                       set_bit(count, &tz->trips_disabled);
> -       }
> +       result = thermal_zone_device_trip_init(tz);
> +       if (result)
> +               goto unregister;
>
>         /* Update 'this' zone's governor information */
>         mutex_lock(&thermal_governor_lock);
> @@ -1299,7 +1335,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         result = thermal_set_governor(tz, governor);
>         if (result) {
>                 mutex_unlock(&thermal_governor_lock);
> -               goto unregister;
> +               goto kfree_indexes;
>         }
>
>         mutex_unlock(&thermal_governor_lock);
> @@ -1307,7 +1343,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         if (!tz->tzp || !tz->tzp->no_hwmon) {
>                 result = thermal_add_hwmon_sysfs(tz);
>                 if (result)
> -                       goto unregister;
> +                       goto kfree_indexes;
>         }
>
>         mutex_lock(&thermal_list_lock);
> @@ -1328,6 +1364,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>
>         return tz;
>
> +kfree_indexes:
> +       kfree(tz->trips_indexes);
>  unregister:
>         device_del(&tz->device);
>  release_device:
> @@ -1406,6 +1444,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         thermal_remove_hwmon_sysfs(tz);
>         ida_simple_remove(&thermal_tz_ida, tz->id);
>         ida_destroy(&tz->ida);
> +       kfree(tz->trips_indexes);
>         mutex_destroy(&tz->lock);
>         device_unregister(&tz->device);
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 1386c713885d..4e576184df49 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -125,6 +125,7 @@ struct thermal_cooling_device {
>   * @devdata:   private pointer for device private data
>   * @trips:     an array of struct thermal_trip
>   * @num_trips: number of trip points the thermal zone supports
> + * @trips_indexes:     an array of sorted trip points indexes
>   * @trips_disabled;    bitmap for disabled trips
>   * @passive_delay_jiffies: number of jiffies to wait between polls when
>   *                     performing passive cooling.
> @@ -166,6 +167,7 @@ struct thermal_zone_device {
>         void *devdata;
>         struct thermal_trip *trips;
>         int num_trips;
> +       int *trips_indexes;
>         unsigned long trips_disabled;   /* bitmap for disabled trips */
>         unsigned long passive_delay_jiffies;
>         unsigned long polling_delay_jiffies;
> --
> 2.25.1
>
