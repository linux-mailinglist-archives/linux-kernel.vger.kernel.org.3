Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD8571415
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiGLIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiGLIMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:12:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF152E6A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:12:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e15so9104377edj.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owNGXTG6trvHPmdErnbDiIfwqp/UAMQF528p+GbC9XU=;
        b=U+hnbQfWIDaw1K825D2TgYJS1lfVHB59AiGRORo//U6OpdXRqxyLW5Rw95DiruSuZo
         6bZKjdQHk8ceVGjQt0KM+0ZfqGLo6lst+Vw8g1pLKiPasESmqAhwd2AoH2aXSamOV4HE
         vtTYYXDydZGgphpwzJ3WsRSx/lOopLf8s39CTdFdIZBk2WTZ9Iq+25m7/n8a3+qls8fx
         OTc6pk57nEQmyB96mD00jWPq06fIv61cUfWVlCUHqUEOEbcxn7unugdeShPeVCf0h8h9
         +FuLetynE0KBn67nmMw60xEY0iW9bHd08AZhMXff39fLnk+4y4vv++8RRFvNR8D3C5Nc
         yTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owNGXTG6trvHPmdErnbDiIfwqp/UAMQF528p+GbC9XU=;
        b=f5aMHC62+HZOHU95e+Xs1qTddQ1RMkbMZOLvHNt4tb9kapNXN01zZmehDpQn61iMTr
         jS6nP4FJEyHEq0SH2eOF1gcmQ/Ub9EHfNba26oZfjj2vRLt1yW02N1p2JhLfn32/HMpj
         ivrdrxRzSe0V8gCzFa75SDmpRL3UTNzZl1dUqpne7q46cWu5KcthDqbEZk5s/Q5EvbGV
         Al91IojIjHttFzwpmZRgntixYkh35p7NMsapnxdCHMV2o9o67UuzYbdpk6ykx4siqTCg
         7tdCyQ3TT3pUTthVIPOekLkF0v0axoQRcgdxhxWtvcH357v5gA7V/5EbJgn0mXOmqW+f
         S8GA==
X-Gm-Message-State: AJIora9xbCHdG75MiQgBNTEQeTzhty+NvsCUoJaVfL1lHROg+91CZ+eS
        QnSCpDiHwAmwe7bH2R4JxCZ2PsqKGK4zfGMCZtmsDg==
X-Google-Smtp-Source: AGRyM1vqyL53pvPNDSVY/fjYfQk+M6LcnvEXWRndS70v9DT/ZldD8MPoIla+vkJA0XBR8teURKSoxNhXBZo4qymOEHY=
X-Received: by 2002:aa7:cdc2:0:b0:43a:7255:5274 with SMTP id
 h2-20020aa7cdc2000000b0043a72555274mr30566286edw.159.1657613525708; Tue, 12
 Jul 2022 01:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707080600.49041-1-allen.chen@ite.com.tw> <20220707080600.49041-4-allen.chen@ite.com.tw>
In-Reply-To: <20220707080600.49041-4-allen.chen@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 12 Jul 2022 10:11:54 +0200
Message-ID: <CAG3jFytTh3gso+B8+O+UXB0u+F3-o0qVdYVF3sn8O6XxfTShzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/bridge: it6505: Modified video clock calculation
 and video debug message
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-Yen Lin <treapking@chromium.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 at 10:06, allen <allen.chen@ite.com.tw> wrote:
>
> From: allen chen <allen.chen@ite.com.tw>
>
> Speed up video clock calculation and remove redundant video debug message.
>
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index cfd2c3275dc5..11a34ddb60a1 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -703,7 +703,7 @@ static void it6505_calc_video_info(struct it6505 *it6505)
>         DRM_DEV_DEBUG_DRIVER(dev, "hactive_start:%d, vactive_start:%d",
>                              hdes, vdes);
>
> -       for (i = 0; i < 10; i++) {
> +       for (i = 0; i < 3; i++) {
>                 it6505_set_bits(it6505, REG_DATA_CTRL0, ENABLE_PCLK_COUNTER,
>                                 ENABLE_PCLK_COUNTER);
>                 usleep_range(10000, 15000);
> @@ -720,7 +720,7 @@ static void it6505_calc_video_info(struct it6505 *it6505)
>                 return;
>         }
>
> -       sum /= 10;
> +       sum /= 3;
>         pclk = 13500 * 2048 / sum;
>         it6505->video_info.clock = pclk;
>         it6505->video_info.hdisplay = hdew;
> @@ -2344,8 +2344,6 @@ static void it6505_irq_hpd(struct it6505 *it6505)
>
>                 if (!it6505_get_video_status(it6505))
>                         it6505_video_reset(it6505);
> -
> -               it6505_calc_video_info(it6505);
>         } else {
>                 memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
>
> --
> 2.25.1
>


Reviewed-by: Robert Foss <robert.foss@linaro.org>
