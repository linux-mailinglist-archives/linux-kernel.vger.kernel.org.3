Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6CB508321
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376619AbiDTIJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376695AbiDTIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:08:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3B9C16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:05:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j8so1096456pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VJvWJPipJHgyfcIiSRVr/9+92NOFrMY62eI57j6ONHM=;
        b=eElVku/lXRj5TNoEgMrlC4V4RxNI2mlNrAa9/FIK4ITD9l6EbTmL9iexMMBYFrKfVZ
         IslU9ZhkZcElVrTPzIaD71hnmB/or5KvGOZr5EP29vDn3EmwQ16vU8IokKSXEdbksf9R
         UXlW+7wyTDdcaEN0Hzz+WSFnQ28AvijGNL4uiPyBCvvE+irC81iDfs9C1SURc8/QQ/0D
         ilH+LFnIXN9e6gvQpRW3CP2CttkaDspJ3V72h9noxjPYQpJ+MWxnnKg4H6P1hBMaGnrt
         6yZmv08vUquiFonc+o21ceFlbSkelwmv1ICyw/DYRH63tXRcPTUQSp8AHuIKD5DyHNGt
         w0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VJvWJPipJHgyfcIiSRVr/9+92NOFrMY62eI57j6ONHM=;
        b=BQf7+i8TNTerDh/exQGMkld9NXLepNJRpUSHNNJxM5axckxTrTxT5WzLZIM58UI5Fv
         GYkpnTs+N5yH7wTMLUDhihDaiJ6ckcbxYN6QZxnbrd7Xbh43q9gf0n8O7o61lVdbqs39
         E5IMHURs9qn87t1LUD30gGkp1OLmz35o6M0N5A+Xa4gPa83ZcHLl45VxXXy71wBTOETd
         3Mw+V7S7Jkf7NPKtcikOA9G9i+PZUZVMceWdKw6VB+bLdo7xLnDFzsyw6rUqg2EK5Wxx
         9ATMnAYV2e8YdldS6CXUldFPtQYSBrnR2cuMbiCEYOV8h5Sddapwjbg1pRmmpF/tx8CB
         w/oQ==
X-Gm-Message-State: AOAM530iZpE4wul8Gfo/ah4JvB4SGhjMPnKTnq0+Jf7D32jP6twDbnAY
        Lb9OMrtOlsFY3LccywXi5NES0iOQv1YXn6kJ
X-Google-Smtp-Source: ABdhPJzk0weKl78YNFVL165GqBuD7AaxSEu7AdBAJT4DJwASOnYKRTq/tqmUp4CBXgx/fW/PllS9ew==
X-Received: by 2002:a17:90a:db08:b0:1c9:7cf3:6363 with SMTP id g8-20020a17090adb0800b001c97cf36363mr3033125pjv.35.1650441940309;
        Wed, 20 Apr 2022 01:05:40 -0700 (PDT)
Received: from [192.168.1.100] ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090a014100b001d2eb7fe951sm3339335pje.13.2022.04.20.01.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 01:05:40 -0700 (PDT)
Message-ID: <96d27d1f-55e4-578a-75e5-686362c05dcf@gmail.com>
Date:   Wed, 20 Apr 2022 16:05:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] drm/vc4: Fix pm_runtime_get_sync() usage
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220419124407.ugzl7hknsytbhrmr@houat>
 <20220420004949.20508-1-linmq006@gmail.com>
 <20220420075108.xm5ujthootlpayy2@houat>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220420075108.xm5ujthootlpayy2@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/20 15:51, Maxime Ripard wrote:
> On Wed, Apr 20, 2022 at 12:49:48AM +0000, Miaoqian Lin wrote:
>> If the device is already in a runtime PM enabled state
>> pm_runtime_get_sync() will return 1, so a test for negative
>> value should be used to check for errors.
>>
>> Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
>> fails, so use pm_runtime_resume_and_get() instead. this function
>> will handle this.
>>
>> Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>> change in v2:
>> - switch to pm_runtime_resume_and_get() to fix refcount leak.
>> ---
>>  drivers/gpu/drm/vc4/vc4_dsi.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
>> index 752f921735c6..9d7ffaf6bc70 100644
>> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
>> @@ -846,8 +846,8 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
>>  	unsigned long phy_clock;
>>  	int ret;
>>  
>> -	ret = pm_runtime_get_sync(dev);
>> -	if (ret) {
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0) {
> pm_runtime_resume_and_get will return 0 on success, so the previous check was correct

previous check is for pm_runtime_get_sync() not for pm_runtime_resume_and_get (),

I switch to pm_runtime_resume_and_get() to fix the refcount leak bug at the same time.

Sure it's ok to use check if(ret) to check the retval, I just follow a more common way

for usage of pm_runtime_resume_and_get() in the codebase—— check ret<0

Since pm_runtime_resume_and_get() return negative error code.

> Maxime
