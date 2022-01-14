Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A526D48EEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiANRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:05:05 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:49675 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiANRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642179905; x=1673715905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LAXbPGrQij7hKaDghaiCxJfHKx2yQSO9XzW1xW7uwLo=;
  b=aBpuejDlNkkEv69TO9q6PjDmSUtlEDzIYrGdvG8BKPn/fQUKHP4hucVD
   SsDQCGVi1cOhZ9dWE/la9tKUWAMqnzyXnuvJIxWd/HxMcxkCwHHeSxOxs
   YK2xh0yXyKrLHXqUTYmmjQFPLEzLXEv9uc7jDkAt/AEdgHNqyXbZQdWDV
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jan 2022 09:05:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:04:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 14 Jan 2022 09:04:48 -0800
Received: from [10.110.125.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 14 Jan
 2022 09:04:47 -0800
Message-ID: <a507d7f2-c1f8-f8bd-24fa-15c4a2fb5a8b@quicinc.com>
Date:   Fri, 14 Jan 2022 09:04:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v13 1/4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1642118019-18673-1-git-send-email-quic_khsieh@quicinc.com>
 <1642118019-18673-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52OETzrO-XxuOQLp=fM17X3SGdD6zARtF85znmTqdvVRg@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52OETzrO-XxuOQLp=fM17X3SGdD6zARtF85znmTqdvVRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/2022 6:42 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-01-13 15:53:36)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 7cc4d21..b3c5404 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -83,6 +83,7 @@ struct dp_display_private {
>>
>>          /* state variables */
>>          bool core_initialized;
>> +       bool phy_initialized;
>>          bool hpd_irq_on;
>>          bool audio_supported;
>>
>> @@ -372,21 +373,38 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>>          return rc;
>>   }
>>
>> -static void dp_display_host_init(struct dp_display_private *dp, int reset)
>> +static void dp_display_host_phy_init(struct dp_display_private *dp)
>>   {
>> -       bool flip = false;
>> +       DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
>> +                       dp->core_initialized, dp->phy_initialized);
>>
>> +       if (!dp->phy_initialized) {
>> +               dp_ctrl_phy_init(dp->ctrl);
>> +               dp->phy_initialized = true;
>> +       }
>> +}
>> +
>> +static void dp_display_host_phy_exit(struct dp_display_private *dp)
>> +{
>> +       DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
>> +                       dp->core_initialized, dp->phy_initialized);
>> +
>> +       if (dp->phy_initialized) {
>> +               dp_ctrl_phy_exit(dp->ctrl);
>> +               dp->phy_initialized = false;
>> +       }
>> +}
>> +
>> +static void dp_display_host_init(struct dp_display_private *dp)
>> +{
>>          DRM_DEBUG_DP("core_initialized=%d\n", dp->core_initialized);
>>          if (dp->core_initialized) {
> When is this true? From what I see dp_display_host_init() is only called
> from two places: resume where core_initialized has been set to false
> during suspend or from dp_display_config_hpd() kicked by the kthread
> where core_initialized is also false.
>
> Also, I see that dp_display_host_deinit() is only called from suspend
> now, so 'core_initialized' is almost always true, except for on the
> resume path and before the kthread is started and in the case that the
> driver probes but can't start the kthread for some reason (is that
> real?).

Yes, that true.

The purpose  of dp_display_host_init() is to configure both dp 
controller and hpd controller to be ready to receive

HPD plugged-in interrupts and at plugged-in handler enable dp phy. 
Therefore core_initialized is set to true at both booting up and resume 
and false at suspend.

>>                  DRM_DEBUG_DP("DP core already initialized\n");
>>                  return;
>>          }
>>
>> -       if (dp->usbpd->orientation == ORIENTATION_CC2)
>> -               flip = true;
>> -
>> -       dp_power_init(dp->power, flip);
>> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
>> +       dp_power_init(dp->power, false);
>> +       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
>>          dp_aux_init(dp->aux);
>>          dp->core_initialized = true;
>>   }
>> @@ -892,12 +901,19 @@ static int dp_display_disable(struct dp_display_private *dp, u32 data)
>>
>>          dp_display->audio_enabled = false;
>>
>> -       /* triggered by irq_hpd with sink_count = 0 */
>>          if (dp->link->sink_count == 0) {
>> +               /*
>> +                * irq_hpd with sink_count = 0
>> +                * hdmi unplugged out of dongle
>> +                */
>>                  dp_ctrl_off_link_stream(dp->ctrl);
>>          } else {
>> +               /*
>> +                * unplugged interrupt
>> +                * dongle unplugged out of DUT
>> +                */
>>                  dp_ctrl_off(dp->ctrl);
>> -               dp->core_initialized = false;
>> +               dp_display_host_phy_exit(dp);
>>          }
>>
>>          dp_display->power_on = false;
>> @@ -1027,7 +1043,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   static void dp_display_config_hpd(struct dp_display_private *dp)
>>   {
>>
>> -       dp_display_host_init(dp, true);
>> +       dp_display_host_init(dp);
>>          dp_catalog_ctrl_hpd_config(dp->catalog);
>>
>>          /* Enable interrupt first time
>> @@ -1306,20 +1322,23 @@ static int dp_pm_resume(struct device *dev)
>>          dp->hpd_state = ST_DISCONNECTED;
>>
>>          /* turn on dp ctrl/phy */
>> -       dp_display_host_init(dp, true);
>> +       dp_display_host_init(dp);
>>
>>          dp_catalog_ctrl_hpd_config(dp->catalog);
>>
>> -       /*
>> -        * set sink to normal operation mode -- D0
>> -        * before dpcd read
>> -        */
>> -       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>
>>          if (dp_catalog_link_is_connected(dp->catalog)) {
>> +               /*
>> +                * set sink to normal operation mode -- D0
>> +                * before dpcd read
>> +                */
>> +               dp_display_host_phy_init(dp);
>> +               dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>                  sink_count = drm_dp_read_sink_count(dp->aux);
>>                  if (sink_count < 0)
>>                          sink_count = 0;
>> +
>> +               dp_display_host_phy_exit(dp);
>>          }
>>
>>          dp->link->sink_count = sink_count;
>> @@ -1363,7 +1382,11 @@ static int dp_pm_suspend(struct device *dev)
>>                  if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>>                          dp_ctrl_off_link_stream(dp->ctrl);
>>
>> +               dp_display_host_phy_exit(dp);
>> +
> Why is there a newline here?
>
>>                  dp_display_host_deinit(dp);
>> +       } else {
>> +               dp_display_host_phy_exit(dp);
>>          }
>>
>>          dp->hpd_state = ST_SUSPENDED;
> There's a dp->core_initialized = false right here but it's not in the
> diff window. It's redundant now because the hunk above is basically
>
> 	if (dp->core_initialized == true) {
> 		...
> 		dp_display_host_phy_exit(dp);
> 		dp_display_host_deinit(dp);
> 	} else {
> 		dp_display_host_phy_exit(dp);
> 	}
>
> 	dp->hpd_state = ST_SUSPENDED;
>
> and dp_display_host_deinit() sets core_initialized to false, thus
> core_initialized will be false here already. Can you remove the
> duplicate assignment?
yes,
>> @@ -1535,7 +1558,7 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>>          state =  dp_display->hpd_state;
>>
>>          if (state == ST_DISPLAY_OFF)
>> -               dp_display_host_init(dp_display, true);
>> +               dp_display_host_phy_init(dp_display);
>>
>>          dp_display_enable(dp_display, 0);
>>
