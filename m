Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3339B5019E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiDNRUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbiDNRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86A630D;
        Thu, 14 Apr 2022 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649956555; x=1681492555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BF7u36Wb73cxpkjy9bfZRgOS+0WolmnhOmyAdga/rCk=;
  b=IQBEOzpVIVV9WhwbLpWQQLcSrwK1JxKRWn5YRyuI6WPYKEO+RapBLjyo
   lu7mNiu7qSTCkqol+SMYSz4WBXqDogywLEtGj66NbGZe80mxMVsyE+1St
   vVNtYgFXZAndXYm3wWy3n8n5/3KER4cKGuqPERbT+lJeLzuNi79pTBcyo
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Apr 2022 10:15:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:15:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 10:15:53 -0700
Received: from [10.110.19.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 10:15:52 -0700
Message-ID: <02faf872-8fef-342a-d070-67b68953b5f8@quicinc.com>
Date:   Thu, 14 Apr 2022 10:15:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/msm/dp: stop event kernel thread when DP unbind
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649883865-9012-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n5259qjMj12LXRp=7kQ7zT3bRMaHpSpwKMwZ8HL6rq7fbw@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n5259qjMj12LXRp=7kQ7zT3bRMaHpSpwKMwZ8HL6rq7fbw@mail.gmail.com>
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


On 4/13/2022 4:19 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-04-13 14:04:25)
>> Current DP driver implementation, event thread is kept running
>> after DP display is unbind. This patch fix this problem by disabling
>> DP irq and stop event thread to exit gracefully at dp_display_unbind().
>>
>> Changes in v2:
>> -- start event thread at dp_display_bind()
>>
>> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 40 +++++++++++++++++++++++++++----------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 01453db..943e4f1 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -113,6 +113,7 @@ struct dp_display_private {
>>          u32 hpd_state;
>>          u32 event_pndx;
>>          u32 event_gndx;
>> +       struct task_struct *ev_tsk;
>>          struct dp_event event_list[DP_EVENT_Q_MAX];
>>          spinlock_t event_lock;
>>
>> @@ -230,6 +231,31 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
>>          complete_all(&dp->audio_comp);
>>   }
>>
>> +static int hpd_event_thread(void *data);
> Is there a reason why this is needed vs. defining the kthread start
> function after hpd_event_thread()?
too many code need to be relocated.
>
>> +
>> +static void dp_hpd_event_setup(struct dp_display_private *dp_priv)
> Maybe dp_hpd_event_thread_start()?
>
>> +{
>> +       init_waitqueue_head(&dp_priv->event_q);
>> +       spin_lock_init(&dp_priv->event_lock);
>> +
>> +       dp_priv->ev_tsk = kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
>> +
>> +       if (IS_ERR(dp_priv->ev_tsk))
>> +               DRM_ERROR("failed to create DP event thread\n");
> Can we return an error from this function?
>
>> +}
>> +
>> +static void dp_hpd_event_stop(struct dp_display_private *dp_priv)
> Maybe dp_hpd_event_thread_stop()?
>
>> +{
>> +       if (IS_ERR(dp_priv->ev_tsk))
>> +               return;
> If we handled the error then this check becomes impossible.
>
>> +
>> +       kthread_stop(dp_priv->ev_tsk);
>> +
>> +       /* reset event q to empty */
>> +       dp_priv->event_gndx = 0;
>> +       dp_priv->event_pndx = 0;
>> +}
>> +
>>   static int dp_display_bind(struct device *dev, struct device *master,
>>                             void *data)
>>   {
>> @@ -269,6 +295,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
>>          if (rc)
>>                  DRM_ERROR("Audio registration Dp failed\n");
>>
>> +       dp_hpd_event_setup(dp); /* start event thread */
> The comment is useless, please remove.
>
>>   end:
>>          return rc;
>>   }
>> @@ -280,6 +307,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>>          struct drm_device *drm = dev_get_drvdata(master);
>>          struct msm_drm_private *priv = drm->dev_private;
>>
>> +       disable_irq(dp->irq);
> Is the disable_irq() necessary? It would be nicer to silence the
> hardware and remove the disable_irq() so that we can reason about the
> code assuming the irq is always enabled after it is requested.
>
>> +       dp_hpd_event_stop(dp); /* stop event thread */
>>          dp_power_client_deinit(dp->power);
>>          dp_aux_unregister(dp->aux);
>>          priv->dp[dp->id] = NULL;
