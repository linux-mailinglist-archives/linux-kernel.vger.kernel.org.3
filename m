Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DFB58AE2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiHEQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiHEQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:29:23 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D651EAC1;
        Fri,  5 Aug 2022 09:29:22 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j63so4509738ybb.13;
        Fri, 05 Aug 2022 09:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JpK4cKjWfUdf5fiTOgPLG1JC3Xe7mGK2psxBpm/kgz0=;
        b=5WmvgU3LEnUUlhoZvFAANJwRfEBY0n0UwBf2M7r7VbcsC//hRMH0CahIzWYYQpe7Y4
         UvNAXCjug+d09y5p4dngiLK0+QAV/TaV57+LQc9bsTpOaJx5Qza+zsri7ODpKGVujXIO
         bIZsNR1ZIPoCwpp5V48xoUvDzXQn9jnFemS6ofNEGcrd7/LbnS0QsNgnD44cVSJezucc
         lTzFnagbCXpKyEM56vM+XKlhO71vJNrK7NShs2hmW27BxLOk1nEpU6M+nCpnMWdCpHtQ
         gTtnsi5qH7K4CixJWsT0BFOlrWrOOer17BtX/EJkOrSCt7iRvFQu98fPhLUhWG52KfS+
         vTJw==
X-Gm-Message-State: ACgBeo0oDEqwOK+M4vgyeEK8YJn+eVK4JB0rrOPID19i5sZAZMd40V9D
        diGI6JW3faDuUWg+91xcJMmtVIZdb6GVnno98e4=
X-Google-Smtp-Source: AA6agR7Zsuuvu2R22w+jsFCs5Obdld9ZRUWowUJ7/XDtMD+zovP2x7IJKUXlcChmvQ7oXdoo4RS6v+yWnnoBfovePVI=
X-Received: by 2002:a25:cc51:0:b0:676:ccba:875 with SMTP id
 l78-20020a25cc51000000b00676ccba0875mr6093715ybf.137.1659716960892; Fri, 05
 Aug 2022 09:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
In-Reply-To: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Aug 2022 18:29:09 +0200
Message-ID: <CAJZ5v0jVp+AW06MqgOmQV=AmGtb7VdY_FYSxC6wT2BZw9uzxnQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/core: Rearm the monitoring only one time
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, Aug 5, 2022 at 5:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The current code calls monitor_thermal_zone() inside the
> handle_thermal_trip() function. But this one is called in a loop for
> each trip point which means the monitoring is rearmed several times
> for nothing (assuming there could be several passive and active trip
> points).
>
> Move the monitor_thermal_zone() function out of the
> handle_thermal_trip() function and after the thermal trip loop, so the
> timer will be disabled or rearmed one time.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Does this series depend on any other?

You've been sending quite a lot of material lately and it is not
always easy to tell what the dependencies between the different patch
series are.

> ---
>  drivers/thermal/thermal_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index b4c68410c158..4e1a83987b99 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -383,11 +383,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>                 handle_critical_trips(tz, trip, trip_temp, type);
>         else
>                 handle_non_critical_trips(tz, trip);
> -       /*
> -        * Alright, we handled this trip successfully.
> -        * So, start monitoring again.
> -        */
> -       monitor_thermal_zone(tz);
>  }
>
>  static void update_temperature(struct thermal_zone_device *tz)
> @@ -503,6 +498,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>
>         for (count = 0; count < tz->num_trips; count++)
>                 handle_thermal_trip(tz, count);
> +
> +       monitor_thermal_zone(tz);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>
> --
> 2.25.1
>
