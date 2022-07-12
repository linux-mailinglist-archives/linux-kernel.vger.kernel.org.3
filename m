Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F75725C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiGLTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGLTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:39:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63799E8D92;
        Tue, 12 Jul 2022 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657653347; x=1689189347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+b+lgaK3YASEo+tcVLtUlg/6iXgxr/IhFSh7iGYLsSs=;
  b=RN7vfW1Lx1aTX6x/nVWfDcPa/r62nDGMK5IYN9mUpf1xme3Pi7sETw10
   Alc5Ht4iTZWW5WVhF/u2ld+eyB0+fm3sCIi6F5NnQAJ4s3+FF9wUc0ylM
   79jDNxSUE+i/tmv3E6KfG4/CXmWGAFFTUDhV2hP7JbJY/pmCtRGZjsc4Z
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jul 2022 12:15:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:15:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 12:15:45 -0700
Received: from [10.216.25.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 12:15:38 -0700
Message-ID: <3c150bc9-68a0-7a35-6511-f80a42e8945b@quicinc.com>
Date:   Wed, 13 Jul 2022 00:45:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH v2 3/7] drm/msm: Fix cx collapse issue during
 recovery
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
CC:     Doug Anderson <dianders@chromium.org>, Sean Paul <sean@poorly.run>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        freedreno <freedreno@lists.freedesktop.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220709112837.v2.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
 <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com>
 <1299312f-e614-e4e2-72cb-fd7fb99922ce@quicinc.com>
 <CAF6AEGvjD3LRm40mPr4n+jzx71WmwYpVWizUDLct9cgafjFRyw@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAF6AEGvjD3LRm40mPr4n+jzx71WmwYpVWizUDLct9cgafjFRyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/12/2022 10:14 PM, Rob Clark wrote:
> On Mon, Jul 11, 2022 at 10:05 PM Akhil P Oommen
> <quic_akhilpo@quicinc.com> wrote:
>> On 7/12/2022 4:52 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>> There are some hardware logic under CX domain. For a successful
>>>> recovery, we should ensure cx headswitch collapses to ensure all the
>>>> stale states are cleard out. This is especially true to for a6xx family
>>>> where we can GMU co-processor.
>>>>
>>>> Currently, cx doesn't collapse due to a devlink between gpu and its
>>>> smmu. So the *struct gpu device* needs to be runtime suspended to ensure
>>>> that the iommu driver removes its vote on cx gdsc.
>>>>
>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>> ---
>>>>
>>>> (no changes since v1)
>>>>
>>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
>>>>    drivers/gpu/drm/msm/msm_gpu.c         |  2 --
>>>>    2 files changed, 14 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index 4d50110..7ed347c 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -1278,8 +1278,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
>>>>            */
>>>>           gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
>>>>
>>>> -       gpu->funcs->pm_suspend(gpu);
>>>> -       gpu->funcs->pm_resume(gpu);
>>>> +       /*
>>>> +        * Now drop all the pm_runtime usage count to allow cx gdsc to collapse.
>>>> +        * First drop the usage count from all active submits
>>>> +        */
>>>> +       for (i = gpu->active_submits; i > 0; i--)
>>>> +               pm_runtime_put(&gpu->pdev->dev);
>>>> +
>>>> +       /* And the final one from recover worker */
>>>> +       pm_runtime_put_sync(&gpu->pdev->dev);
>>>> +
>>>> +       for (i = gpu->active_submits; i > 0; i--)
>>>> +               pm_runtime_get(&gpu->pdev->dev);
>>>> +
>>>> +       pm_runtime_get_sync(&gpu->pdev->dev);
>>> In response to v1, Rob suggested pm_runtime_force_suspend/resume().
>>> Those seem like they would work to me, too. Why not use them?
>> Quoting my previous response which I seem to have sent only to Freedreno
>> list:
>>
>> "I believe it is supposed to be used only during system sleep state
>> transitions. Btw, we don't want pm_runtime_get() calls from elsewhere to
>> fail by disabling RPM here."
> The comment about not wanting other runpm calls to fail is valid.. but
> that is also solveable, ie. by holding a lock around runpm calls.
> Which I think we need to do anyways, otherwise looping over
> gpu->active_submits is racey..
>
> I think pm_runtime_force_suspend/resume() is the least-bad option.. or
> at least I'm not seeing any obvious alternative that is better
>
> BR,
> -R
We are holding gpu->lock here which will block further submissions from 
scheduler. Will active_submits still race?

It is possible that there is another thread which successfully completed 
pm_runtime_get() and while it access the hardware, we pulled the plug on 
regulator/clock here. That will result in obvious device crash. So I can 
think of 2 solutions:

1. wrap *every* pm_runtime_get/put with a mutex. Something like:
             mutex_lock();
             pm_runtime_get();
             < ... access hardware here >>
             pm_runtime_put();
             mutex_unlock();

2. Drop runtime votes from every submit in recover worker and wait/poll 
for regulator to collapse in case there are transient votes on 
regulator  from other threads/subsystems.

Option (2) seems simpler to me.  What do you think?

-Akhil.

