Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A44FB35D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiDKF5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiDKF5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:57:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999C33A26;
        Sun, 10 Apr 2022 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649656533; x=1681192533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p9HXYw/ALt+MopqQNrusnXpB/e7Lu7tHls88nUVRk1Q=;
  b=QcRVSt6R79v20L1QwpL+LLtsoOjO3j2CEb+SeUma3+6sIc3r9+LCt0+s
   1Vt1Tv+YUbBauWnaIeMlHIM1uteoM2s7g6tzgWBo8vRr9jUYMfSTT+6FD
   DLRo28e/5YPsa4oOkHixAUL1m+n6G+/HDTk2/gBCjLEVTFESB0SYpDtzg
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Apr 2022 22:55:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 22:55:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 10 Apr 2022 22:55:31 -0700
Received: from [10.111.167.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 10 Apr
 2022 22:55:29 -0700
Message-ID: <adb5b728-d1e3-022d-62fa-1f7278e63e41@quicinc.com>
Date:   Sun, 10 Apr 2022 22:55:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dsi: Use connector directly in
 msm_dsi_manager_connector_init()
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>, "Sean Paul" <sean@poorly.run>
CC:     <linux-kernel@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Sean Paul <seanpaul@chromium.org>
References: <20220318000731.2823718-1-swboyd@chromium.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220318000731.2823718-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/2022 5:07 PM, Stephen Boyd wrote:
> The member 'msm_dsi->connector' isn't assigned until
> msm_dsi_manager_connector_init() returns (see msm_dsi_modeset_init() and
> how it assigns the return value). Therefore this pointer is going to be
> NULL here. Let's use 'connector' which is what was intended.
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Fixes: 6d5e78406991 ("drm/msm/dsi: Move dsi panel init into modeset init path")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> 
> I don't know if this is superseeded by something else but I found this
> while trying to use the connector from msm_dsi in this function.
> 
>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 0c1b7dde377c..9f6af0f0fe00 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -638,7 +638,7 @@ struct drm_connector *msm_dsi_manager_connector_init(u8 id)
>   	return connector;
>   
>   fail:
> -	connector->funcs->destroy(msm_dsi->connector);
> +	connector->funcs->destroy(connector);
>   	return ERR_PTR(ret);
>   }
>   
> 
> base-commit: 05afd57f4d34602a652fdaf58e0a2756b3c20fd4
