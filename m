Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38074FC93C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 02:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiDLAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 20:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiDLAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:25:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A91A398
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:23:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h14so24332185lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yOjAWbY0UR7Bw7D+6dLajU1Gt4KJ9I9tTJQx5yeuMKM=;
        b=nTYdC2mOxTqAVDPAfm4M/DKJTAtGPexyIeFczb44uM99vLJi4+KMXs5FlGtBz/LlSc
         /S4Lc8OMJTOuSpsm0k1d4AWMldDw/rEsArXH2/TL9c+HMaVhv6Vs6oOcpHb0Jrnaapd7
         bhya9Ip74FhxLoeiNWaYvv9/PXSR6DK4GaJe6/xViUD/SoQn68Q/EEXWN6dY6ThjPtm4
         2kRjmQcCANcGWxt9xJXFIVJYC+FAASLF3Ej9Fvbd7lh6tLdrnCOGLCFBei4rf8IspoJk
         4ftS/KIdUJjuRRMrzNZVEu+ymRmdvp2mBX+x+D0MWmY4JBt9YAriWegqdSTnT47tAtED
         3Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yOjAWbY0UR7Bw7D+6dLajU1Gt4KJ9I9tTJQx5yeuMKM=;
        b=ypAU4A8Ct0wrKaEjIPZO868nPeqCBIe/Dl+jj81uu0gERXjp3UbXBcc9tJ0RJ1hjKP
         eaQvZKCOZHNk2SDR953g95tsGa8pvCUXiY8YlITOPz06NkVYVeH+d0AksIEKdTD5wtyc
         o5wc/7t34Aj3hcxVW7+2Mg8NjrwdxfhCZ/ZEB0Uu1XS2lizweGb0ktyAFS81jXuPV9j9
         UUIlL9ho+rUmMBETqKRCEfX+LiAhTRIjbQoAPw5qt+y1sh4SvvnayD6Kdjjfk4lJCwra
         dWamAsIPWOf/tooSwVqHFKtMd/tp9kd8UPyM3nsUFd7+609UlFe575SrtZq2KyJ9iuuQ
         gg/A==
X-Gm-Message-State: AOAM531uU7mLUeYEChks3GxpSDqVd5ImBm1hi0FNoylERc34+BhuNTxF
        vF4rEWmu/7krKP5xfZOD1HSJN9W3cRxCKw==
X-Google-Smtp-Source: ABdhPJwsKGf4RfVTHS/qN0bJdgQaSZll46wag0CzD6YUaL28bZDNRZULT7YDpPfyBV9HNO5cnN/31A==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr22394740lfh.629.1649722980575;
        Mon, 11 Apr 2022 17:23:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f3-20020a056512228300b0044a0e0a609bsm3455478lfu.38.2022.04.11.17.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 17:22:59 -0700 (PDT)
Message-ID: <7529d921-0b12-d162-416d-3542933a0aed@linaro.org>
Date:   Tue, 12 Apr 2022 03:22:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/msm/dp: stop event kernel thread when DP unbind
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649722129-12542-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53zYpqJL9GCoqZRwMptCne+4Dk4thz-7rCDac7H98dm=A@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAE-0n53zYpqJL9GCoqZRwMptCne+4Dk4thz-7rCDac7H98dm=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 03:21, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-04-11 17:08:49)
>> Current DP driver implementation, event thread is kept running
>> after DP display is unbind. This patch fix this problem by disabling
>> DP irq and stop event thread to exit gracefully at dp_display_unbind().
>>
>> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 
> Should add a Reported-by tag from Dmitry here.
> 
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 01453db..fa1ef8e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -273,6 +274,8 @@ static int dp_display_bind(struct device *dev, struct device *master,
>>          return rc;
>>   }
>>
>> +static void dp_hpd_event_stop(struct dp_display_private *dp_priv);
> 
> Why can't the function be defined here?
> 
>> +
>>   static void dp_display_unbind(struct device *dev, struct device *master,
>>                                void *data)
>>   {
>> @@ -280,6 +283,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>>          struct drm_device *drm = dev_get_drvdata(master);
>>          struct msm_drm_private *priv = drm->dev_private;
>>
>> +       disable_irq(dp->irq);
>> +       dp_hpd_event_stop(dp);
>>          dp_power_client_deinit(dp->power);
>>          dp_aux_unregister(dp->aux);
>>          priv->dp[dp->id] = NULL;
>> @@ -1054,7 +1059,7 @@ static int hpd_event_thread(void *data)
>>
>>          dp_priv = (struct dp_display_private *)data;
>>
>> -       while (1) {
>> +       while (!kthread_should_stop()) {
>>                  if (timeout_mode) {
>>                          wait_event_timeout(dp_priv->event_q,
>>                                  (dp_priv->event_pndx == dp_priv->event_gndx),
>> @@ -1137,7 +1142,22 @@ static void dp_hpd_event_setup(struct dp_display_private *dp_priv)
>>          init_waitqueue_head(&dp_priv->event_q);
>>          spin_lock_init(&dp_priv->event_lock);
>>
>> -       kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
>> +       dp_priv->ev_tsk = kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
>> +
>> +       if (IS_ERR(dp_priv->ev_tsk))
>> +               DRM_ERROR("failed to create DP event thread\n");
> 
> Why can't we error out? Why can't this kthread be started in probe?

Just my 2c. I don't think starting it in probe is a good idea. The 
driver uses components, so, in my opinion, the thread should be started 
from bind and stopped in unbind.

> 
>> +}
>> +
>> +static void dp_hpd_event_stop(struct dp_display_private *dp_priv)
>> +{
>> +       if (IS_ERR(dp_priv->ev_tsk))
>> +               return;
>> +
>> +       kthread_stop(dp_priv->ev_tsk);
>> +
>> +       /* reset event q to empty */
>> +       dp_priv->event_gndx = 0;
>> +       dp_priv->event_pndx = 0;
>>   }
>>


-- 
With best wishes
Dmitry
