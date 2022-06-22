Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EBF5552AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377366AbiFVRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376453AbiFVRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:42:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446934654
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:42:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c4so28965069lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Md1LFFMVf3qzgQl06XYv2bG2aVcmSQ0Imz09zcqF9fE=;
        b=BKHdplf9Z9UYjFpu0usV1HiUVRkZrmz6azNJU7EC0MviAcfmO/rMhk1qqtXUmZJ5IL
         hdjnrvu84pvYn8IVuFvN1f4Br15iQ7froaX8gqPoFdJDxRn39/uc+pt0KXQRc8y1FrBg
         7EYrgyuwW8eOEro4h+ZrqssVv+yMUnSl+U3TCAOvcTUWCU6PSfwFGIYzyi7iTHrPtu6t
         qrjTm1Tsh/UsLuBTseWzt9aDUuks/Uc0JnM87Dyj8KP4mtTPfMSI6m5c4AV94mb0BAJt
         xCeq/L2uxpIE785DkcbrummXJZ/HiWvDS0uc47Bs/8zviuoh9zGldNWQclHF1KwDInbN
         6MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Md1LFFMVf3qzgQl06XYv2bG2aVcmSQ0Imz09zcqF9fE=;
        b=FKPiuNsAjMkPAAv2BRa1DUSTGbneOvxM48uEp/Bp8csYedjM5cVJpw2zag1WRMrH0V
         w0tHwHlUV7qfw9ycYHZ0NEszQUrIny4QaaXex6zoYt5Pz6ge+0SDiDp0ozwraVTJkdCg
         ZsFNcdFHgn+go+cS20sbSjZkTHd1DGq66d5/ITtxU3jAdk6Qi3y2xwapj6U2QSgpirCd
         pTtnbejA6flAi84LHSPE/p6jJTfYXbgbbaEFucmdK2xd6bX6UmLug38opvpqa1d8bx9Y
         84er9HVB/h9CRhQyEWGZ4/0bC1HYEsiQqJJprcyT2V3SPBMuISEY2T5AadonC0JhUjei
         vG2A==
X-Gm-Message-State: AJIora82OpRSWvMh7hl3oI7/oxAOADeL+CFULQg6kIPq5AKCILTXqyT1
        QaJBYrA3g86v99lG9J5oO1h/oA==
X-Google-Smtp-Source: AGRyM1t7MP6/Z+Yz4nicI0Mu0cth9yPiwZA7MruELCF+kKK//sFOF/JfUauGdWLSIkbgxgAVQEmhvw==
X-Received: by 2002:ac2:5cc6:0:b0:47f:7a4b:9db8 with SMTP id f6-20020ac25cc6000000b0047f7a4b9db8mr2803564lfq.592.1655919719106;
        Wed, 22 Jun 2022 10:41:59 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e99c3000000b0025574e803fasm2511387ljj.18.2022.06.22.10.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:41:58 -0700 (PDT)
Message-ID: <8394943c-8d51-df67-1603-6f37ac26a730@linaro.org>
Date:   Wed, 22 Jun 2022 20:41:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/msm/dpu: Increment vsync_cnt before waking up
 userspace
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mark Yacoub <markyacoub@chromium.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20220622023855.2970913-1-swboyd@chromium.org>
 <b133b67f-0d99-af6b-94a5-d5ff4b5752f1@quicinc.com>
 <CAF6AEGuL0+3162jGb2YLsYoW-fmNsARuKcvE-+d5hRkCiicp4g@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAF6AEGuL0+3162jGb2YLsYoW-fmNsARuKcvE-+d5hRkCiicp4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 20:33, Rob Clark wrote:
> On Wed, Jun 22, 2022 at 10:24 AM Abhinav Kumar
> <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 6/21/2022 7:38 PM, Stephen Boyd wrote:
>>> The 'vsync_cnt' is used to count the number of frames for a crtc.
>>> Unfortunately, we increment the count after waking up userspace via
>>> dpu_crtc_vblank_callback() calling drm_crtc_handle_vblank().
>>> drm_crtc_handle_vblank() wakes up userspace processes that have called
>>> drm_wait_vblank_ioctl(), and if that ioctl is expecting the count to
>>> increase it won't.
>>>
>>> Increment the count before calling into the drm APIs so that we don't
>>> have to worry about ordering the increment with anything else in drm.
>>> This fixes a software video decode test that fails to see frame counts
>>> increase on Trogdor boards.
>>>
>>> Cc: Mark Yacoub <markyacoub@chromium.org>
>>> Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
>>> Fixes: 885455d6bf82 ("drm/msm: Change dpu_crtc_get_vblank_counter to use vsync count.")
>>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>
>> This is right, we should increment before drm_crtc_handle_vblank() as
>> that will query the vblank counter. This also matches what we do
>> downstream, hence
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> One small nit though, shouldnt the fixes tag be
>>
>> 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> 
> *Kinda*.. but the sw vblank counter wasn't used for reporting frame nr
> to userspace until 885455d6bf82.  You could possibly list both,
> perhaps, but 885455d6bf82 is the important one for folks backporting
> to stable kernels to be aware of

I'd agree, the original Fixes tag seems good to me.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
