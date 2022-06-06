Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1ED53ED18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiFFRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFFRkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:40:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CA29E4FC;
        Mon,  6 Jun 2022 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654537239; x=1686073239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zESBcsC3q66fDUCxK78kqEowxXd5sdCuRRFUeC5plGY=;
  b=NQt9j21O1AfVYuLvhpPla1cGimW7w7CmyskBG5WRPF9F1Bd7UT4ZR9XP
   mRQkgc89gX+K93xs5UO3AzjZub6U0Fd18CKsnFS5qrlXqKiucrH7igLnB
   nZ//hUIkFrmy/9Toty7AkU4rA9U0Ih0mMi1pu/17+/NQUVB6rn+kLXUa5
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2022 10:40:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:40:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 10:40:38 -0700
Received: from [10.110.88.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 10:40:37 -0700
Message-ID: <68c6f375-5b11-98f2-83f5-1b481ea09ebd@quicinc.com>
Date:   Mon, 6 Jun 2022 10:40:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/2] drm/msm: enable msm irq after all initializations
 are done successfully at msm_drm_init()
Content-Language: en-US
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654291716-6603-1-git-send-email-quic_khsieh@quicinc.com>
 <1654291716-6603-2-git-send-email-quic_khsieh@quicinc.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <1654291716-6603-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will drop this patch since the problem had been fixed by Dmitry 
Baryshkov patch.

https://gitlab.freedesktop.org/drm/msm/-/commit/577e2a9dfc8fba7938aaf75db63fae7e328cc3cb



On 6/3/2022 2:28 PM, Kuogee Hsieh wrote:
> At msm initialize phase, msm_drm_init() is called to initialize modules
> sequentially. It will call msm_drm_uninit() to clean up initialized phase
> if any module initialization return failed. This patch move msm_irq_install()
> to the last step of msm_drm_init() after all modules are initialized successfully
> so that no msm_irq_unistall() required at msm_drm_uninit() if any module
> initialization failed happen at msm_drm_init().
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 29 ++++++-----------------------
>   1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 6665c5a..ab42e9a 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -132,15 +132,6 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
>   	return 0;
>   }
>   
> -static void msm_irq_uninstall(struct drm_device *dev)
> -{
> -	struct msm_drm_private *priv = dev->dev_private;
> -	struct msm_kms *kms = priv->kms;
> -
> -	kms->funcs->irq_uninstall(kms);
> -	free_irq(kms->irq, dev);
> -}
> -
>   struct msm_vblank_work {
>   	struct work_struct work;
>   	int crtc_id;
> @@ -232,10 +223,6 @@ static int msm_drm_uninit(struct device *dev)
>   
>   	drm_mode_config_cleanup(ddev);
>   
> -	pm_runtime_get_sync(dev);
> -	msm_irq_uninstall(ddev);
> -	pm_runtime_put_sync(dev);
> -
>   	if (kms && kms->funcs)
>   		kms->funcs->destroy(kms);
>   
> @@ -437,16 +424,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   		goto err_msm_uninit;
>   	}
>   
> -	if (kms) {
> -		pm_runtime_get_sync(dev);
> -		ret = msm_irq_install(ddev, kms->irq);
> -		pm_runtime_put_sync(dev);
> -		if (ret < 0) {
> -			DRM_DEV_ERROR(dev, "failed to install IRQ handler\n");
> -			goto err_msm_uninit;
> -		}
> -	}
> -
>   	ret = drm_dev_register(ddev, 0);
>   	if (ret)
>   		goto err_msm_uninit;
> @@ -467,6 +444,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   	if (ret)
>   		goto err_msm_uninit;
>   
> +	if (kms) {
> +		pm_runtime_get_sync(dev);
> +		msm_irq_install(ddev, kms->irq);
> +		pm_runtime_put_sync(dev);
> +	}
> +
>   	drm_kms_helper_poll_init(ddev);
>   
>   	return 0;
