Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5225F587733
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiHBGoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHBGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:44:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8F45074
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:44:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c17so2092743lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZOIv/vib2AyO0KkqSUf/4LiDcnhQnMzPWNm6fTpfwe4=;
        b=zRsdTe2s2ok+tSA85hlsvI3Tp6wFqiwLQLGt0x5DWPDzHm3bXY1/ITRMp6N3Jo+x7p
         4pKD7OIvDedM5gi0YEQ4Z4v1ftVyjzsl1wFe4zma6Pv7sNCLToGtd08gqYlI39sN8fRW
         KGTHJ0N71mA6p05A4zRR3+2FK7Kb5EhYSz14PVS0G3m/XUv7I1zeRs2w3kdiZBMNeUPG
         tIuDT4HQ3L5BPCoqRAzEQjHb3xwZhw6DpC3aqUsjyyg864A1PpQQK/Z1VZV9gJ38kDfg
         z2OUYd22s9uATlIViBwdaZvCRIfF/YEcGqUdrh+pv9Pz/BsqaazOGmGEF24DHdlLpt3r
         pPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZOIv/vib2AyO0KkqSUf/4LiDcnhQnMzPWNm6fTpfwe4=;
        b=nxxuLxINQK744dp26QV6PnwdNa9m1tarHhk1YONO3XVsEXNs3WXl+JRr/oYwHQ9Igo
         oYxQuU+F1BwTCXiupjTa3gyEvuf6HIpzTa3rGsjAiFXoP3SgVwnnyKHeOmLlwgKwBli4
         bVt6ruCEB+Uq/mxqttWejgU4L3DHg0HQckwXTMWwjLm3Ddc0qRCWD/dJ8+1zNAG0rXsz
         AZrNYqBTw3MWurmV7NQwiaeQvTaoCTF+auNCLD5OeO6ZUKldN09N7NoUDYMZviPxw610
         tpa9bjH4cVZfXXDgUDEkBHyTbyaT9B/pwEwBCt9zc4L9Po9SnoJUis4k38efPLkQ095F
         PdrA==
X-Gm-Message-State: AJIora/efzhw/wqrO2gPcEqKqVThIwk8JYXnIKDCXzQ48M+8rHAla2Uo
        Nl1zDDMvKifW0m2fwEPJr0q9Tw==
X-Google-Smtp-Source: AGRyM1tb/aedcmiebbe1NUyI4UkGBdIxQqcLT2KKnD0mSMr6dbKmSZ1Ja9uT9FYb+wh62/LMA5bbWA==
X-Received: by 2002:a05:6512:3f1e:b0:48a:74cb:1409 with SMTP id y30-20020a0565123f1e00b0048a74cb1409mr6807833lfa.546.1659422640532;
        Mon, 01 Aug 2022 23:44:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b14-20020a05651c032e00b0025d5eb5dde7sm704460ljp.104.2022.08.01.23.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 23:44:00 -0700 (PDT)
Message-ID: <1948d519-9ec0-e874-d51a-6d9f2f5ca3f6@linaro.org>
Date:   Tue, 2 Aug 2022 09:43:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/msm/gpu: Drop qos request if
 devm_devfreq_add_device() fails
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220708162632.3529864-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220708162632.3529864-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 19:26, Bjorn Andersson wrote:
> In the event that devm_devfreq_add_device() fails the device's qos freq
> list is left referencing df->idle_freq and df->boost_freq. Attempting to
> initialize devfreq again after a probe deferral will then cause invalid
> memory accesses in dev_pm_qos_add_request().
> 
> Fix this by dropping the requests in the error path.
> 
> Fixes: 7c0ffcd40b16 ("drm/msm/gpu: Respect PM QoS constraints")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 2 ++
>   1 file changed, 2 insertions(+)


-- 
With best wishes
Dmitry
