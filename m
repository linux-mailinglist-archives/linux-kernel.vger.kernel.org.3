Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83EA51896F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiECQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiECQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:16:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895327164;
        Tue,  3 May 2022 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651594384; x=1683130384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9FGMVgF8GLGaAcGv/yGifqNyiG6ez9qf2269SDYd8Uc=;
  b=D331LDeqrGr8UuZKYQcxcTDV272NmmudzC3lKV+OGrAlOWrOHd6mLrHy
   zDqM8XMZsnIyzkmoNLtXghUJa4AFAoTHtR9oqKauDFa67Yx8qJwop00mm
   Qvf4R0HmrVZnwG617m/ZHrBgsk2Gif9VwoAqeb6adh0PW0lNATJvTH/Qk
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 03 May 2022 09:13:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:13:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 09:13:03 -0700
Received: from [10.134.70.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 09:13:02 -0700
Message-ID: <b96858a9-c38f-6576-e61c-9a94b0ee53f1@quicinc.com>
Date:   Tue, 3 May 2022 09:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/msm/dp: fix event thread stuck in wait_event after
 kthread_stop()
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
References: <1651532668-18873-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n51TjqYKzPbP7JHKi+ostwM7Q8FX64eC3Gufuz846mLA3g@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n51TjqYKzPbP7JHKi+ostwM7Q8FX64eC3Gufuz846mLA3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/2/2022 6:13 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-05-02 16:04:28)
>> Event thread supposed to exit from its while loop after kthread_stop().
>> However there may has possibility that event thread is pending in the
>> middle of wait_event due to condition checking never become true.
>> To make sure event thread exit its loop after kthread_stop(), this
>> patch OR kthread_should_stop() into wait_event's condition checking
>> so that event thread will exit its loop after kernal_stop().
>>
>> Changes in v2:
>> --  correct spelling error at commit title
>>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Fixes: 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index c388323..5200a58 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1106,12 +1106,17 @@ static int hpd_event_thread(void *data)
>>          while (!kthread_should_stop()) {
>>                  if (timeout_mode) {
>>                          wait_event_timeout(dp_priv->event_q,
>> -                               (dp_priv->event_pndx == dp_priv->event_gndx),
>> -                                               EVENT_TIMEOUT);
>> +                               ((dp_priv->event_pndx == dp_priv->event_gndx) ||
> Why the parenthesis (before and after)?
>
>> +                                       kthread_should_stop()), EVENT_TIMEOUT);
>>                  } else {
>>                          wait_event_interruptible(dp_priv->event_q,
>> -                               (dp_priv->event_pndx != dp_priv->event_gndx));
>> +                               ((dp_priv->event_pndx != dp_priv->event_gndx) ||
> Why the parenthesis (before and after)?
>
>> +                                       kthread_should_stop()));
>>                  }
>> +
>> +               if(kthread_should_stop())
> Missing space after if
>
>> +                       break;
> Is it possible to move the wait_event to the end of the loop and always
> run the loop initially? That way we don't have to check for
> kthread_should_stop() again.

no, since we have to make sure q is not empty so that we can proceed to 
service events.

bu ti thin we can use while (1) instead of while 
(!kthread_should_stop()) since we have add kthread_should_stop() into 
wait_event condition checking.

