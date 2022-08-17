Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D15979D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiHQWyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbiHQWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:54:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08275491CB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:54:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y13so81916ejp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QschqWR/xbvl1D7imcOoJeImJIJB3zdqTJ6vvEQFZ4w=;
        b=Nlsrd3j+SqpVi0O5EgU7LKy3RgW5hlhIhEHJbL8PIe4KcgXB4S4VWvugb2BrDi72QO
         P29yb1T2N1GX/JPH/XtLz7DwBuv2p5xdYTM2diVXaK1/C7WP75BugOuwDWTs+lzS4qsG
         WZbAXOvndNMdRr34lChjTEKxN2yrbCMamJVbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QschqWR/xbvl1D7imcOoJeImJIJB3zdqTJ6vvEQFZ4w=;
        b=1CAbFFwy+Rhn/jROSx3JMdOXYpxkbxr7KEffljuO2NvtbC6j8ZLaWnypsPIVwcT3ga
         NA57CSXov60y7WSRuynNAzJAka5d7reF5mByeg0i36RY7eoF8JkL/VUmbjRV+YWO7422
         lCMYiKoXsX1yuxX+iDeAvJAP1Rr1+36skE/ZF0HMg5O+bxsE8pgpyITWXoAiJA7Aw8L4
         bsZAHhcfOl+PwK85S7+AcrjdbIlp6Qqa+oNuGHD1l6MCIvchEg8y7lJqOBjRSNd/a1E1
         zadoHUdZHDno2LeS6zGdGBrTFDcRWF9exgnKMdJvjbTGgI8NGPDeWbExWYbvr7xe/iDT
         VsRQ==
X-Gm-Message-State: ACgBeo1h0T4CfWKrFKnlpJmjIwusn5MrpZOaXzxn+VAQ8DNcbp74ZVzu
        aQyjlstzrm64OoCyWVB9hziWFidRgCr9zWxb
X-Google-Smtp-Source: AA6agR6VGE4k/boJjx9JQ2ZGZG8ho2Mia+2VQA/k9IzsqBdDaVthCG3dDLcHuvB+VHnghym6LaZgHA==
X-Received: by 2002:a17:907:75fb:b0:730:9e1f:73f1 with SMTP id jz27-20020a17090775fb00b007309e1f73f1mr121035ejc.495.1660776888316;
        Wed, 17 Aug 2022 15:54:48 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090633d600b0072b33e91f96sm7308808eja.190.2022.08.17.15.54.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 15:54:47 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1742250wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:54:47 -0700 (PDT)
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr3178011wme.188.1660776886931; Wed, 17
 Aug 2022 15:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org>
In-Reply-To: <20220815093905.134164-1-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Aug 2022 15:54:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
Message-ID: <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        rock.chiu@paradetech.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 15, 2022 at 2:39 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> The double reset power-on sequence is a workaround for the hardware
> flaw in some chip that SPI Clock output glitch and cause internal MPU
> unable to read firmware correctly. The sequence is suggested in ps8640
> application note.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 49107a6cdac18..d7483c13c569b 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -375,6 +375,11 @@ static int __maybe_unused ps8640_resume(struct device *dev)
>         gpiod_set_value(ps_bridge->gpio_reset, 1);
>         usleep_range(2000, 2500);
>         gpiod_set_value(ps_bridge->gpio_reset, 0);
> +       /* Double reset for T4 and T5 */
> +       msleep(50);
> +       gpiod_set_value(ps_bridge->gpio_reset, 1);
> +       msleep(50);
> +       gpiod_set_value(ps_bridge->gpio_reset, 0);

We really need another 100 ms here? ps8640 is already quite slow at
powering itself up and that has a real user impact. Why was it only
2.5 ms for the first reset and 50 ms for the second?

-Doug
