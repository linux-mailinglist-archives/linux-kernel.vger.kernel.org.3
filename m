Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5733054BD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbiFNWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiFNWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:11:47 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A74EDF4;
        Tue, 14 Jun 2022 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655244706; x=1686780706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QyBtVrN988JTZi57APICOccjvVk0rIujIlei0eNvXBg=;
  b=Z7IREYwIkKka0NJDJHuzjO8Lt5Vbofc3JfKK6hrN2jCQuedUuilT7UDF
   jroWSq4X5fdOgO5Tlmn6DDEAx6W1grBtyOples6F8wg9RSf1jnB8AzkSN
   6R9+kHgpfgxL473NkD1c50A50KvGZqy2Exr6aTTaJrALmYsGho4oQC+5g
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jun 2022 15:11:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 15:11:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 15:11:45 -0700
Received: from [10.110.74.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 15:11:44 -0700
Message-ID: <3481878b-95c5-d803-8b7b-c7e8c83bbcc5@quicinc.com>
Date:   Tue, 14 Jun 2022 15:11:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6] drm/msm/dp: force link training for display resolution
 change
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1655240702-12230-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52EAyTcQd6CiwXT1T658C-b+2r14BK_3-tf-ZiJdzqaAw@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52EAyTcQd6CiwXT1T658C-b+2r14BK_3-tf-ZiJdzqaAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/2022 2:59 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-06-14 14:05:02)
>> Display resolution change is implemented through drm modeset. Older
>> modeset (resolution) has to be disabled first before newer modeset
>> (resolution) can be enabled. Display disable will turn off both
>> pixel clock and main link clock so that main link have to be
>> re-trained during display enable to have new video stream flow
>> again. At current implementation, display enable function manually
>> kicks up irq_hpd_handle which will read panel link status and start
>> link training if link status is not in sync state.
>>
>> However, there is rare case that a particular panel links status keep
>> staying in sync for some period of time after main link had been shut
>> down previously at display disabled. In this case, main link retraining
>> will not be executed by irq_hdp_handle(). Hence video stream of newer
>> display resolution will fail to be transmitted to panel due to main
>> link is not in sync between host and panel.
>>
>> This patch will bypass irq_hpd_hanle() in favor of directly call
> s/hanle/handle/
>
>> dp_ctrl_on_stream() to always perform link training in regardless of
>> main link status. So that no unexpected exception resolution change
>> failure cases will happen. Also this implementation are more efficient
>> than manual kicking off irq_hpd_handle function.
>>
>> Changes in v2:
>> -- set force_link_train flag on DP only (is_edp == false)
>>
>> Changes in v3:
>> -- revise commit  text
>> -- add Fixes tag
>>
>> Changes in v4:
>> -- revise commit  text
>>
>> Changes in v5:
>> -- fix spelling at commit text
>>
>> Changes in v6:
>> -- split dp_ctrl_on_stream() for phy test case
>> -- revise commit text for modeset
>>
>> Fixes: 62671d2ef24b ("drm/msm/dp: fixes wrong connection state caused by failure of link train")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 31 +++++++++++++++++++++++--------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 13 ++++++-------
>>   3 files changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index af7a80c..cb9c7af 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1807,7 +1807,27 @@ static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
>>          return dp_ctrl_setup_main_link(ctrl, &training_step);
>>   }
>>
>> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>> +int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
>> +{
>> +       int ret = 0;
> Drop assignment please.
>
>> +       struct dp_ctrl_private *ctrl;
>> +
>> +       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>> +
>> +       ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>> +
>> +       ret = dp_ctrl_enable_stream_clocks(ctrl);
>> +       if (ret) {
>> +               DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       dp_ctrl_send_phy_test_pattern(ctrl);
> None of this code needs to be run in the normal display on case?

+       ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
+
+       ret = dp_ctrl_enable_stream_clocks(ctrl);

These two lines are also used at normal display on case (dp_ctrl_on_stream()).
I have to copy them to here to form a stand alone dp_ctrl_on_stream_phy_test_report().

>> +
>> +       return 0;
>> +}
>> +
>> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
>>   {
>>          int ret = 0;
>>          bool mainlink_ready = false;
>> @@ -1843,12 +1863,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>>                  goto end;
>>          }
>>
>> -       if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
>> -               dp_ctrl_send_phy_test_pattern(ctrl);
>> -               return 0;
>> -       }
>> -
>> -       if (!dp_ctrl_channel_eq_ok(ctrl))
>> +       if (force_link_train || !dp_ctrl_channel_eq_ok(ctrl))
>>                  dp_ctrl_link_retrain(ctrl);
>>
>>          /* stop txing train pattern to end link training */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index c388323..b6d25ab 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1688,10 +1689,12 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>>
>>          state =  dp_display->hpd_state;
>>
>> -       if (state == ST_DISPLAY_OFF)
>> +       if (state == ST_DISPLAY_OFF) {
>>                  dp_display_host_phy_init(dp_display);
>> +               force_link_train = true;
>> +       }
>>
>> -       dp_display_enable(dp_display, 0);
>> +       dp_display_enable(dp_display, force_link_train);
> Do we need to pass it from here? Why can't dp_display_enable() simply
> check for 'state == ST_DISPLAY_OFF' and then force retrain the link?
