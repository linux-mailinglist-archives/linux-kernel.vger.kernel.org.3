Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375D5662DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiGEFlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEFlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:41:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD6265E;
        Mon,  4 Jul 2022 22:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656999671; x=1688535671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10yG6y6njUSdyHbnv5fALLIcr4SspTq4ByE5kOtgKqY=;
  b=E1N+Ko7cnsb4KvgCq+VpxxB3xiN8fbAkUoCNU1c6szXd4p2auKWkVvoO
   RuLHrQ+u3ylWf3msQR57FFsomI67a0q90x1x486NGIeWFr5Yv9uKKPmeD
   s+ii9YUdfWIZhCRTuhWwhHhrPQ/hSeiMwSh3kjsRv8zRb6rHp9ra314Jo
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Jul 2022 22:41:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:41:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 22:41:10 -0700
Received: from [10.111.163.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Jul 2022
 22:41:06 -0700
Message-ID: <48f97293-9fe2-a9fd-b051-fd1fc190bc6c@quicinc.com>
Date:   Mon, 4 Jul 2022 22:41:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH] drm/msm/dp: make eDP panel as the first
 connected connector
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Vinod Koul" <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
References: <1656429606-2765-1-git-send-email-quic_khsieh@quicinc.com>
 <F35C87BF-46A5-41D3-B8A5-B2AB4A24252D@linaro.org>
 <CAD=FV=X3cv=Q30pODyi__OyRY+LbFT14RfEELvm_DAeHafF70g@mail.gmail.com>
 <CAF6AEGvFYK3x_CmErkKsmYNEv9y8AksE9UB_sfp-Z7RieX=tVg@mail.gmail.com>
 <E87F561E-22B4-46B6-AD9B-4995E92A8E29@linaro.org>
 <1df69cf9-7610-45af-240c-1b8e02953bc1@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1df69cf9-7610-45af-240c-1b8e02953bc1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2022 11:14 AM, Dmitry Baryshkov wrote:
> On 30/06/2022 09:14, Dmitry Baryshkov wrote:
>>
>>
>> On 30 June 2022 04:57:35 GMT+03:00, Rob Clark <robdclark@gmail.com> 
>> wrote:
>>> On Wed, Jun 29, 2022 at 5:36 PM Doug Anderson <dianders@chromium.org> 
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Jun 28, 2022 at 1:14 PM Dmitry Baryshkov
>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>
>>>>> On 28 June 2022 18:20:06 GMT+03:00, Kuogee Hsieh 
>>>>> <quic_khsieh@quicinc.com> wrote:
>>>>>> Some userspace presumes that the first connected connector is the 
>>>>>> main
>>>>>> display, where it's supposed to display e.g. the login screen. For
>>>>>> laptops, this should be the main panel.
>>>>>>
>>>>>> This patch call drm_helper_move_panel_connectors_to_head() after
>>>>>> drm_bridge_connector_init() to make sure eDP stay at head of
>>>>>> connected connector list. This fixes unexpected corruption happen
>>>>>> at eDP panel if eDP is not placed at head of connected connector
>>>>>> list.
>>>>>
>>>>> The change itself is a good fix anyway. (And I'd ack it.) However I 
>>>>> would like to understand why does it fix the corruption issue. What 
>>>>> is we have eDP and DSI, with DSI ending up before the eDP? Would we 
>>>>> see the issue?
>>>>> Also could you please describe the mind of corruption you are 
>>>>> observing?
>>>>
>>>> I've spent a whole bunch of time poking at this and in the end my
>>>> conclusion is this:
>>>>
>>>> 1. The glitchyness seems to be a result of the Chrome OS userspace
>>>> somehow telling the kernel to do something wrong.
>>>>
>>>> 2. I believe (though I have no proof other than Kuogee's patch fixing
>>>> things) that the Chrome OS userspace is simply confused by the eDP
>>>> connector being second. This would imply that Kuogee's patch is
>>>> actually the right one.
>>>>
>>>> 3. It would be ideal if the Chrome OS userspace were fixed to handle
>>>> this, but it's an area of code that I've never looked at. It also
>>>> seems terribly low priority to fix since apparently other OSes have
>>>> similar problems (seems like this code was originally added by
>>>> RedHat?)
>>>>
>>>>
>>>> Specifically, I tested with a similar but "persistent" glitch that I
>>>> reproduced. The glitch Kuogee was digging into was a transitory glitch
>>>> on the eDP (internal) display when you plugged in a DP (external)
>>>> display. It would show up for a frame or two and then be fixed. I can
>>>> get a similar-looking glitch (vertical black and white bars) that
>>>> persists by doing these steps on a Chrome OS device (and Chrome OS
>>>> kernel):
>>>>
>>>> a) Observe screen looks good.
>>>> b) Observe DP not connected.
>>>> c) Plug in DP
>>>> d) See transitory glitch on screen, then it all looks fine.
>>>> e) set_power_policy --ac_screen_dim_delay=5 --ac_screen_off_delay=10
>>>> f) Wait for screen to turn off
>>>> g) Unplug DP
>>>> h) Hit key on keyboard to wake device.
>>>> i) See glitchy.
>>>> j) Within 5 seconds: set_power_policy --ac_screen_dim_delay=5000
>>>> --ac_screen_off_delay=10000
>>>>
>>>> Once I'm in the persistent glitch:
>>>>
>>>> * The "screenshot" command in Chrome OS shows corruption. Not exactly
>>>> black and white bars, but the image produced has distinct bands of
>>>> garbage.
>>>>
>>>> * I can actually toggle between VT2 and the main screen (VT1). Note
>>>> that VT1/VT2 are not quite the normal Linux managed solution--I
>>>> believe they're handled by frecon. In any case, when I switch to VT2
>>>> it looks normal (I can see the login prompt). Then back to VT1 and the
>>>> vertical bars glitch. Back to VT2 and it's normal. Back to VT1 and the
>>>> glitch again. This implies (especially with the extra evidence of
>>>> screenshot) that the display controller hardware is all fine and that
>>>> it's the underlying data that's somehow messed up.
>>>
>>> fwiw, from looking at this a bit w/ Doug, I think the "glitch" is
>>> simply just an un-renderered buffer being interpreted by the display
>>> controller as UBWC (because userspace tells it to)
>>
>> Thanks for the description. I think the userspace code should be fixed 
>> too, but this patch can go in on its own.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> After some time (please excuse me), musing with the code and even 
> picking up the commit for the merge branch, I understood the fact that I 
> did not like about this change. It moves all panel connectors (generic 
> code) from the DP-specific driver.
> 
> I'd like to retract my R-b. Please move this call to the msm_drm_init(). 
> Calling this function somewhere after the ->kms_init() would make sure 
> that all panel connectors are close to the top of the list, whichever 
> MDP/DPU driver is used and whichever actual interface is bound to this 
> panel.
> 
Ah. True, but just to add. It should be after kms_init() but before 
drm_dev_register().

>>
>>
>>>
>>> BR,
>>> -R
>>>
>>>> When I pick Kuogee's patch then this "persistent" glitch goes away
>>>> just like the transitory one does.
>>>>
>>>> I'm going to go ahead and do:
>>>>
>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>> Tested-by: Douglas Anderson <dianders@chromium.org>
>>
> 
> 
