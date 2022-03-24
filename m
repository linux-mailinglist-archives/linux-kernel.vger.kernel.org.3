Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5C4E682C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352412AbiCXR56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiCXR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:57:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50959A5C;
        Thu, 24 Mar 2022 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648144584; x=1679680584;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3WjmSUx8RaM4/QVWsCIY83coBlhfFkLNK0Bb6r9AgAQ=;
  b=T/kbSGfdzOl10jQLAB3g5Pqe4qnCzpNgoj44vJOKFxAPCSm0woF+MAlQ
   FXeXbhxBZnwkKYJiA1JRSgcAIf/1XcW7NivgkvzKb//M4ZRgMVsoRKHeX
   wUCmZXdk4BTuuXjyyCV5dDj8lO9iuzweaL7v3QBhAx+0hDYxPGsCugUS6
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2022 10:56:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 10:56:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 10:56:23 -0700
Received: from [10.110.52.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 10:56:22 -0700
Message-ID: <0f017516-58f4-f26e-d598-4be9311e2e27@quicinc.com>
Date:   Thu, 24 Mar 2022 10:56:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/disp: check the return value of kzalloc()
Content-Language: en-US
To:     <xkernel.wang@foxmail.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <tencent_B3E19486FF39415098B572B7397C2936C309@qq.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <tencent_B3E19486FF39415098B572B7397C2936C309@qq.com>
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



On 3/24/2022 2:15 AM, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> index cabe151..369e57f 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> @@ -169,6 +169,8 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
>   	va_list va;
>   
>   	new_blk = kzalloc(sizeof(struct msm_disp_state_block), GFP_KERNEL);
> +	if (!new_blk)
> +		return;
>   
>   	va_start(va, fmt);
>   
