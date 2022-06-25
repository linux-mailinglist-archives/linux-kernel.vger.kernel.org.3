Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1855A5BD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiFYBQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFYBQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 21:16:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4AD40A19;
        Fri, 24 Jun 2022 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656119764; x=1687655764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uua8kxPJXfOueiekdB2Tgio7+vOKfLeb4cJSDLh9XaA=;
  b=NpEP0gfnbj8eiLKcYge27K0r2wzCy3iJQb8muaea144jXi9EOzMc40G5
   WS3bQUEHLgU51WPqqin2spVX2SueImuWg/GFCOYGbnQNVSDN5hPeEhtGu
   dL1bp3sCC+8PnotH3iGD3CFrI5RsVrkwD9rv3cWFjAtv0iILP3rYkFqYb
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 18:16:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 18:16:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 18:16:03 -0700
Received: from [10.111.168.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 18:15:59 -0700
Message-ID: <3b3ae4d6-ec49-6c1e-ece7-ef49adb2f85c@quicinc.com>
Date:   Fri, 24 Jun 2022 18:15:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <fa7f8bf1-33cd-5515-0143-6596df2bd740@quicinc.com>
 <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
 <326912ff-9771-0711-366d-79acd436908b@quicinc.com>
 <CAE-0n51qrdrFtSr0vRwgYkMgSZfnzQuinaUROQsp30QoDchWQA@mail.gmail.com>
 <0ff3d6a3-dc5c-7c77-f8a1-6c4f6c1a3215@quicinc.com>
 <CAE-0n515hMKqQ+Vj1Sg54PpwkbWMYJ77QN+y+KZNBWymjhpWKw@mail.gmail.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com>
 <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAE-0n51PiVo042oj8JrAxNTytmAoQx0kdqs_iCDffXa1+iur1A@mail.gmail.com>
 <CAE-0n50Qq2_eayXAUMzU29wKkpa6JZTG6J1dthUY1Y9tAjy_2Q@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAE-0n50Qq2_eayXAUMzU29wKkpa6JZTG6J1dthUY1Y9tAjy_2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/24/2022 5:23 PM, Stephen Boyd wrote:
> Quoting Stephen Boyd (2022-06-24 17:11:01)
>> Quoting Abhinav Kumar (2022-06-24 17:03:37)
>>>
>>> So let me try to explain this as this is what i understood from the
>>> patch and how kuogee explained me.
>>>
>>> The ordering of the array still matters here and thats what he is trying
>>> to address with the second change.
>>
>> The order of the array should not matter. That's the problem.
> 
> It seems like somewhere else the order of the array matters, presumably
> while setting up encoders?
> 
>>
>>>
>>> So as per him, he tried to swap the order of entries like below and that
>>> did not work and that is incorrect behavior because he still retained
>>> the MSM_DP_CONTROLLER_x field for the table like below:
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
>>> b/drivers/gpu/drm/msm/dp/dp_display.c
>>> index dcd80c8a794c..7816e82452ca 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>> @@ -140,8 +140,8 @@ static const struct msm_dp_config sc7180_dp_cfg = {
>>>
>>>    static const struct msm_dp_config sc7280_dp_cfg = {
>>>           .descs = (const struct msm_dp_desc[]) {
>>> -               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
>>> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
>>>                   [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000,
>>> .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
>>> +               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
>>> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
>>>           },
>>>           .num_descs = 2,
>>>    };
>>>
>>>
>>> The reason order is important is because  in this function below, even
>>> though it matches the address to find which one to use it loops through
>>> the array and so the value of *id will change depending on which one is
>>> located where.
>>>
>>> static const struct msm_dp_desc *dp_display_get_desc(struct
>>> platform_device *pdev,
>>>                                unsigned int *id)
>>
>> Thanks! We should fix this function to not overwrite the id.
>>
> 
> Ah nevermind. I mixed up dp->id and h_tile_instance thinking one was
> overwriting the other but that doesn't make any sense.

Yes, I also misunderstood one point.

Even if we re-order like above, we are still retaining the index 
correctly so that will still work.

I checked with kuogee again now, he mentioned he needs this only for 
patch 3.

He is not sure of the root-cause of why turning ON the first display 
fixes the issue . I think that needs to be debugged correctly to answers 
questions posted by you / Dmitry. Lets hold on these patches till we 
have the answers.




