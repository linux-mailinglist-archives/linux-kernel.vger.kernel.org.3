Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5F558794
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiFWSbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiFWSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:31:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C438B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656005576; x=1687541576;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+18geU6kgLSNuF8HqLH40DKFCzt6e4PapO6WZMaC8r4=;
  b=OpY7F7wD5rPSmk3uHiN9xWIQ4fvxrLMICqmVws9ErlXcFm1Hzu8W5luI
   KE7tQg8LOpCpSBksmI/uhaQiwGYn2vfCkmZ2iOxDKGEMJNufYCJO0DYdW
   znVcTUl7OInnbafVvSUh097v0GNGRSHGBnF+HI+PQaCg3SppT40/LWV9G
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jun 2022 10:32:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:32:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 23 Jun 2022 10:32:55 -0700
Received: from [10.111.161.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 10:32:53 -0700
Message-ID: <5736c38e-b262-0697-be77-b5126fe4d65b@quicinc.com>
Date:   Thu, 23 Jun 2022 10:32:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RESEND] drm/msm/dpu: Fix variable dereferenced before
 check
Content-Language: en-US
To:     sunliming <sunliming@kylinos.cn>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <kelulanainsley@gmail.com>,
        <freedreno@lists.freedesktop.org>,
        kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
References: <20220623012707.453972-1-sunliming@kylinos.cn>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220623012707.453972-1-sunliming@kylinos.cn>
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



On 6/22/2022 6:27 PM, sunliming wrote:
> Fixes the following smatch warning:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
> dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before check 'conn_state'
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for 
writeback")
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
