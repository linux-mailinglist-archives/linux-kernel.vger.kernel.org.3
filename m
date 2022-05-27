Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B5535EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351105AbiE0K42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350015AbiE0K4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:56:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D612E318;
        Fri, 27 May 2022 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653648969; x=1685184969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n9ZtfLYbiHUyNK9FwbMHCz9wbqDK0jQYEbG5n43ksBg=;
  b=t5mGIInt3OKUUIyFFKDZ73xUEt4Y0Z+uGOnGdkB2oqawEOq9opkay8qN
   wHo3O0YiyuphKn9rlVvpelK4/M94Z5ldQoBVC4ta2pbeCfiWvBo3/vpiy
   +HtSlGcnDBJUrErceW/9UXl/qwUbCvvXdvv1V1cC77DCu7youFGLO7oWn
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 May 2022 03:56:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 03:56:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 03:56:08 -0700
Received: from [10.216.14.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 03:56:04 -0700
Message-ID: <87cb2f71-81fa-3dd7-83f9-f2b053efabc4@quicinc.com>
Date:   Fri, 27 May 2022 16:26:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC 2/2] usb: dwc3: Refactor PHY logic to support Multiport
 Controller
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
 <Youx4uztX0RNRVkd@xps13>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <Youx4uztX0RNRVkd@xps13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2022 9:40 PM, Brian Masney wrote:
> On Thu, May 19, 2022 at 06:04:55PM +0530, Harsh Agarwal wrote:
>> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> -	if (IS_ERR(dwc->usb3_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb3_generic_phy);
>> -		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb3_generic_phy = NULL;
>> -		else
>> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +		if (IS_ERR(dwc->usb2_phy[0])) {
>> +			ret = PTR_ERR(dwc->usb2_phy[0]);
>> +			if (ret == -ENXIO || ret == -ENODEV)
>> +				dwc->usb2_phy[0] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +		}
>> +
>> +		if (IS_ERR(dwc->usb3_phy[0])) {
>> +			ret = PTR_ERR(dwc->usb3_phy[0]);
>> +			if (ret == -ENXIO || ret == -ENODEV)
>> +				dwc->usb3_phy[0] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +		}
>> +
>> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> +		if (IS_ERR(dwc->usb2_generic_phy)) {
>> +			ret = PTR_ERR(dwc->usb2_generic_phy);
>> +			if (ret == -ENOSYS || ret == -ENODEV)
>> +				dwc->usb2_generic_phy = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +		}
> I know that this block is a copy and paste move from above, but is the
> ENOSYS check really needed? It looks like the phy_get() only returns
> -ENODEV.
sure I got ENOSYS removed in my RFC V2 patch. This was present by 
default, so I did not change it earlier.
>> @@ -1147,8 +1149,10 @@ struct dwc3 {
>>   
>>   	struct reset_control	*reset;
>>   
>> -	struct usb_phy		*usb2_phy;
>> -	struct usb_phy		*usb3_phy;
>> +	struct usb_phy		**usb2_phy;
>> +	struct usb_phy		**usb3_phy;
>> +	u32			num_hsphy;
>> +	u32			num_ssphy;
> Rename num_hsphy / num_ssphy to num_usb2_phy and num_usb3_phy so this is
> easier to audit.
Okay will change this in my next Patch.
>
> Brian
>
