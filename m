Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAF49A155
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359443AbiAXXch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456647AbiAXWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:39:52 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA02C04D61D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:04:20 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so8270024otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JYiLYol9mvWoC/k9SlBNW3f4S6peoi+xmexnQLDaAHc=;
        b=HsuuTxhscaoAqtQaDrdwBqOr+pYZMN4w2SA8Q7gzbGeDVQlpfcRDDYbqoI1eGaw4HH
         tqzC8Rw8Wq9AFXlLETHFjUOJ/Kd57+8avtXJcdQl+Zk2xnWWSjvNGfjrKmB1mjc9h3G/
         J51AFEegRcmcOXWbI+rmYoSKJy7YCRzp/zMxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JYiLYol9mvWoC/k9SlBNW3f4S6peoi+xmexnQLDaAHc=;
        b=V5JuFevwKvfVhdY0gN82jg4/VfrRxiGjzO8mW9Eoz9h7/g4Il3EXFC9ESIWSA/X++L
         8d9rBCDOO/oF0pPDhlmAsEmWsohSWw9tUoANh6U3f209NYSUu1DkvFBje5q4Q6yzsV1d
         XHDowfBhtrEl2V040tn5CNJblXczGJCRAXnNtAv8EDoGssnRsZK0FVtV4qElbnnnG1+K
         cTh3qE1QQk6jBS8GmdQz8gnP5/Qf5Gw0rFqZAznjB2qdGlVMicwgDYNP4papy/ZPBFJt
         nvwzYbQ2CEUiLuP94JIpK6Ocda8eabyDZ+OS7+zcI34YAc3InAC4xj8BdApwXUTsOelH
         RJfQ==
X-Gm-Message-State: AOAM532tokHHmFaROLCnAXDPQ98+8VqfeZCZcBfc42iBRU/IxuyRuqB1
        zVmJ2TlsqXb5GiLQVPYPOHeIPoZunAMF5DMS514NPA==
X-Google-Smtp-Source: ABdhPJzWss7XOnvh73u3Bx1WcknT+UoYuzDwWnibDZtvmdSPqZExl7hcfY2zpEl1b5NjqqKETJt01WEhiJ/eialMpxs=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr6213128ots.159.1643058259360;
 Mon, 24 Jan 2022 13:04:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 13:04:18 -0800
MIME-Version: 1.0
In-Reply-To: <1643057170-10413-1-git-send-email-quic_khsieh@quicinc.com>
References: <1643057170-10413-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 13:04:18 -0800
Message-ID: <CAE-0n53nFcMzuKfqVRac6PRTkoPrftXL+uVK56ZQsHVWHmivkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: always add fail-safe mode into connector mode list
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-24 12:46:10)
> Some of DP link compliant test expects to return fail-safe mode
> if prefer detailed timing mode can not be supported by mainlink's
> lane and rate after link training. Therefore add fail-safe mode
> into connector mode list as backup mode. This patch fixes test
> case 4.2.2.1.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Any Fixes tag? I also wonder why this isn't pushed into the DP core code
somehow. Wouldn't every device need to add a 640x480 mode by default?

> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 3b02922..7743b45 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -221,6 +221,11 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
>                 if (drm_add_modes_noedid(connector, 640, 480))
>                         drm_set_preferred_mode(connector, 640, 480);
>                 mutex_unlock(&connector->dev->mode_config.mutex);
> +       } else {
> +               /* always add fail-safe mode as backup mode */
> +               mutex_lock(&connector->dev->mode_config.mutex);
> +               drm_add_modes_noedid(connector, 640, 480);
> +               mutex_unlock(&connector->dev->mode_config.mutex);
>         }
>
>         if (panel->aux_cfg_update_done) {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
