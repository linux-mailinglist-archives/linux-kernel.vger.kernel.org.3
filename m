Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF658972B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiHDEua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiHDEu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:50:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE80186E8;
        Wed,  3 Aug 2022 21:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659588627; x=1691124627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kaFm7WB45/t+ZVt6kFh6saY9zhjnV9Zkq3YgVtfmQEo=;
  b=qx/2RFpHkRSYhcKYQARM82X/5kWrB0EWVZjeBKdsD11FQzXzH6F3xczF
   zjGvxp8uP9hYOcJ8ErOseb571JyKHOA69B7YN0nybCrLLkdX2teMq1fNx
   dNmCgO/0aY7qmliwuFjG89F8WUtgC/qYiAjGHWVzFjTa6ULYr/BV1O81X
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 21:50:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 21:50:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 21:50:26 -0700
Received: from [10.216.16.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 21:50:23 -0700
Message-ID: <284b0697-e630-8900-9ed6-d83d2f99619c@quicinc.com>
Date:   Thu, 4 Aug 2022 10:20:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
 <YulMeEngNyoBOGBP@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YulMeEngNyoBOGBP@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2022 9:40 PM, Johan Hovold wrote:
> On Fri, Jul 15, 2022 at 06:51:52PM +0530, Krishna Kurapati wrote:
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
>> commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
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
>> Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> v2: Set return value to EPROBE_DEFER to drop reference to dwc3 node
>>
>>   drivers/usb/dwc3/dwc3-qcom.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 7703655..6676b39 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>>   		dev_err(dev, "failed to get dwc3 platform device\n");
>>   	}
>>   
>> +	if (!qcom->dwc3->dev.driver)
>> +		ret = -EPROBE_DEFER;
>> +
>>   node_put:
>>   	of_node_put(dwc3_np);
> NAK.
>
> We should not be adding hacks like this to the driver.
>
> There are other ways to avoid this, but please take a look at the
> following series which makes the problem identified by this patch go
> away first:
>
> 	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org
>
> Johan
Hi Johan,

  Thanks for the review and patches. Agreed that if we are moving 
wakeup-source to glue driver, dwc3 probe getting deferred won't be an issue.

Regards,
Krishna,
