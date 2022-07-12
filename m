Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE36C5711AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiGLFFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGLFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:05:08 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5D2A947;
        Mon, 11 Jul 2022 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657602304; x=1689138304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=17Z3xulwqXW1QfY/QEzxXBPkNTk6rcH+8iLrHGYb9Gc=;
  b=nMKl+JYsmhP0fxQaA5vxiY+CMDMyvebMO7iTgHsCX76WHfWxV5jIhAVb
   UFBfMDLto7dtxqhE+pHoQo1CokouS0K9b55rHxss/5au/LNy9L5WrvPks
   3spVHFCz9z5XKGp/C1JtYMIweRobtZ0yUKrLB9kRqSQyGKz+jMYKmpFKJ
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Jul 2022 22:05:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 22:05:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Jul 2022 22:05:02 -0700
Received: from [10.216.10.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Jul
 2022 22:04:56 -0700
Message-ID: <1299312f-e614-e4e2-72cb-fd7fb99922ce@quicinc.com>
Date:   Tue, 12 Jul 2022 10:34:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH v2 3/7] drm/msm: Fix cx collapse issue during
 recovery
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Sean Paul <sean@poorly.run>, Jonathan Marek <jonathan@marek.ca>,
        "David Airlie" <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Jordan Crouse" <jordan@cosmicpenguin.net>,
        freedreno <freedreno@lists.freedesktop.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220709112837.v2.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
 <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com>
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

On 7/12/2022 4:52 AM, Doug Anderson wrote:
> Hi,
>
> On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>> There are some hardware logic under CX domain. For a successful
>> recovery, we should ensure cx headswitch collapses to ensure all the
>> stale states are cleard out. This is especially true to for a6xx family
>> where we can GMU co-processor.
>>
>> Currently, cx doesn't collapse due to a devlink between gpu and its
>> smmu. So the *struct gpu device* needs to be runtime suspended to ensure
>> that the iommu driver removes its vote on cx gdsc.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
>>   drivers/gpu/drm/msm/msm_gpu.c         |  2 --
>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 4d50110..7ed347c 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1278,8 +1278,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
>>           */
>>          gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
>>
>> -       gpu->funcs->pm_suspend(gpu);
>> -       gpu->funcs->pm_resume(gpu);
>> +       /*
>> +        * Now drop all the pm_runtime usage count to allow cx gdsc to collapse.
>> +        * First drop the usage count from all active submits
>> +        */
>> +       for (i = gpu->active_submits; i > 0; i--)
>> +               pm_runtime_put(&gpu->pdev->dev);
>> +
>> +       /* And the final one from recover worker */
>> +       pm_runtime_put_sync(&gpu->pdev->dev);
>> +
>> +       for (i = gpu->active_submits; i > 0; i--)
>> +               pm_runtime_get(&gpu->pdev->dev);
>> +
>> +       pm_runtime_get_sync(&gpu->pdev->dev);
> In response to v1, Rob suggested pm_runtime_force_suspend/resume().
> Those seem like they would work to me, too. Why not use them?
Quoting my previous response which I seem to have sent only to Freedreno 
list:

"I believe it is supposed to be used only during system sleep state 
transitions. Btw, we don't want pm_runtime_get() calls from elsewhere to 
fail by disabling RPM here."

-Akhil
