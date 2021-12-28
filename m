Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E39F480CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhL1Stp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbhL1Stn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:49:43 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 10:49:43 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so6298959oog.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 10:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eXhwfFLm6xuRXH07dJ43yJ+pTlr8xJ8+NlyVlndnfCM=;
        b=tsMCTyQL8yJvHEdjhTZNmLbJ57UAa8DmU4t+AJIjvr371gGhUD4TpfUfYQ+wQ74Imv
         GaoTxx0a03liOrWDFTeLIJCz1QWWvFJ0G6VIj7rkBgnwyPISmapj8NcRCURqS5IQ7I/b
         h8pLQWqR15McqilHIGRd9jtVaklDqDJRvrIC5hueGCx4lw0QBN/tFoe4Hbp9z4QxCkb5
         C1seEJxP7fvY6+cfZh4ZxgXtihTJjJP5yHQfR3pcueda7gQu0CypJ/kHPJVXWCsbN7hB
         iOezJZgrSR1fEP5Y+xvs8FkNRG0xJcHg6n8H/elrrOeVVr+F83OilwPLezSr1XU7Kha4
         t8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXhwfFLm6xuRXH07dJ43yJ+pTlr8xJ8+NlyVlndnfCM=;
        b=W2zdAPuSNhpaEArxuJNam0KFJkK97alBWDMtHAj9gPmADp+T568Q2RkEAnuO+hviQa
         O2Qa00Lqr7rfztV0jKoLNKxzvld2NayAPQ+vUf+3kKJKI2U1MdE10MCpXBTwL7msEV/7
         JbbSDUf/aDfoTjJ6/wCLQh4FhH7YsAqZM+nNVC8nb9X/wJeoN6FAPeSh8Ra2KWZMpjFm
         pmMf6IT/WYKyEpM9EeGiL2doLbzmtfmVWcbGrwjNjRx+mzBRfga+JyB7X9xBlYjKFSLA
         Dvz8AjSL9xF4djJv1CBfIzFw6ZMv4lP9TpONJSN+dDzSgWLefitTJDNU9olzF/+9EHfl
         EG7Q==
X-Gm-Message-State: AOAM533HMBioC2S/hOThtzppHuCzTVwTSiMM6Iu9LouQTAhpO/78/q9X
        o+WGGhFueU1FxSa1jsWxdEfozw==
X-Google-Smtp-Source: ABdhPJxFcz2lm2/hfGgOO3cwto/v7M4ze2hWUHK5rd5mQN6CYOKVEj4fK2UGpbvGa7fyTR5s1kvLFA==
X-Received: by 2002:a4a:a4c9:: with SMTP id c9mr14129371oom.21.1640717382428;
        Tue, 28 Dec 2021 10:49:42 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 90sm3133883otn.59.2021.12.28.10.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 10:49:42 -0800 (PST)
Date:   Tue, 28 Dec 2021 10:50:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: populate connector of struct  dp_panel
Message-ID: <Yctcgslq283lZXW/@ripper>
References: <1640713908-7453-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640713908-7453-1-git-send-email-quic_khsieh@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Dec 09:51 PST 2021, Kuogee Hsieh wrote:

> There is kernel crashed happen due to unable to handle kernel NULL

It would be wonderful, for my understanding today, as well as people in
the coming months to be able to search for the callstack etc on the
mailing list, if you could provide some details about the crash.

E.g. a callstack or description of when it happens.

> pointer dereference  of dp_panel->connector while running DP link
> layer compliance test case 4.2.2.6 (EDIDCorruption Detection).
> This patch will fixed the problem by populating connector of dp_panel.
> 
> Fixes: 7948fe12d47 ("drm/msm/dp: return correct edid checksum after corrupted edid checksum read")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 71db10c..6a938a2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -197,6 +197,8 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
>  	kfree(dp_panel->edid);
>  	dp_panel->edid = NULL;
>  
> +	dp_panel->connector = connector;

So you have a dp_display_private object with a panel and a connector
allocated, but before you manage to associate the two you get a HPD
event and call this function, so you decide to stitch the two together
just here in some piece of code unrelated to the initialization of your
objects?

It sounds like we're lacking synchronization between the initialization
and the HPD interrupts and this would not be the correct solution.

Regards,
Bjorn

> +
>  	dp_panel->edid = drm_get_edid(connector,
>  					      &panel->aux->ddc);
>  	if (!dp_panel->edid) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
