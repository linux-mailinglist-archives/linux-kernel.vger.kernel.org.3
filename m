Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB43595BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiHPMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiHPMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:41:07 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCFBA1A7E;
        Tue, 16 Aug 2022 05:41:03 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31f445bd486so146940557b3.13;
        Tue, 16 Aug 2022 05:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tOBTZ+IbxItFSekwqOrDODveS1vmfywusyws8j6ne/c=;
        b=LXt94MrRm2sKTkwEnJrLUb5OmeJLW6OqgyXY6bMzNMYv15Ub412x6FRLZBsQ3acpYB
         +cBLuHXoX7T2hbj1fL4FMdwtwALV2qD49BP6tlzFtZ6Sle8TjTXDAb6pAZkQq07rHeVq
         XtkH+ziLiOCgogMNc2ZkQOW+VEG4uqioU+CVQMM/Z0eX2UeQhBERfTMVIb5TH3jSnyp1
         rkDQkch1nWrfHpMiVLQOxUzUUGOmyuRujZxqe7QhZH/igWJNP2Gd9obZyKUyXnUdCwRE
         24CVhgKiNmA6kau/klKAv5Zr5cdtZHwS8PPI6ys06a8rPHKuRRl6+k5M1Xp+MCOPxeXx
         o77A==
X-Gm-Message-State: ACgBeo3SlCzfczex5SxNNMsnzy8QSChdNdOknu/+m39Fmye1ztyJ1mmk
        I5++nhM9fRahFA9x2Hy439lJKRqxkrXLbROk6jo=
X-Google-Smtp-Source: AA6agR64P7P8DycfUUvrvigW47P7hj8lnXG0b8HaH2VlqHrRhqlopmb6QgJqysFlTE+f4isOBqPM6tMqx2M/zMU+mN0=
X-Received: by 2002:a25:e90d:0:b0:67e:e3c:1459 with SMTP id
 n13-20020a25e90d000000b0067e0e3c1459mr14390191ybd.622.1660653662803; Tue, 16
 Aug 2022 05:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
 <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org> <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
 <2ab74b1a-7087-cbfc-3f05-92e0eef30ca9@linaro.org>
In-Reply-To: <2ab74b1a-7087-cbfc-3f05-92e0eef30ca9@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Aug 2022 14:40:51 +0200
Message-ID: <CAJZ5v0jKpT0R2btHCtoyqrnF6-pvVx2q8zmYcR2mT6qtsbkJVg@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] New thermal OF code
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        damien.lemoal@opensource.wdc.com, Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        mhiramat@kernel.org, Talel Shenhar <talel@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, anarsoul@gmail.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        glaroque@baylibre.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Keerthy <j-keerthy@ti.com>
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

On Mon, Aug 15, 2022 at 9:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 28/07/2022 16:37, Rafael J. Wysocki wrote:
> > Hi Daniel,
> >
> > On Wed, Jul 27, 2022 at 11:46 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >> we are close to release v5.19.
> >>
> >> I want to send a PR this week but it would be nice if this series could
> >> be part of it, so the trip point rework we discussed earlier (it is a
> >> long series) could be merged more easily for v5.21-rc1 as it will depend
> >> on these changes.
> >>
> >> This series was tested on different platforms, rk3399, broadcom and
> >> rcar. The external drivers as ata, touchscreen, regulator, hwmon were
> >> acked/reviewed and some other thermal drivers reviewed also. Some others
> >> remain without feedback because the maintainer is unresponsive or the
> >> driver is orphaned, falling under the thermal framework maintenance
> >> umbrella. All the drivers changes are the same.
> >>
> >> I do believe it does a nice cleanup and consolidation of the OF thermal
> >> code and realign it with the core thermal framework.
> >>
> >> Is it ok to merge the series?
> >
> > I would prefer to put it into linux-next for a few days.
> >
> > Why don't you send 2 pull requests, one with all of the other material
> > you have for 5.20 and another one with this series (it may be on top
> > of the first one)?
> >
> > I will be able to defer pushing the second one till the second half of
> > the merge window.
>
> I setup a branch with the patches and the fixes.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/v6.0-rc1-2
>
> Is there still time for a PR ?

Not for 6.0-rc.

I'm out of office this week, but I'll gladly merge an early PR for 6.1
next week.

Cheers!
