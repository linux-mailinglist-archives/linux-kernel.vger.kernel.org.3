Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562D5364A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353602AbiE0PZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344384AbiE0PZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:25:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44658E72;
        Fri, 27 May 2022 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653665147; x=1685201147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4AmAb1G5xdwslkVKnzE93VMW23TrnWoLURqtUMAegWE=;
  b=T9cghxPOj/KLj2uzGacuRYZahdBSNSBk20Du+WutpDwkUE7UGiXz6Ie9
   fFncuKXBDLWYFY7ufCMTvpJ2IAnULrT4Q/bxm8ZkIiyFWFT8AAft5s+Mj
   SO6fHcBDro0dLcdwX5MoAMWk31rw3oqdcJQyxn+xL5AptBinJgmslqF6D
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 08:25:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 08:25:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 08:25:44 -0700
Received: from [10.110.46.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 08:25:43 -0700
Message-ID: <1f325de0-a10e-27a8-ce7a-9ecaed75465c@quicinc.com>
Date:   Fri, 27 May 2022 08:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/msm/dp: force link training for display resolution
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
References: <1653585978-30090-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53Nr7o=ZmSsBWOjUxCKxMYNrVwuVdbdL0wG7WZyrPo4Yw@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n53Nr7o=ZmSsBWOjUxCKxMYNrVwuVdbdL0wG7WZyrPo4Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/2022 5:07 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-05-26 10:26:18)
>> During display resolution changes display have to be disabled first
>> followed by display enable with new resolution. This patch force
>> main link always be retrained during display enable procedure to
>> simplify implementation instead of manually kicking of irq_hpd
>> handle.
> How is that better? Can you please describe how it improves things? I
> suppose it avoids some round trips through the event queue just to turn
> on the display?

This try to fix customer issues which only happen on one particular 
panel which fails on display resolution changes sometimes.

I will add more description.

>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Any Fixes tag? Or it's not fixing anything, just making things simpler?
will add.
>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 5ddb4e8..8b71013 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index 2433edb..dcc7af21 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -20,7 +20,7 @@ struct dp_ctrl {
>>   };
>>
>>   int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
>> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
>> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train);
> Can we have another API like dp_ctrl_on_stream_retrain()? Or name
> 'force_link_train' to 'retrain'?
>
>>   int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
>>   int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>>   void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index bfc6581..9246421 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -892,7 +892,7 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)
> Any reason why dp_display_enable() is forward declared and why it takes
> a u32 data argument? It's not part of the eventqueue calling code from
> what I can tell so we should be able to rename 'data' to 'retrain_link'?
>
>>                  return 0;
>>          }
>>
>> -       rc = dp_ctrl_on_stream(dp->ctrl);
>> +       rc = dp_ctrl_on_stream(dp->ctrl, data);
>>          if (!rc)
>>                  dp_display->power_on = true;
>>
>> @@ -1594,6 +1594,7 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>>          int rc = 0;
>>          struct dp_display_private *dp_display;
>>          u32 state;
>> +       bool force_link_train = false;
>>
>>          dp_display = container_of(dp, struct dp_display_private, dp_display);
>>          if (!dp_display->dp_mode.drm_mode.clock) {
>> @@ -1622,10 +1623,12 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>>
>>          state =  dp_display->hpd_state;
>>
>> -       if (state == ST_DISPLAY_OFF)
>> +       if (state == ST_DISPLAY_OFF) {
>>                  dp_display_host_phy_init(dp_display);
>> +               force_link_train = 1;
> Use true instead of 1 if the type is a bool please.
>
>> +       }
>>
>> -       dp_display_enable(dp_display, 0);
>> +       dp_display_enable(dp_display, force_link_train);
>>
>>          rc = dp_display_post_enable(dp);
>>          if (rc) {
