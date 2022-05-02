Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A985171B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiEBOld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiEBOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:41:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AD510BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:37:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i62so11841423pgd.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74bxgGuHU9jSk3+QuQXZKRvlg8V04rNVxn+TIhl3ghI=;
        b=US2i16G1FslRkGzUxXxBxn5PpAczH/bRPVsvbNYjBDpAbIud3dKvEm6qAcX8D/oZ5Z
         Tk9hvG3m4vnc71cxDEuZQRK/OOh4iXy1/kZVMLznQYGfhpbxBzLaTpJr7xzbcITYCPoR
         d+Qx9Lsf6E7YpfDfJwEzuvPwbx3SMTstl+zX30Yzd5dIFyfrgjAqTESfzPSnxoKc66Pw
         HYpEOptx+COAhLTNA1avuz+BaGoEm9EBzevRp4pdPJWXXZn1dLx6adODGE0pH46ilwUT
         k2Ush7C83FevsksKSoImxQFzDDSLTI0oI+vQAzXUD4dl+j++RxPC9LjzqYDQy2FMVMrR
         uAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74bxgGuHU9jSk3+QuQXZKRvlg8V04rNVxn+TIhl3ghI=;
        b=xQ2HUtFXiWQC3AN2piT/XUGtvXPesmFLgBRq/gvknj8566rZ+TYgqs9S/OqHMsTfcb
         K+8jKpY3X3MKE4SzgSS/K8h7ZfH3blGOcRBMfhODRlkrdlL5qsATA7fcvbleVPHISNIk
         nAYiyvI8OeXJKteSozOcsQRRLyWQby0brM0eJMpJl8pnjLR+aPnGxPudgR92yvlODztf
         PlXI0KQtCvgpcm8MNaU3X+pkJ2+5Ea+YCpWUJwnPuLCT3VyTaVv4HENNcKLSIltXfo+x
         GaaYKFTfkd+DNUbXRTsy9fFgHYjQzlbbqGH/p8pNgtLXkzO3JPbVq8dPpLGYayo19OE2
         QFCA==
X-Gm-Message-State: AOAM5311CLzn2hb3Qke4QM9WWLRSrScCXU6d+ev+zeg++mWZ/Du4uK1C
        hA5VIKGs1/GgPWDA7vHEKTtjzMogO4xxCGdYIBjxsQ==
X-Google-Smtp-Source: ABdhPJxO8+87e2lHNCFbPay2aHSBemsxX2KpF1wpvTcg1JbtYVs08QwN6sikfE7I6JCo0Vr2Ph9NRx2sMzw7tPml9ys=
X-Received: by 2002:a62:6d47:0:b0:4fe:15fa:301d with SMTP id
 i68-20020a626d47000000b004fe15fa301dmr11688627pfc.29.1651502278898; Mon, 02
 May 2022 07:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220425134424.1150965-1-treapking@chromium.org>
In-Reply-To: <20220425134424.1150965-1-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 2 May 2022 16:37:48 +0200
Message-ID: <CAG3jFys-qNAER4xVhbNqE9xbsjTMEbaBR291Kc1M1SKkH5oE1w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Send DPCD SET_POWER to downstream
To:     Pin-Yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, 25 Apr 2022 at 15:44, Pin-Yen Lin <treapking@chromium.org> wrote:
>
> Send DPCD SET_POWER command to downstream in .atomic_disable to make the
> downstream monitor enter the power down mode, so the device suspend won't
> be affected.
>
> Fixes: b5c84a9edcd418 ("drm/bridge: add it6505 driver")
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 8fed30df08b0..4b673c4792d7 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -737,8 +737,9 @@ static int it6505_drm_dp_link_probe(struct drm_dp_aux *aux,
>         return 0;
>  }
>
> -static int it6505_drm_dp_link_power_up(struct drm_dp_aux *aux,
> -                                      struct it6505_drm_dp_link *link)
> +static int it6505_drm_dp_link_set_power(struct drm_dp_aux *aux,
> +                                       struct it6505_drm_dp_link *link,
> +                                       u8 mode)
>  {
>         u8 value;
>         int err;
> @@ -752,18 +753,20 @@ static int it6505_drm_dp_link_power_up(struct drm_dp_aux *aux,
>                 return err;
>
>         value &= ~DP_SET_POWER_MASK;
> -       value |= DP_SET_POWER_D0;
> +       value |= mode;
>
>         err = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
>         if (err < 0)
>                 return err;
>
> -       /*
> -        * According to the DP 1.1 specification, a "Sink Device must exit the
> -        * power saving state within 1 ms" (Section 2.5.3.1, Table 5-52, "Sink
> -        * Control Field" (register 0x600).
> -        */
> -       usleep_range(1000, 2000);
> +       if (mode == DP_SET_POWER_D0) {
> +               /*
> +                * According to the DP 1.1 specification, a "Sink Device must
> +                * exit the power saving state within 1 ms" (Section 2.5.3.1,
> +                * Table 5-52, "Sink Control Field" (register 0x600).
> +                */
> +               usleep_range(1000, 2000);
> +       }
>
>         return 0;
>  }
> @@ -2624,7 +2627,8 @@ static enum drm_connector_status it6505_detect(struct it6505 *it6505)
>         if (it6505_get_sink_hpd_status(it6505)) {
>                 it6505_aux_on(it6505);
>                 it6505_drm_dp_link_probe(&it6505->aux, &it6505->link);
> -               it6505_drm_dp_link_power_up(&it6505->aux, &it6505->link);
> +               it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
> +                                            DP_SET_POWER_D0);
>                 it6505->auto_train_retry = AUTO_TRAIN_RETRY;
>
>                 if (it6505->dpcd[0] == 0) {
> @@ -2960,8 +2964,11 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
>
>         DRM_DEV_DEBUG_DRIVER(dev, "start");
>
> -       if (it6505->powered)
> +       if (it6505->powered) {
>                 it6505_video_disable(it6505);
> +               it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
> +                                            DP_SET_POWER_D3);
> +       }
>  }
>
>  static enum drm_connector_status
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
