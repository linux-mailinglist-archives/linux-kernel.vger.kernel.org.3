Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9E502F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348590AbiDOTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbiDOTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:45:39 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1F50E3D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:43:09 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so1508438oof.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=d8U0beeOnRgpffBKA26u/nuFILvGpJKtOOLZ6tEr+hI=;
        b=OubeX/VjHjycjXmUUBY+EXLYUTjpyMeN0CjFecikN3Os5nY3jnDY+L58kLzteBD8dX
         oqZ3xQmv29vpTtqEYXNB3e40dIGNWI+0MWGRrnEz0h4E1VFSePJpyva9XXw0HZl4abrM
         TLeEKUhj9bEmKU6XZ/q3dcpwQAZtzq+Kgl2Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=d8U0beeOnRgpffBKA26u/nuFILvGpJKtOOLZ6tEr+hI=;
        b=7/vc5hqz1eqGdLZ2dPjpLBBPE9YhRWqfwyxC10RDK0adm1VyCBfEI3K0wKtznreM0O
         UmZKsX0UI6ETOdIWDP4Ntn/61t4U6zsgH4YjAexL8n6KsbNK5o4Lhzx0/Vq2v8D8Z1c6
         CD+tl64NNuWCJUAhz3hOZ2xJv38Cj0SIcD387pbCWpFZr2W47OSeEImLeR1a5gyGLWTp
         vu/CpvpR50lUREu9Rir6kv+gRdya1p2sCJoa6Dw5VFg7Ujl+ZVzgEymUMXubFeTXGluI
         oqkPwfLUfQA+Tt3toJ/hF3UglceanxSSvK8B5TrMFTaXowCoGaAYayPPfGM2Hie10eiS
         fNhw==
X-Gm-Message-State: AOAM531v+JfGSVMg2RINPbk3ikb6Ed9i23+MetoeMMK9AsJ/cztfx+yg
        Ch4tMGHWhqPsnbZx2zGRzPcjMjYVFhfDyWtaHq85jA==
X-Google-Smtp-Source: ABdhPJwfzYrDMaHMqxqa+9iMCFn6F9al3KfQl7uVpDg7xlLlpCKzQ+uq2y0In5Wy24FshAbV42giP5SSmXcgRFrWLpY=
X-Received: by 2002:a4a:6b49:0:b0:329:99cd:4fb8 with SMTP id
 h9-20020a4a6b49000000b0032999cd4fb8mr196501oof.25.1650051788795; Fri, 15 Apr
 2022 12:43:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Apr 2022 12:43:08 -0700
MIME-Version: 1.0
In-Reply-To: <1650037276-27812-1-git-send-email-quic_khsieh@quicinc.com>
References: <1650037276-27812-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 15 Apr 2022 12:43:08 -0700
Message-ID: <CAE-0n52aQdKUYojgGM+C-FEJeEzuRrHCNSBM8rUDxh+Qp-FUnA@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/dp: stop event kernel thread when DP unbind
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-15 08:41:16)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 01453db..92c9819 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -230,6 +231,14 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
>         complete_all(&dp->audio_comp);
>  }
>
> +static void dp_hpd_event_thread_stop(struct dp_display_private *dp_priv)
> +{
> +       kthread_stop(dp_priv->ev_tsk);
> +
> +}
> +
> +static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv);
> +
>  static int dp_display_bind(struct device *dev, struct device *master,
>                            void *data)
>  {
> @@ -280,6 +290,9 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>         struct drm_device *drm = dev_get_drvdata(master);
>         struct msm_drm_private *priv = drm->dev_private;
>
> +       /* disable all HPD interrupts */
> +       dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
> +       dp_hpd_event_thread_stop(dp);

It's a one line function. How about just

	kthread_stop(dp->ev_tsk)

>         dp_power_client_deinit(dp->power);
>         dp_aux_unregister(dp->aux);
>         priv->dp[dp->id] = NULL;
