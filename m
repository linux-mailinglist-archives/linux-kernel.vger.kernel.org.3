Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE024ED79A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiCaKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiCaKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:12:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6144C7AC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:10:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so40692829lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DkPFTvrQEeskfvBTqfSOajTcre8fVDqFYzIN3B6dTsI=;
        b=KItC8IMn5rncXU6DjNFWlsw2ttC3GaaAEUbxCnBOR7T/9Tfj6lRHHFcT2drBRA225/
         dk71o9m/4VllMnJRSsHw7LpJ9ASmXszD3qY5Zz+5TfhYdsRg38C3XtGxx2w1jGsQWBY8
         ih5uzDcudKl79At3nt5SsfB64kDTfNMDqHWXP07DhGCY1vsGKCPn+LukasFPljTlUHJI
         fP10i7MwzuQBxdQAzpmwtCsOshjAuwnIOjprbAKbJ1Yy6ciMxquv4ewcAaNOedjPDwYA
         nOxsNYnOLJ6pOXJnjlR2ncJeheVQ923O6vmgq2BTKrYI1rCvcolTwFfgDgtF5Fn0MUui
         Bdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DkPFTvrQEeskfvBTqfSOajTcre8fVDqFYzIN3B6dTsI=;
        b=M/Cmr1UxqDycB3s2uyB5rDpAh1q/BsmlwLq4nOjNjK7izFTN4FnI8FJ59uORIO9QFS
         q0YWGVgN2fp983JzyAwO2bz+wRpP6dlZQItcTSqRdPVeWTUJe+Tz+SYLINJwizQbcppz
         ccCUiFeZ2o/labJ4cZ0xcNlQg4FWd7BkKr8kiFdN0glF7AoEWPku2hsKkaypChTqX5Wz
         NUEDu5v0LkHqrej3uDBALuq7rHfN0R9PWQysZlCoivJjPVmS8QoKmgCsMZiuFMFx2QB2
         GXiRQmfyUBLGExemRHOMYfWW5cSKBnERgiJ7LbvuU0GOqQKbzQX9wBr2nhsmeWTl+wmW
         eNEQ==
X-Gm-Message-State: AOAM533QocEXHAgLMqI3aBQOmvqfn4EkAe+OYzmcbBOf8NlgJ9ERWusA
        sBqe6Bv4iGO0PPS2Rk1RdqaSoA==
X-Google-Smtp-Source: ABdhPJwtAJyMy0EoY+rrG6bKX7082NXgD8paVU/49U2dxYES7x6TI8M54x7s0LTqdnwet5PnHMXT9w==
X-Received: by 2002:ac2:485b:0:b0:44a:23d5:d4bd with SMTP id 27-20020ac2485b000000b0044a23d5d4bdmr10216994lfy.214.1648721428984;
        Thu, 31 Mar 2022 03:10:28 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a26-20020a19fc1a000000b0044ab4920887sm805769lfi.57.2022.03.31.03.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 03:10:28 -0700 (PDT)
Message-ID: <d9ac1cee-d4fc-09ae-b2df-82ae2ecd57fb@linaro.org>
Date:   Thu, 31 Mar 2022 13:10:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 4/8] drm/msm/dp: avoid handling masked interrupts
Content-Language: en-GB
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-5-git-send-email-quic_sbillaka@quicinc.com>
 <CAA8EJprMvik_6xmGt2oZGpDG9FoMtC_ojuw+oTjPLTck4Hu3WA@mail.gmail.com>
 <MW4PR02MB7186669BA1B19FA4F184B558E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <MW4PR02MB7186669BA1B19FA4F184B558E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 08:53, Sankeerth Billakanti (QUIC) wrote:
> Hi Dmitry,
> 
>> On Wed, 30 Mar 2022 at 19:03, Sankeerth Billakanti
>> <quic_sbillaka@quicinc.com> wrote:
>>>
>>> The interrupt register will still reflect the connect and disconnect
>>> interrupt status without generating an actual HW interrupt.
>>> The controller driver should not handle those masked interrupts.
>>>
>>> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_catalog.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c
>>> b/drivers/gpu/drm/msm/dp/dp_catalog.c
>>> index 3c16f95..1809ce2 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
>>> @@ -608,13 +608,14 @@ u32 dp_catalog_hpd_get_intr_status(struct
>>> dp_catalog *dp_catalog)  {
>>>          struct dp_catalog_private *catalog = container_of(dp_catalog,
>>>                                  struct dp_catalog_private, dp_catalog);
>>> -       int isr = 0;
>>> +       int isr, mask;
>>>
>>>          isr = dp_read_aux(catalog, REG_DP_DP_HPD_INT_STATUS);
>>>          dp_write_aux(catalog, REG_DP_DP_HPD_INT_ACK,
>>>                                   (isr & DP_DP_HPD_INT_MASK));
>>> +       mask = dp_read_aux(catalog, REG_DP_DP_HPD_INT_MASK);
>>>
>>> -       return isr;
>>> +       return isr & (DP_DP_HPD_STATE_STATUS_MASK | mask);
>>
>> I suspect that the logic is inverted here. Shouldn't it be:
>>
>> return isr & DP_DP_HPD_STATE_STATUS_MASK & mask;
>>
>> ?
>>
>   
> The value of DP_DP_HPD_STATE_STATUS_MASK is 0xE0000000 and the value of the read
> interrupt mask variable could be is 0xF.
> 
> The mask value is indicated via the register, REG_DP_DP_HPD_INT_MASK, bits 3:0.
> The HPD status is indicated via a different read-only register REG_DP_DP_HPD_INT_STATUS, bits 31:29.

I see. Maybe the following expression would be better?

return isr & (mask & ~DP_DP_HPD_INT_MASK);

> 
> isr & DP_DP_HPD_STATE_STATUS_MASK & mask, will return 0 always.
> 
>>>   }
>>>
>>>   int dp_catalog_ctrl_get_interrupt(struct dp_catalog *dp_catalog)
>>> --
>>> 2.7.4
>>>
>>
>>
>> --
>> With best wishes
>> Dmitry
> 
> Thank you,
> Sankeerth


-- 
With best wishes
Dmitry
