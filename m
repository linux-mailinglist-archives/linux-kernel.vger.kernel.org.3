Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF95715EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiGLJlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiGLJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:41:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92B5A2EE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:41:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e69so13019660ybh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap4l5XvEX4U5y4HXdhNjnDCI2p/ybo07t52ucHAEl58=;
        b=nF5jk4IbkWMGbIvw6tuAwseMZKQOb4ZuSAzGDcOJ6hXjhVuy5eJJvBwMgRRJKyQTok
         R88q4K0mceZid2iijl+74nhtOqj+jdMd/PaLJmi1NaA24/LA6+6TXm9v7UxfZofiD0CW
         XaP6nyYSFoHb5NPejvOBbiHaG1D3SuT886+Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap4l5XvEX4U5y4HXdhNjnDCI2p/ybo07t52ucHAEl58=;
        b=ZlWECn87eWX2t2sGI+9b8Bhj8wUjXju9wdxyKgBYOId6DcN5gYOOVAJ7o/okAOH5OR
         JNICfUpnhVzeUlqHPz6gdKzZZCWGhMv/hnjf1681WMEq/tfJtHpzsp+7aR9VOrDndG5t
         OvZ+2uE0YRn1FVVi6jaGmGfjyttQ5DZZk/h/HRvgG9mFGuLkCCAQ3KX/GeYjJIYtPatw
         a3mJuthVYHDbg7wN6i8sNaQt42tommxKIeDFAWmBrWxY1bL2X4J4SsEKcdMFsKcPZt9I
         mlWtw9FEuVmrQWjhqkfU03VgS0QdTtuZYEw2rG8IQw1ItuayzcWGY6c8O7/X1bPgDzaq
         QDJg==
X-Gm-Message-State: AJIora/dz/lJY8j1qGHibhY8JloJ9gvdkHnzZn2ClNHnkqU2rrqbFNnM
        rPLOp/MPyyghi4N/J3WLFMEntTDqCCxS8UOr06m6gQ==
X-Google-Smtp-Source: AGRyM1ueFTwJTwmZe47+iw7VZHKOxIEWEBZvmpXenIjQL5R+ILXsO8/oHHqMY6GdJ5+VnIf5wvoGvPY5MBQuREGAMf8=
X-Received: by 2002:a05:6902:728:b0:66e:8f7b:a252 with SMTP id
 l8-20020a056902072800b0066e8f7ba252mr20510340ybt.584.1657618871004; Tue, 12
 Jul 2022 02:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220707080600.49041-1-allen.chen@ite.com.tw> <20220707080600.49041-2-allen.chen@ite.com.tw>
 <CAG3jFystTA3sD2nWJHPYq39WxRwjVt4qj2DMDk2Khh1kR=8ntg@mail.gmail.com>
In-Reply-To: <CAG3jFystTA3sD2nWJHPYq39WxRwjVt4qj2DMDk2Khh1kR=8ntg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 12 Jul 2022 17:41:00 +0800
Message-ID: <CAGXv+5HcU6paJJzm4nLe6mmSYUaR-pp5LBsy9aev0RRX+FKmcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: it6505: Modified power sequence
To:     Robert Foss <robert.foss@linaro.org>
Cc:     allen <allen.chen@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Pin-yen Lin <treapking@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>
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

On Tue, Jul 12, 2022 at 4:08 PM Robert Foss <robert.foss@linaro.org> wrote:
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

I think you're confusing GPIO_ACTIVE_{LOW,HIGH} flags in the device tree
vs GPIOD_OUT_{LOW,HIGH}, which just sets the "default" state the GPIO
should be in when it is requested.

This change doesn't impact the device tree.


Regards
ChenYu

> >         if (IS_ERR(pdata->gpiod_reset)) {
> >                 dev_err(dev, "gpiod_reset gpio not found");
> >                 return PTR_ERR(pdata->gpiod_reset);
> > --
> > 2.25.1
> >
