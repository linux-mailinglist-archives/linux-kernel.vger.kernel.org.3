Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2954EB30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378665AbiFPU3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiFPU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:29:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F35C750;
        Thu, 16 Jun 2022 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655411343; x=1686947343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NoCtxtbcqu+xKoXbpE9s02YriiqOhO6QDcxNHKKprhI=;
  b=UUOkoMx9FvZgFYKtvF7pxd0WgjDxTihwbQ98w6eRfCB4Q97pOLnMqS7v
   /gXRSY+PIwQ43GIc+NZdBWPn1KHtmMPxU8vwV0Me2oYC3SIkbZcz5agcT
   o68TJNLoeXJR4ijnzs5Nm3t6Hqg5r1kDdrZp9dUa4tKISt+2G2VF2kwaL
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jun 2022 13:29:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:29:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 16 Jun 2022 13:29:02 -0700
Received: from [10.110.49.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 13:29:00 -0700
Message-ID: <be06b65d-a39e-7e1d-891e-def55f0d8043@quicinc.com>
Date:   Thu, 16 Jun 2022 13:29:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/2] drm/msm/dp: clean up pixel_rate from dp_ctrl.c
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1655399361-10842-1-git-send-email-quic_khsieh@quicinc.com>
 <1655399361-10842-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n50cteV=uYRR=7LmcUB00kjHwDRoutq+sz5FoGmZqLso4Q@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n50cteV=uYRR=7LmcUB00kjHwDRoutq+sz5FoGmZqLso4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2022 1:07 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-06-16 10:09:21)
>> dp_ctrl keep an local cache of pixel_rate which increase confusing
>> in regrading how pixel_rate being used. This patch refer pixel_rate
>> directly from dp_panel to eliminate unnecessary pixel_rate variable
>> from struct dp_ctrl.
>>
>> Changes in v8:
>> -- add this patch to remove pixel_rate from dp_ctrl
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> I can send a proper patch for this myself later.
ok, then I will drop this patch
>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 158 +++++++++++++++++++--------------------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h |   2 -
>>   2 files changed, 79 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 01028b5..6fddddd 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1528,36 +1526,6 @@ static int dp_ctrl_link_maintenance(struct dp_ctrl_private *ctrl)
>>          return ret;
>>   }
>>
>> -static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>> -{
>> -       int ret = 0;
>> -
>> -       if (!ctrl->link->phy_params.phy_test_pattern_sel) {
>> -               drm_dbg_dp(ctrl->drm_dev,
>> -                       "no test pattern selected by sink\n");
>> -               return ret;
>> -       }
>> -
>> -       /*
>> -        * The global reset will need DP link related clocks to be
>> -        * running. Add the global reset just before disabling the
>> -        * link clocks and core clocks.
>> -        */
>> -       ret = dp_ctrl_off(&ctrl->dp_ctrl);
>> -       if (ret) {
>> -               DRM_ERROR("failed to disable DP controller\n");
>> -               return ret;
>> -       }
>> -
>> -       ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>> -       if (!ret)
>> -               ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
>> -       else
>> -               DRM_ERROR("failed to enable DP link controller\n");
>> -
>> -       return ret;
>> -}
>> -
>>   static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
>>   {
>>          bool success = false;
>> @@ -1610,6 +1578,56 @@ static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
>>          return success;
>>   }
>>
>> +int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
>> +{
>> +       int ret = 0;
>> +       struct dp_ctrl_private *ctrl;
>> +       unsigned long pixel_rate;
>> +
>> +       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>> +
>> +       pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>> +       ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
>> +       if (ret) {
>> +               DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       dp_ctrl_send_phy_test_pattern(ctrl);
>> +
>> +       return 0;
>> +}
>> +
>> +static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>> +{
>> +       int ret = 0;
>> +
>> +       if (!ctrl->link->phy_params.phy_test_pattern_sel) {
>> +               drm_dbg_dp(ctrl->drm_dev,
>> +                       "no test pattern selected by sink\n");
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * The global reset will need DP link related clocks to be
>> +        * running. Add the global reset just before disabling the
>> +        * link clocks and core clocks.
>> +        */
>> +       ret = dp_ctrl_off(&ctrl->dp_ctrl);
>> +       if (ret) {
>> +               DRM_ERROR("failed to disable DP controller\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>> +       if (!ret)
>> +               ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
>> +       else
>> +               DRM_ERROR("failed to enable DP link controller\n");
>> +
>> +       return ret;
>> +}
>> +
>>   void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
>>   {
>>          struct dp_ctrl_private *ctrl;
> I'd prefer these hunks to be part of a different patch. Either squashed
> into the previous patch, or after the previous patch to show that a
> forward declaration isn't necessary, but helped minimize the diff of
> that patch.
>
>> @@ -1685,6 +1703,7 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>>          u32 const phy_cts_pixel_clk_khz = 148500;
>>          u8 link_status[DP_LINK_STATUS_SIZE];
>>          unsigned int training_step;
>> +       unsigned long pixel_rate;
>>
>>          if (!dp_ctrl)
>>                  return -EINVAL;
