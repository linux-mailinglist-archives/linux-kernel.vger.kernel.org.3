Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC558CA0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbiHHOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiHHOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:01:34 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D1B7E9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:01:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso6536768otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1bWg+m+jw/+r4wYqHClm6tUZpgW51N7+kmJOJCqAdPk=;
        b=nUys/aMEq2iDDeeUARose1WXtTg0aZC8yli8fl/IPHCyRTYTT9H/H+NpgHE+cFIGtO
         dxmDoUEUf8MOfJNHY1R9Koi/mKrbTasMBA8TdV6YsZeWJNJ7d8GA/ti85c9IvJWMCm0o
         CbcMpliONd/ox5bM2Zc5IIPc06u1dDPyRywVd2s2CmvusPOtf0ZyfpX8GT5Bfs8Qtzwf
         akngiCHcpoyk4ZuIkxbkpyNYuTvWxoYeEuO+RFAblBRfdYs6jmwjJj63hMRXNJd9HARx
         UhEvd1QRQ7DP1q8ya2cM4lTJ4qFOIdc1XdtBUCb4tQekQJtLIHTtP5uhFeRAjMwR9Wfn
         gcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1bWg+m+jw/+r4wYqHClm6tUZpgW51N7+kmJOJCqAdPk=;
        b=ya24/c7V/4Vn0fsJte9iSfXLdV9Jrq/6yPA7B9ks73M4k8SvZ0rxXbesOF7hasvdCH
         Q8Cc55WA3CzzciFy8Kscs3B/4ezmMBLPu0QLv4PeahGWB3nydotIoZy/v5X1Hi7pdXIa
         mIK2AZzYh8PeKslejdi83leF4n9ERvS4URquVYxskIMIk4AGsPuryIesSnJvaKuOVRO8
         N9Wid/geDeVpKnJEYV30ZJb3g1PvsilLqrO4kyfrBl3L/MW3kaRE7n7T4I+7yynhxJvV
         2n9nS7cS5KO7rgSw9uKwI0ZT9SQ54fonjGT0k1BN/fktjZ+rWcL0LboqjC2tOA8sGoNz
         eCzQ==
X-Gm-Message-State: ACgBeo3LWXwIq3CpodYl9jCeaygrDDijGPyaXyb0Vp4FmRf0u1O/nKTm
        s51jizhRu+XLsMCdOGhyLKyOdNFrqcPQHwmCnE8=
X-Google-Smtp-Source: AA6agR4YELjv9BJeb9147J2EhGtR592a4GYhYv21z9/6z/4k3regMk7xov3kZANLG+pXW9ULPbF1KBNB3UF8nAcFG+8=
X-Received: by 2002:a9d:6b13:0:b0:637:749:a0b7 with SMTP id
 g19-20020a9d6b13000000b006370749a0b7mr132505otp.163.1659967293195; Mon, 08
 Aug 2022 07:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628181838.2031-1-max.oss.09@gmail.com> <20220628181838.2031-5-max.oss.09@gmail.com>
 <a010d333-70b1-bc58-ddf8-d3fa911a6852@ti.com>
In-Reply-To: <a010d333-70b1-bc58-ddf8-d3fa911a6852@ti.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Mon, 8 Aug 2022 16:01:21 +0200
Message-ID: <CAEHkU3Wtw_5DTXiCTKN7eAqKXyLeDVqvzdvLCWi8fUwLQKtEPg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/panel: simple: add bus-format support for panel-dpi
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     max.krummenacher@toradex.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aradhya

Thanks for the review.

Rob's comment requires changes to panel-common.yaml in order for this to get in.
I think I know what needs to be done.

However, as there is no agreement on bus-format in the first place there is no
point in sorting that out now.

Regards
Max

