Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0055A36B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiFXVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiFXVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:17:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4712FBFE;
        Fri, 24 Jun 2022 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656105474; x=1687641474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oXy5HhC7O8BQutw+O6SMcz5I+YvGlUPqUb8wDFujtUU=;
  b=yZ9CVgOf5yGlP3bXckFz7een8A8t4w3eH3t1EoxYjR2UVkKdbVeMDHSF
   qaWBkL6QdMiQosdCFomy5RIbw3RqXMNAKSjbwXx4RXnJk/IEW2d0FoeJg
   BXv7QAQVj8SzhowmDQ+yUT8fVxUeWqFeCt3M1P9xZFl5+0l6L9/dsLN8z
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 14:17:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 14:17:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 14:17:52 -0700
Received: from [10.110.58.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 14:17:51 -0700
Message-ID: <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com>
Date:   Fri, 24 Jun 2022 14:17:50 -0700
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
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com>
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


On 6/24/2022 1:00 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-06-24 10:15:11)
>> Current the index (dp->id) of DP descriptor table (scxxxx_dp_cfg[]) are tightly
>> coupled with DP controller_id. This means DP use controller id 0 must be placed
>> at first entry of DP descriptor table (scxxxx_dp_cfg[]). Otherwise the internal
>> INTF will mismatch controller_id. This will cause controller kickoff wrong
>> interface timing engine and cause dpu_encoder_phys_vid_wait_for_commit_done
>> vblank timeout error.
>>
>> This patch add controller_id field into struct msm_dp_desc to break the tightly
>> coupled relationship between index (dp->id) of DP descriptor table with DP
>> controller_id.
> Please no. This reverts the intention of commit bb3de286d992
> ("drm/msm/dp: Support up to 3 DP controllers")
>
>      A new enum is introduced to document the connection between the
>      instances referenced in the dpu_intf_cfg array and the controllers in
>      the DP driver and sc7180 is updated.
>
> It sounds like the intent of that commit failed to make a strong enough
> connection. Now it needs to match the INTF number as well? I can't
> really figure out what is actually wrong, because this patch undoes that
> intentional tight coupling. Is the next patch the important part that
> flips the order of the two interfaces?

The commit bb3de286d992have two problems,

1)  The below sc7280_dp_cfg will not work, if eDP use 
MSM_DP_CONTROLLER_2 instead of  MSM_DP_CONTROLLER_1

since it have num_descs =2 but eDP is at index 2 (CONTROLLER_2) which 
never be reached.

static const struct msm_dp_config sc7280_dp_cfg = {
         .descs = (const struct msm_dp_desc[]) {
                 [MSM_DP_CONTROLLER_2] = { .io_start = 0x0aea0000, 
.connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
                 [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, 
.connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
         },
         .num_descs = 2,
};

2)  DP always has index of 0 (dp->id = 0) and the first one to call 
msm_dp_modeset_init(). This make DP always place at head of bridge chain.

At next patch eDP must be placed at head of bridge chain to fix eDP 
corruption issue. This is the purpose of this patch. I will revise the 
commit text.


