Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D0568845
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiGFM04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jul 2022 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiGFM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:26:55 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766223141;
        Wed,  6 Jul 2022 05:26:54 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id e69so20452891ybh.2;
        Wed, 06 Jul 2022 05:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gpk0Gh0a+AtnRVgdtA4MUVRtIe6naoBICzq73QDej2Y=;
        b=qfOtqNnIRC9LBsBjWVd+mVuSYQ+7+66az3Nk/6mzHxqA1tMch9LUtiT4gOhpg2MT5/
         fMl2edI7qz3wc+XzS2Crf3VOBDT0wTGDwsWF1vZ8HtBnyO4BCG6WRsyumThe82PaMHxZ
         WA5JI4VIlb69pDNozD2x7COZxyyf7GW9XLwmJwTITfGw4dyC2ih9ArJMv5GbXl8ftiOC
         egNdsaw/c57BtUbdHA6GA2VvqKH5Mc8fjCtVT6xDWYc0wFtArrYQwGP+okIkOSes9oBd
         UwM0FpxSuoSYdx46ryVNY1JbL44m8R2o7DdUaHvsHsRRr2Ljjl/AMFNvdGfI+HP8u1AU
         bdyA==
X-Gm-Message-State: AJIora+AE7HGTq2JsZBbyR9O/hvSAk3rCcZowXmc+N1G1PSN3hlg2Les
        oi5BWkaLe12sSDMDP+KsARTaPRktOmVuGb5BWS82axQf
X-Google-Smtp-Source: AGRyM1tKDYbnkqKUPoh71iZOMDwFVwrB8898cCK95PJhcy623Xcogk41U3bLgfT9DGSd625UZs38bVOravIr+SKYhag=
X-Received: by 2002:a25:ab81:0:b0:66e:3dc5:898c with SMTP id
 v1-20020a25ab81000000b0066e3dc5898cmr19162785ybi.81.1657110413378; Wed, 06
 Jul 2022 05:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220629151012.3115773-1-daniel.lezcano@linaro.org> <92c86903-354f-0114-a796-64571667a923@linaro.org>
In-Reply-To: <92c86903-354f-0114-a796-64571667a923@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 14:26:42 +0200
Message-ID: <CAJZ5v0jPdo5=YWS_ZjLDojtXkpxqejzircN+fGG9y1pnCyH_qg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/core: Use clamp() helper in the stepwise governor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 2:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/06/2022 17:10, Daniel Lezcano wrote:
> > The code is actually clampling the next cooling device state using the
> > lowest and highest states of the thermal instance.
> >
> > That code can be replaced by the clamp() macro which does exactly the
> > same. It results in a simpler routine to read.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
>
> I'll apply this series if nobody has comments

Sounds good to me.

Please feel free to add ACKs from me to the patches.

>
> >   drivers/thermal/gov_step_wise.c | 15 ++++-----------
> >   1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
> > index 12acb12aac50..6efbfaf014da 100644
> > --- a/drivers/thermal/gov_step_wise.c
> > +++ b/drivers/thermal/gov_step_wise.c
> > @@ -11,6 +11,7 @@
> >    */
> >
> >   #include <linux/thermal.h>
> > +#include <linux/minmax.h>
> >   #include <trace/events/thermal.h>
> >
> >   #include "thermal_core.h"
> > @@ -52,10 +53,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >
> >       if (!instance->initialized) {
> >               if (throttle) {
> > -                     next_target = (cur_state + 1) >= instance->upper ?
> > -                                     instance->upper :
> > -                                     ((cur_state + 1) < instance->lower ?
> > -                                     instance->lower : (cur_state + 1));
> > +                     next_target = clamp((cur_state + 1), instance->lower, instance->upper);
> >               } else {
> >                       next_target = THERMAL_NO_TARGET;
> >               }
> > @@ -66,10 +64,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >       switch (trend) {
> >       case THERMAL_TREND_RAISING:
> >               if (throttle) {
> > -                     next_target = cur_state < instance->upper ?
> > -                                 (cur_state + 1) : instance->upper;
> > -                     if (next_target < instance->lower)
> > -                             next_target = instance->lower;
> > +                     next_target = clamp((cur_state + 1), instance->lower, instance->upper);
> >               }
> >               break;
> >       case THERMAL_TREND_RAISE_FULL:
> > @@ -82,9 +77,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >                               next_target = THERMAL_NO_TARGET;
> >               } else {
> >                       if (!throttle) {
> > -                             next_target = cur_state - 1;
> > -                             if (next_target > instance->upper)
> > -                                     next_target = instance->upper;
> > +                             next_target = clamp((cur_state - 1), instance->lower, instance->upper);
> >                       }
> >               }
> >               break;
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
