Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D287525814
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359351AbiELXFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359343AbiELXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:05:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A04AFAD5;
        Thu, 12 May 2022 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652396700; x=1683932700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Irmk+PIoDl9lVGe3CGNHkqKewPzKLkRFe6w4ku7l9SQ=;
  b=M7suJ0HBk4PZDniWOyJMxoqOaiYOayE9BxU34k9c8HqVAL23QDJ0WvRu
   S76R/1GI47qGQrA+vsJ3nv0stnBphPDgvIqKyoVC/rT25UplfAJ+k/g6e
   9y1U8Mo6/QoMuhrJu1xyyZQ9mQZGFtE9nEnkGRvOvYlZxwymBIhzg8dEl
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 May 2022 16:05:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:04:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 16:04:59 -0700
Received: from [10.38.247.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 16:04:56 -0700
Message-ID: <09d99477-ac9d-ee90-41f1-af13a302d25d@quicinc.com>
Date:   Thu, 12 May 2022 16:04:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] drm/msm/dsi: don't powerup at modeset time for
 parade-ps8640
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "David Airlie" <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>
References: <20220512145954.v4.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
 <dd62b8a7-43b9-364a-a427-94d621648012@linaro.org>
 <a721e2e9-934e-3028-cb1a-047f6d5c5b1e@quicinc.com>
 <CAD=FV=U_dfCzcW6kP9zH=pxOUAioTMwh7=0-_=zSAkX9hurZmg@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAD=FV=U_dfCzcW6kP9zH=pxOUAioTMwh7=0-_=zSAkX9hurZmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/2022 3:44 PM, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 12, 2022 at 3:34 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> On 5/12/2022 3:16 PM, Dmitry Baryshkov wrote:
>>> On 13/05/2022 01:00, Douglas Anderson wrote:
>>>> Commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
>>>> time") caused sc7180 Chromebooks that use the parade-ps8640 bridge
>>>> chip to fail to turn the display back on after it turns off.
>>>>
>>>> Unfortunately, it doesn't look easy to fix the parade-ps8640 driver to
>>>> handle the new power sequence. The Linux driver has almost nothing in
>>>> it and most of the logic for this bridge chip is in black-box firmware
>>>> that the bridge chip uses.
>>>>
>>>> Also unfortunately, reverting the patch will break "tc358762".
>>>>
>>>> The long term solution here is probably Dave Stevenson's series [1]
>>>> that would give more flexibility. However, that is likely not a quick
>>>> fix.
>>>>
>>>> For the short term, we'll look at the compatible of the next bridge in
>>>> the chain and go back to the old way for the Parade PS8640 bridge
>>>> chip. If it's found that other bridge chips also need this workaround
>>>> then we can add them to the list or consider inverting the condition.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com
>>>>
>>>>
>>>> Fixes: 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
>>>> time")
>>>> Suggested-by: Rob Clark <robdclark@gmail.com>
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>> Yes, I think this is a better solution than a full revert
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> I am curious to know why this doesnt work for parade but will not hold
>> this patch back for that. We are initializing and turning on DSI PHY now
>> before turning on the bridge chip which is actually better as we are
>> putting PHY in a good state.
>>
>> So this should have been better, but somehow doesn't work.
> 
> I can't really explain it, but mostly because the Parade chip is just
> a big black box. There have been several times when an OEM using this
> bridge chip had one problem or another with getting the display to
> turn on, then the parade FAE would make some magic tweak to the
> firmware and it would be fixed. The current way that the Linux driver
> is working is with pretty much zero configuration so I think this chip
> bakes in a bunch of assumptions about the timings / signal coming from
> the MIPI DSI side. It doesn't surprise me that changing the order like
> this would confuse it.
> 
> In theory I believe the Parade chip can run in a less "automatic" mode
> where everything is configured and controlled by Linux. I'd really
> have preferred if we could have gotten that done, but it didn't end up
> happening. :(
> 
> -Doug

Again this is not to block this change (you already have my ack) but 
perhaps to help you debug this for future reference as we wont know what 
change can break parade even in the future if this happens again and the 
compatible check for parade will keep growing.

One suggestion I can give is can we read any status bits out of the 
parade chip in the power_on() method as its right after the new method 
to check why its not in good status or what error bits it throws and 
perhaps share those error bits with the FAE to see when this error can 
come to decode this black box a bit :)

 From those bits, we can narrow down why this timing or sequence change 
is affecting them. Like some things could be somehow this is delaying 
the video pixels from transmitting, it expects PHY to be in some state 
etc and we can kind-of reverse engineer why this change broke it.

Like-wise, it is highly possible at the moment we have identified only 
parade not to work but if there is something wrong with this change we 
can atleast know what and address it.

Thanks

Abhinav
