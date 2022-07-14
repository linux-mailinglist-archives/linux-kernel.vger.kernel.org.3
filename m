Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B3575172
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiGNPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGNPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:09:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC92981F;
        Thu, 14 Jul 2022 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657811378; x=1689347378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ySITWGdTdHqE+HMwzETa1LVQtsm5GALRydsd94U9OFU=;
  b=UTtQeHsKCpYJhWgzTg5CtwfVyYApnxZQyT7J0Kj2/hlJ3oKhdQShLWjy
   J3fUbfHRZ4+aRexmi17tRtCjFE0baM1iUVgxms8m1E0JDqkp0cr9w2iqZ
   OPVSGSwpvpcgZY6dlUzN5MwQTfSZdNrKXpgqq0Lhj6y+m/bkFO4J8eDfe
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 08:09:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 08:09:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 08:09:37 -0700
Received: from [10.216.25.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 08:09:34 -0700
Message-ID: <2938c8ff-ecc6-0a6e-6011-f83f3e3fbaa1@quicinc.com>
Date:   Thu, 14 Jul 2022 20:39:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1657810516-31143-1-git-send-email-quic_kriskura@quicinc.com>
 <YtAv8R7QlTZCjvRO@kroah.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YtAv8R7QlTZCjvRO@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 7/14/2022 8:32 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 08:25:16PM +0530, Krishna Kurapati wrote:
>> On SC7180 devices, it is observed that dwc3 probing is deferred
>> because device_links_check_suppliers() finds that '88e3000.phy'
>> isn't ready yet.
>>
>> As a part of its probe call, dwc3-qcom driver checks if dwc3 core
>> is wakeup capable or not. If the dwc3 core is wakeup capable, driver
>> configures dwc-qcom's power domain to be always ON. Also it configures
>> dp/dm interrupts accordingly to support wakeup from system suspend.
>>
>> More info regarding the same can be found at:
>> commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status"
>> commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
>>
>> In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
>> probe, driver ends up reading the wakeup capability of dwc3 core as false
>> leading to instability in suspend/resume path.
>>
>> To avoid this scenario, ensure dwc3_probe is successful by checking
>> if appropriate driver is assigned to it or not after the of_platform_populate
>> call. If it isn't then defer dwc3-qcom probe as well.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 7703655..096d1414 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>>   		dev_err(dev, "failed to get dwc3 platform device\n");
>>   	}
>>   
>> +	if (!qcom->dwc3->dev.driver)
>> +		return -EPROBE_DEFER;
>> +
> Why not limit this check to a device type like your changelog mentions?
>
> thanks,
>
> greg k-h
Hi Greg,

I wanted to make it common to any device using this driver. Although on 
devices
ike SC7280,this issue is not seen but the code would hold good. Do you 
see any
concerns if we do it this way ?

Thanks,
Krishna,
