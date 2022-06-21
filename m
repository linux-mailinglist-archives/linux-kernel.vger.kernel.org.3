Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138CF553916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiFURnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiFURm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:42:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25231A81C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655833371; x=1687369371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=juFpBoX8mv2m0Y+Y+TyQ4uv/9T8Dpez6/NubB+3YFLU=;
  b=jUZBDZB0lOjHrVU7I6T61XcI2VghQuAVLBieT4reX8F+GwHtV1hH+QOA
   ydi1UjmFEqGApKDy59Bffvc8UOejuHDgvipQ1rjQoPjLS29i9fOv3d6TA
   sLdx57Jo3ahv8zx0Mx30sXGx+xBWTQgvhrmzg3Yfg4toe3VJcAqeEFIQL
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 10:42:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 10:42:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 10:42:50 -0700
Received: from [10.38.247.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 10:42:48 -0700
Message-ID: <d4b882ba-b773-5271-6050-416c8f3cad4b@quicinc.com>
Date:   Tue, 21 Jun 2022 10:42:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Fix variable dereferenced before check
Content-Language: en-US
To:     sunliming <sunliming@kylinos.cn>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <kelulanainsley@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220621110634.368913-1-sunliming@kylinos.cn>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220621110634.368913-1-sunliming@kylinos.cn>
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



On 6/21/2022 4:06 AM, sunliming wrote:
> Fixes the following smatch warning:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
> dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before check 'conn_state'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 59da348ff339..0ec809ab06e7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -252,11 +252,6 @@ static int dpu_encoder_phys_wb_atomic_check(
>   	DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
>   			phys_enc->wb_idx, mode->name, mode->hdisplay, mode->vdisplay);
>   
> -	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> -		return 0;
> -
> -	fb = conn_state->writeback_job->fb;
> -
>   	if (!conn_state || !conn_state->connector) {
>   		DPU_ERROR("invalid connector state\n");
>   		return -EINVAL;
> @@ -267,6 +262,11 @@ static int dpu_encoder_phys_wb_atomic_check(
>   		return -EINVAL;
>   	}
>   
> +	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> +		return 0;
> +
> +	fb = conn_state->writeback_job->fb;
> +
>   	DPU_DEBUG("[fb_id:%u][fb:%u,%u]\n", fb->base.id,
>   			fb->width, fb->height);
>   
