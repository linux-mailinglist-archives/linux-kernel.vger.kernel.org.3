Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9E52F7AF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 04:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354372AbiEUCnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiEUCnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 22:43:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B351737DC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 19:43:50 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4nvf1pHSzhYsK;
        Sat, 21 May 2022 10:43:10 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 10:43:48 +0800
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <dmitry.baryshkov@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220506123246.21788-1-yuehaibing@huawei.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b5e6ca38-00c2-a58a-ee73-f0795233bcba@huawei.com>
Date:   Sat, 21 May 2022 10:43:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20220506123246.21788-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2022/5/6 20:32, YueHaibing wrote:
> While CONFIG_OF is n but COMPILE_TEST is y, we got this:
> 
> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>   Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
>   Selected by [y]:
>   - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
> 
> Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning.
> 
> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix this in DRM_DP_AUX_BUS dependencies
> ---
>  drivers/gpu/drm/display/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> index 1b6e6af37546..09712b88a5b8 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -3,7 +3,7 @@
>  config DRM_DP_AUX_BUS
>  	tristate
>  	depends on DRM
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  
>  config DRM_DISPLAY_HELPER
>  	tristate
> 
