Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D054B49F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiFNP3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356880AbiFNP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:28:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01C1D315;
        Tue, 14 Jun 2022 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655220513; x=1686756513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dk/uftXxWRMi9gukWl5RtM5/3/9fc7LP4heY2n2z6Eo=;
  b=Nkcsxb9SsCb5keZwRbA1b9NyeSWymU9C4W7kV4z0ptlzmVIR50IARCAB
   iO7qMPHvAcxBuX6mXF7ak5muRDVDu9i93drvUKB/a13KkcUPVtofJEfQQ
   AF37mSe5jklORNld/SL+5boRoocXeqQ14A4eBq23vZoGc3MLNKYxRoGaE
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Jun 2022 08:28:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:28:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 08:27:51 -0700
Received: from [10.110.74.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 08:27:50 -0700
Message-ID: <4c1ae3a9-0130-ac10-011f-b0db170da5ea@quicinc.com>
Date:   Tue, 14 Jun 2022 08:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] drm/msm/dp: force link training for display resolution
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
References: <1655156917-21726-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n50Z92PM+j7S_wmTeLcmu5cVO3YBT+viLeoLs5QhgXZMoA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n50Z92PM+j7S_wmTeLcmu5cVO3YBT+viLeoLs5QhgXZMoA@mail.gmail.com>
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


On 6/14/2022 1:38 AM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-06-13 14:48:37)
>> During display resolution changes display have to be disabled first
>> followed by display enabling with new resolution. Display disable
>> will turn off both pixel clock and main link clock so that main link
>> have to be re-trained during display enable to have new video stream
>> flow again. At current implementation, display enable function manually
>> kicks up irq_hpd_handle which will read panel link status and start link
>> training if link status is not in sync state. However, there is rare
>> case that a particular panel links status keep staying in sync for
>> some period of time after main link had been shut down previously at
>> display disabled. Main link retraining will not be executed by
>> irq_hdp_handle() if the link status read from panel shows it is in
>> sync state. If this was happen, then video stream of newer display
>> resolution will fail to be transmitted to panel due to main link is
>> not in sync between host and panel. This patch force main link always
>> be retrained during display enable procedure to prevent this rare
>> failed case from happening. Also this implementation are more
>> efficient than manual kicking off irq_hpd_handle function.
> How is resolution change different from disabling and enabling the
> display? The commit text talks about resolution changes, but the code
> doesn't compare resolutions from before and after to know when to
> retrain the link. Can the code be made to actually do what the commit
> text says? It would be clearer if the code looked for actual resolution
> changes instead of hooking the dp_bridge_enable() function.

Resolution changes are implemented through modeset. Therefore you can 
treat resolution changes equal to modeset.

dp_bridge_enable() and dp_bridge_disable() are end of function of 
modeset since DP driver is implemented as DRM bridge.

you have to use modeset to disable previous resolution and modeset to 
enable newer resolution.

Resolution changes is the term from end user point of view. For DP 
driver, we should use modeset.

I will revise the commit text for this.




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
>> Fixes: 62671d2ef24b ("drm/msm/dp: fixes wrong connection state caused by failure of link train")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    |  6 +++---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>>   3 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index af7a80c..bea93eb 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1551,7 +1551,7 @@ static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>>
>>          ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>>          if (!ret)
>> -               ret = dp_ctrl_on_stream(&ctrl->dp_ctrl);
>> +               ret = dp_ctrl_on_stream(&ctrl->dp_ctrl, false);
> Does this even matter if it's true or false? The 'sink_request' has
> DP_TEST_LINK_PHY_TEST_PATTERN set from what I can tell, and then
> dp_ctrl_on_stream() bails out before calling dp_ctrl_link_retrain()
> anyway. It would be nice if we could split dp_ctrl_on_stream() so that
> the part after the check for the sink request is a different function
> that is called by dp_display.c and then this code can call the 'prepare'
> function that does the first part. Then we can ignore the testing path
> in the code, and possibly remove the conditional in dp_ctrl_on_stream()?
>
>>          else
>>                  DRM_ERROR("failed to enable DP link controller\n");
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index c388323..370348d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -872,7 +872,7 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)
>>                  return 0;
>>          }
>>
>> -       rc = dp_ctrl_on_stream(dp->ctrl);
>> +       rc = dp_ctrl_on_stream(dp->ctrl, data);
>>          if (!rc)
>>                  dp_display->power_on = true;
>>
>> @@ -1654,6 +1654,7 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>>          int rc = 0;
>>          struct dp_display_private *dp_display;
>>          u32 state;
>> +       bool force_link_train = false;
>>
>>          dp_display = container_of(dp, struct dp_display_private, dp_display);
>>          if (!dp_display->dp_mode.drm_mode.clock) {
>> @@ -1688,10 +1689,14 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>>
>>          state =  dp_display->hpd_state;
>>
>> -       if (state == ST_DISPLAY_OFF)
>> +       if (state == ST_DISPLAY_OFF) {
>>                  dp_display_host_phy_init(dp_display);
>>
>> -       dp_display_enable(dp_display, 0);
>> +               if (!dp->is_edp)
> I didn't see any answer to my question about why edp is special on v4.
> Can you at least add a comment to the code about why edp doesn't need to
> unconditionally retrain, but DP does?
>
>> +                       force_link_train = true;
>> +       }
>> +
>> +       dp_display_enable(dp_display, force_link_train);
>>
>>          rc = dp_display_post_enable(dp);
>>          if (rc) {
