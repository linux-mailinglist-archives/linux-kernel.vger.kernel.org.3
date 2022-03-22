Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283DE4E39B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiCVHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiCVHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:34:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F19220FA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:33:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p9so23613595wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeL0XwdZoDHk0HJY6UD4i5wOSw01lP9KaIX9E/wmf14=;
        b=Ghj1Jwr7ot5jaMNP4tgZiZFZL7OwaoIaxLvWPfbUSU3LVjjJMwkPb4phdWEskVIQYa
         1NhjsthU4Uibt9mwHfI3JumhT0MwIwUrgRiuxbwi+zspq5hEShpCEKmyxQHKUKm/ApqS
         KzcCAYNQBh5mnxsooaC4By2KqQg53TdhPFAzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeL0XwdZoDHk0HJY6UD4i5wOSw01lP9KaIX9E/wmf14=;
        b=7+eLNPEOwmGZhv8iPCgGIV0HV3PFN9m01WOd6sFw4EN2CXhCruRx2pDFAZMXMmRUWG
         Yw4a5HfCnLuH1NlUeAg0sfQJxGcLTq+HP5SelwZgioAOSVLmYSxMdc4b/zgkmpXnMWhm
         afOFvdvHSjx4tRAURX7hfkdGeSVA12jpBQJajXvjmViRm6EamTIn8qms8DeGs3jK4/0r
         WLiyONkbT4Dka52VQUoqMqK08LlsxFOgfpX/hvhc/b1NbaYDrdbABmaJcdyQJ8FjiId9
         KMgVuSmPlMfOGfxwf1O6N27PkgomdIdRdMrBHhF9376jPs9c959WC/C50ZyJklZAbNp5
         FBLg==
X-Gm-Message-State: AOAM533eYmWBANHmGgjVlKcaDP6yveq/lu6V/s6aTCHEgLmTw7iV7VxC
        5ets8APvMoe/E1s0VdXuPNk9B8DZumTtlofv+liZGA==
X-Google-Smtp-Source: ABdhPJy9dN6URJJcdfux8bA4y/yRtsPYh8+Hjvg2L2uTjRxceqsjwuE40RumFic8CrYPwgdIMr2McDKJyEOsXADZvJA=
X-Received: by 2002:adf:d1e3:0:b0:204:7e76:8a70 with SMTP id
 g3-20020adfd1e3000000b002047e768a70mr1860283wrd.580.1647934408221; Tue, 22
 Mar 2022 00:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220302120925.4153592-1-xji@analogixsemi.com> <CAEXTbpeUTdfA31gpiJAzvyCScjWLUqCxjpF6-YCFCe5JmiyDZw@mail.gmail.com>
In-Reply-To: <CAEXTbpeUTdfA31gpiJAzvyCScjWLUqCxjpF6-YCFCe5JmiyDZw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 22 Mar 2022 15:33:17 +0800
Message-ID: <CAEXTbpf2V9CD=rs_KkVkD58rhtbiicFNjdphbuS0PU_5P=x0ZA@mail.gmail.com>
Subject: Re: drm/bridge: anx7625: Set downstream sink into normal status
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, treapking@google.com,
        qwen@analogixsemi.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@chromium.org,
        bliang@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Can we use dev_dbg instead of dev_info for the logging?

The log here is more like a debugging message, and using dev_dbg makes
it consistent with anx7625_dp_stop.

Sorry for not catching this earlier.

Best regards,
Pin-yen

On Thu, Mar 3, 2022 at 3:52 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Reviewed-by: Pin-Yen Lin <treapking@chromium.org>
>
>
> On Wed, Mar 2, 2022 at 8:09 PM Xin Ji <xji@analogixsemi.com> wrote:
> >
> > As downstream sink was set into standby mode while bridge disabled,
> > this patch used for setting downstream sink into normal status
> > while enable bridge.
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 9aab879a8851..963eaf73ecab 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -919,12 +919,20 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
> >  {
> >         int ret;
> >         struct device *dev = &ctx->client->dev;
> > +       u8 data;
> >
> >         if (!ctx->display_timing_valid) {
> >                 DRM_DEV_ERROR(dev, "mipi not set display timing yet.\n");
> >                 return;
> >         }
> >
> > +       dev_info(dev, "set downstream sink into normal\n");
> > +       /* Downstream sink enter into normal mode */
> > +       data = 1;
> > +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
> > +       if (ret < 0)
> > +               dev_err(dev, "IO error : set sink into normal mode fail\n");
> > +
> >         /* Disable HDCP */
> >         anx7625_write_and(ctx, ctx->i2c.rx_p1_client, 0xee, 0x9f);
> >
