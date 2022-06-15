Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6154C865
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbiFOMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348588AbiFOMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:23:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F93A1A2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:23:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so18601711lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8rUU1v4caE1AGNF+lS60izJAnVf3yfLugaHg1ivJmQQ=;
        b=G0WaETsHyn+zH1jan5g5fdKXYSbLSIGLfgZCngWeHK8SNc6nQaDLhLivMVUXnvlOTv
         j4gPVfyfvAz+71QqSBN+y91lg+zLaTokZAhllYwPwsCK7/ml459ODxQJCMOfUsXTuX3t
         24phzz2A2cO/wqpy9Cfq7Uyvzpd30CBu0tJ6U/ma4Ol39pEUANFas0cu+qBJR9+vtJym
         DPopdyECdgnP8WHtBZLiwlyRDDKcirwwmxibKWqcycj8pkqYLWrqfWLtV5jbnrMQkwlv
         2uY4eH6XkhHaUimOqIEBGDesWnkEPYdELMPnKw04x6Ab55rDraTSah6vX2q/VZog+RMX
         zM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8rUU1v4caE1AGNF+lS60izJAnVf3yfLugaHg1ivJmQQ=;
        b=zMlTeIErjPZV0cd1JyIXJn3hgmR6g2a8oSfV7K4kkQWZ3iPMjCGRDKqQzC49beC33E
         PjFCMNftl2np3jishkunvSB9bRzow28Q9scE5PuP8xXJj3P3wdYYnfUqP1xgl/WpbVsX
         pDay3CS9NiwF/a9GJB1XCWW2KDkHFNSjlW4s2ifMmN3XscA6ZCgqY9aisGOJH6h8lppF
         UuMMiMD3bqydboKdrmicJYZwtklkQFvbuYr2dGbsdTofk/CvjxffOwcGY4QYj5FlLygo
         fwcRmZr6OXv+1FpXk9HCJEWsnDJIfjnk1MyMnNe740F7ogEKFYR8deIh5huI99Kb61uH
         c6oA==
X-Gm-Message-State: AJIora+wUI76EkexK88Iy8u29FrKr1/bFkwEbvGk0Lb+UQoUvN2BEivN
        9Qj/xSdECrr4YBWCNGn2g0Ew9A==
X-Google-Smtp-Source: AGRyM1sxaiDNiyNPJgYfTRi01S0KUZbw4hqUs7vxcFmh4deHfpD4rJBiVYuquo3bmE4kDP6en8Kvxw==
X-Received: by 2002:a05:6512:3a84:b0:479:209a:578a with SMTP id q4-20020a0565123a8400b00479209a578amr5931900lfu.292.1655295825901;
        Wed, 15 Jun 2022 05:23:45 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e87c6000000b00255ac185029sm1672893ljj.30.2022.06.15.05.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:23:45 -0700 (PDT)
Message-ID: <29ae886c-b2b2-2387-87cb-e4a885080418@linaro.org>
Date:   Wed, 15 Jun 2022 15:23:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [v2] drm/msm: add null checks for drm device to avoid crash
 during probe defer
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, vpolimer@quicinc.com, swboyd@chromium.org,
        kalyant@quicinc.com
References: <1654249343-24959-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1654249343-24959-1-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 12:42, Vinod Polimera wrote:
> During probe defer, drm device is not initialized and an external
> trigger to shutdown is trying to clean up drm device leading to crash.
> Add checks to avoid drm device cleanup in such cases.
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual
> address 00000000000000b8
> 
> Call trace:
> 
> drm_atomic_helper_shutdown+0x44/0x144
> msm_pdev_shutdown+0x2c/0x38
> platform_shutdown+0x2c/0x38
> device_shutdown+0x158/0x210
> kernel_restart_prepare+0x40/0x4c
> kernel_restart+0x20/0x6c
> __arm64_sys_reboot+0x194/0x23c
> invoke_syscall+0x50/0x13c
> el0_svc_common+0xa0/0x17c
> do_el0_svc_compat+0x28/0x34
> el0_svc_compat+0x20/0x70
> el0t_32_sync_handler+0xa8/0xcc
> el0t_32_sync+0x1a8/0x1ac
> 
> Changes in v2:
> - Add fixes tag.
> 
> Fixes: 623f279c778 ("drm/msm: fix shutdown hook in case GPU components failed to bind")
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 4448536..d62ac66 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -142,6 +142,9 @@ static void msm_irq_uninstall(struct drm_device *dev)
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct msm_kms *kms = priv->kms;
>   
> +	if (!irq_has_action(kms->irq))
> +		return;

As a second thought I'd still prefer a variable here. irq_has_action 
would check that there is _any_ IRQ handler for this IRQ. While we do 
not have anybody sharing this IRQ, I'd prefer to be clear here, that we 
do not want to uninstall our IRQ handler rather than any IRQ handler.

> +
>   	kms->funcs->irq_uninstall(kms);
>   	if (kms->irq_requested)
>   		free_irq(kms->irq, dev);
> @@ -259,6 +262,7 @@ static int msm_drm_uninit(struct device *dev)
>   
>   	ddev->dev_private = NULL;
>   	drm_dev_put(ddev);
> +	priv->dev = NULL;
>   
>   	destroy_workqueue(priv->wq);
>   
> @@ -1167,7 +1171,7 @@ void msm_drv_shutdown(struct platform_device *pdev)
>   	struct msm_drm_private *priv = platform_get_drvdata(pdev);
>   	struct drm_device *drm = priv ? priv->dev : NULL;
>   
> -	if (!priv || !priv->kms)
> +	if (!priv || !priv->kms || !drm)
>   		return;
>   
>   	drm_atomic_helper_shutdown(drm);


-- 
With best wishes
Dmitry
