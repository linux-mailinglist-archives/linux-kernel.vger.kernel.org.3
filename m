Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD254BAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiFNThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiFNThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:37:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB01AD9C;
        Tue, 14 Jun 2022 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655235435; x=1686771435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ry/MW3cGwWBXJo5LFJEWkEv0wSGZc+G+X/VY17t5peg=;
  b=PjVpzy4ii1sO+Qcgo7VS3vnSE6g0z3LunX42RtB6IZPu9VfOFBG1cI5m
   41dp9diZ36CDK90t54GdF2tx7ubFxYD8gs7eYUekcU9meZYvMYQws7d25
   mGuwDnIzGOBOdscPmIAxROxyoaVcXi9Ntm11OroU+vFVBotcmnc8iuYlv
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jun 2022 12:37:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 12:37:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 12:37:13 -0700
Received: from [10.216.52.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 12:37:07 -0700
Message-ID: <4b22f283-0897-6729-e54f-a8bb47b5c368@quicinc.com>
Date:   Wed, 15 Jun 2022 01:07:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from system
 suspend
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com> <Yp5nf2w8uVZ38/XZ@google.com>
 <Yqd9IHQEj3Ex+FcF@google.com> <YqjLHyUVEjf7I3MI@google.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YqjLHyUVEjf7I3MI@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/2022 11:23 PM, Matthias Kaehlcke wrote:
> On Mon, Jun 13, 2022 at 11:08:32AM -0700, Matthias Kaehlcke wrote:
>> On Mon, Jun 06, 2022 at 01:45:51PM -0700, Matthias Kaehlcke wrote:
>>> On Thu, Jun 02, 2022 at 12:35:42PM -0700, Matthias Kaehlcke wrote:
>>>> Hi Krishna,
>>>>
>>>> with this version I see xHCI errors on my SC7180 based system, like
>>>> these:
>>>>
>>>> [   65.352605] xhci-hcd xhci-hcd.13.auto: xHC error in resume, USBSTS 0x401, Reinit
>>>>
>>>> [  101.307155] xhci-hcd xhci-hcd.13.auto: WARN: xHC CMD_RUN timeout
>>>>
>>>> After resume a downstream hub isn't enumerated again.
>>>>
>>>> So far I didn't see those with v13, but I aso saw the first error with
>>>> v16.
>>> It also happens with v13, but only when a wakeup capable vUSB <= 2
>>> device is plugged in. Initially I used a wakeup capable USB3 to
>>> Ethernet adapter to trigger the wakeup case, however older versions
>>> of this series that use usb_wakeup_enabled_descendants() to check
>>> for wakeup capable devices didn't actually check for vUSB > 2
>>> devices.
>>>
>>> So the case were the controller/PHYs is powered down works, but
>>> the controller is unhappy when the runtime PM path is used during
>>> system suspend.
>> The issue isn't seen on all systems using dwc3-qcom and the problem starts
>> during probe(). The expected probe sequence is something like this:
>>
>> dwc3_qcom_probe
>>    dwc3_qcom_of_register_core
>>      dwc3_probe
>>
>>    if (device_can_wakeup(&qcom->dwc3->dev))
>>      ...
>>
>> The important part is that device_can_wakeup() is called after dwc3_probe()
>> has completed. That's what I see on a QC SC7280 system, where wakeup is
>> generally working with these patches.
>>
>> However on a QC SC7180 system dwc3_probe() is deferred and only executed after
>> dwc3_qcom_probe(). As a result the device_can_wakeup() call returns false.
>> With that the controller/driver ends up in an unhappy state after system
>> suspend.
>>
>> Probing is deferred on SC7180 because device_links_check_suppliers() finds
>> that '88e3000.phy' isn't ready yet.
> It seems device links could be used to make sure the dwc3 core is present:
>
>    Another example for an inconsistent state would be a device link that
>    represents a driver presence dependency, yet is added from the consumer’s
>    ->probe callback while the supplier hasn’t probed yet: Had the driver core
>    known about the device link earlier, it wouldn’t have probed the consumer
>    in the first place. The onus is thus on the consumer to check presence of
>    the supplier after adding the link, and defer probing on non-presence.
>
>    https://www.kernel.org/doc/html/v5.18/driver-api/device_link.html#usage
>
>
> You could add something like this to dwc3_qcom_of_register_core():
>
>
>    device_link_add(dev, &qcom->dwc3->dev,
>    		  DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOPROBE_CONSUMER);
>
>    if (qcom->dwc3->dev.links.status != DL_DEV_DRIVER_BOUND)
>        ret = -EPROBE_DEFER;
>
>
>  From the doc it isn't clear how the consumer is supposed to check presence
> of the supplier, the above check of the link status is also used in
> drivers/cpufreq/mediatek-cpufreq.c , but not elsewhere outside of the
> driver framework.
Hi Mathias,

     Thanks for the input. I will try the above snippet and confirm if 
probe call happens in sync with of_platform_populate in 
dwc3_qcom_of_register_core

Regards,
Krishna,
