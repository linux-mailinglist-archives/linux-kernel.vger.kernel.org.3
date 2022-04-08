Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0F4F9B98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiDHRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiDHRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:25:33 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7E15FC6;
        Fri,  8 Apr 2022 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649438609; x=1680974609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aa5sCfirQTu8in8E9d3/He4tgrCReFZ3CgCEUVvEwHo=;
  b=Zom5E9ESdRO37HNAzAxF/vwo4nxl+JOtYmBQXKTe/vd2h+Qdeki6nQjD
   2yNhOhYbzpH4MIosszYtpDFa9/snTmmhTSXw8M+BjO7WJdJt8YdkB8hgK
   KIJ4awuTJRyJhApAqiQp8VWEPPjcxwDV+ZSl0NVV6lLBA9w4zr/4siezJ
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Apr 2022 10:23:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:23:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Apr 2022 10:23:28 -0700
Received: from [10.111.161.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 8 Apr 2022
 10:23:24 -0700
Message-ID: <e91f4f18-020b-7919-0a82-0b733cdc2de2@quicinc.com>
Date:   Fri, 8 Apr 2022 10:23:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>
CC:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
 <3e5fa57f-d636-879a-b98f-77323d07c156@linaro.org>
 <CAD=FV=Uibu-kZyix7K4_WVc-+C8xpzTqU4WFy7O=6sukMZrX5g@mail.gmail.com>
 <MW4PR02MB7186245772DAC3E04FA8D1C0E1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com>
 <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com>
 <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
 <225d2c0a-42ec-28ad-688c-e7e9e2035ee1@quicinc.com>
 <CAD=FV=W=WjSACHvRDFBnkLUp-LU2c4XMu3=FTzTx=zexNF5PAw@mail.gmail.com>
 <CAA8EJpqLZ9up4euGEbhf5QyBqm4tJuLcHi7D+0Si7ak9Jej52w@mail.gmail.com>
 <CAD=FV=XwOzsRf7RnvyBjr5TtedMhC0LJFKoK9tp-kw1eEyuJmQ@mail.gmail.com>
 <CAA8EJprb5UF24WRNvGaY_hSqW--NPd=9=8AaPYWSMbUumNn+dQ@mail.gmail.com>
 <CAD=FV=UG7k4A+hMXxwju-0mLddD1oJdGngXMkMA-dO3AxOx0rQ@mail.gmail.com>
 <CAA8EJprLRiWrkqLG09UG1arDmo1fuq917ztfxts66p+AaYcYbA@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJprLRiWrkqLG09UG1arDmo1fuq917ztfxts66p+AaYcYbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug and Dmitry

On 4/8/2022 7:58 AM, Dmitry Baryshkov wrote:
> On Fri, 8 Apr 2022 at 16:43, Doug Anderson <dianders@chromium.org> wrote:
>>
>> Hi,
>>
>> On Fri, Apr 8, 2022 at 5:20 AM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>>>
>>>> I guess my thought was that in DP you could still create the AUX bus
>>>> at probe time. Then for DP you just return an instant "transfer
>>>> failed" from the AUX bus if HPD isn't asserted. For eDP (as discussed
>>>> elsewhere) when we try to do an AUX transfer then we delay until HPD
>>>> is there.
>>>
>>> I think panel-edp would already handle the delay, so we do not need to
>>> have this logic in the DP driver.
>>
>> There's a whole discussion about this between Stephen and me in patch
>> #5 ("drm/msm/dp: wait for hpd high before any sink interaction").
>> Basically:
>>
>> * If panel HPD is hooked up to the dedicated HPD pin on the eDP
>> controller then the panel driver doesn't have a way to read it.
> 
> I refreshed that dialog. I must admit, I have missed the fact that the
> HPD pin might not be visible as the GPIO pin.
> 
>> * We can't leverage the existing "HPD" query functions in DRM because
>> those indicate whether a panel is _physically_ connected. For eDP, it
>> always is.
> 
> Yes, I was thinking about (mis)using the
> drm_bridge_connector_hpd_notify() for generic HPD-related
> notifications (to tell eDP that it should check the current state). I
> have abandoned that idea.
> 
>> For now the rule is that the AUX transfer function is in charge of
>> waiting for HPD for eDP if the dedicated HPD pin is used. If we want
>> to re-invent this we could, but that system works, isn't _too_ ugly,
>> and we're already making big enough changes in this series.
> 
> The is_hpd_asserted() looks like a good callback for the aux bus.
> It will allow the panel driver to check if the panel is powered up (in
> the absence of the GPIO pin).
> 
>>>> So we can still acquire resources (clocks, PHY, io maps, etc) at probe
>>>> time for DP and create the AUX bus, right? It will just return
>>>> "-ENODEV" if HPD isn't asserted and you're DP?
>>>
>>> Yes, please. I still suppose that we'd need a separate case to
>>> power_on eDP's PHY during the probe time. Maybe I'm mistaken here.
>>
>> I think the ideal way is to do it like Kieran's proposal for sn65dsi86:
>>
>> https://lore.kernel.org/r/20220317131250.1481275-4-kieran.bingham+renesas@ideasonboard.com/
>>
>> * When enabling HPD (physical hot plug detect) in the hpd_enable()
>> callback you do a pm_runtime_get(). You do the
>> pm_runtime_put_autosuspend() when disabling. This is only used for DP
>> since we only provide DRM_BRIDGE_OP_HPD for DP, not for eDP.
>>
>> * We do a pm_runtime_get() / pm_runtime_put_autosuspend() in the AUX
>> transfer routine. While holding the pm_runtime reference we check HPD.
>> For DP we return immediately if HPD isn't asserted. For eDP, we delay.
>>
>> * We do the pm_runtime_get() in pre_enable and the pm_runtime_put() in
>> post_disable. For DP this will add a 2nd refcount (since we probably
>> were holding the reference for HPD). For eDP this will cause us to
>> power on.
>>
>> * If there's any other time we need to read HW registers, and we
>> aren't guaranteed to already have a pm_runtime reference (like during
>> probe), we can do a temporary pm_runtime_get() /
>> pm_runtime_put_autosuspend().
> 
> This looks good. I'd be more than welcome to review such series.
> 
> Note: I think this would require using
> drm_bridge_connector_enable_hpd() in the DP code.
> Hopefully at some point we would be able to move all
> drm_bridge_connector calls to the core msm layer.
> --
> With best wishes
> Dmitry


Thanks for the proposals.

In general I would break up this task as follows:

1) Re-factoring dp/edp parsing code to move it to probe ( its currently
done in bind ). So not sure what dependencies we will uncover there.
Nonetheless, lets assume for now it can be done.

2) Then bind all the power resources needed for AUX in pm_runtime_ops

3) Handle EPROBE_DEFER cases of the panel-eDP aux device

4) Probably the biggest from our point of view --- makes sure none of 
this breaks DP/eDP

Since QC will be taking ownership of all of this, I would still suggest 
land this series first so that basic display functionality on sc7280
chromebooks works, unblocks more developers and this program and we can
internally evaluate all of this and post the changes as-and-when ready
for review.

So, I suggest/request acking this current one after
fixing the other comments (unrelated to this re-factor) which have been 
given so far ofcourse, as we all agree this is not breaking and seems 
pretty reasonable short term.

Doug, you can track this re-factor with a different bug so that all this 
discussion remains intact.

Thanks

Abhinav


