Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B8490AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiAQOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:38:31 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61605 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiAQOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642430308; x=1673966308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/wDgTOF9nD7qJTc2/BsA6bElbpP6tW+QytfeDJS27YY=;
  b=C0EepcS3/ekrhwuHlJhh9te+VirEkSGBOupOI2IiLbfdRda8/Z/PuG78
   Zjfsw0txq5JOiymPOQLklUMrTqeU47inz3BUneF/9jngJx3tB6V1zkgts
   MdJ+XRMGSzxx9BUNH90RKqvNCrdhQYDUSLVWmDkXOnZTTCP3ubwMcsFuf
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 17 Jan 2022 06:38:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 06:38:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 17 Jan 2022 06:38:25 -0800
Received: from [10.216.12.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 17 Jan
 2022 06:38:19 -0800
Message-ID: <bd284863-3643-4a8e-beb6-f47cc60ea1b5@quicinc.com>
Date:   Mon, 17 Jan 2022 20:08:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] drm/msm/adreno: Expose speedbin to userspace
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220112030115.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
 <20220112030115.3.I86c32730e08cba9e5c83f02ec17885124d45fa56@changeid>
 <CAF6AEGuJxdrYM5XXt6sUGmjossqZTRzwQ6Y8qYsnfCYDvGQurw@mail.gmail.com>
 <CAA8EJpokgiUbqj9BOF52a9QjJK53PinNHfxy_6nbNq53JnO2Og@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAA8EJpokgiUbqj9BOF52a9QjJK53PinNHfxy_6nbNq53JnO2Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/2022 12:43 PM, Dmitry Baryshkov wrote:
> On Thu, 13 Jan 2022 at 00:19, Rob Clark <robdclark@gmail.com> wrote:
>> On Tue, Jan 11, 2022 at 1:31 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>> Expose speedbin through MSM_PARAM_CHIP_ID parameter to help userspace
>>> identify the sku.
>>>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>>
>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> index f33cfa4..e970e6a 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> @@ -242,10 +242,11 @@ int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
>>>                  *value = !adreno_is_a650_family(adreno_gpu) ? 0x100000 : 0;
>>>                  return 0;
>>>          case MSM_PARAM_CHIP_ID:
>>> -               *value = adreno_gpu->rev.patchid |
>>> -                               (adreno_gpu->rev.minor << 8) |
>>> -                               (adreno_gpu->rev.major << 16) |
>>> -                               (adreno_gpu->rev.core << 24);
>>> +               *value = (uint64_t) adreno_gpu->rev.patchid |
>>> +                               (uint64_t) (adreno_gpu->rev.minor << 8) |
>>> +                               (uint64_t) (adreno_gpu->rev.major << 16) |
>>> +                               (uint64_t) (adreno_gpu->rev.core << 24) |
>>> +                               (((uint64_t) adreno_gpu->rev.sku) << 32);
>> How about this instead, so we are only changing the behavior for
>> new/unreleased devices:

I thought this property was only used for new devices whereas the 
existing devices rely on REVN.

-Akhil.

>>
>> *value = adreno_gpu->rev.patchid |
>> (adreno_gpu->rev.minor << 8) |
>> (adreno_gpu->rev.major << 16) |
>> (adreno_gpu->rev.core << 24);
>> if (!adreno_gpu->info->revn)
>> *value |= (((uint64_t) adreno_gpu->rev.sku) << 32);
>>
>> (sorry about the butchered indentation.. somehow gmail has become
>> antagonistic about pasting code)
> I assume that you would like to keep userspace compat for older chips.
> thus the if.
> Maybe we should introduce MSM_PARAM_CHIP_ID_SKU instead (and gradually
> make userspace switch to it)?
>
>> BR,
>> -R
>>
>>>                  return 0;
>>>          case MSM_PARAM_MAX_FREQ:
>>>                  *value = adreno_gpu->base.fast_rate;
>>> --
>>> 2.7.4
>>>
>
>