On Wed, Aug 3, 2022 at 8:45 AM Aradhya Bhatia <a-bhatia1@ti.com> wrote:
>
>
>
> On 28-Jun-22 23:48, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > Evaluate the device tree bus-format property to set bus_format for
> > a 'panel-dpi' panel. Additionally infer the bpc value from the
> > given bus-format.
> >
> > Valid values for bus-format are found in:
> > <include/dt-bindings/display/dt-media-bus-format.h>
> >
> > This completes the addition of panel-dpi to completely specify
> > a panel-simple panel from the device tree.
> >
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > ---
> >
> > Changes in v3:
> > - Moved the bus-format property under the port/endpoint node as
> >    suggested by Rob Herring
> >
> > Changes in v2:
> > - Fix errors found by dt_binding_check
> >
> >   drivers/gpu/drm/panel/panel-simple.c | 49 ++++++++++++++++++++++++++++
> >   1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 4a2e580a2f7b..f1a457f1069e 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -21,9 +21,11 @@
> >    * DEALINGS IN THE SOFTWARE.
> >    */
> >
> > +#include <dt-bindings/display/dt-media-bus-format.h>
> >   #include <linux/delay.h>
> >   #include <linux/gpio/consumer.h>
> >   #include <linux/module.h>
> > +#include <linux/of_graph.h>
> >   #include <linux/of_platform.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> > @@ -449,10 +451,12 @@ static int panel_dpi_probe(struct device *dev,
> >                          struct panel_simple *panel)
> >   {
> >       struct display_timing *timing;
> > +     struct device_node *endpoint;
> >       const struct device_node *np;
> >       struct panel_desc *desc;
> >       unsigned int bus_flags;
> >       struct videomode vm;
> > +     u32 bus_format;
> >       int ret;
> >
> >       np = dev->of_node;
> > @@ -477,6 +481,51 @@ static int panel_dpi_probe(struct device *dev,
> >       of_property_read_u32(np, "width-mm", &desc->size.width);
> >       of_property_read_u32(np, "height-mm", &desc->size.height);
> >
> > +     endpoint = of_graph_get_endpoint_by_regs(np, -1, -1);
> > +     if (endpoint &&
> > +         !of_property_read_u32(endpoint, "bus-format", &bus_format)) {
> > +             /* infer bpc from bus-format */
> > +             switch (bus_format) {
> > +             case DT_MEDIA_BUS_FMT_RGB565_1X16:
> > +                     desc->bus_format = MEDIA_BUS_FMT_RGB565_1X16;
> > +                     desc->bpc = 6;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_RGB666_1X18:
> > +                     desc->bus_format = MEDIA_BUS_FMT_RGB666_1X18;
> > +                     desc->bpc = 6;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> > +                     desc->bus_format = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
> > +                     desc->bpc = 6;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_BGR888_1X24:
> > +                     desc->bus_format = MEDIA_BUS_FMT_BGR888_1X24;
> > +                     desc->bpc = 8;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_GBR888_1X24:
> > +                     desc->bus_format = MEDIA_BUS_FMT_GBR888_1X24;
> > +                     desc->bpc = 8;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_RBG888_1X24:
> > +                     desc->bus_format = MEDIA_BUS_FMT_RBG888_1X24;
> > +                     desc->bpc = 8;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_RGB888_1X24:
> > +                     desc->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> > +                     desc->bpc = 8;
> > +                     break;
> > +             case DT_MEDIA_BUS_FMT_RGB888_1X32_PADHI:
> > +                     desc->bus_format = MEDIA_BUS_FMT_RGB888_1X32_PADHI;
> > +                     desc->bpc = 8;
> > +                     break;
> > +             default:
> > +                     dev_err(dev, "%pOF: unknown bus-format property\n", np);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     of_node_put(endpoint);
> > +
> >       /* Extract bus_flags from display_timing */
> >       bus_flags = 0;
> >       vm.flags = timing->flags;
>
> I understand that it is important to add a bus-format property for dumb
> dpi-panels, and I agree with the implementation in the patch-set.
>
> However,
> I do not yet fully understand Rob's comments on the dt-bindings side of
> patch set (patch 1/4) and what consequences it may cause if that remains
> unresolved.
>
> Given that the bus-format property gets added, I do not see any concern
> with the panel-simple driver patch.
>
>
> Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
>
>
> Regards
> Aradhya
