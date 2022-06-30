Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4388C5621D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiF3SNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3SNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:13:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707810E0;
        Thu, 30 Jun 2022 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656612794; x=1688148794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PEKZxYZlf0wcPMg3FnbHkkbDO5CYIxcaK6zhZdRvs6E=;
  b=CVcEjdAD/stI+71OPiaOFw3053D9mP5f9gO0aqBcMXKC330nm6L1gjwe
   1MnAXeANF1MGjwhPhfUWJ6xFBktg+LwipR7q7Fc/AudYqOUAevrwesELO
   EOrUCgWBNgbRHbkI9pGspZhZebF47Qm4ufKMVZ04M2NPx57zM9sXTl+Sr
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Jun 2022 11:13:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 11:13:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 30 Jun 2022 11:13:11 -0700
Received: from [10.216.41.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 30 Jun
 2022 11:13:05 -0700
Message-ID: <c16a1c37-9183-8d0c-a5ad-39b897a0ab24@quicinc.com>
Date:   Thu, 30 Jun 2022 23:43:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from system
 suspend
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com> <Yp5nf2w8uVZ38/XZ@google.com>
 <Yqd9IHQEj3Ex+FcF@google.com> <YqjLHyUVEjf7I3MI@google.com>
 <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
 <YqtlRQOwb3t6Xtd0@google.com>
 <20220620085415.GA13744@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n52bq9feA6BVdAp791SWQtT1Yj4M2ppg3o_KOaRFO8r+0Q@mail.gmail.com>
 <20220628053148.GA21797@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n50PGw_XSZ0-iV7gem6+-LENoq6ZVOwX3f+0XjkrHg-rLw@mail.gmail.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAE-0n50PGw_XSZ0-iV7gem6+-LENoq6ZVOwX3f+0XjkrHg-rLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 6/30/2022 3:45 AM, Stephen Boyd wrote:
> Quoting Pavan Kondeti (2022-06-27 22:31:48)
>> On Mon, Jun 27, 2022 at 01:02:49PM -0700, Stephen Boyd wrote:
>>> Quoting Pavan Kondeti (2022-06-20 01:54:15)
>>>> Would like to hear other people thoughts on this.
>>>>
>>> I'm not following very closely but it sounds like a problem that may be
>>> solved by using the component driver code (see
>>> include/linux/component.h). That would let you move anything that needs
>>> to be done once the child devices probe to the aggregate driver 'bind'
>>> function (see struct component_master_ops::bind).
>> Thanks Stephen for letting us know about the component device framework.
>>
>> IIUC,
>>
>> - dwc3-qcom (parent of the dwc3 core) registers as a component master by
>> calling component_master_add_with_match() before calling
>> of_platform_populate(). The match callback could be as simple as comparing
>> the device against our child device.
>>
>> - The dwc3 core (child) at the end of its probe can add as a component by calling
>> component_add().
>>
>> - The above triggers the component_master_ops::bind callback implemented in
>>    dwc3-qcom driver which signals that we are good to go.
>>
>> - The dwc-qcom can call component_bind_all() to finish the formality i.e
>>    telling the dwc3 core that we are good to go.
>>
>> Is my understanding correct? This is what we are looking for i.e a way for
>> the child device(s) to signal the parent when the former is bounded.
> Sounds about right to me.
>
>> Also what happens when the child device probe fails for any reason. i.e
>> component_add() would never be called so the master driver i.e dwc3-qcom would
>> wait indefinitely. May be it needs to implement a timeout or runtime suspend
>> etc should take care of keeping the resoures in suspend state.
> When the child fails probe, it should return -EPROBE_DEFER if probe
> needs to be deferred. Then the driver will attempt probe at a later
> time. If probe fails without defer then it will never work and dwc3-qcom
> will wait indefinitely. Not much we can do in that situation.
Hi Stephen,

   Thanks for the idea. But doesn't adding dwc3 as a component to an agg
driver meanthat this change needs to be done on all glue drivers, as
component_bind_all( ) from master componentis supposed to let the dwc3
core know that we are good to go ?
> dwc3-qcom should wait for dwc3 core to call component_add() and then do
> whatever needs to be done once the dwc3 core is registered in the
> dwc3-qcom bind callback. Honestly this may all be a little overkill if
> there's only two drivers here, dwc3-qcom and dwc3 core. It could
> probably just be some callback from dwc3 core at the end of probe that
> calls some function in dwc3-qcom.
Since the issue we are facing is that the ssphy device links are not ready
causing the dwc3 probe not being invoked, can we add an API as Pavan 
suggested
to check if deferred_probe listfor dwc3 device is empty or not andbased on
that we can choose to defer our qcomprobe ? In this case, we don't need to
touch the dwc3 core driver and would be making changesonly in qcom glue 
driver.
