Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA26855A483
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiFXWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 18:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiFXWxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:53:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0A45793;
        Fri, 24 Jun 2022 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656111228; x=1687647228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TZOMCG67drrunYm+DJzfXcI4dQeWRX6/LkhF4yBxQWQ=;
  b=vYWnQiKk6jhYNBOuCR2i0QMkAesFN9NsOHrBQ/3KXIgQksUmGI270Oxm
   ygsPIG8RNW4Kp/sH6Y2RVms8kRNyKfC9A+xMHD12FYqw7BpS7Pnko5gKG
   hyDceGpj4nktsQjVks5HmE6C10zT+0Q7/6A3qtd+2cG2MMbt4hOS6l/70
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 15:53:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 15:53:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 15:53:47 -0700
Received: from [10.110.58.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 15:53:45 -0700
Message-ID: <326912ff-9771-0711-366d-79acd436908b@quicinc.com>
Date:   Fri, 24 Jun 2022 15:53:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com>
 <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com>
 <CAE-0n53kNCK0ajHfY2WQr5HEQZtZSBLnhfbTuZwaUNEOZhsKPg@mail.gmail.com>
 <fa7f8bf1-33cd-5515-0143-6596df2bd740@quicinc.com>
 <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
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


On 6/24/2022 3:19 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-06-24 14:49:57)
>> On 6/24/2022 2:40 PM, Stephen Boyd wrote:
>>> Quoting Kuogee Hsieh (2022-06-24 14:17:50)
>>>> On 6/24/2022 1:00 PM, Stephen Boyd wrote:
>>>>> Quoting Kuogee Hsieh (2022-06-24 10:15:11)
>>>>>> Current the index (dp->id) of DP descriptor table (scxxxx_dp_cfg[]) are tightly
>>>>>> coupled with DP controller_id. This means DP use controller id 0 must be placed
>>>>>> at first entry of DP descriptor table (scxxxx_dp_cfg[]). Otherwise the internal
>>>>>> INTF will mismatch controller_id. This will cause controller kickoff wrong
>>>>>> interface timing engine and cause dpu_encoder_phys_vid_wait_for_commit_done
>>>>>> vblank timeout error.
>>>>>>
>>>>>> This patch add controller_id field into struct msm_dp_desc to break the tightly
>>>>>> coupled relationship between index (dp->id) of DP descriptor table with DP
>>>>>> controller_id.
>>>>> Please no. This reverts the intention of commit bb3de286d992
>>>>> ("drm/msm/dp: Support up to 3 DP controllers")
>>>>>
>>>>>        A new enum is introduced to document the connection between the
>>>>>        instances referenced in the dpu_intf_cfg array and the controllers in
>>>>>        the DP driver and sc7180 is updated.
>>>>>
>>>>> It sounds like the intent of that commit failed to make a strong enough
>>>>> connection. Now it needs to match the INTF number as well? I can't
>>>>> really figure out what is actually wrong, because this patch undoes that
>>>>> intentional tight coupling. Is the next patch the important part that
>>>>> flips the order of the two interfaces?
>>>> The commit bb3de286d992have two problems,
>>>>
>>>> 1)  The below sc7280_dp_cfg will not work, if eDP use
>>>> MSM_DP_CONTROLLER_2 instead of  MSM_DP_CONTROLLER_1
>>> Why would we use three indices for an soc that only has two indices
>>> possible? This is not a real problem?
>> I do not what will happen at future, it may have more dp controller use
>> late.
>>
>> at current soc, below table has only one eDP will not work either.
>>
>> static const struct msm_dp_config sc7280_dp_cfg = {
>>            .descs = (const struct msm_dp_desc[]) {
>>                    [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000,
>> .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
>>
>>            .num_descs = 1,
> So the MSM_DP_CONTROLLER_* number needs to match what exactly?MSM

MSM_DP_CONTROLLER_1 need to match to the index = 1 of sc7280_dp_cfg[] <== This is correct

The problem is sc7280_dp_cfg[] have two entries since eDP place at index 
of MSM_DP_CONTROLLER_1.

but .num_desc = 1  <== this said only have one entry at sc7280_dp_cfg[] 
table. Therefore eDP will never be found at for loop  at 
_dpu_kms_initialize_displayport().


>
>>>> since it have num_descs =2 but eDP is at index 2 (CONTROLLER_2) which
>>>> never be reached.
>>>>
>>>> static const struct msm_dp_config sc7280_dp_cfg = {
>>>>            .descs = (const struct msm_dp_desc[]) {
>>>>                    [MSM_DP_CONTROLLER_2] = { .io_start = 0x0aea0000,
>>>> .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
>>>>                    [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
>>>> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
>>>>            },
>>>>            .num_descs = 2,
>>>> };
>>>>
>>>> 2)  DP always has index of 0 (dp->id = 0) and the first one to call
>>>> msm_dp_modeset_init(). This make DP always place at head of bridge chain.
>>> What does this mean? Are you talking about the list of bridges in drm
>>> core, i.e. 'bridge_list'?
>> yes,
> I changed the drm_bridge_add() API and that doesn't make any difference.
> The corruption is still seen. That would imply it is not the order of
> the list of bridges.

Sorry, my mistake. it is not in drm_bridge_add.

It should be in dpu_encoder_init() of _dpu_kms_initialize_displayport().

can you make below changes (patch) to _dpu_kms_initialize_displayport().

kuogee: go backward for dp modeset_init

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c 
b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 3a4da0d..b271a4b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -611,9 +611,15 @@ static int _dpu_kms_initialize_displayport(struct 
drm_device *dev,
         struct drm_encoder *encoder = NULL;
         struct msm_display_info info;
         int rc;
-       int i;
+       int i,num;
+
+       num = ARRAY_SIZE(priv->dp);

+#ifdef XXXX
         for (i = 0; i < ARRAY_SIZE(priv->dp); i++) {
+#else
+       for (i = num - 1; i >= 0 ; i--) {
+#endif
                 if (!priv->dp[i])
                         continue;


>
> ---8<---
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index e275b4ca344b..e3518101b65e 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -165,7 +165,7 @@ void drm_bridge_add(struct drm_bridge *bridge)
>   	mutex_init(&bridge->hpd_mutex);
>
>   	mutex_lock(&bridge_lock);
> -	list_add_tail(&bridge->list, &bridge_list);
> +	list_add(&bridge->list, &bridge_list);
>   	mutex_unlock(&bridge_lock);
>   }
>   EXPORT_SYMBOL(drm_bridge_add);
>
>>>> At next patch eDP must be placed at head of bridge chain to fix eDP
>>>> corruption issue. This is the purpose of this patch. I will revise the
>>>> commit text.
>>>>
>>> Wouldn't that be "broken" again if we decided to change drm_bridge_add()
>>> to add to the list head instead of list tail? Or if somehow
>>> msm_dp_modeset_init() was called in a different order so that the DP
>>> bridge was added before the eDP bridge?
>> we have no control of drm_bridge_add().
>>
>> Since drm perform screen update following bridge chain sequentially, we
>> have to make sure primary always update first.
>>
