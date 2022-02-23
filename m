Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBAA4C1CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiBWUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiBWUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:09:12 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053D4CD44;
        Wed, 23 Feb 2022 12:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645646923; x=1677182923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+MGvrogjK3hBuwIOknzKUrzQSja4adIWRodFkkTu2kk=;
  b=qAu3HWwEtw6P/h3mKJP5QzYTHoGNQNbzHClMR3xvT211kdvjO6BZfWcA
   xRSkXlgxJbpTQugwZpKvC9pP3K0FHhDFmpboCywcu9hiDPwFefW3G3seQ
   +c2UtidQmDkzt1WQTbQjuBapTau7x+1T9cjoJl9l6fhvGJgYoocEHVl07
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 12:08:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 12:08:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 12:08:42 -0800
Received: from [10.216.14.166] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 23 Feb
 2022 12:08:36 -0800
Message-ID: <d70cf11a-1a23-e240-3565-9966a6f4bfaa@quicinc.com>
Date:   Thu, 24 Feb 2022 01:38:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/5] drm/msm/adreno: Generate name from chipid for 7c3
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1645454462-27867-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220221201039.2.I9436e0e300f76b2e6c34136a0b902e8cfd73e0d6@changeid>
 <CAF6AEGuVZaOdUUf8ccokTQdAXMdW3oVYNx3ae9ShBoh8ibXVOw@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAF6AEGuVZaOdUUf8ccokTQdAXMdW3oVYNx3ae9ShBoh8ibXVOw@mail.gmail.com>
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

On 2/23/2022 6:28 AM, Rob Clark wrote:
> On Mon, Feb 21, 2022 at 6:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>> Use a gpu name which is sprintf'ed from the chipid for 7c3 gpu instead of
>> hardcoding one. This helps to avoid code churn in case of a gpu rename.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>>   drivers/gpu/drm/msm/adreno/adreno_device.c |  1 -
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 14 ++++++++++++--
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index fb26193..89cfd84 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -318,7 +318,6 @@ static const struct adreno_info gpulist[] = {
>>                  .hwcg = a660_hwcg,
>>          }, {
>>                  .rev = ADRENO_REV(6, 3, 5, ANY_ID),
>> -               .name = "Adreno 7c Gen 3",
>>                  .fw = {
>>                          [ADRENO_FW_SQE] = "a660_sqe.fw",
>>                          [ADRENO_FW_GMU] = "a660_gmu.bin",
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> index f33cfa4..158bbf7 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> @@ -929,12 +929,22 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>          struct adreno_platform_config *config = dev->platform_data;
>>          struct msm_gpu_config adreno_gpu_config  = { 0 };
>>          struct msm_gpu *gpu = &adreno_gpu->base;
>> +       struct adreno_rev *rev = &config->rev;
>> +       const char *gpu_name;
>> +       static char name[8];
> I think 8 is not always enough.. but maybe just use devm_kasprintf()
> to keep it simpler?
>
> BR,
> -R
Sounds good. Will update this patch.

-Akhil.
>>          adreno_gpu->funcs = funcs;
>>          adreno_gpu->info = adreno_info(config->rev);
>>          adreno_gpu->gmem = adreno_gpu->info->gmem;
>>          adreno_gpu->revn = adreno_gpu->info->revn;
>> -       adreno_gpu->rev = config->rev;
>> +       adreno_gpu->rev = *rev;
>> +
>> +       gpu_name = adreno_gpu->info->name;
>> +       if (!gpu_name) {
>> +               sprintf(name, "%d.%d.%d.%d", rev->core, rev->major, rev->minor,
>> +                               rev->patchid);
>> +               gpu_name = name;
>> +       }
>>
>>          adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
>>
>> @@ -948,7 +958,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>          pm_runtime_enable(dev);
>>
>>          return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
>> -                       adreno_gpu->info->name, &adreno_gpu_config);
>> +                       gpu_name, &adreno_gpu_config);
>>   }
>>
>>   void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>> --
>> 2.7.4
>>

