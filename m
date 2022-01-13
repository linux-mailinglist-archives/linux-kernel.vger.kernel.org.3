Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA33248DF26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiAMUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:44:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22289 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiAMUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642106660; x=1673642660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=57MqfI7dB+tsBDAjgRqB/dMauShg7UH+ZvEMZcujzw4=;
  b=x/KTwNB3+RSHFVdwVaHHEXvYGKgCf2LRJPdXUrNiG+s9Q7mCKBqsGZMV
   0fwM9jDCiQQ0GlxPjv011XpOt0PzuWsOyzpuozkh97AH4NzPOcXxNGXth
   TCy2fOTm/FIyc111L9BGVff7fcYsTkfk6sbIxcTh+nfd6949QUhCrz6u4
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Jan 2022 12:44:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 12:44:18 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 13 Jan 2022 12:44:18 -0800
Received: from [10.110.125.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 13 Jan
 2022 12:44:16 -0800
Message-ID: <64ad7053-beac-0c28-7d09-ea32a4f7fbad@quicinc.com>
Date:   Thu, 13 Jan 2022 12:44:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v11 1/4] drm/msm/dp: do not initialize phy until plugin
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
References: <1641926606-1012-1-git-send-email-quic_khsieh@quicinc.com>
 <1641926606-1012-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53hrPYR3ThwxM_+fzyRSB+6W1drFymW5n_RKmg_gf8z-w@mail.gmail.com>
 <84ee17f9-2597-86b6-1517-2358d443f65b@quicinc.com>
 <CAE-0n5134H0puMicozjdfTY+zXVUZyrebjv7Hto3EWcQAELO4A@mail.gmail.com>
 <338ae657-e8ed-e620-0aa7-4ad05df18ad1@quicinc.com>
 <CAE-0n51QbJHnOses5sF6xECR0gRZB1Fbi1KqoLG+61ZWH9BtOA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n51QbJHnOses5sF6xECR0gRZB1Fbi1KqoLG+61ZWH9BtOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/2022 11:47 AM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-01-13 09:51:42)
>> On 1/12/2022 8:13 PM, Stephen Boyd wrote:
>>>>>> -       if (dp->usbpd->orientation == ORIENTATION_CC2)
>>>>>> -               flip = true;
>>>>>> +       dp_power_init(dp->power, false);
>>>>>> +       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
>>>>>> +
>>>>>> +       /*
>>>>>> +        * eDP is the embedded primary display and has its own phy
>>>>>> +        * initialize phy immediately
>>>>> Question still stands why we can't wait for hpd high from the eDP panel.
>>>>> Also, I think "has its own phy" means that it's not part of a combo
>>>>> USB+DP phy? Can you please clarify?
Correct, eDP has its dedicated phy which is not part of combo phy.
>>>>>> +        */
>>>>>> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP)
>>>>>> +               dp_display_host_phy_init(dp);
>>>>>>
>>>>>> -       dp_power_init(dp->power, flip);
>>>>>> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
>>>>>>            dp_aux_init(dp->aux);
>>>>>>            dp->core_initialized = true;
>>>>>>     }
>>>>>> @@ -1306,20 +1330,23 @@ static int dp_pm_resume(struct device *dev)
>>>>>>            dp->hpd_state = ST_DISCONNECTED;
>>>>>>
>>>>>>            /* turn on dp ctrl/phy */
>>>>>> -       dp_display_host_init(dp, true);
>>>>>> +       dp_display_host_init(dp);
>>>>>>
>>>>>>            dp_catalog_ctrl_hpd_config(dp->catalog);
>>>>>>
>>>>>> -       /*
>>>>>> -        * set sink to normal operation mode -- D0
>>>>>> -        * before dpcd read
>>>>>> -        */
>>>>>> -       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>>>>>
>>>>>>            if (dp_catalog_link_is_connected(dp->catalog)) {
>>>>>> +               /*
>>>>>> +                * set sink to normal operation mode -- D0
>>>>>> +                * before dpcd read
>>>>>> +                */
>>>>>> +               dp_display_host_phy_init(dp);
>>>>>> +               dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>>>>>                    sink_count = drm_dp_read_sink_count(dp->aux);
>>>>>>                    if (sink_count < 0)
>>>>>>                            sink_count = 0;
>>>>>> +
>>>>>> +               dp_display_host_phy_exit(dp);
>>>>> Why is the phy exited on resume when the link is still connected? Is
>>>>> this supposed to be done only when the sink_count is 0? And how does
>>>>> this interact with eDP where the phy is initialized by the call to
>>>>> dp_display_host_init() earlier in this function.

At beginning of dp_pm_resume bot core_initialized and phy_initialized 
should be off.

However at the case of dongle still connected to DUT, we have to read 
dongle dpcd to decided any hdmi connect to dongle (sink_count != 0). in 
this case, we have to turn on phy to perform dpcd read and  turn off phy 
after read so the following plugged-in interrupt can be handled correctly.

>>>>>>            }
>>>>>>
>>>>>>            dp->link->sink_count = sink_count;
>>> Any response to the above two comments?
> ??
