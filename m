Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4952A4F9A52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiDHQRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiDHQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:17:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EE357734
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:14:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j9so7821677lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/SWSieq/x4paIxvEX4XMyhkbxR8UMVfWRh7r/9jR+Cc=;
        b=moYf/PvSTIAmgGtZ+zmxrAouvxxE7YzhW3XrtHMUlrC6jl8mjoFVA8NVKnxUAWV6Ic
         xmG0mdHpBPdfE0wve8IIrNUNIcBeIVsB4AQKsYJg4qMovdmIh+iyrKC2sJvPITqHzWFo
         mfeOXwe4sGQlMymEKFeyAeBnwv+7Ivv+36QDjwFCxJs6V8KBLbxLHmOBdN5Wnt3d5+k4
         09CUrE8g69fwD4szHruGk5hYv5pkkAJlrmvru7YYzka0hDNzY30yksYjmCcZks4bm7nD
         I3gHb1fqk+aByJnM1JzQ6mpAOQ0fyywFDuekhO+27hHHyrd6nwOpwrfTHNv7EWdhdtfK
         80ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/SWSieq/x4paIxvEX4XMyhkbxR8UMVfWRh7r/9jR+Cc=;
        b=seOU8mLcYbDb1Sssb/mYis955aCixpZDcOXxyNnTA7lI1GvJBfV5g8e7V6/mL+xJVw
         LuswHkAnx+ez5UEfyy73Oxp/jM6QEU8aqtkbDct9QBsJ9OKM5mVUwHtfuP/KgQOl046t
         hJy5+2ZPcTLXN5tGRlZZI5Rn5adRNnV/2pQ+AFGpzR1R5zn/4lzZuYKrqJmcFbKQazwW
         17ve2CCFOFg1cyreD2pBt3f1bfy1myd095ZA9unYaVYhnpfWl7y6x4Av9OybQ0fTcj4T
         9H2EGMa/6l4akHWGiMojvq8irXU3YmpteTWS9nnT8n5Y8nydlQLcgAs8LoSGGH5zTozV
         jZ+w==
X-Gm-Message-State: AOAM531+L8mYjAAJY78PD0HuS/lTX/AnP8QsrEE1aj1SY7IRSl83vICX
        mbZPQA4bdwbJEMl6bqBaK9LVnQ==
X-Google-Smtp-Source: ABdhPJzwJcWy7YoPs+RM0xo8q4ohRQtmoCIFwBex9mQ/bLJoDJNhH9ND1g6yAXGxb79Kdi7PxaQnbA==
X-Received: by 2002:ac2:5448:0:b0:46b:877e:9c1e with SMTP id d8-20020ac25448000000b0046b877e9c1emr2028009lfn.326.1649434494149;
        Fri, 08 Apr 2022 09:14:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q22-20020a194316000000b0044a93059aa9sm2492444lfa.260.2022.04.08.09.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 09:14:53 -0700 (PDT)
Message-ID: <94da2c97-2ad2-4575-bd73-d66ad989e17b@linaro.org>
Date:   Fri, 8 Apr 2022 19:14:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 5/8] drm/msm/dp: prevent multiple votes for dp
 resources
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        quic_aravindh@quicinc.com
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-6-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=Wn-XypjRcw-D0VtBHZbuTz=RHiMq6RCHCa=CWmZM42nQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=Wn-XypjRcw-D0VtBHZbuTz=RHiMq6RCHCa=CWmZM42nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 02:23, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 30, 2022 at 9:04 AM Sankeerth Billakanti
> <quic_sbillaka@quicinc.com> wrote:
>>
>> The aux_bus support with the dp_display driver will enable the dp
>> resources during msm_dp_modeset_init. The host_init has to return early
>> if the core is already initialized to prevent putting an additional vote
>> for the dp controller resources.
>>
>> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
> I'm not a huge fan of this but I'll leave it up to Dmitry. In general
> it feels like there should be _a_ place that enables these resources.
> Checks like this make it feel like we just scattershot enabling
> resources in a bunch of random places instead of coming up with the
> design for enabling them in the right place.

I'd prefer to see a check for eDP in dp_display_config_hpd(). Or even 
better to see that this function isn't called for eDP at all.

> 
> In any case, if we do end up landing this patch, it sure feels like it
> needs to move earlier in the patch series, right? This patch shouldn't
> hurt even without the other patches in the series but if you apply the
> earlier patches in the series without this one then you'll have a bug,
> right? That means this needs to come earlier.
> 
> -Doug


-- 
With best wishes
Dmitry
