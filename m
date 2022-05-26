Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E98534ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiEZMIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiEZMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:08:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFCE6FA35
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:08:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d129so1166174pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjOWEbyt4Ro1fIWUT8SNiX3DuKLQiF+WmKI78RmvKKE=;
        b=UNWyzFK8Vc7v4ZA885SMSw+7EH0q15ojR+He2o6c5PxLMYP+x3PbY6JBy0VcaVPJHF
         WKli4RyrW7xEnyMdLL5JZVRVgDjeyANAJLHBVixC0H78FxnnFzuDhUA2fIbMVq2aEKJe
         4FnNrYfrIl3fyYA11iur6l32ecwOD4e6R5CKEvb5T7r6LG5lcKY7jUUc2EXRMCFiFwdt
         tiEcZIta2HU51d61YIlZFjFQOWX3nbhrWItKA03jAlHeHgT1yQ/5USPtUIeL1ceHDujt
         H9oEJOPJcAy07G/eGTiZW6KRA2dr9h1HWYZNmfi2jOhXSq8aHYmQ/R46Sgsj7+XTevbv
         HCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjOWEbyt4Ro1fIWUT8SNiX3DuKLQiF+WmKI78RmvKKE=;
        b=Cyy/w0rHanZHlrcGKNDzJ5Jfg4g5/Wk4tNeQ5NnDpCHbnnOEarzZnpBU+G+NPvNVRd
         /+1qVgJls2Z4nJWL505ntsy6aj94ZLHfXob2sNqFCS2yWQZarCB7O3i7vH/7Vzfi61MW
         nMg6NTMKf+z+ErNGu68yIDRjY7D2GnrUSFIbvqImjEa4c31ugKkI+TOfmttda2GwUzJA
         mlWAl7X3JfYvN5hxVC9XmG99LB1UBgBUNPm053fgxw2+7vupTs1HQS3x+l7Kt58M4Rqr
         6BXsFrDq1DJ3NVWCwbVCmAUhferc749tDji17n62T6CIEbtfbrwCix1UJ8ViJsguYcOU
         rxpA==
X-Gm-Message-State: AOAM532FsjHUs5lQTqdz4LJzhM4yzJGHhuwd3/oTQKNKfjJrqBsHBfdN
        xAjryIEsjQMeGd1cNl/3rzRTVmYkHuWppJ90VKX6Qw==
X-Google-Smtp-Source: ABdhPJwLSJF2+bp+VvmR3MEKtg4PATwjIP6ZcUm+9oZ3uYMHbgr9rT4ptK8D8m31usIIvnqN9A9UgB0SwMZLl1VLhnQ=
X-Received: by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id
 j10-20020a056a00174a00b0050d44ca004bmr38665734pfc.0.1653566924909; Thu, 26
 May 2022 05:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220523130144.444225-1-net147@gmail.com> <868d010c-9fca-3fac-7657-faaa2f271c14@denx.de>
 <CANwerB30qwH4pe1wMqAvRgi6gAntZX=AqAh67dEvg4+D1jcnfQ@mail.gmail.com> <4c740b30-9ba0-c5a9-13b6-7f6c3b417595@denx.de>
In-Reply-To: <4c740b30-9ba0-c5a9-13b6-7f6c3b417595@denx.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 26 May 2022 14:08:34 +0200
Message-ID: <CAG3jFysO9Pqagnrrzs=+8_MFh-+zv5Pj3H=zPzVVN-R4+t6cHQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: icn6211: Adjust clock phase using SYS_CTRL_1
To:     Marek Vasut <marex@denx.de>
Cc:     Jonathan Liu <net147@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 15:25, Marek Vasut <marex@denx.de> wrote:
>
> On 5/23/22 15:20, Jonathan Liu wrote:
> > Hi Marek,
> >
> > On Mon, 23 May 2022 at 23:15, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 5/23/22 15:01, Jonathan Liu wrote:
> >>> The code from [1] sets SYS_CTRL_1 to different values depending on the
> >>> desired clock phase (0, 1/4, 1/2 or 3/4). A clock phase of 0 aligns the
> >>> positive edge of the clock with the pixel data while other values delay
> >>> the clock by a fraction of the clock period. A clock phase of 1/2 aligns
> >>> the negative edge of the clock with the pixel data.
> >>>
> >>> The driver currently hard codes SYS_CTRL_1 to 0x88 which corresponds to
> >>> aligning the positive edge of the clock with the pixel data. This won't
> >>> work correctly for panels that require aligning the negative edge of the
> >>> clock with the pixel data.
> >>>
> >>> Adjust the clock phase to 0 if DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE is
> >>> present in bus_flags, otherwise adjust the clock phase to 1/2 as
> >>> appropriate for DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE.
> >>>
> >>> [1] https://github.com/tdjastrzebski/ICN6211-Configurator
> >>>
> >>> Signed-off-by: Jonathan Liu <net147@gmail.com>
> >>> ---
> >>> V2: Use GENMASK and FIELD_PREP macros
> >>> ---
> >>>    drivers/gpu/drm/bridge/chipone-icn6211.c | 18 ++++++++++++++++--
> >>>    1 file changed, 16 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> >>> index 47dea657a752..f1538fb5f8a9 100644
> >>> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> >>> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> >>> @@ -9,6 +9,8 @@
> >>>    #include <drm/drm_print.h>
> >>>    #include <drm/drm_mipi_dsi.h>
> >>>
> >>> +#include <linux/bitfield.h>
> >>> +#include <linux/bits.h>
> >>>    #include <linux/delay.h>
> >>>    #include <linux/gpio/consumer.h>
> >>>    #include <linux/i2c.h>
> >>> @@ -26,6 +28,11 @@
> >>>    #define PD_CTRL(n)          (0x0a + ((n) & 0x3)) /* 0..3 */
> >>>    #define RST_CTRL(n)         (0x0e + ((n) & 0x1)) /* 0..1 */
> >>>    #define SYS_CTRL(n)         (0x10 + ((n) & 0x7)) /* 0..4 */
> >>> +#define SYS_CTRL_1_CLK_PHASE_MSK     GENMASK(5, 4)
> >>
> >> This should be GENMASK(7, 6) , no ?
> >
> > Clock phase 0 = 0b_1000_1000 = 0x88
> > Clock phase 1/4 = 0b_1001_1000 = 0x98
> > Clock phase 1/2 = 0b_1010_1000 = 0xA8
> > Clock phase 3/4 = 0b_1011_1000 = 0xB8
> >
> > The clock phase bits are 5:4 not 7:6. The upper 2 bits and lower 4
> > bits are unknown.
>
> Doh, you're right.
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Applied to drm-misc-next.
