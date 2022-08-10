Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241E858F44D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiHJWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiHJWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:22:55 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005518C452
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:22:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10d845dcf92so19471961fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=6ZXpeykwT3UcSDOHGtJfXAmbLhvIZVOoNhfE2nMEi9U=;
        b=fNj6bGWSepVNh9KUpmWHunpqN8Jhu3GMgOn+GPdB4erApMi1R65km8K1Kmq7Mej4Nq
         +A4fckaH0S/Wcj86Dko9ri0Rc+tf9fvc6osQfaJSsy13zB/TMANokZiR5NSjqI6ff4Tq
         1Az7Ym4yC5q6aCw2z+xVuxCZpPI193+UioaKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=6ZXpeykwT3UcSDOHGtJfXAmbLhvIZVOoNhfE2nMEi9U=;
        b=brGrQQvCAADQvDfbzr18VJx+cSrzPi1c4f6KGuVHtCkpQFgroSO9UIV5/gp/l3Bnvm
         nrKDJ6WrCyZ6LUYbEz7ew+GeuH6kyhhUlzyFpg8goeNgw1ewq9mrO2suasFyCSxH2j8s
         ME8Ux3RX5pAEIlTWZ/o0QUIG8+POac8yKLvom3Yx0a6feXSrKaMqPeBsaAl0SMwjt1Ft
         wRJwUXsLKAQiGhevXu6iornXD4+chrImp481JoZ47N7ERbJhKdOULYOIB9IWsrNaV8b0
         Kj4q7BPwwTN9XnyCN1lvpwLy4oHSyWqcMhkGFoMdAygaiwjd09UbjGV5QbvQ9XHP94r0
         WjnA==
X-Gm-Message-State: ACgBeo0O7xusar+w/hTgewPwF/O7lv946TnhZXTvvoor9rLmTNCnLaEP
        LJZr+O4AK+TIzmuBUGV7etWFSYpVfJLd2EZLERhLWg==
X-Google-Smtp-Source: AA6agR4tGznIvQwijtSDOPuLU9fc/WJ4b/gonUrK7uyKPVZ3I1QHlYY7Al1Vij85kOgI7HtbkFv2qGEbFQGqeEitqyg=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr2438112oab.44.1660170173320; Wed, 10
 Aug 2022 15:22:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Aug 2022 17:22:52 -0500
MIME-Version: 1.0
In-Reply-To: <1660159551-13828-1-git-send-email-quic_khsieh@quicinc.com>
References: <1660159551-13828-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 Aug 2022 17:22:52 -0500
Message-ID: <CAE-0n533SUb3Bg=pR8Fhwo-M5qLWiti4nzLR-rSGVAsrXgEYNQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: check hpd_state before push idle pattern
 at dp_bridge_disable()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-08-10 12:25:51)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index b36f8b6..678289a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1729,10 +1729,20 @@ void dp_bridge_disable(struct drm_bridge *drm_bridge)
>         struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>         struct msm_dp *dp = dp_bridge->dp_display;
>         struct dp_display_private *dp_display;
> +       u32 state;
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>
> +       mutex_lock(&dp_display->event_mutex);
> +
> +       state = dp_display->hpd_state;
> +       if (state != ST_DISCONNECT_PENDING && state != ST_CONNECTED) {

It's concerning that we have to check this at all. Are we still
interjecting into the disable path when the cable is disconnected?

> +               mutex_unlock(&dp_display->event_mutex);
> +               return;
> +       }
> +
>         dp_ctrl_push_idle(dp_display->ctrl);
> +       mutex_unlock(&dp_display->event_mutex);
