Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB8555264
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376802AbiFVR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376330AbiFVR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:28:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F216257
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655918938; x=1687454938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zqnpY4X29rKyTvgX1mfr7bzlTooayOG6LmPdVgV081s=;
  b=MA4StN2FXn0xL2XjfVOPR8LtLuCAk3OB69FAas94zkv0RMMNew1WosrO
   gadIB8pZ8c3zOrSg1TMvcF4RYbHv8cG+TZFrt1f2oxxzkooB/iVGLogJw
   CDdNpIULMzWUpDWMNpvrflxKC0aiNMCfoJmgaQfZlA/Fo6agFjwIS/rEY
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 10:28:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:28:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 10:28:57 -0700
Received: from [10.111.161.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 10:28:55 -0700
Message-ID: <51c48862-967d-fcfa-d744-b234a091a834@quicinc.com>
Date:   Wed, 22 Jun 2022 10:28:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Fix variable dereferenced before check
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     sunliming <sunliming@kylinos.cn>, <robdclark@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kelulanainsley@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20220621110634.368913-1-sunliming@kylinos.cn>
 <d4b882ba-b773-5271-6050-416c8f3cad4b@quicinc.com>
 <955f881c-7731-a337-3ff9-e58863c41976@quicinc.com>
 <CAA8EJpreR2bk827Mb4doU5yf=Af-3djoJ=UiOomfsGmuV1MUhA@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpreR2bk827Mb4doU5yf=Af-3djoJ=UiOomfsGmuV1MUhA@mail.gmail.com>
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



On 6/21/2022 10:49 AM, Dmitry Baryshkov wrote:
> On Tue, 21 Jun 2022 at 20:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> Copying freedreno
> 
> The patch needs to be sent to freedreno@. Otherwise it doesn't exist
> in patchwork.

Ack

Hi Sunliming

Can you please re-send this and copy freedreno email list along with the 
Reviewed-by and Reported-by tags which I have given below?

Thanks

Abhinav

> 
>>
>> On 6/21/2022 10:42 AM, Abhinav Kumar wrote:
>>>
>>>
>>> On 6/21/2022 4:06 AM, sunliming wrote:
>>>> Fixes the following smatch warning:
>>>>
>>>> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
>>>> dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before
>>>> check 'conn_state'
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: sunliming <sunliming@kylinos.cn>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>
>>>> ---
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>>>> index 59da348ff339..0ec809ab06e7 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>>>> @@ -252,11 +252,6 @@ static int dpu_encoder_phys_wb_atomic_check(
>>>>        DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
>>>>                phys_enc->wb_idx, mode->name, mode->hdisplay,
>>>> mode->vdisplay);
>>>> -    if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
>>>> -        return 0;
>>>> -
>>>> -    fb = conn_state->writeback_job->fb;
>>>> -
>>>>        if (!conn_state || !conn_state->connector) {
>>>>            DPU_ERROR("invalid connector state\n");
>>>>            return -EINVAL;
>>>> @@ -267,6 +262,11 @@ static int dpu_encoder_phys_wb_atomic_check(
>>>>            return -EINVAL;
>>>>        }
>>>> +    if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
>>>> +        return 0;
>>>> +
>>>> +    fb = conn_state->writeback_job->fb;
>>>> +
>>>>        DPU_DEBUG("[fb_id:%u][fb:%u,%u]\n", fb->base.id,
>>>>                fb->width, fb->height);
> 
> 
> 
