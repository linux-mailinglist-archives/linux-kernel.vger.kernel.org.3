Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1393480DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhL1XL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbhL1XL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:11:28 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6BDC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:11:28 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so26170692otg.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QJatUqtrqh2u+VQ/YEVsxnrHJlj+/BrTRHbzfVft99w=;
        b=lqkilty6YJQ1GjHtPQzpLJtQ3DiUkzKB4wNlcIoixTL8Bi1PYowZY6V0KjQh60SlXi
         NWIzka+giCnGfLHgBA12GV0CMRk48HAlTIPHP4viQV8K8lfwWYZ3hwpWTKf1ZE5TYzX/
         2pikMyyMySkKvU+eG9JFxmYMKaw/phzBKQ46NU0QWPGB4HK8B30lVgIoa7JgUMHCFZot
         F6e7/7uRG9Z9SA6v4ztKE6RHQOs2t4icWTZ7fAgHrAWfzXK9oRvS42wfdXHImPgLdRWc
         UOYpr8PFxM81Yz6fXQLh3bfd0zOjOt3ZQcj8EoODoMt/GUjboz6SD1tLcoNTRttnIqdL
         NwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJatUqtrqh2u+VQ/YEVsxnrHJlj+/BrTRHbzfVft99w=;
        b=4zNj/kS+vpVGYpy1hylE2TcaxCKBnUrPo9AV2HKmFHc0wLjgwXpVoQyVotDgycDj4x
         133JDXp6OzZR3wF4IXbozS7qJjEyRltHv8gfNCofzAS6mkqMUMfaK1eGa4qBjP4jTIME
         qzWYnHhhljEb9wxCBd8R7kq39Fdj4pwtxQxTZCoD/f07RbHIAxRDisDmOUPdLtDAM1QN
         qlTNh2wriat3tWBo+CXhfOiOG6oNTrAocRSSqHUXh+skC6QpPS4Ns6SHFNo+CxWFVDNm
         3kVZN+SDm64LA0WH9H1iXmUNB/ALY8r0m5X1O+L2LX4AQIU15IhpBZ0iUaiOQhnT9Wsi
         XMyw==
X-Gm-Message-State: AOAM5319WFU5dzaDDIODMv/4XxREuO/nhFP9n0wZD2LO5j0SQYNq6Shv
        ehO8xJBxkNZDlWiiiHgFHD67fQ==
X-Google-Smtp-Source: ABdhPJwH8iu/90QsiUNBVr78Y45xQO15a26mtV1pK6pLYmCJ5Ecawo2PscMep3kzBxC6RJzSDRQwdA==
X-Received: by 2002:a9d:200f:: with SMTP id n15mr16820098ota.66.1640733087117;
        Tue, 28 Dec 2021 15:11:27 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a6sm4198301oil.6.2021.12.28.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 15:11:26 -0800 (PST)
Date:   Tue, 28 Dec 2021 15:12:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuogee Hsieh <khsieh@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: add support of tps4 (training pattern 4) for
 HBR3
Message-ID: <YcuZ29QV+hfJprSl@ripper>
References: <1640717489-7366-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640717489-7366-1-git-send-email-quic_khsieh@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Dec 10:51 PST 2021, Kuogee Hsieh wrote:

> From: Kuogee Hsieh <khsieh@codeaurora.org>
> 
> Some DP sinkers prefer to use tps4 instead of tps3 during training #2.
> This patch will use tps4 to perform link training #2 if sinker's DPCD
> supports it.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 39558a2..c7b0657 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1181,7 +1181,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>  			int *training_step)
>  {
>  	int tries = 0, ret = 0;
> -	char pattern;
> +	char pattern, state_ctrl_bit;
>  	int const maximum_retries = 5;
>  	u8 link_status[DP_LINK_STATUS_SIZE];
>  
> @@ -1189,12 +1189,20 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>  
>  	*training_step = DP_TRAINING_2;
>  
> -	if (drm_dp_tps3_supported(ctrl->panel->dpcd))
> +	if (drm_dp_tps4_supported(ctrl->panel->dpcd)) {
> +		pattern = DP_TRAINING_PATTERN_4;
> +		state_ctrl_bit = 4;
> +	}
> +	else if (drm_dp_tps3_supported(ctrl->panel->dpcd)) {
>  		pattern = DP_TRAINING_PATTERN_3;
> -	else
> +		state_ctrl_bit = 3;
> +	}
> +	else {
>  		pattern = DP_TRAINING_PATTERN_2;
> +		state_ctrl_bit = 2;
> +	}
>  
> -	ret = dp_catalog_ctrl_set_pattern(ctrl->catalog, pattern);
> +	ret = dp_catalog_ctrl_set_pattern(ctrl->catalog, state_ctrl_bit);

The patch looks good, but as the state_ctrl_bit is no longer equal to
DP_PATTERN_n the function and argument names are misleading.

Please rename it to something like
"dp_catalog_ctrl_set_pattern_state_bit()" and the "pattern" argument
within that function to "state_bit".

Thanks,
Bjorn

>  	if (ret)
>  		return ret;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
