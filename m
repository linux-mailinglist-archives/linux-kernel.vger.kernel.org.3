Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596A529C58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbiEQI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiEQI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:26:02 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81746F23
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:25:54 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r1so21469352oie.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qFyj5figDGQVFNUWmIzfj4DH6eo/m3Ta43JA6WzvT2c=;
        b=O3ps97EHSIwu0IuHVUjVpLTmRF7nNzrP+6cR37aR9UAJOkAvkCNANY0qTFVPksvWkL
         flbsM7GACfhNRO9+HE3f5hQrZ80I8U+gm3r/y1CQMl9zlMqZGFYkcA4HF6K3GMXQwecn
         Qcf+MEJ7B5c1TEE/NB45C2BVnbNqH2suwpi7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qFyj5figDGQVFNUWmIzfj4DH6eo/m3Ta43JA6WzvT2c=;
        b=RKLbTPtR20YL3yt5sMM2/uD63UVwP6sVwWbpm2HCTexMmfyGQuHiUKtmyLwQDNZvF+
         AXUoAmPbGXkqcfl5QBfmJxY2o2EBd0y9+yM0el120jfhSPpIH1bg9hsgH4I3Z38yrto/
         o8ER2U3y//By0Uj+GX+yNjmrKjQD81R8NYsNx+JOWgMCbExVOXJIyrTf+DnZ8ILrPMF5
         UDMGVdfRlLyVq5Flgszlr0SWirqpHLHFz0p7o0NdRlFGpzIBfkQhm3nXIMJDkCt1UXr1
         mGL1EVrqACg1LX6z6ayw/+4Ke953aqgfvhj/STcjnNPPoUZEKmxE+FwWRu/zkYMw5DGa
         7SLw==
X-Gm-Message-State: AOAM533ZLGwGVioTUgmKeY9RriZPSsAXGcvtYedoLpdgjjGt7AzpO/ha
        rLHDHqnnDP5KP3Upx5Hq4KucUXa3upMR7zC4+dKJUA==
X-Google-Smtp-Source: ABdhPJxs+1xc/Lw2u3NTSePNRBog18/DG6e9Xn3YMLc6OyuZxzAX8XTsp+t318WYkCDh7KJLL1WVJkbua4qZl8h/e38=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr9696354oiw.193.1652775953881; Tue, 17
 May 2022 01:25:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 May 2022 01:25:53 -0700
MIME-Version: 1.0
In-Reply-To: <1652384598-21586-1-git-send-email-quic_khsieh@quicinc.com>
References: <1652384598-21586-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 17 May 2022 01:25:53 -0700
Message-ID: <CAE-0n5277_-=ZYprmF6JcVfrnG0aZVXqXq092VS=mkDtrOB_wg@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/dp: Always clear mask bits to disable
 interrupts at dp_ctrl_reset_irq_ctrl()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-05-12 12:43:18)
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index af7a80c..f3e333e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1389,8 +1389,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
>
>         dp_catalog_ctrl_reset(ctrl->catalog);
>
> -       if (enable)
> -               dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
> +       /*
> +        * all dp controller programmable registers will not
> +        * be reset to default value after DP_SW_RESET
> +        * therefore interrupt mask bits have to be updated
> +        * to enable/disable interrupts
> +        */
> +       dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);

I think Dmitry requested that this part be split off to a different
patch. It's fixing the call to dp_ctrl_reset_irq_ctrl() for the disable
case.

>  }
>
>  void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..ab691aa 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -98,6 +98,8 @@ struct dp_display_private {
>         struct dp_ctrl    *ctrl;
>         struct dp_debug   *debug;
>
> +       bool suspended;
> +

Can we not have this flag? I also don't understand how this patch waits
for the event queue to drain. There are now multiple places we check to
see if we've suspended, but is it even possible to be in those places
during suspend? What is wrong with moving to an irq thread? Is it
because we want to wait for a modeset (EV_USER_NOTIFICATION)?

>         struct dp_usbpd_cb usbpd_cb;
>         struct dp_display_mode dp_mode;
>         struct msm_dp dp_display;
