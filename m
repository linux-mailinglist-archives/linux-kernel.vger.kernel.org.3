Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4012D4E3AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiCVIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiCVIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:45:16 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB732A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:43:48 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id v206so2229137vsv.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSE12avE5FpxzB4ihxmwpNNroKbegiLE8Kcfh7pXhI0=;
        b=CAMeB2ST43DRf4It75FcHrj3pWVjgoU+rJAtfYkUjxAvWDIpFOdbszM+63cPIONVn3
         adssPgQVp/yN3XlQlAQ2bDLMCVTyMwrCaRwgu4TQ7YM2nKLW7GIdBB0zb2Yz3eLDBXwX
         /DRW1X7gPkDqfs7/iFO6K4ODSuOzUc58+C/g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSE12avE5FpxzB4ihxmwpNNroKbegiLE8Kcfh7pXhI0=;
        b=lBUVIZBNfz1Mom5hQuXfpANYfYzAYS/LN5zs+rivVyF3se1m6b2nWaEGsTggbEGJAm
         gy8VnRAbtcwZkHzGJMd8BpK2Lz91lphcIzV4A0Geimkbw9zgfFqiDYfVnq8Y3GaRvclU
         uPSo3EquUc9tga3zGk/pRX9J3RubIJH5xkkLspK/TU8Y+3yjhBifFLY82uUvKQQOeBJK
         p9labZ79Up74ue2qBQ0y8LJlM1FZrWKEMiKHAs4ADhjJ+WPurs37ZhSIuEVJZ0ad1Ioc
         Krd92NkUpiv/CVXiZFraE2JDPQYmCgWZI0byIKA4AgKX8E4YYK0fk9J2qGO0KnKwEZnS
         LwCw==
X-Gm-Message-State: AOAM533xmwUaR9tmNp1OX0X77Mfbc5BNxuLfc6+xHfblQ92yO9OoefxK
        1QHGbOzFK4f9GbHJO+wabWLRSeu8Ids+dtAUseRn1Q==
X-Google-Smtp-Source: ABdhPJziRzdD1GSZYrFkru+e7JN1ZBA/uGtcNDTkNfmw6kEHpfJ/FNnidKcb4lh8jEoGs4LHjs05R3ewSo7m2vfRzSw=
X-Received: by 2002:a05:6102:ed5:b0:322:ba55:d279 with SMTP id
 m21-20020a0561020ed500b00322ba55d279mr8412347vst.77.1647938627194; Tue, 22
 Mar 2022 01:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220322080213.1487134-1-xji@analogixsemi.com>
In-Reply-To: <20220322080213.1487134-1-xji@analogixsemi.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 22 Mar 2022 16:43:20 +0800
Message-ID: <CAJMQK-j+PhB6dZBuKG3NtW94oT0bVkp9G1bXhmyZLgYOmTCgog@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Set downstream sink into normal status
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, treapking@chromium.org, pihsun@chromium.org,
        tzungbi@google.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 4:02 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> As downstream sink was set into standby mode while bridge disabled,
> this patch used for setting downstream sink into normal status
> while enable bridge.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> Reviewed-by: Pin-Yen Lin <treapking@chromium.org>
>
> ---
> V1 -> V2: use dev_dbg replace of dev_info
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 9a2a19ad4202..dcf3275a00fe 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -924,12 +924,20 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
>  {
>         int ret;
>         struct device *dev = &ctx->client->dev;
> +       u8 data;
>
>         if (!ctx->display_timing_valid) {
>                 DRM_DEV_ERROR(dev, "mipi not set display timing yet.\n");
>                 return;
>         }
>
> +       dev_dbg(dev, "set downstream sink into normal\n");
> +       /* Downstream sink enter into normal mode */
> +       data = 1;
> +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
> +       if (ret < 0)
> +               dev_err(dev, "IO error : set sink into normal mode fail\n");
> +

The driver uses DRM_DEV_* for logs. Can we use this?

>         /* Disable HDCP */
>         anx7625_write_and(ctx, ctx->i2c.rx_p1_client, 0xee, 0x9f);
>
> --
> 2.25.1
>
