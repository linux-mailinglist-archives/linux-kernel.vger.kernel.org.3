Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335C57C29C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiGUDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:21:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EAB47BA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:21:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so416973wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp8UseCrak3Uf7ZMCku83+o+h8VdCTPmgbNqPdL/mic=;
        b=CWUDWwoFiqmSGU594z2yMobPBq5pAqEvzEkfu+LhpngVJg8+AB17WOtYFUaOLL3w/O
         WZho1Qu5XCZaEiphXiRPHKtYVElMDWAJP16GepKTPRvoGBYykFbFg6t4aRMmgv2wuIdI
         3cPqRJ9B5aiYxPIjxulAhMdSjndzkcdd0VaCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp8UseCrak3Uf7ZMCku83+o+h8VdCTPmgbNqPdL/mic=;
        b=4V+n9SKJoSpK6FlnAGthsmnSgr8CyErnSIm9wr1/SXdLWelkiJcTIAMC0DRCUbsVEi
         rxV0pqyY02gaFfmBo4GUHIGUpeVQsLzgfQjDncXBhCka7StU6cO/omh2f5GT/lJ2ocYZ
         bpiM+/+i5+vHRB71UExPmaxZe74p1beRfA6hpnfFwZN481oCPvhzBZw14tQG9ZGyU+Eb
         dhSbNcnTAd00jIePy/65zBDKZelGPnYk+x9mXJU6GIOLqiix5ThSU8nKW1tjn+7Vjzz6
         l4tQPBGf6zXm4XYOxSJamj3NpOEoRPReNpfo++5ghlz0CwgIuztpoUtspoj2WlyJZvKg
         lr3g==
X-Gm-Message-State: AJIora/Wdd+gLA9nI2s0v29IIRBTXSxlzCMZTu2weKOmjRIKm3sdrIjT
        j9rOEX7eEaY36ahF7haA6U+JQBM/XqB3at9/4aZc7A==
X-Google-Smtp-Source: AGRyM1vXWKjhZfkFxxLgAqLrdrUS9zjdNtBJmP2AvtzG3M6MPXGe4Kuq83Pcwy/jiil49jxrZHAjerDJBVq2qFdBaGY=
X-Received: by 2002:a5d:4cce:0:b0:21d:755b:d4f8 with SMTP id
 c14-20020a5d4cce000000b0021d755bd4f8mr34773870wrt.190.1658373684373; Wed, 20
 Jul 2022 20:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220713031547.11641-1-allen.chen@ite.com.tw> <CAG3jFyvDWXZsSKaztKgbAUOY8DNFb81KvSpG5fQC=t1dUZp8oA@mail.gmail.com>
In-Reply-To: <CAG3jFyvDWXZsSKaztKgbAUOY8DNFb81KvSpG5fQC=t1dUZp8oA@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 21 Jul 2022 11:21:13 +0800
Message-ID: <CAEXTbpeJweJEzPC-cRXYCGGoLM73-8Px8FY6P9hajk2V9eKbLw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: it6505: Add i2c api power on check
To:     Robert Foss <robert.foss@linaro.org>
Cc:     allen <allen.chen@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-yen Lin <treapking@google.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

The same patch has been reviewed and applied as
86088f88a25c76baac304b6f887e5da2c30c4e07 in "drm/bridge: it6505: Fixes
bugs" series.

We accidentally sent this out as an individual patch and forgot to
revoke this after sending out the complete series.

Sorry about that.

Regards,
Pin-yen

On Tue, Jul 19, 2022 at 11:26 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> On Wed, 13 Jul 2022 at 05:16, allen <allen.chen@ite.com.tw> wrote:
> >
> > From: allen chen <allen.chen@ite.com.tw>
> >
> > Use i2c bus to read/write when it6505 power off will occur i2c error.
> > Add this check will prevent i2c error when it6505 power off.
> >
> > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/ite-it6505.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> > index aa5e0aa1af85..cfd2c3275dc5 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -518,6 +518,9 @@ static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
> >         int err;
> >         struct device *dev = &it6505->client->dev;
> >
> > +       if (!it6505->powered)
> > +               return -ENODEV;
> > +
> >         err = regmap_read(it6505->regmap, reg_addr, &value);
> >         if (err < 0) {
> >                 dev_err(dev, "read failed reg[0x%x] err: %d", reg_addr, err);
> > @@ -533,6 +536,9 @@ static int it6505_write(struct it6505 *it6505, unsigned int reg_addr,
> >         int err;
> >         struct device *dev = &it6505->client->dev;
> >
> > +       if (!it6505->powered)
> > +               return -ENODEV;
> > +
> >         err = regmap_write(it6505->regmap, reg_addr, reg_val);
> >
> >         if (err < 0) {
> > @@ -550,6 +556,9 @@ static int it6505_set_bits(struct it6505 *it6505, unsigned int reg,
> >         int err;
> >         struct device *dev = &it6505->client->dev;
> >
> > +       if (!it6505->powered)
> > +               return -ENODEV;
> > +
> >         err = regmap_update_bits(it6505->regmap, reg, mask, value);
> >         if (err < 0) {
> >                 dev_err(dev, "write reg[0x%x] = 0x%x mask = 0x%x failed err %d",
> > @@ -2553,13 +2562,12 @@ static int it6505_poweron(struct it6505 *it6505)
> >                 usleep_range(10000, 20000);
> >         }
> >
> > +       it6505->powered = true;
> >         it6505_reset_logic(it6505);
> >         it6505_int_mask_enable(it6505);
> >         it6505_init(it6505);
> >         it6505_lane_off(it6505);
> >
> > -       it6505->powered = true;
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.25.1
> >
>
> This patch no longer applies to the drm-misc-next tree, could you
> rebase it and send out a v3?
