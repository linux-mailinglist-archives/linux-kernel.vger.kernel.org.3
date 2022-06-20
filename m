Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356AD5520B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiFTPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbiFTPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:25:13 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E3D3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655738621; x=1687274621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IOpznbgvSaym+Sif0wAWCP/JivReL3TNtBOptLf7zn8=;
  b=wgjTf1UGWwQYP8eyRqatehUMZffOiqT4mm/V4yJSOXkzC3KhGvXG4g0+
   T6ZFGkjmd5dnRSWMT2WtDJcn0avmk4KF2KVCSbgQSnGAFw8b3iat81388
   bNiI1iQ0mEAqyCZxjW+UzKOJ1w15rw/deMEeFJ8d6Dzc6lbkg5mAjHyN6
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jun 2022 08:23:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:23:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 08:23:40 -0700
Received: from [10.110.14.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 08:23:39 -0700
Message-ID: <920ec4fd-2ab0-2a0a-83fb-fc824ca7425d@quicinc.com>
Date:   Mon, 20 Jun 2022 08:23:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] drm/msm/dp: Reorganize code to avoid forward
 declaration
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        Sean Paul <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
References: <20220617204750.2347797-1-swboyd@chromium.org>
 <20220617204750.2347797-2-swboyd@chromium.org>
 <ddddcb1d-46c6-4903-3a8a-83bc96ece159@linaro.org>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <ddddcb1d-46c6-4903-3a8a-83bc96ece159@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 6/17/2022 3:50 PM, Dmitry Baryshkov wrote:
> On 17/06/2022 23:47, Stephen Boyd wrote:
>> Let's move these functions around to avoid having to forward declare
>> dp_ctrl_on_stream_phy_test_report(). Also remove
>> dp_ctrl_reinitialize_mainlink() forward declaration because we're doing
>> that sort of task.
>>
>> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 104 +++++++++++++++----------------
>>   1 file changed, 50 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c 
>> b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 703249384e7c..bd445e683cfc 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1238,8 +1238,6 @@ static int dp_ctrl_link_train_2(struct 
>> dp_ctrl_private *ctrl,
>>       return -ETIMEDOUT;
>>   }
>>   -static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private 
>> *ctrl);
>> -
>>   static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
>>               int *training_step)
>>   {
>> @@ -1534,38 +1532,6 @@ static int dp_ctrl_link_maintenance(struct 
>> dp_ctrl_private *ctrl)
>>       return ret;
>>   }
>>   -static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl 
>> *dp_ctrl);
>> -
>> -static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private 
>> *ctrl)
>> -{
>> -    int ret = 0;
>> -
>> -    if (!ctrl->link->phy_params.phy_test_pattern_sel) {
>> -        drm_dbg_dp(ctrl->drm_dev,
>> -            "no test pattern selected by sink\n");
>> -        return ret;
>> -    }
>> -
>> -    /*
>> -     * The global reset will need DP link related clocks to be
>> -     * running. Add the global reset just before disabling the
>> -     * link clocks and core clocks.
>> -     */
>> -    ret = dp_ctrl_off(&ctrl->dp_ctrl);
>> -    if (ret) {
>> -        DRM_ERROR("failed to disable DP controller\n");
>> -        return ret;
>> -    }
>> -
>> -    ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>> -    if (!ret)
>> -        ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
>> -    else
>> -        DRM_ERROR("failed to enable DP link controller\n");
>> -
>> -    return ret;
>> -}
>> -
>>   static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private 
>> *ctrl)
>>   {
>>       bool success = false;
>> @@ -1618,6 +1584,56 @@ static bool 
>> dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
>>       return success;
>>   }
>>   +static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
>> +{
>> +    int ret;
>> +    struct dp_ctrl_private *ctrl;
>> +
>> +    ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>> +
>> +    ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>> +
>> +    ret = dp_ctrl_enable_stream_clocks(ctrl);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    dp_ctrl_send_phy_test_pattern(ctrl);
>> +
>> +    return 0;
>> +}
>> +
>> +static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private 
>> *ctrl)
>> +{
>> +    int ret = 0;
>> +
>> +    if (!ctrl->link->phy_params.phy_test_pattern_sel) {
>> +        drm_dbg_dp(ctrl->drm_dev,
>> +            "no test pattern selected by sink\n");
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * The global reset will need DP link related clocks to be
>> +     * running. Add the global reset just before disabling the
>> +     * link clocks and core clocks.
>> +     */
>> +    ret = dp_ctrl_off(&ctrl->dp_ctrl);
>> +    if (ret) {
>> +        DRM_ERROR("failed to disable DP controller\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>> +    if (!ret)
>> +        ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
>> +    else
>> +        DRM_ERROR("failed to enable DP link controller\n");
>> +
>> +    return ret;
>> +}
>> +
>>   void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
>>   {
>>       struct dp_ctrl_private *ctrl;
>> @@ -1815,26 +1831,6 @@ static int dp_ctrl_link_retrain(struct 
>> dp_ctrl_private *ctrl)
>>       return dp_ctrl_setup_main_link(ctrl, &training_step);
>>   }
>>   -static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
>> -{
>> -    int ret;
>> -    struct dp_ctrl_private *ctrl;
>> -
>> -    ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>> -
>> -    ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>> -
>> -    ret = dp_ctrl_enable_stream_clocks(ctrl);
>> -    if (ret) {
>> -        DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>> -        return ret;
>> -    }
>> -
>> -    dp_ctrl_send_phy_test_pattern(ctrl);
>> -
>> -    return 0;
>> -}
>> -
>>   int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
>>   {
>>       int ret = 0;
>
>
