Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAA55EDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiF1T2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiF1T1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:27:31 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00782EA5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:25:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q11so18514645oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+10FmmpqDQ0iNQ5Hk+84+aEcJCyKp/8SCF4Ixa+q6vY=;
        b=iWoHl7bZvWLVEdyAkVHFeVQz5J5DMUAU7JZsWGv75MVdaQTPO4PjFEa73jbyeZ0a7T
         xYdBhRWVXlgotRQhwz40G1SjZEJIh0jhxk77xoO/+75mFRYfwlh72OamED42p/y7jKds
         eSCzvfYTzsMBJbT6sDnsmjSTUrcXfo223xgGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+10FmmpqDQ0iNQ5Hk+84+aEcJCyKp/8SCF4Ixa+q6vY=;
        b=ULZmEP6+1fqlhqTEs6kQ94THzMX6iPi6b/pobETzPdP7vS8D2bfKQxottSGBeguRSX
         kr0UdcAlJvFoJ/48Kn9oykICPsLfndV4Hnbhqoxa6BdX56xlepcPs+AL07kx5ESysFYd
         Dm0QJAQNquDyMYTR3Hk1fePIGkA/kTAlekK7SEwZOozjgs+JQug18p4IlcQ04YPMkr4z
         c6qB8BjYUHaVQaFj95UJxGn2MSYMpPLfx8j+Y/cl21f1r+0S1FCVdkhg5x6JsUjxjhMZ
         SzSR2WoFp+cUYZ9FoJUmfvfCx4g3FM21OExhEl/WQkqHFQAByxudV9zt2oo8+p4Squh0
         p4Kg==
X-Gm-Message-State: AJIora+iACntr3qU53fFpxNDHToFC8rBTFoO0fSr/g4GD/TU3LbDZM6u
        bks9m5M+2ew6CiEhr0Hl1z5C9fN0ZSVchtbxIpZ8Kg==
X-Google-Smtp-Source: AGRyM1uK9sCuCgSQeIp27nBgEZ2sQNBvuCqqCtZe9EH/XnmRvoODP7KKek4LsMwjVWsoM1WCvJ7STbiQ7QLirJs4Wok=
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id
 bc28-20020a056808171c00b00334934263efmr822636oib.63.1656444340248; Tue, 28
 Jun 2022 12:25:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jun 2022 14:25:39 -0500
MIME-Version: 1.0
In-Reply-To: <20220622173605.1168416-6-pmalani@chromium.org>
References: <20220622173605.1168416-1-pmalani@chromium.org> <20220622173605.1168416-6-pmalani@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 28 Jun 2022 14:25:39 -0500
Message-ID: <CAE-0n517BB8YbN5AZG6M3ZrZGOJDV=+t0R9d8wD+gVqO1aD1Xg@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] drm/bridge: anx7625: Add typec_mux_set callback function
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-06-22 10:34:34)
> From: Pin-Yen Lin <treapking@chromium.org>
>
> Add the callback function when the driver receives state
> changes of the Type-C port. The callback function configures the
> crosspoint switch of the anx7625 bridge chip, which can change the
> output pins of the signals according to the port state.

Can this be combined with the previous two patches? They really don't
stand alone because the previous two patches are adding stubs that are
filled out later.

> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index bd21f159b973..5992fc8beeeb 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -15,6 +15,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/workqueue.h>
>
> @@ -2582,9 +2583,64 @@ static void anx7625_runtime_disable(void *data)
>         pm_runtime_disable(data);
>  }
>
> +static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
> +                                         enum typec_orientation orientation)
> +{
> +       if (orientation == TYPEC_ORIENTATION_NORMAL) {
> +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> +                                 SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
> +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> +                                 SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
> +       } else if (orientation == TYPEC_ORIENTATION_REVERSE) {
> +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> +                                 SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
> +               anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> +                                 SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
> +       }
> +}
> +
> +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> +{
> +       if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
> +               /* Both ports available, do nothing to retain the current one. */
> +               return;
> +       else if (ctx->typec_ports[0].dp_connected)
> +               anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
> +       else if (ctx->typec_ports[1].dp_connected)
> +               anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
> +}
> +
>  static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
>                                  struct typec_mux_state *state)
>  {
> +       struct anx7625_port_data *data = typec_mux_get_drvdata(mux);
> +       struct anx7625_data *ctx = data->ctx;
> +       struct device *dev = &ctx->client->dev;
> +       bool new_dp_connected, old_dp_connected;
> +
> +       if (ctx->num_typec_switches == 1)

How do we handle the case where the usb-c-connector is directly
connected to the RX1/TX1 and RX2/TX2 pins? This device would be an
orientation (normal/reverse) and mode switch (usb/dp) in that scenario,
but this code is written in a way that the orientation switch isn't
going to flip the crosspoint switch for the different pin assignments.
