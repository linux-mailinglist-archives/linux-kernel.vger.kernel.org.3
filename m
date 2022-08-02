Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27037587D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiHBNwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiHBNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:52:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B225E8E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:52:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so12074143ejp.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tygEmQo2fM88im/5bVVcHB1T0VfpleA6ie9m/bYh6CA=;
        b=BwabfrmKwaXUPfLOc0/xFNk7TwdvzAmRAZLjnCecg3eGFOpbuCPTb99uRYNiJDeN/i
         pWY80JnwJ/rhXVCW1KReEMwjUNtqWIEN9Skv0RcjmNAkhQUv1pH3tg9Z4WL54qq1eB6H
         gbCFQL74Ea3UBH0CKyJMbJJmJs/r54zc8GTD8nC4hzrZ5ADvoNAdBXlGrJzoDpI9UhVQ
         C3Iov+WX1d+RKaI/roFmqXWXvNjkgfthmIcIcIKHqToPg6YiUJJdNJv+n2NUHXGuuI1M
         ts4Ij8QC7vwjyBRPO74AZyAzmqZKZLRacvL2b1oT0hhfEzSF/Ug825EEQJYcwFa8emQl
         2Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tygEmQo2fM88im/5bVVcHB1T0VfpleA6ie9m/bYh6CA=;
        b=TTA/uB3IT5XBzItBgR9JEYCie6+8VnI2DWiwCdyUJQ/9bS3HGdCPGfkQstFttD3m+v
         v+ymGE6C2pCVSAMr8cwnvtqKU72UC9aaHMYNyEyoanZYgXBlSsaBASjSwT9jUwset6+F
         OzhM+nji6C+rXaiGt+GAzlIOwlxhfFqkjq+eHOvpAPzciKeztzcU2lGWBDCJLlD15jAX
         g/JtnCy4ZlHp/QwpKp/q09JdTR9w/2edc07rsXaA+G/Z2MKONfQTVaDiLbWuuBXbUm85
         yQa3Uh6nlih4QaYC3fHmnIMGTxYXrB0AXLevWNf1Y7EZswLUjbQTkyPq0eSogs7bSPa3
         xbNQ==
X-Gm-Message-State: AJIora9p6I6EYMM4aVUTTvBx8ths+4J3X+GLEaDLtIEBihJvBxMXk3/k
        TGOJZ9zq9OHFYuJRJIdS8+A1Ip72Obnt65D9Qck=
X-Google-Smtp-Source: AGRyM1shdJmsktY8zrcXEWcL4rBfP+9PL5Kqswpu3FBaUufmuBcYlYGatVQ8fWVuu6PBCAyYLpwcd/aMQkLJe1qA6Bs=
X-Received: by 2002:a17:907:6e12:b0:72e:6774:cb80 with SMTP id
 sd18-20020a1709076e1200b0072e6774cb80mr15871363ejc.504.1659448328964; Tue, 02
 Aug 2022 06:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
 <20220801225538.qtdb5zd66g6ipewz@pengutronix.de> <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
 <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com>
 <CAOMZO5BQWnUj4Ouq3=vhqq55zN8otO_9vPX8ht+muFM_5pg9Fg@mail.gmail.com>
 <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
 <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de> <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
In-Reply-To: <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 2 Aug 2022 08:51:57 -0500
Message-ID: <CAHCN7xLpCbOY+Ma6gKJievw6aUZ5-Qs4S=zxjTgRu=Be7zvhoQ@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 7:13 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Aug 2, 2022 at 3:08 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Adam, Fabio,
> >
> > On 22-08-01, Adam Ford wrote:
> > > On Mon, Aug 1, 2022 at 8:53 PM Fabio Estevam <festevam@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 1, 2022 at 10:39 PM Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > > I managed to get my HDMI output working. I had the lanes set to 2
> > > > > instead of 4.  Once I switched to 4-lanes, the monitor came up in
> > > > > 1080p.  I haven't yet been able to get other modes to work.
> > > >
> > > > Ok, good. On another thread, you mentioned that you were also trying
> > > > to get LVDS to work via SN65DSI83.
> > > >
> > > > Does LVDS work for you on this branch?
> > >
> > > I haven't tried with Marek's latest suggestion.  In the other thread
> > > he mentioned a burst mode and setting the DSI speeds to higher
> > > frequencies, but the patch he had didn't look like it would apply
> > > cleanly, so I will need to dig into that a bit further.
> >
> > Can you provide me a link to this thread?
>
> Sure,
>
> https://www.spinics.net/lists/dri-devel/msg358301.html
>
> >
> > > Since my company doesn't really ship the LVDS displays with the kits,
> > > the HDMI is the default video, so I've been focusing on it.
> > >
> > > To answer Marco's question, I was able to revert "MLK-21958-13:
> > > drm/bridge: adv7511: Limit supported clocks" and still get a display
> > > at 1080p, but all the other resolutions I tried appear to come up
> > > blank.
> >
> > Cool so now you have the same state as we are.
>
> I have a couple patches applied to mine which mimic some of the stuff
> that NXP did.  Since I have access to a programmer manual, i was able
> to confirm some of the 7535 specific stuff and the low-refresh rate
> changes in their kernel appear appropriate and I also created a second
> table of default settings for the 7535 and if the type is set
> properly, i'll use the newer table instead of the older one. If anyone
> wants any of these patches, I can certainly share them, but I am not
> certain they make any difference.
>
> There are a few other items in the programmer manual that I want to
> attempt to implement once I have a chance to further review the
> document.
>
> >
> > I think that the most important one is the blanking calc. Can you try to
> > revert "drm/bridge: adv7511: Repair bus_flags and bus_format" and check
> > if you can get a output still? Also something to try would be to disable
> > the internal timing generator by specifying
> > 'adi,disable-timing-generator'. Also if you have an oscilloscope for

I did some reading about the internal timing generator.  It appears
that it's required when video formats use fractional bytes, and it's
preconfigured to run at 720p by default, but registers 28h through 37h
configure it for other video modes.

Are you thinking the imx8mm DSI generator would do it better?

> > such frequencies you can check the hdmi clk-lane. I noticed that this is
> > sometimes wrong.
>
> I am doing this from my home office as a side project, so I don't have
> a scope, but I can try to revert the other patch and try to disable
> the internal timing generator when I get home tonight.  I'll report my
> findings.
>
> >
> > Regards,
> >   Marco
> >
> > > I didn't try every one.  With that revert, more options come
> > > available, but 1440x900 and 800x600 were options I tried
> > > unsuccessfullyl.
> >
> > >
> > > adam
> > >
