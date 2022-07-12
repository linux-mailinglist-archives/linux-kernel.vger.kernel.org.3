Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9379572246
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiGLSQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiGLSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:16:50 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243ABD3B5;
        Tue, 12 Jul 2022 11:16:50 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31c86fe1dddso89929167b3.1;
        Tue, 12 Jul 2022 11:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlWXUwga3ltyY5Mjt3+pu126riRkOGLx3DSNAjuT1jk=;
        b=zJJXrME0AvHpSeqzAO9PB7L7yLF1UIo2SMrU1wrmfM3B8NCYF7+vrxLJAyD2Cp27j2
         ddNAItA1YuH/ZjNbTXjD0pW2h2FZLspEUPzjWiEfQIjxDIUUXHpzD6MN2BoifBELuC1+
         CfIZy2cONRhRFCINydPx1dmHIyJNglraM0u3HExfbc8M84kzrBOud0QfepQlMKJDSeNW
         14iumXynUTJQgvrCd+oeyS9xRo4ZmdWgEhGSXKqDjDCobLC4vMQPRCNx2VVpFd9H32ON
         cuAhXp6pSyYAM47+p4cMkHsl+mzs0I6IBnyXxseGma0TvpuDP4TVrEFiU3mJCeZBlpmg
         N2xw==
X-Gm-Message-State: AJIora+eDdrVKDJq1bKl2gS9eZM9e1va4q7kwp1y5vL3pL2+P98UjL9J
        yoROomMSRXFETtsiJdsDZpfXXw2/M/cKMynR0yk=
X-Google-Smtp-Source: AGRyM1u4CV9wOgZQoJoK07kxVH9aOriHxiZ30XDiUkh8YZxZv9ldmutudpeup7pyDVREWd2fDYZDpkZ21Ee1jBC8suA=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr27671017ywx.196.1657649809348; Tue, 12
 Jul 2022 11:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org> <20220708183210.1334839-2-daniel.lezcano@linaro.org>
In-Reply-To: <20220708183210.1334839-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 20:16:38 +0200
Message-ID: <CAJZ5v0j9pQz5eTwZdt-ZXBgrKkO7O3+G48XRJh2A5-j5Ze28=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] thermal/core: Passing a parameter instead of
 calling the function again
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>
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

On Fri, Jul 8, 2022 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> As the trip temperature is already available when calling the
> function,

Which function?

I would change the subject to something like "Avoid calling
->get_trip_temp() unnecessarily" and then use the specific function
name in the changelog.

The changes themselves LGTM.

> pass it as a parameter instead of having the function
> calling the ops again to retrieve the same data.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9f771b15ed8..f66036b3daae 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
>  EXPORT_SYMBOL(thermal_zone_device_critical);
>
>  static void handle_critical_trips(struct thermal_zone_device *tz,
> -                                 int trip, enum thermal_trip_type trip_type)
> +                                 int trip, int trip_temp, enum thermal_trip_type trip_type)
>  {
> -       int trip_temp;
> -
> -       tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -
>         /* If we have not crossed the trip_temp, we do not care. */
>         if (trip_temp <= 0 || tz->temperature < trip_temp)
>                 return;
> @@ -394,7 +390,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>         handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
>
>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
> -               handle_critical_trips(tz, trip, type);
> +               handle_critical_trips(tz, trip, trip_temp, type);
>         else
>                 handle_non_critical_trips(tz, trip);
>         /*
> --
> 2.25.1
>
