Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A4522864
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiEKAWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiEKAWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:22:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5956F51589
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:22:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i11so909511ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdS4LZ7mqGBxPaeGzqFu6xL7PLhOVbvjUXM7la61o/M=;
        b=XgCUr/iOevJS21fhdEkGGCivLNeOLhoAWYumXsPp88f8f/zg+5r5oQHJyI4Ie99jFI
         agkIVkxUbE8yXd6i6Us8qlSyT/Th3Y/mrwqi1qoVavNqEeWz0RweVhVtAqH3vjyRYzQ3
         ItTBNXxi/bmOSBRTTNxUjknJVTUCg+RndVzGtDIYpws852Kh9mUQXEBSpuS563rOh/hE
         bfDND2E5hCJkaOpuX/tSNFmiHcrXBGanJACUQmkrx5DOn3b2P9kZmXBCR1m7VvrDkv6A
         jKVcgfEuIoysQ3aA0Mo3H3SGEIPWd/6Z/VCs8DchZjZGpV1XFn4R47tG4UWTYddAgCIb
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdS4LZ7mqGBxPaeGzqFu6xL7PLhOVbvjUXM7la61o/M=;
        b=35r7BS9G88Ouppp/ZPP9fQR+7LB4hXL6vqYbm1e10Lmyt6j08giVSnJC6nKwjiO6ya
         iNz1pTXuffb4Dkbdgdg9wVfikQVjJ6hWZmQEJMkqG1hWrY1d7Af6XBotQ+22N6/3yIzo
         Hdc9SD9DtvrCIDgykTGwpGlpVxAbS6nM1d4VI/sZlf+FYETCgYFdTLEV1Bx9kTreDZHF
         AVfK4IrHXLhwy6CJL6vgeoQcPEfSdukbQdOCf0AUTtgovMFAP6NMWUdvBiADgPXAP+1i
         9QIxcKAaGi4XNx6/AEwapMUgfCLNoeTBVOki0XkDZb9TLB6JFkw0ZdkwF2a5oRq9LQkY
         mMZg==
X-Gm-Message-State: AOAM532iLEzbX5lACa9pdKqj8s4hGuWOWsVM3fzz5c89zmwz4JVmcEGN
        6O6Ozhzv1B/0CXP46RphHmyB4dm8EH/guBHrjaeAUw==
X-Google-Smtp-Source: ABdhPJz4MB95vmfbkO8RYAD9atniqUztRKCagWj0vKt6uZa5Ph2V5Tsln22BbnQi2fFneVAxvQrYIjwoAXhjbIjn+NQ=
X-Received: by 2002:a25:fb10:0:b0:64a:d339:3f38 with SMTP id
 j16-20020a25fb10000000b0064ad3393f38mr11111060ybe.234.1652228550563; Tue, 10
 May 2022 17:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org> <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
In-Reply-To: <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 May 2022 03:22:19 +0300
Message-ID: <CAA8EJpqBnR_-YaNj-hc6fjfeRX-aTBhuzCFKg77QEyANu37cnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 at 22:30, Douglas Anderson <dianders@chromium.org> wrote:
>
> This adds a devm managed version of drm_bridge_add(). Like other
> "devm" function listed in drm_bridge.h, this function takes an
> explicit "dev" to use for the lifetime management. A few notes:
> * In general we have a "struct device" for bridges that makes a good
>   candidate for where the lifetime matches exactly what we want.
> * The "bridge->dev->dev" device appears to be the encoder
>   device. That's not the right device to use for lifetime management.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
> Changes in v3:
> - Patch ("drm/bridge: Add devm_drm_bridge_add()") new for v3.
>
>  drivers/gpu/drm/drm_bridge.c | 23 +++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index c96847fc0ebc..e275b4ca344b 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -170,6 +170,29 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_add);
>
> +static void drm_bridge_remove_void(void *bridge)
> +{
> +       drm_bridge_remove(bridge);
> +}
> +
> +/**
> + * devm_drm_bridge_add - devm managed version of drm_bridge_add()
> + *
> + * @dev: device to tie the bridge lifetime to
> + * @bridge: bridge control structure
> + *
> + * This is the managed version of drm_bridge_add() which automatically
> + * calls drm_bridge_remove() when @dev is unbound.
> + *
> + * Return: 0 if no error or negative error code.
> + */
> +int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge)
> +{
> +       drm_bridge_add(bridge);
> +       return devm_add_action_or_reset(dev, drm_bridge_remove_void, bridge);
> +}
> +EXPORT_SYMBOL(devm_drm_bridge_add);
> +
>  /**
>   * drm_bridge_remove - remove the given bridge from the global bridge list
>   *
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index f27b4060faa2..42aec8612f37 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -796,6 +796,7 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
>  }
>
>  void drm_bridge_add(struct drm_bridge *bridge);
> +int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge);
>  void drm_bridge_remove(struct drm_bridge *bridge);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>                       struct drm_bridge *previous,
> --
> 2.36.0.550.gb090851708-goog
>


--
With best wishes
Dmitry
