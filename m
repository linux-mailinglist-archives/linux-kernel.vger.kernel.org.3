Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE79D517183
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiEBO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiEBO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:29:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB3DFF3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:26:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so16227210pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BfTecELncQo+MNmOrEVdpVY4MKw3ykdNOngFq2vpEA=;
        b=nlEGE88TfuhYScKEinFaoc5rceXxa8XrGcaZaXC85R5Ua1dFEJu3XwrQwS9W5zP0ov
         1ZikyBkktgggbx4qMDaRRK+Pz06aKjCPIynSZ67Fi9tYi3L7T6RXC/CDJC7/Xnc+eEEU
         NNYdKcmxpvOgDPrrA/QV9zvUX9uz/eUBlLBvag5mqIDZrc8jbY6ekIofWlZCv+wKd/D0
         TLNjsnNAyBRpQrQqbZ3L0Y5LA2FzDmIi+JErF8T0JeRSSvwvdsQCC7lsx+boi4TNIrsO
         aVnuzQJS0p75jkexoO7ReRO1aGvRkeA9l3OA8fOdiY+EKIRfGQtHk/JAnvw1cS/bfjP8
         0scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BfTecELncQo+MNmOrEVdpVY4MKw3ykdNOngFq2vpEA=;
        b=yDkyZ2bcNOE/6cG6m1hL1pQCzZZF0V2gNaNyZMAQ360XHHePkFwiDutgYtkRFxBoVW
         kJH3bCN5ahUfeAEzI2dvCzDBRL4gAd7tioWMxeE1RH6we7y/bP5nB+hWdjl9fJLHYfFy
         AiFNkt0hLko9MeFOQ4lQ0EIUNgbHDobrNJG3y782oV0+K5lvExvKjWJkcmwZryIbpsoe
         uBPQNNS54N+jg4bapcYUGlogQgmqo9p29DSLARWJaXoYBzrfxl+aUApNRllxdRkaWSX/
         TIfAfgdeMITwX9dZFEBFPf27XMBTnYcInwVCqrGkpV8A/CoqYniTIiMTF+F1Aw64A6LV
         cVsg==
X-Gm-Message-State: AOAM532djdCzTVAgCAbZRv7kR7W9PQ5JJoWSFbgtuUX3xYae9mggwdLh
        C+3dmG3GeUj99bLJ2PNSrzu+DXx6OBZsXJKLDSijMA==
X-Google-Smtp-Source: ABdhPJwocUL+W9zxZIvjEloZYnEbg/cP02pumTmxSJz/dIfLCydeibCk/PpvPcTl7r7HiM/1LA7UxYijjIW9ZFmvq04=
X-Received: by 2002:a17:90b:1e4e:b0:1dc:583c:398 with SMTP id
 pi14-20020a17090b1e4e00b001dc583c0398mr6056116pjb.232.1651501576683; Mon, 02
 May 2022 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220430064828.2470989-1-jstultz@google.com>
In-Reply-To: <20220430064828.2470989-1-jstultz@google.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 2 May 2022 16:26:05 +0200
Message-ID: <CAG3jFyurX5MKDr9=kEFT6AaV+HZf588cAMLaBG8G+6CAr-3QJQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] drm/bridge: lt9611: Consolidate detection logic
To:     John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel-team@android.com
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

On Sat, 30 Apr 2022 at 08:48, John Stultz <jstultz@google.com> wrote:
>
> This patch simply consolidates the duplicated detection
> functionality in the driver.
>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index 63df2e8a8abc..bf66af668f61 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -578,10 +578,8 @@ static struct lt9611_mode *lt9611_find_mode(const struct drm_display_mode *mode)
>  }
>
>  /* connector funcs */
> -static enum drm_connector_status
> -lt9611_connector_detect(struct drm_connector *connector, bool force)
> +static enum drm_connector_status __lt9611_detect(struct lt9611 *lt9611)
>  {
> -       struct lt9611 *lt9611 = connector_to_lt9611(connector);
>         unsigned int reg_val = 0;
>         int connected = 0;
>
> @@ -594,6 +592,12 @@ lt9611_connector_detect(struct drm_connector *connector, bool force)
>         return lt9611->status;
>  }
>
> +static enum drm_connector_status
> +lt9611_connector_detect(struct drm_connector *connector, bool force)
> +{
> +       return __lt9611_detect(connector_to_lt9611(connector));
> +}
> +
>  static int lt9611_read_edid(struct lt9611 *lt9611)
>  {
>         unsigned int temp;
> @@ -887,17 +891,7 @@ static void lt9611_bridge_mode_set(struct drm_bridge *bridge,
>
>  static enum drm_connector_status lt9611_bridge_detect(struct drm_bridge *bridge)
>  {
> -       struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
> -       unsigned int reg_val = 0;
> -       int connected;
> -
> -       regmap_read(lt9611->regmap, 0x825e, &reg_val);
> -       connected  = reg_val & BIT(0);
> -
> -       lt9611->status = connected ?  connector_status_connected :
> -                               connector_status_disconnected;
> -
> -       return lt9611->status;
> +       return __lt9611_detect(bridge_to_lt9611(bridge));
>  }
>
>  static struct edid *lt9611_bridge_get_edid(struct drm_bridge *bridge,

I think this looks good. Thank John!

Reviewed-by: Robert Foss <robert.foss@linaro.org>
