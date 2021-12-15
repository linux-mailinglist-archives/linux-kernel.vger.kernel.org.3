Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417F2475865
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbhLOMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:06:40 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40129 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236954AbhLOMGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639569999; x=1671105999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fMixDV+hpNbYQgek63SXWJhHVAjFsf+hOokboNZBz2g=;
  b=eosEveaLkkQruSdc9rBUVdiOKPH/9ggzEoE+wAL9g7+12yPbhHWBfRHx
   uHskI7Xh3dvjlgHDQIE7LDWudK7n0QZWBrzo5JxjzVJLBqH9PQmpvXOYW
   Tu/wjonaXvaaPalVQcA/b2KQGpLjrzwbfoUt4h/A3jaHfgfopQUxPxGoF
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Dec 2021 04:06:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 04:06:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 04:06:37 -0800
Received: from [10.50.9.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 04:06:31 -0800
Message-ID: <5ebbc96a-941f-8f64-e6e9-d70d38260b9d@quicinc.com>
Date:   Wed, 15 Dec 2021 17:36:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 4/8] usb: dwc3: drd: Register the eud connector child
 node for dwc3
Content-Language: en-CA
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
 <bcb48839a520b8bfc9b09e7a26ba8a8459ab602d.1638430506.git.quic_schowdhu@quicinc.com>
 <YbenLLPUYVX50CJc@robh.at.kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YbenLLPUYVX50CJc@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 1:33 AM, Rob Herring wrote:
> On Thu, Dec 02, 2021 at 03:21:23PM +0530, Souradeep Chowdhury wrote:
>> Register the child node for dwc3 which is the "eud_usb_connector".
>> The eud driver will be able to switch the usb role from device to
>> host and vice versa using the role switch property of dwc3 node.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   drivers/usb/dwc3/drd.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index d7f7683..b4ea55c 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include <linux/extcon.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/of_graph.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/property.h>
>> @@ -164,6 +165,27 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
>>   	return irq;
>>   }
>>   
>> +static int dwc3_register_eud(struct dwc3 *dwc)
>> +{
>> +	struct device		*dev = dwc->dev;
>> +	struct device_node	*np = dev->of_node;
>> +	int                     ret;
>> +
>> +	of_get_child_by_name(np, "eud_usb_connector");
> Connector nodes are named 'connector' or possibly 'usb-connector'. If
> you are creating an ABI with the node name, it should be documented.
> However, it's preferred to use 'compatible' for identifying nodes rather
> than a node name.
Ack.
>> +	if (!np) {
>> +		dev_dbg(dev, "no usb_connector child node specified\n");
>> +		return 0;
>> +	}
>> +
>> +	ret = of_platform_populate(np, NULL, NULL, dev);
> But why is any of this needed. The connector doesn't have a driver (I
> expect eventually we will) and the EUD device is not a child.

Ack. This can be removed as we are no longer mapping EUD as a type C 
connector.


>> +	if (ret) {
>> +		dev_err(dev, "failed to register usb_connector - %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   void dwc3_otg_init(struct dwc3 *dwc)
>>   {
>>   	u32 reg;
>> @@ -580,6 +602,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
>>   		ret = dwc3_setup_role_switch(dwc);
>>   		if (ret < 0)
>>   			return ret;
>> +
>> +		ret = dwc3_register_eud(dwc);
>> +		if (ret < 0)
>> +			return ret;
>>   	} else if (dwc->edev) {
>>   		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>>   		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>> -- 
>> 2.7.4
>>
>>
