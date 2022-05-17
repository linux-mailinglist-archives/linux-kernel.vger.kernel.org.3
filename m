Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9301652A772
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiEQP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350695AbiEQP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:56:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DE11141;
        Tue, 17 May 2022 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652802961; x=1684338961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iFNC9pJMxKmwTNanwEvj72sYQG04wOKPy2LjfMmbxhE=;
  b=EvjzUniyvnV8yRX/rMqx0IiTRCIqMES+MFatEZEfsXYZbulDoDjY8fi7
   GDEwvNP6zSgPzUfsR8VpvHgA6lEyaWYahKSt2+6EXQ76cwGrCWzn9DiLD
   h0QkDMIB+vQWE3we4suMxq3lIdWicolmyX8WS7POyLtnyEf1VYxXRQKYp
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 17 May 2022 08:56:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:55:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 08:55:40 -0700
Received: from [10.110.42.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 08:55:39 -0700
Message-ID: <55093da8-1354-957f-70f1-9db56e0665fc@quicinc.com>
Date:   Tue, 17 May 2022 08:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6] drm/msm/dp: Always clear mask bits to disable
 interrupts at dp_ctrl_reset_irq_ctrl()
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
References: <1652384598-21586-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n5277_-=ZYprmF6JcVfrnG0aZVXqXq092VS=mkDtrOB_wg@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n5277_-=ZYprmF6JcVfrnG0aZVXqXq092VS=mkDtrOB_wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2022 1:25 AM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-05-12 12:43:18)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index af7a80c..f3e333e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1389,8 +1389,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
>>
>>          dp_catalog_ctrl_reset(ctrl->catalog);
>>
>> -       if (enable)
>> -               dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
>> +       /*
>> +        * all dp controller programmable registers will not
>> +        * be reset to default value after DP_SW_RESET
>> +        * therefore interrupt mask bits have to be updated
>> +        * to enable/disable interrupts
>> +        */
>> +       dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
> I think Dmitry requested that this part be split off to a different
> patch. It's fixing the call to dp_ctrl_reset_irq_ctrl() for the disable
> case.
ok, will do that
>>   }
>>
>>   void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index c388323..ab691aa 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -98,6 +98,8 @@ struct dp_display_private {
>>          struct dp_ctrl    *ctrl;
>>          struct dp_debug   *debug;
>>
>> +       bool suspended;
>> +
> Can we not have this flag? I also don't understand how this patch waits
> for the event queue to drain. There are now multiple places we check to
> see if we've suspended, but is it even possible to be in those places
> during suspend? What is wrong with moving to an irq thread? Is it
> because we want to wait for a modeset (EV_USER_NOTIFICATION)?

dp_pm_suspend happen after display off. therefore event q should be 
emptied when dp_pm_suspend called.

since dp_pm_suspend and event_thread share an mutex, if suspended flag 
set at dp_pm_suspend which guarantee

event thread will not be wakeed up to process since event q is empty.

We used event q is to guarantee all events (irqs) are kept in event q 
with timing order (no any events missed) and executed later in timing 
order too to work the scenario likes dongle plug/unplugged several times 
consecutively.

We used to workqueue but cause many synchronization issues.

I will try thread_irq to see it will yield any advantage over kernel thread.

>>          struct dp_usbpd_cb usbpd_cb;
>>          struct dp_display_mode dp_mode;
>>          struct msm_dp dp_display;
