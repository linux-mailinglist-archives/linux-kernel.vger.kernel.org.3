Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9184E6838
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbiCXR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352437AbiCXR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:59:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9D45789;
        Thu, 24 Mar 2022 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648144701; x=1679680701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mrbgLvlsjdW9rx9HY/2WDm9oF7weTNiBspzAy++1AVA=;
  b=TzTFHEZOy8FoYnN7HPs5eNBpL/c0bgZ38K8K5Fzms63fSVtWRD0YQOu5
   sFTzs5N9tDgDyxeYACb7/FOwXXaIACJQ8FtBmg9Z24x4yUxlAfM+FfPMy
   EKha75HVH9qHXoQdvin2BKXMPiWexH/5k09I8IIPcWxCVJSxhzwe7WwkK
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Mar 2022 10:58:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 10:58:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 10:58:18 -0700
Received: from [10.110.52.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 10:58:18 -0700
Message-ID: <4a23c6a6-737a-c910-588b-8d4827d9560c@quicinc.com>
Date:   Thu, 24 Mar 2022 10:58:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/mdp5: check the return of kzalloc()
Content-Language: en-US
To:     <xkernel.wang@foxmail.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <tencent_F71D40EE9851737338A6289EC3A3942EFE09@qq.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <tencent_F71D40EE9851737338A6289EC3A3942EFE09@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 1:36 AM, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index c6b69af..5f914cc 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -90,15 +90,18 @@ static void mdp5_plane_reset(struct drm_plane *plane)
>   		__drm_atomic_helper_plane_destroy_state(plane->state);
>   
>   	kfree(to_mdp5_plane_state(plane->state));
> -	mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
> +	plane->state = NULL;
>   
> -	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
> -		mdp5_state->base.zpos = STAGE_BASE;
> -	else
> -		mdp5_state->base.zpos = STAGE0 + drm_plane_index(plane);
> -	mdp5_state->base.normalized_zpos = mdp5_state->base.zpos;
> +	mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
> +	if (mdp5_state) {
> +		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
> +			mdp5_state->base.zpos = STAGE_BASE;
> +		else
> +			mdp5_state->base.zpos = STAGE0 + drm_plane_index(plane);
> +		mdp5_state->base.normalized_zpos = mdp5_state->base.zpos;
>   
> -	__drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
> +		__drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
> +	}
>   }
>   
>   static struct drm_plane_state *
