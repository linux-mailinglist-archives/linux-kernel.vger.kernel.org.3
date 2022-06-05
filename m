Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D953DDA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346944AbiFES3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiFES3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:29:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1E12ADF;
        Sun,  5 Jun 2022 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654453753; x=1685989753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7CN5CVW4y6vndDpfXtnuBA35CphKx0VJEXmhpRPvYg8=;
  b=QL9aKmjyQ/28EzV5C0yy0WpF1LZ+tyT0TmwLPX4VjYHDbishEc4hn3rJ
   +UHMT9uXrxs0qk19Lil/Cd6ABSEE/hZ3E5eWMn9/Jb+tzB8bH/AQiIH5O
   zaNw6pWzsIbc7AYF84ef5GV5EM5pXkgrnVQVB23pIlX+fJA9ZH+tXwyJC
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jun 2022 11:29:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 11:29:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 5 Jun 2022 11:29:12 -0700
Received: from [10.216.59.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 5 Jun 2022
 11:29:07 -0700
Message-ID: <d756152e-64aa-9519-ae42-5a4bb7727fbf@quicinc.com>
Date:   Sun, 5 Jun 2022 23:59:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] usb: dwc3: Refactor PHY logic to support Multiport
 Controller
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com>
 <1653985217-20953-4-git-send-email-quic_harshq@quicinc.com>
 <20220531122605.GA14607@hu-pkondeti-hyd.qualcomm.com>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <20220531122605.GA14607@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 5/31/2022 5:56 PM, Pavan Kondeti wrote:
