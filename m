Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7358251DC98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443202AbiEFP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443087AbiEFPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:55:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F2B59BAD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651852333; x=1683388333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wcCqtZEPwF4j+NJY+GsjG63IidZrMrfgVo1P2Q6mh+Q=;
  b=OfqlgN4rNvF+YeU9HhYU+8NiQsjoOV2aCXPJXIQErrFCLSgnZm/zKOsp
   2XimRXm/R6rbraWsoMEQKY2tC9t+ier+WKdok10pkKSK2Cw0GtDNddCrt
   bh2nbUKXUX0iZiXOlzpz8i6z9KVLgus6b24NsrYHyNL720T+oPuFpl8Fs
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 May 2022 08:52:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:52:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 08:52:12 -0700
Received: from [10.111.168.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 08:52:10 -0700
Message-ID: <df0fd0ea-96db-ec4c-2271-280bd8bcdf79@quicinc.com>
Date:   Fri, 6 May 2022 08:52:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20220506123246.21788-1-yuehaibing@huawei.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220506123246.21788-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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



On 5/6/2022 5:32 AM, YueHaibing wrote:
> While CONFIG_OF is n but COMPILE_TEST is y, we got this:
> 
> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
>    Selected by [y]:
>    - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
> 
> Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning.
> 
> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> v2: fix this in DRM_DP_AUX_BUS dependencies
> ---
>   drivers/gpu/drm/display/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> index 1b6e6af37546..09712b88a5b8 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -3,7 +3,7 @@
>   config DRM_DP_AUX_BUS
>   	tristate
>   	depends on DRM
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>   
>   config DRM_DISPLAY_HELPER
>   	tristate
