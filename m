Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126914CBA14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiCCJWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiCCJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:22:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE116BCD6;
        Thu,  3 Mar 2022 01:21:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D15781F4537A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646299309;
        bh=Oe2pV1nTwtl1ZAeBq7ptzCBBqpUgYg8U9OQ8spRg7k0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kxwvKdJAr8t3ibeUYyY3yZwFjajIrc8P7Izj4oGXdVD8DepEDb8cHlC6SQHcUe1+6
         P5wGoTx1r7580zSAScrN+FoSMg4nK1kc+Fgmz3YnDKHYHFW5erqwKkfCNF4U0af5ai
         69xDhPXEgIYTW4uFXwOIqY0Ef1Jr8KYiRT/Fjfdm1216hApVM0PU+0TKPWSzNfDtKq
         DyslyhiFTfwRe/3qTRGRB++2ApHP5qAZkP21+hqNqdmz+euw1ZlrArm5QJNTRwXiY2
         wqhx33a2wZqYobw/xwc/InZYoztSn7aOsMLZ3nhANidG5f9l2kcEM0jwDOTjF3Xujm
         QGKio3vllwnFw==
Message-ID: <373491a2-0fa5-0326-29cd-1650f86202d4@collabora.com>
Date:   Thu, 3 Mar 2022 10:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 07/10] drm/msm/adreno: Retry on gpu resume failure
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
References: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220302225551.v1.7.I55e39e28375b64455d1605f67453d5e91b0c2710@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220302225551.v1.7.I55e39e28375b64455d1605f67453d5e91b0c2710@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/03/22 18:27, Akhil P Oommen ha scritto:
> Retry infinitely on resume failure because there is nothing much we can
> do if GPU is not ON. Also, this helps us to avoid checking for the
> return value of pm_runtime_get() to see if GPU is ON.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 89cfd84..abcc553 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -603,8 +603,16 @@ static const struct of_device_id dt_match[] = {
>   static int adreno_resume(struct device *dev)
>   {
>   	struct msm_gpu *gpu = dev_to_gpu(dev);
> +	int ret;
> +
> +	/* What hope do we have for the future if we can't turn ON gpu */

Hello Akhil,

the hope for the future would be to at least not lock up everything with
an infinite loop, so, please change this to have a limited amount of retries.

My guess would be that a maximum of 10 is already a lot of retries, but
feel free to choose an appropriate number.

Regards,
Angelo

> +	while (true) {
> +		ret = gpu->funcs->pm_resume(gpu);
> +		if (!ret)
> +			break;
> +	}
>   
> -	return gpu->funcs->pm_resume(gpu);
> +	return 0;
>   }
>   
>   static int active_submits(struct msm_gpu *gpu)


