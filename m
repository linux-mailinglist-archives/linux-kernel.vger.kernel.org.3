Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA8501F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbiDOAFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347862AbiDOAFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:05:21 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B264BDA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:02:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 12so7059014oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lFXIXGhjvQiAzcJjIJPH2ZocTakW8F4DCyIRzI8kZmQ=;
        b=a4UWMC3Ccy7fIO00COl5o++pPXzAJXp59uvvch6NqUugy5OUGyM4dqnLcYCxTtGTFs
         Exo5iNPWolW/pq+nOr9yCp7r5sCLhqMJnPCFdnFrD5QjBf8Qbyc/O8pcq8lKkzxRciu5
         DB5F212L1L9QUmqGCIfD5Cb2uIcmq/xP98dEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lFXIXGhjvQiAzcJjIJPH2ZocTakW8F4DCyIRzI8kZmQ=;
        b=LhvMXCtWYY9YH1rBT+NkhmqczbH/0kFH5/6B3YLf3iT9nUOTxpsfGdBEeL5X9Mq6rW
         OwJXMaa98nMcOQ1lKHQYSJbbonPQdJs9puyMYOKFVFglDlU3KlEDgy3zaW5ijgvNpd5A
         w4N6TmPEVAG9G8WHVPpC3+9OZVcGodf9xMuROlRSZTNWmN1UKN02Y50vAeNv1ZjhtUb0
         BJNXNLJ6uhaL/D697Ll79rPAhiELoHupB6MfpqJF5t0t9KH+9aqOPCA8VvSIgCNjj9iv
         4WGIS1bWHv+7vmIDnEdN9rn0ZtP953eHuE4Afzr4c/zsyT1PUVjLLFcDJ0699icJ04mv
         U2UA==
X-Gm-Message-State: AOAM531aCh+X86JS+4HE9423d3fqVov3x425KUnYwDibG1z+IlidxWQG
        VRzKgixx5zfEEMUHzro75IhKiQ0pb3aD6771KHPU4w==
X-Google-Smtp-Source: ABdhPJwI9zofyRE9RWr2YAteFhCYNo1cf6Ca5LBeolyDphWIQ4e7AZhm56lnYdqGmBbQIaHvNgr0o138d2iJdeIDoco=
X-Received: by 2002:a05:6808:10d4:b0:2fa:5fa6:e9c4 with SMTP id
 s20-20020a05680810d400b002fa5fa6e9c4mr467095ois.193.1649980974816; Thu, 14
 Apr 2022 17:02:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 17:02:54 -0700
MIME-Version: 1.0
In-Reply-To: <1649973079-5916-1-git-send-email-quic_khsieh@quicinc.com>
References: <1649973079-5916-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 17:02:54 -0700
Message-ID: <CAE-0n53jz9EZ=ry3+zh7KgyYLcF5dQoKeBwcXDQzq8wagyzRvg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/msm/dp: stop event kernel thread when DP unbind
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-14 14:51:19)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 01453db..baba95d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -230,6 +231,18 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
>         complete_all(&dp->audio_comp);
>  }
>
> +

One too many newlines

> +static void dp_hpd_event_thread_stop(struct dp_display_private *dp_priv)
> +{
> +       kthread_stop(dp_priv->ev_tsk);
> +
> +       /* reset event q to empty */
> +       dp_priv->event_gndx = 0;
> +       dp_priv->event_pndx = 0;
> +}

This can move after the start function?

> +
> +static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv);
> +
>  static int dp_display_bind(struct device *dev, struct device *master,
>                            void *data)
>  {

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
