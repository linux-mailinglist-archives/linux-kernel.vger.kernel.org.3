Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039747C621
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbhLUSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:16:15 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2669 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbhLUSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640110574; x=1671646574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=87wmM1aAjQ9JXZUAKdF+CTr0EM6APa+CfM0DbP+Bdgc=;
  b=CYH2mkoIOlm+iMOgetSkJmhC23se6+ESgjwuTgVgxNscX/ZHxoN9Hy8H
   wOmIDD6iDDZN4zyMO03flS5g2vzm1vXDK7npUdpMSep9iLn6OvJWVvCGU
   45CzcCWyaxCgpE+gfDTKQWNItcQMNEx8lyN8acaOi7jKtceN2NVwYeJJx
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2021 10:16:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 10:16:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 10:16:12 -0800
Received: from [10.110.121.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 21 Dec
 2021 10:16:11 -0800
Message-ID: <cb935a39-3b15-19fe-983c-dce326b2bf06@quicinc.com>
Date:   Tue, 21 Dec 2021 10:16:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v7 2/2] drm/msm/dp: do not initialize phy until plugin
 interrupt received
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1639085707-27845-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n51pbf3GqwA-wtTe5+rRvA_KMmb8kd6fqqDtZRX+X_3qiA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n51pbf3GqwA-wtTe5+rRvA_KMmb8kd6fqqDtZRX+X_3qiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 5:50 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2021-12-09 13:35:07)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 0766752..cfbc5e4 100644
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
>> @@ -371,21 +372,46 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
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
> Is this check only here because we don't know when this function is
> getting called? I see in the DP case we get here from
> dp_display_usbpd_configure_cb() but in the eDP case we get here from
> dp_display_host_init() and presumably again from
> dp_display_usbpd_configure_cb() called by dp_hpd_plug_handle().
>
> If at all possible, I'd prefer to not have another tracking variable and
> call dp_display_host_phy_init() from the same place regardless of DP or
> eDP. Doing that would make it symmetric, per the commit text.

Agree, but  dp->phy_initialized variable used to track some other 
conditions.

For example, phy required to be re inited if dpcd read failed due to 
cable unplugged.

other dpcd read failed will not required to re inited.

Therefore I think dp->phy_initialized variable is still required.

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
>>                  DRM_DEBUG_DP("DP core already initialized\n");
>>                  return;
>>          }
>>
>> -       if (dp->usbpd->orientation == ORIENTATION_CC2)
>> -               flip = true;
>> +       dp_power_init(dp->power, false);
>> +       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
>> +
>> +       /*
>> +        * eDP is the embedded primary display and has its own phy
>> +        * initialize phy immediately
> Can we get some more details here? Why is it better to initialize the
> phy here vs. when HPD goes high on the panel? The comment says what the
> code is doing but it isn't telling us why that's OK.

Will do.

>
>> +        */
>> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP)
>> +               dp_display_host_phy_init(dp);
>>
>> -       dp_power_init(dp->power, flip);
>> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
>>          dp_aux_init(dp->aux);
>>          dp->core_initialized = true;
>>   }
