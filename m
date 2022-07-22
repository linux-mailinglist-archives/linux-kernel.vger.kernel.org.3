Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD157E4CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiGVQui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiGVQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:50:32 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9263F8;
        Fri, 22 Jul 2022 09:50:31 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31e560aa854so53694567b3.6;
        Fri, 22 Jul 2022 09:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ExEbscQZTCAMoS6RueRD8hllPVfb47k9WrjDpmmW1xE=;
        b=cf3u6js1nrdm6Tv0GO02N4l3gzKOfRz5U+gcynsLwm/MblgAxYnYdWe+pbV2ll6/A1
         4KAvTJzkvTewHX9m/UyDqRI/La2qJX7vaL40D45NUWKSTENRkIpLCN6NmRpINS/X1Yzg
         9gl6gkfBRCJHi3i5uDgBeF5JalN/0K2uRSbtRH7GLgjBRvdfN/9WWYF7SmswfrIQ7+IB
         j5/N+0pK6yqso5DTJDF4Vir2GNxeH+zaSXt/cmJE6kdUkhes/CDQ8o1MXFvQ1Zxkc7IU
         7h6KwROYqqNVpg/sopO+tAzEG3AO38t+Wyd820fqOuWp1ehhKFLPiJAyeEoEjgPaRaDi
         fezg==
X-Gm-Message-State: AJIora9PCFpmsrP6oQB9F9PlBaqXMC7SWS9qlSPSw6IfoNzEuWkjiotw
        gaH4aUHktQDfLWyoq60OQr8BdXrCcz1Lw00yJ5w=
X-Google-Smtp-Source: AGRyM1u9d2vgqbxFxy1xBm+vdO9nqxuLVB41o+iHG8g351Kh3BE0yMR3mRLBQqP/z6VOzD3egQQum0lw7jwB3Nls6bA=
X-Received: by 2002:a81:78c6:0:b0:31e:848b:6e2 with SMTP id
 t189-20020a8178c6000000b0031e848b06e2mr596773ywc.301.1658508630476; Fri, 22
 Jul 2022 09:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
 <20220710123512.1714714-13-daniel.lezcano@linexp.org> <CAJZ5v0hTQBXbKNurR0p8_MWmcW-EtezUg1oSNLVEYEAdzpeyBA@mail.gmail.com>
 <5e9f6d35-08ff-4949-67b0-a2feaab79814@linexp.org>
In-Reply-To: <5e9f6d35-08ff-4949-67b0-a2feaab79814@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jul 2022 18:50:17 +0200
Message-ID: <CAJZ5v0hA-JzYbdfoNfXhdNoeL1VLWk3umS=wxEmER=PtMUw17w@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
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

On Thu, Jul 21, 2022 at 11:29 PM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:
>
> On 19/07/2022 20:26, Rafael J. Wysocki wrote:
> > On Sun, Jul 10, 2022 at 2:35 PM Daniel Lezcano
> > <daniel.lezcano@linexp.org> wrote:
> >> Now that we have the thermal trip stored in the thermal zone in a
> >> generic way, we can rely on them and remove one indirection we found
> >> in the thermal_of code and do one more step forward the removal of the
> >> duplicated structures.
> >>
> >> Cc: Alexandre Bailon <abailon@baylibre.com>
> >> Cc: Kevin Hilman <khilman@baylibre.com>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> >> ---
> >>   drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
> >>   1 file changed, 16 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> >> index e187461dd396..601552c55d0b 100644
> >> --- a/drivers/thermal/thermal_of.c
> >> +++ b/drivers/thermal/thermal_of.c
> >> @@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
> >>    */
> >>   int of_thermal_get_ntrips(struct thermal_zone_device *tz)
> >>   {
> >> -       struct __thermal_zone *data = tz->devdata;
> >> -
> >> -       if (!data || IS_ERR(data))
> >> -               return -ENODEV;
> >> -
> >> -       return data->ntrips;
> >> +       return tz->ntrips;
> > Hasn't this been renamed to num_trips?
>
> Right, it is changed in patch 12/12

Well, what about combining them, then?
