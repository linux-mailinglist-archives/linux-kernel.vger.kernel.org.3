Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4937571557
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiGLJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGLJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:08:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E95073A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:08:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so10294597wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64H1Kxgm8ncmGDcNtttCQA5XuXOfCcJqu3peaSGQwt0=;
        b=LNz3i4o2jAUEcKiMvsU1dfaggfgUlmGi8O0gCZsYDtksi3Ay6mT+0QO1Ws/AQ0xRf7
         OxiV1c5uRao+KCfHGIwCbH8P2LGz5roJlvYguREHYMFQXtL5jgUTD55IOkgc/jvTEcPO
         GSgZA5VVRaX3K9fFfaktQ2ZRV1FCXoL/jQxSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64H1Kxgm8ncmGDcNtttCQA5XuXOfCcJqu3peaSGQwt0=;
        b=BszU/DpdHzqXlwwriz0S4VgMS5nsi2kxk2daPEhsP+CDF4WTGQFB/tbSrXTO+CLG/u
         SbKS8Gj+8v0loSGWwIn3FJc+WQq6EpsFC8UyAFU8MAgYu5cYbW8wBthWNmPdZRPQNkdE
         MZo7/HrLZCGqOhRx0JZ9b4XuD1PgwGshjrFM8pjBCElAh4t2iQnTPO67u1CfoXThKPc0
         wTuKDdY1wNpNrpiSYK/HKWxpSYJXkfz1ARpdrGEl/Xb9GfCocH+xxTfKM26LHZchf8kT
         24TNR3wFcOJ5F3Z2vDA4sNhxRrGfMbBbXq7hWxl/L6/6TMcC9GGMvmFdkJWKzsS/NPuy
         dXSg==
X-Gm-Message-State: AJIora9RsjI7TSsC7ND0gdWqjQbiRrIAR9bz2k4I9nxHDhUi09BR9QrV
        2s83iFr3Pb13I0m2nB5rhMLej+o76wBsL8FdJVKHzg==
X-Google-Smtp-Source: AGRyM1veFTFmz28R79lM12n/O8GNXkrvz8w+ExQZWk8HwJqmd7Y+ArzgKwSYKQFbeBymgAOO/6GwPX3fMphTlpVQQzU=
X-Received: by 2002:a5d:64cc:0:b0:21d:a4bd:fdbe with SMTP id
 f12-20020a5d64cc000000b0021da4bdfdbemr9984122wri.580.1657616894391; Tue, 12
 Jul 2022 02:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220707080600.49041-1-allen.chen@ite.com.tw> <20220707080600.49041-2-allen.chen@ite.com.tw>
 <CAG3jFystTA3sD2nWJHPYq39WxRwjVt4qj2DMDk2Khh1kR=8ntg@mail.gmail.com>
In-Reply-To: <CAG3jFystTA3sD2nWJHPYq39WxRwjVt4qj2DMDk2Khh1kR=8ntg@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 12 Jul 2022 17:08:03 +0800
Message-ID: <CAEXTbpc4PpvoOdu0OSsgvZFsc9AeJwvz7AmnabYO8-wGS56N5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: it6505: Modified power sequence
To:     Robert Foss <robert.foss@linaro.org>
Cc:     allen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Tue, Jul 12, 2022 at 4:07 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Hi Allen,
>
> On Thu, 7 Jul 2022 at 10:06, allen <allen.chen@ite.com.tw> wrote:
> >
> > From: allen chen <allen.chen@ite.com.tw>
> >
> > Change power sequence to meet it6505 data sheet requirement when boot on.
> >
> > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> >
> > ---
> >  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> > index 2d119e3016b3..aa5e0aa1af85 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -3029,7 +3029,7 @@ static int it6505_init_pdata(struct it6505 *it6505)
> >                 return PTR_ERR(pdata->ovdd);
> >         }
> >
> > -       pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +       pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>
> Making this change is problematic since it requires a corresponding
> change in all of the device trees that use this device. It's against
> policy to change this interface after it has been introduced.
>
> Unless anyone thinks otherwise, I would like to see this patch dropped.

I don't really understand why this would require corresponding change
in device trees.

Currently there's no real it6505 user on upstream. Also, the GPIO
value will be changed
in it6505_poweron, so this change only affects the power on sequence of it6505.

>
> >         if (IS_ERR(pdata->gpiod_reset)) {
> >                 dev_err(dev, "gpiod_reset gpio not found");
> >                 return PTR_ERR(pdata->gpiod_reset);
> > --
> > 2.25.1
> >
