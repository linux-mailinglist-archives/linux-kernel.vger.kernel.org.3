Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC657A672
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiGSSYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiGSSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:24:31 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9305C9DA;
        Tue, 19 Jul 2022 11:24:30 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 64so28009766ybt.12;
        Tue, 19 Jul 2022 11:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48raHFTKbrj8Vl3w1c4/M6bTKcLquPMNkRREEdYPnkM=;
        b=u4q8M2TuZqOLdI+o26hX8ZAGfyAn4gcb8KqJT1mvkXfxAYTiLjq8tQkN3Oba4KWNKg
         UAMj7h18z6JkfR53FxdFlMDlpPv6Mar7z+i7p1m/zpWHcXtBzEe4aKTH9KaxJQAd2o2i
         IjFylgCfHVih1mTe+S1nE4BKe8paojC13Kd4Tzut+uhBrcRZkRKx48PV0lZrkBJ2kVzn
         FZzA5FhPBZyFsvmkfZg15v1aIJvr6R7L6xvobt3Q59c6e9/vABXEFoVHnxnbtNgYl+VM
         rkBfnoxP/P45z6h//xt6jYDLJt1zUDnZQvwW8em0H7BQb64eEj6u0OWNsSBe+96Qu5kO
         KMgA==
X-Gm-Message-State: AJIora8PPFLI1YDSlzsyDDtr6kck8E/LqdNny57C7Wq7i29WQsYph+A+
        N/wiHcrdNoTOVP6waVPZ1wHEYOpasRai1nFEGzI=
X-Google-Smtp-Source: AGRyM1sD5X5dw8EhtE0U+LDqxugFi2U0yB543Ac3KRnAVyhBkQUNYLiCV/1vBs5fond8ahBeGAi8J2xjF9JhyuGSm1Y=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr33107462ybg.633.1658255070163; Tue, 19
 Jul 2022 11:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org> <20220710123512.1714714-12-daniel.lezcano@linexp.org>
In-Reply-To: <20220710123512.1714714-12-daniel.lezcano@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jul 2022 20:24:19 +0200
Message-ID: <CAJZ5v0hJNUm1kyF7XdK1EiLNg6DmihBMbrZZsxgOjvi-xq3=cQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] thermal/of: Store the trips in the thermal zone
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
> As the thermal zone contains the trip point, we can store them
> directly when registering the thermal zone. That will allow another
> step forward to remove the duplicate thermal zone structure we find in
> the thermal_of code.
>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_of.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 19243c57b3f4..e187461dd396 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
>                 tzp->slope = tz->slope;
>                 tzp->offset = tz->offset;
>
> -               zone = thermal_zone_device_register(child->name, tz->ntrips,
> -                                                   mask, tz,
> -                                                   ops, tzp,
> -                                                   tz->passive_delay,
> -                                                   tz->polling_delay);
> +               zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
> +                                                              mask, tz, ops, tzp, tz->passive_delay,
> +                                                              tz->polling_delay);
>                 if (IS_ERR(zone)) {
>                         pr_err("Failed to build %pOFn zone %ld\n", child,
>                                PTR_ERR(zone));
> --

IMO it would be less confusing if this was merged with the patch
introducing thermal_zone_device_register_with_trips().
