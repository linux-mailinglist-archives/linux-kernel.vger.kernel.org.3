Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8552A792
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349824AbiEQQCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiEQQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:02:37 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E92F39A;
        Tue, 17 May 2022 09:02:36 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ff39b44b06so6504697b3.13;
        Tue, 17 May 2022 09:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kW+aTBI3GUuS4AtTEj2lYQ2dwz3Tt3kiKnZkdF26p9k=;
        b=1ges2W1h2Dbpl4Rzs9liIF3uMrwClnfvVh7Oab9d7CwTlTqUt/jRr0otxJElsSDIFq
         3I2nayz2cnDCB0o7p2E9bzHs6Qw+R2UH0CNAsHe/PNxQsD9x9cB+xOkkE4MJlp6i+tpl
         7+O2TLTM3En7JxgI3tW2GdhkpbXxieq8Dl7TUq+41LLFMkKJwhR1tNUwIdaAqyPv5M7G
         bSrfUNgWXKt5HpFHUAVBWXEDCU+yRQf6FPxMFkCOYcfWoZvGbYk2qA7aOjqXBjY38P5h
         NIWTP8zA4hgROcD2jVy9lvdNo7ax65RYa6/CpAoGHAH9wCrHVfR6ZWMukGI3UpXdjKzK
         gRSg==
X-Gm-Message-State: AOAM533YDa0UpBq3xpWJxi674OMiNajm5ChgKtThQX//u2ZI8kqsCp+Q
        cLc4LFuKj4/ywrsqRhU2aJz02UuwCY8UbmHuZAM=
X-Google-Smtp-Source: ABdhPJwzZGGSK5X2wGO9/Ae7NeKwMSMDwZ6QfwBdVrQtWVBBDAKzSVJ+LYrMrO9BGHzxb1ks9WLG5IeBzA7UKsAw0tk=
X-Received: by 2002:a81:91d4:0:b0:2fe:e300:3581 with SMTP id
 i203-20020a8191d4000000b002fee3003581mr14970551ywg.7.1652803355679; Tue, 17
 May 2022 09:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 18:02:24 +0200
Message-ID: <CAJZ5v0hMVDePyu53hLyoxOZuScuUD_oQGE+NrnnhHqQwi-8o3g@mail.gmail.com>
Subject: Re: [PATCH 00/15] thermal OF rework
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Wed, Apr 27, 2022 at 12:15 AM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:
>
> The thermal framework initialization with the device tree appears to
> be complicated and hard to make it to evolve.
>
> It contains duplication of almost the same thermal generic structures
> and has an assymetric initialization making hard any kind of serious
> changes for more complex features. One of them is the multiple sensors
> support per thermal zone.
>
> In order to set the scene for the aforementioned feature with generic
> code, we need to cleanup and rework the device tree initialization.
>
> However this rework is not obvious because of the multiple components
> entering in the composition of a thermal zone and being initialized at
> different moments. For instance, a cooling device can be initialized
> before a sensor, so the thermal zones must exist before the cooling
> device as well as the sensor. This asynchonous initialization forces
> the thermal zone to be created with fake ops because they are
> mandotory and build a list of cooling devices which is used to lookup
> afterwards when the cooling device driver is registering itself.
>
> Actually, the correct behavior IMHO, would be having a sensor
> registration resulting in the thermal zone creation. If the cooling
> device is registered before, it won't find the thermal zone and should
> return -EPROBE_DEFER.
>
> As there could be a large number of changes, this first series provide
> some steps forward for a simpler device tree initialization.
>
> The first patch could appear scary as it touches a big number of files
> but it is actually just renaming a structure name
>
> Daniel Lezcano (15):
>   thermal/core: Rename thermal_zone_device to thermal_zone
>   thermal/core: Change thermal_zone_ops to thermal_sensor_ops
>   thermal/core: Add a thermal sensor structure in the thermal zone
>   thermal/core: Remove duplicate information when an error occurs
>   thermal/of: Replace device node match with device node search
>   thermal/of: Remove the device node pointer for thermal_trip
>   thermal/of: Move thermal_trip structure to thermal.h
>   thermal/core: Remove unneeded EXPORT_SYMBOLS
>   thermal/core: Move thermal_set_delay_jiffies to static
>   thermal/core: Rename trips to ntrips
>   thermal/core: Add thermal_trip in thermal_zone
>   thermal/core: Register with the trip points
>   thermal/of: Store the trips in the thermal zone
>   thermal/of: Use thermal trips stored in the thermal zone
>   thermal/of: Initialize trip points separately

Generally, the series looks reasonable to me, but I'm not convinced
about the first patch.

It looks like a decision needs to be made regarding how exactly a
"thermal zone" is going to be defined now and how it is going to be
related to thermal sensors.

My basic question is this: If trip points are associated with thermal
sensors, then what a thermal zone really is and what is it useful for?