> Hi Harsh,
>
> On Tue, May 31, 2022 at 01:50:17PM +0530, Harsh Agarwal wrote:
>> Currently the DWC3 driver supports only single port controller
>> which requires at most 2 PHYs ie HS and SS PHYs.
>>
>> But some SOCs have a "multiport" USB DWC3 controller where a
>> single controller supports multiple ports and each port have
>> their own PHYs. Refactor PHY logic to support the same.
>>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 400 +++++++++++++++++++++++++++++++++-------------
>>   drivers/usb/dwc3/core.h   |  12 +-
>>   drivers/usb/dwc3/drd.c    |  16 +-
>>   drivers/usb/dwc3/gadget.c |   4 +-
>>   4 files changed, 305 insertions(+), 127 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 5734219..5cc799e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -120,7 +120,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   {
>>   	struct dwc3 *dwc = work_to_dwc(work);
>>   	unsigned long flags;
>> -	int ret;
>> +	int i, ret;
>>   	u32 reg;
>>   
> <snip>
>
>> -static int dwc3_core_get_phy(struct dwc3 *dwc)
>> +static struct usb_phy *dwc3_core_get_phy_by_handle_with_node(struct device *dev,
>> +	const char *phandle, u8 index, struct device_node *lookup_node)
>> +{
>> +	struct device_node *node;
>> +	struct usb_phy	*phy;
>> +
>> +	node = of_parse_phandle(lookup_node, phandle, index);
>> +	if (!node) {
>> +		dev_err(dev, "failed to get %s phandle in %pOF node\n", phandle,
>> +			dev->of_node);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	phy = devm_usb_get_phy_by_node(dev, node, NULL);
>> +	of_node_put(node);
>> +	return phy;
>> +}
> Remove this function definition, since we moved this to PHY library.
Got it removed in the latest PS v2
>
>> +
>> +static int dwc3_count_phys(struct dwc3 *dwc, struct device_node *lookup_node)
>> +{
>> +	int count;
>> +
>> +	count = of_count_phandle_with_args(lookup_node, "phys", NULL);
>> +
>> +	if (count == -ENOENT)
>> +		count = of_count_phandle_with_args(lookup_node, "usb-phy", NULL);
>> +
>> +	if (count == 1) {
>> +		dwc->num_usb2_phy++;
>> +	} else if (count == 2) {
>> +		dwc->num_usb2_phy++;
>> +		dwc->num_usb3_phy++;
>> +	} else {
>> +		return count;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int dwc3_extract_num_phys(struct dwc3 *dwc)
>> +{
>> +	struct device_node	*ports, *port;
>> +	int			ret;
>> +
>> +	/* Find if any "multiport" child is present inside DWC3*/
>> +	for_each_available_child_of_node(dwc->dev->of_node, ports) {
>> +		if (!strcmp(ports->name, "multiport"))
>> +			break;
>> +	}
>> +	if (!ports) {
>> +		dwc->num_usb2_phy = 1;
>> +		dwc->num_usb3_phy = 1;
>> +	} else {
>> +		for_each_available_child_of_node(ports, port) {
>> +			ret  = dwc3_count_phys(dwc, port);
>> +			if (ret)
>> +				return ret;
> If you break the loop, you have to call of_node_put() explicitly.
Done. P;ease check v2
>
>> +		}
>> +	}
>> +	dev_info(dwc->dev, "Num of HS and SS PHY are %u %u\n", dwc->num_usb2_phy,
>> +									dwc->num_usb3_phy);
> If I declare the multiport node don't specify any phys for any of the ports,
> we end up coming here with dwc->num_usb2_phy = dwc->num_usb3_phy = 0. That is
> a problem since we access dwc->usb2_phy[0] directly. Can we bail out in that
> case?
We have mandated to use either usb-phy or Generic phy inside the child nodes
of multiport.
>
>> +
>> +	dwc->usb2_phy = devm_kzalloc(dwc->dev,
>> +		sizeof(*dwc->usb2_phy) * dwc->num_usb2_phy, GFP_KERNEL);
>> +	if (!dwc->usb2_phy)
>> +		return -ENOMEM;
>> +
>> +	dwc->usb3_phy = devm_kzalloc(dwc->dev,
>> +		sizeof(*dwc->usb3_phy) * dwc->num_usb3_phy, GFP_KERNEL);
>> +	if (!dwc->usb3_phy)
>> +		return -ENOMEM;
>> +
>> +	dwc->usb2_generic_phy = devm_kzalloc(dwc->dev,
>> +		sizeof(*dwc->usb2_generic_phy) * dwc->num_usb2_phy, GFP_KERNEL);
>> +	if (!dwc->usb2_generic_phy)
>> +		return -ENOMEM;
>> +
>> +	dwc->usb3_generic_phy = devm_kzalloc(dwc->dev,
>> +		sizeof(*dwc->usb3_generic_phy) * dwc->num_usb3_phy, GFP_KERNEL);
>> +	if (!dwc->usb3_generic_phy)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +static int dwc3_core_get_phy_by_node(struct dwc3 *dwc,
>> +		struct device_node *lookup_node, int i)
>>   {
>>   	struct device		*dev = dwc->dev;
>> -	struct device_node	*node = dev->of_node;
>> -	int ret;
>> +	int			ret;
>>   
>> -	if (node) {
>> -		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
>> -		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
>> +	if (lookup_node) {
>> +		dwc->usb2_phy[i] = devm_of_usb_get_phy_by_phandle(dev,
>> +								"usb-phy", 0, lookup_node);
>> +		dwc->usb3_phy[i] = devm_of_usb_get_phy_by_phandle(dev,
>> +								"usb-phy", 1, lookup_node);
>>   	} else {
>> -		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>> -		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>> +		dwc->usb2_phy[i] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>> +		dwc->usb3_phy[i] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>>   	}
>>   
>> -	if (IS_ERR(dwc->usb2_phy)) {
>> -		ret = PTR_ERR(dwc->usb2_phy);
>> +	if (IS_ERR(dwc->usb2_phy[i])) {
>> +		ret = PTR_ERR(dwc->usb2_phy[i]);
>>   		if (ret == -ENXIO || ret == -ENODEV)
>> -			dwc->usb2_phy = NULL;
>> +			dwc->usb2_phy[i] = NULL;
>>   		else
>>   			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>>   	}
>>   
>> -	if (IS_ERR(dwc->usb3_phy)) {
>> -		ret = PTR_ERR(dwc->usb3_phy);
>> +	if (IS_ERR(dwc->usb3_phy[i])) {
>> +		ret = PTR_ERR(dwc->usb3_phy[i]);
>>   		if (ret == -ENXIO || ret == -ENODEV)
>> -			dwc->usb3_phy = NULL;
>> +			dwc->usb3_phy[i] = NULL;
>>   		else
>>   			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>>   	}
>>   
>> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> -	if (IS_ERR(dwc->usb2_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb2_generic_phy);
>> -		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb2_generic_phy = NULL;
>> +	dwc->usb2_generic_phy[i] = devm_of_phy_get(dev, lookup_node, "usb2-phy");
>> +	if (IS_ERR(dwc->usb2_generic_phy[i])) {
>> +		ret = PTR_ERR(dwc->usb2_generic_phy[i]);
>> +		if (ret == -ENODEV)
>> +			dwc->usb2_generic_phy[i] = NULL;
>>   		else
>>   			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>>   	}
>>   
>> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> -	if (IS_ERR(dwc->usb3_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb3_generic_phy);
>> -		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb3_generic_phy = NULL;
>> +	dwc->usb3_generic_phy[i] = devm_of_phy_get(dev, lookup_node, "usb3-phy");
>> +	if (IS_ERR(dwc->usb3_generic_phy[i])) {
>> +		ret = PTR_ERR(dwc->usb3_generic_phy[i]);
>> +		if (ret == -ENODEV)
>> +			dwc->usb3_generic_phy[i] = NULL;
>>   		else
>>   			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>>   	}
>> +	return 0;
>> +}
>> +
>> +static int dwc3_core_get_phy(struct dwc3 *dwc)
>> +{
>> +	struct device		*dev = dwc->dev;
>> +	struct device_node	*node = dev->of_node;
>> +	struct device_node	*ports, *port;
>> +	int ret, i = 0;
>> +
>> +	ret = dwc3_extract_num_phys(dwc);
>> +	if (ret) {
>> +		dev_err(dwc->dev, "Unable to extract number of PHYs\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Find if any "multiport" child is present inside DWC3*/
>> +	for_each_available_child_of_node(node, ports) {
>> +		if (!strcmp(ports->name, "multiport"))
>> +			break;
>> +	}
>> +
>> +	if (!ports) {
>> +		ret = dwc3_core_get_phy_by_node(dwc, node, 0);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		for_each_available_child_of_node(ports, port) {
>> +			ret = dwc3_core_get_phy_by_node(dwc, port, i);
>> +			if (ret)
>> +				return ret;
>> +			i++;
>> +		}
>> +	}
>>   
> How does this work actually for a case where I have 4 ports with hs_phy=4 and
> ss_phy=2. Here we end up calling i = {0, 1, 2, 3} and accessing un-allocated
> ss phy instances in dwc3_core_get_phy_by_node(). you should also handle the
> case where first two ports are HS only and last two ports are both HS and SS.
Thanks for this endcase. Got it rectified in the new PS v2.
Yes lets suppose a Quadport controller having the first two
ports as HS only and last two ports as SS+HS capable.
Then proper indexing for SS PHY should also be taken care of.
Even though SS phy belongs to 3rd port, it's index will start with 0.
This is because for each SS PHY we have to properly map to
USBPIPECTL, PORTSC registers.
>
> Thanks,
> Pavan
