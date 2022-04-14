Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90950195B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbiDNRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiDNRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:01:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C8191;
        Thu, 14 Apr 2022 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649954123; x=1681490123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xSXPlBzZTv6+R+sI6EzS6LbvpQWfbv+dUZziSIPXPjs=;
  b=dfZix8l3Uf4DmBU3HFK37cz1VOJXK3cJb0MNitgy4MjdJ9i2m0/Tpt9h
   BNenD7QaJFTd97YkJuI9HF6XdjU30IXI6qj1ekM0FtZpU/04XIW9oBnGL
   0rPKyMAPNng7v/rC1CVLmdFqQW59Ti15CywqugaidhFUQRti5QAkcg9XV
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Apr 2022 09:35:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:35:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 09:35:21 -0700
Received: from [10.110.43.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 09:35:20 -0700
Message-ID: <0d8a0716-c8b8-a4f6-3e9a-924245dd97fc@quicinc.com>
Date:   Thu, 14 Apr 2022 09:34:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n511nbPrRCMx3E2De-htmR79vZr4ezSj13Gm1PbTGasC4A@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n511nbPrRCMx3E2De-htmR79vZr4ezSj13Gm1PbTGasC4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/2022 5:02 PM, Stephen Boyd wrote:
> The subject is still misleading. It is fixing something. It may be
> enhancing it as well but it is clearly fixing it first.
>
> Quoting Kuogee Hsieh (2022-04-06 14:28:13)
>> dp_hpd_plug_handle() is responsible for setting up main link and send
>> uevent to notify user space framework to start video stream. Similarly,
>> dp_hdp_unplug_handle is responsible to send uevent to notify user space
>> framework to stop video stream and then tear down main link.
>> However there are rare cases, such as in the middle of system suspending,
>> that uevent could not be delivered to user space framework. Therefore
>> some kind of recover mechanism armed by timer need to be in place in the
>> case of user space framework does not respond to uevent.
>>
>> This patch have both dp_conenct_pending_timeout and
>> dp_disconnect_pending_timeout are used to stop video stream and tear down
>> main link and eventually restore DP driver state to known default
>> DISCONNECTED state in the case of timer fired due to framework does not
>> respond to uevent so that DP driver can recover itself gracefully at next
>> dongle unplug followed by plugin event.
>>
>> Changes in v2:
>> -- replace dp_display_usbpd_disconnect_cb with dp_display_notify_disconnect
> I'd prefer this part to be a different patch. It can come after the fix
> to ease backporting.
>
> Also, is there any response to Dmitry's question yet? I haven't seen
> anything.

Sorry, since our internal review does not like this approach.

I will upload new patch for review soon.

>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index 2433edb..ffafe17 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -22,6 +22,7 @@ struct dp_ctrl {
>>   int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
>>   int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
>>   int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
>> +int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
>>   int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>>   void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
>>   void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 178b774..a6200a5 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -451,11 +451,14 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
>>
>>   static int dp_display_usbpd_disconnect_cb(struct device *dev)
> We shouldn't need to keep around an empty function.
>
>>   {
>> +       return 0;
>> +}
>> +
>> +static void dp_display_notify_disconnect(struct device *dev)
>> +{
>>          struct dp_display_private *dp = dev_get_dp_display_private(dev);
>>
>>          dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>> -
>> -       return 0;
>>   }
>>
>>   static void dp_display_handle_video_request(struct dp_display_private *dp)
>> @@ -593,10 +596,16 @@ static int dp_connect_pending_timeout(struct dp_display_private *dp, u32 data)
>>
>>          mutex_lock(&dp->event_mutex);
>>
>> +       /*
>> +        * main link had been setup but video is not ready yet
>> +        * only tear down main link
>> +        */
>>          state = dp->hpd_state;
>>          if (state == ST_CONNECT_PENDING) {
>> -               dp->hpd_state = ST_CONNECTED;
>>                  DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
>> +               dp_ctrl_off_link(dp->ctrl);
>> +               dp_display_host_phy_exit(dp);
>> +               dp->hpd_state = ST_DISCONNECTED;
>>          }
>>
>>          mutex_unlock(&dp->event_mutex);
>> @@ -645,6 +654,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>>                  if (dp->link->sink_count == 0) {
>>                          dp_display_host_phy_exit(dp);
>>                  }
>> +               dp_display_notify_disconnect(&dp->pdev->dev);
>>                  mutex_unlock(&dp->event_mutex);
>>                  return 0;
>>          }
>> @@ -661,19 +671,22 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>>                  return 0;
>>          }
>>
>> -       dp->hpd_state = ST_DISCONNECT_PENDING;
>> -
>>          /* disable HPD plug interrupts */
>>          dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
>>
>>          /*
>>           * We don't need separate work for disconnect as
>>           * connect/attention interrupts are disabled
>> -        */
>> -       dp_display_usbpd_disconnect_cb(&dp->pdev->dev);
>> +       */
> This comment end is wrong. It should be unchanged.
>
>> +       dp_display_notify_disconnect(&dp->pdev->dev);
>>
>> -       /* start sentinel checking in case of missing uevent */
>> -       dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
>> +       if (state == ST_DISPLAY_OFF) {
>> +               dp->hpd_state = ST_DISCONNECTED;
>> +       } else {
>> +               /* start sentinel checking in case of missing uevent */
>> +               dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
>> +               dp->hpd_state = ST_DISCONNECT_PENDING;
>> +       }
>>
>>          /* signal the disconnect event early to ensure proper teardown */
>>          dp_display_handle_plugged_change(&dp->dp_display, false);
>> @@ -695,10 +708,16 @@ static int dp_disconnect_pending_timeout(struct dp_display_private *dp, u32 data
>>
>>          mutex_lock(&dp->event_mutex);
>>
>> +       /*
>> +        * main link had been set up and video is ready
>> +        * tear down main link, video stream and phy
>> +        */
>>          state =  dp->hpd_state;
>>          if (state == ST_DISCONNECT_PENDING) {
>> -               dp->hpd_state = ST_DISCONNECTED;
>>                  DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
>> +               dp_ctrl_off(dp->ctrl);
>> +               dp_display_host_phy_exit(dp);
>> +               dp->hpd_state = ST_DISCONNECTED;
>>          }
>>
>>          mutex_unlock(&dp->event_mutex);
