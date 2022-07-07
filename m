Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055256AE66
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiGGW2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiGGW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:28:13 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B335065D47;
        Thu,  7 Jul 2022 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657232892; x=1688768892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bxnC823s2jQTCTW1F00fQ9L9FPUuS6prikA03g2KwGA=;
  b=eptQZV1e5MDhcuFHnnFT1cN7FmslzPoUBhOd9hgdCJJWgJtZmJlzs/cG
   YWd1TWgUgfzcXzAxjkcSI+EA+RB8vV1PXrFpJtbCiafy3iKGeRluuO72w
   zkerOMMUO8aGFHdG5xf0KsI+SIuvRICKUpq3aPWArzZwBM3H9cnOoRAsa
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jul 2022 15:28:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 15:28:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 15:28:11 -0700
Received: from [10.111.163.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 15:28:09 -0700
Message-ID: <5112b6fd-32c3-c447-61e1-828d5a0aa7c6@quicinc.com>
Date:   Thu, 7 Jul 2022 15:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Fix for non-visible planes
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        Fernando Ramos <greenfoo@u92.eu>,
        Mark Yacoub <markyacoub@google.com>
References: <20220707212003.1710163-1-robdclark@gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220707212003.1710163-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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



On 7/7/2022 2:20 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes `kms_cursor_crc --run-subtest cursor-offscreen`.. when the cursor
> moves offscreen the plane becomes non-visible, so we need to skip over
> it in crtc atomic test and mixer setup.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Will pick up the fixes tag from Dmitry's r-b.
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 4dd0ce09ca74..4ba000951a90 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -422,6 +422,9 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   		if (!state)
>   			continue;
>   
> +		if (!state->visible)
> +			continue;
> +
>   		pstate = to_dpu_plane_state(state);
>   		fb = state->fb;
>   
> @@ -1195,6 +1198,9 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>   		if (cnt >= DPU_STAGE_MAX * 4)
>   			continue;
>   
> +		if (!pstate->visible)
> +			continue;
> +
>   		pstates[cnt].dpu_pstate = dpu_pstate;
>   		pstates[cnt].drm_pstate = pstate;
>   		pstates[cnt].stage = pstate->normalized_zpos;
