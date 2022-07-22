Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A857E4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiGVRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGVRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:00:07 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3B2DD;
        Fri, 22 Jul 2022 10:00:05 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31e7055a61dso53783087b3.11;
        Fri, 22 Jul 2022 10:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iD/RsD0e1/AY5YXptAbQ0YMY7CfmX34mV0YyWFWCnqY=;
        b=m1HhRMi+IPTMR8AN+GCcbZdn0588cFlebn8ZHzuKk6x1XQS5IyGaPNZwDizzkRffiW
         uu04K9lwD6JCxvjRQwDmkMW/PQnN0aDWUjKSHkflb+fYJtwXUo7rjlO3m30PKApE1aFM
         87AkmpuE03kfrwTic4VD0KxdWD6kSp6AclEEZj6GOjwbxaBUlLKC/9UXrfm0WCygo+P1
         4yY2gBh5zPddRN4uyZGQxO0FpEPM9iDxihiYQ/UtztykAa+BUHYHAUp0A91e0Lput2xV
         LQIiS6+WoU72BCj3q9dyEv/fb9zVfpYrkC56RbQi+z4gjg46gD/RWFyHVEUpBZWPDp8I
         7Jcg==
X-Gm-Message-State: AJIora8r9g2JNASlFQXjvP859kkL6VYZDcPzRpBrLEZyq+EVZ5JayabN
        FqTcj6odfp+yp7fMdKTRpVyv6Aj9ETuWfS347EwHpqlb
X-Google-Smtp-Source: AGRyM1vVDTvs9u/fVT6+LQGTnjmfn8/vtK5YhSrI2f4pW7OswwplMRiqcFXJjK9N2b34/RT3MAD2F11GXSBgn9JhYWE=
X-Received: by 2002:a81:1a11:0:b0:31e:4549:d667 with SMTP id
 a17-20020a811a11000000b0031e4549d667mr667631ywa.196.1658509204641; Fri, 22
 Jul 2022 10:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
 <20220710123512.1714714-12-daniel.lezcano@linexp.org> <CAJZ5v0hJNUm1kyF7XdK1EiLNg6DmihBMbrZZsxgOjvi-xq3=cQ@mail.gmail.com>
 <c75d5dca-17d5-6542-b0aa-46ed036567c7@linexp.org>
In-Reply-To: <c75d5dca-17d5-6542-b0aa-46ed036567c7@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jul 2022 18:59:51 +0200
Message-ID: <CAJZ5v0gOeoz7ifDWwKW0D2h8WUJmLeDCF2bD8hu5Sm--BOPLVA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] thermal/of: Store the trips in the thermal zone
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Thu, Jul 21, 2022 at 11:31 PM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:
>
> On 19/07/2022 20:24, Rafael J. Wysocki wrote:
> > On Sun, Jul 10, 2022 at 2:35 PM Daniel Lezcano
> > <daniel.lezcano@linexp.org> wrote:
> >> As the thermal zone contains the trip point, we can store them
> >> directly when registering the thermal zone. That will allow another
> >> step forward to remove the duplicate thermal zone structure we find in
> >> the thermal_of code.
> >>
> >> Cc: Alexandre Bailon <abailon@baylibre.com>
> >> Cc: Kevin Hilman <khilman@baylibre.com>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> >> ---
> >>   drivers/thermal/thermal_of.c | 8 +++-----
> >>   1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> >> index 19243c57b3f4..e187461dd396 100644
> >> --- a/drivers/thermal/thermal_of.c
> >> +++ b/drivers/thermal/thermal_of.c
> >> @@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
> >>                  tzp->slope = tz->slope;
> >>                  tzp->offset = tz->offset;
> >>
> >> -               zone = thermal_zone_device_register(child->name, tz->ntrips,
> >> -                                                   mask, tz,
> >> -                                                   ops, tzp,
> >> -                                                   tz->passive_delay,
> >> -                                                   tz->polling_delay);
> >> +               zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
> >> +                                                              mask, tz, ops, tzp, tz->passive_delay,
> >> +                                                              tz->polling_delay);
> >>                  if (IS_ERR(zone)) {
> >>                          pr_err("Failed to build %pOFn zone %ld\n", child,
> >>                                 PTR_ERR(zone));
> >> --
> > IMO it would be less confusing if this was merged with the patch
> > introducing thermal_zone_device_register_with_trips().
>
> You suggest to merge 8,9 and 10, right ?

Yes, if that makes sense.

Generally speaking, I prefer the changes in every patch to be
self-contained, unless the patch would be too large this way or it
would cross boundaries of many subsystems.
