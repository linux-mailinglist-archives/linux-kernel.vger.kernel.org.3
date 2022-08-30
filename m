Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764E95A5DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiH3IPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiH3IPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:15:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADAD6CF73
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:15:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lx1so20482913ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s+gdl9H5n8j4hKv3w97SJ726qTudg1e81QWIUDUaB48=;
        b=pNqWd8jFVhhrMDvbwttW3wGMsTlmWu5+Q3CZG0rQLkWDO2fqB/7QUzz0Jp6Lv4TF7p
         MfaN1jd5T8UBxVpJMjaScALQPXXksv7qJo4Unz1ZDS7fG6NdGsBmq47t1c6ZbJQTiPo2
         ZX1nx7beoEhFLn5QI3x4is034HNKHwEuiqW0+vNEDKHUeLJNYlCJJm0v7udvPBAK60eJ
         TQG0qGHkFDIbBW9Nn8eQg0H7LLCWDw7B2z6SpF5Ph5OPA16fL/HEa4mt3eu8WNUvOJxG
         /mnusbaU0Bh32ixzvGu7DbDwomf4nh0fE/f1QHJj/8QmfrSTNLyNHXtjJ1srRHMfd4nS
         FDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s+gdl9H5n8j4hKv3w97SJ726qTudg1e81QWIUDUaB48=;
        b=6naZbMLwBIBO6qKtL6i387/7BkVhQiEGuvuLCFutPrRo4wvQzjfEPfkTEqQWX5SLuM
         Elk19TK/7fZRF+NES4zPPd6yQfpEdaBI/8wlkSkCP2MfEjRSi2RK4r1BqpGmWpMFDvS9
         NRvY4z93+zgFv0Zek8frsf7DFbaojtspgs5FxbQ2wKWS6ASSDNBAS0jpleHWvg+RQSEs
         ZdlzQsFwXTgOZo16D7EnsNplK++gZcnLRHittRp2va9mmU9vSxMhIlhKX7dBKYixKMBA
         11mxDtAX2jYPsV9Ov+RoUw6+Qhgc5GobYEA2s9syfE9JIwMDalB1DuhaEx35SnmE0RTs
         04WQ==
X-Gm-Message-State: ACgBeo3/sQrD4MOfKwEq0UylIln3eOylnuYZLpFlZ8evi8VyKKBGkhoB
        GcocXqNzjXcb9gN86JBb/nbIYyFznKpjivV+wgZ/1g==
X-Google-Smtp-Source: AA6agR7c/Yn6ztwSwjOFO/3EFw4sNtHKHsxhBfWJr74L8Ao8x8881pMcSw1YmFEJRpnxwLgiv4Xl5r5p3ger0qeh6Kk=
X-Received: by 2002:a17:907:7d91:b0:731:7ecb:1e5b with SMTP id
 oz17-20020a1709077d9100b007317ecb1e5bmr16189024ejc.78.1661847333431; Tue, 30
 Aug 2022 01:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220830045756.1655954-1-treapking@chromium.org>
In-Reply-To: <20220830045756.1655954-1-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 30 Aug 2022 10:15:21 +0200
Message-ID: <CAG3jFysagrW_SKFmO1CEbwpOQhCmWGSVgghvEQcFgfPSdaFv0w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: it6505: Fix the order of DP_SET_POWER commands
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org
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

On Tue, 30 Aug 2022 at 06:58, Pin-yen Lin <treapking@chromium.org> wrote:
>
> Send DP_SET_POWER_D3 command to the downstream before stopping DP, so the
> suspend process will not be interrupted by the HPD interrupt. Also modify
> the order in .atomic_enable callback to make the callbacks symmetric.
>
> Fixes: 46ca7da7f1e8 ("drm/bridge: it6505: Send DPCD SET_POWER to downstream")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
>
> Changes in v2:
> - Correct "fixes" tag.
> - Collect "Reviewed-by" tag.
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index f9251ec49bf0..2bb957cffd94 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2951,9 +2951,6 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
>         if (ret)
>                 dev_err(dev, "Failed to setup AVI infoframe: %d", ret);
>
> -       it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
> -                                    DP_SET_POWER_D0);
> -
>         it6505_update_video_parameter(it6505, mode);
>
>         ret = it6505_send_video_infoframe(it6505, &frame);
> @@ -2963,6 +2960,9 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
>
>         it6505_int_mask_enable(it6505);
>         it6505_video_reset(it6505);
> +
> +       it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
> +                                    DP_SET_POWER_D0);
>  }
>
>  static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
> @@ -2974,9 +2974,9 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
>         DRM_DEV_DEBUG_DRIVER(dev, "start");
>
>         if (it6505->powered) {
> -               it6505_video_disable(it6505);
>                 it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
>                                              DP_SET_POWER_D3);
> +               it6505_video_disable(it6505);
>         }
>  }
>
> --
> 2.37.2.672.g94769d06f0-goog
>

Applied to drm-misc-next.
