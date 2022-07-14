Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7CA57521E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiGNPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiGNPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:43:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D15725A;
        Thu, 14 Jul 2022 08:43:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EBGT9r002977;
        Thu, 14 Jul 2022 15:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XjKbJWTNAy4ioQOT7EWLJNd88qNSy98TRzw40NFx5V0=;
 b=RBmuTm7JYxpYQ9fNrrBZ0/da9jj4xy8/tyeaC4qGn0mtaz26LrK/GB4AzJYh0fTpW4Ts
 VHnzeK8mRy3We6fgMxeYV521PjxGNa/8UlGkp4QI2/vvEuoULZ+jwgnh/eMQC9cehOg+
 sIwBxlhXbOewoPl1cMglXWExam26C2JNH8Nr43ctfxtfJg+89Xe6eXi6I7vl0KiUgUQi
 COFfJK8gqjHEhBPEwdTW5eEy67luJ21qDULU5mGvMsjo5WwXe+JQw6PoAdx3khdtRQEd
 ejqMDxR6YTESoRYf9Ck8114Hk7W3NKe3g2lZdf7SmymYz4O93URkaC8y5+041eeZUnfR nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3haaba9qj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 15:43:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26EFhIb3015297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 15:43:18 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 08:43:17 -0700
Received: from [10.216.25.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 08:43:14 -0700
Message-ID: <156915e9-34c4-0b20-61b7-d6d5bfc584fa@quicinc.com>
Date:   Thu, 14 Jul 2022 21:13:11 +0530
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
 <2938c8ff-ecc6-0a6e-6011-f83f3e3fbaa1@quicinc.com>
 <YtA2FwnL9GRUU35i@kroah.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YtA2FwnL9GRUU35i@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CMJdVSAlC86WE-CmJh3cLUBn5X_sThcW
X-Proofpoint-ORIG-GUID: CMJdVSAlC86WE-CmJh3cLUBn5X_sThcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_12,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2022 8:58 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 08:39:31PM +0530, Krishna Kurapati PSSNV wrote:
>> On 7/14/2022 8:32 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jul 14, 2022 at 08:25:16PM +0530, Krishna Kurapati wrote:
>>>> On SC7180 devices, it is observed that dwc3 probing is deferred
>>>> because device_links_check_suppliers() finds that '88e3000.phy'
>>>> isn't ready yet.
>>>>
>>>> As a part of its probe call, dwc3-qcom driver checks if dwc3 core
>>>> is wakeup capable or not. If the dwc3 core is wakeup capable, driver
>>>> configures dwc-qcom's power domain to be always ON. Also it configures
>>>> dp/dm interrupts accordingly to support wakeup from system suspend.
>>>>
>>>> More info regarding the same can be found at:
>>>> commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status"
>>>> commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
>>>>
>>>> In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
>>>> probe, driver ends up reading the wakeup capability of dwc3 core as false
>>>> leading to instability in suspend/resume path.
>>>>
>>>> To avoid this scenario, ensure dwc3_probe is successful by checking
>>>> if appropriate driver is assigned to it or not after the of_platform_populate
>>>> call. If it isn't then defer dwc3-qcom probe as well.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>    drivers/usb/dwc3/dwc3-qcom.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>>>> index 7703655..096d1414 100644
>>>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>>>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>>>> @@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>>>>    		dev_err(dev, "failed to get dwc3 platform device\n");
>>>>    	}
>>>> +	if (!qcom->dwc3->dev.driver)
>>>> +		return -EPROBE_DEFER;
>>>> +
>>> Why not limit this check to a device type like your changelog mentions?
>>>
>>> thanks,
>>>
>>> greg k-h
>> Hi Greg,
>>
>> I wanted to make it common to any device using this driver. Although on
>> devices
>> ike SC7280,this issue is not seen but the code would hold good. Do you see
>> any
>> concerns if we do it this way ?
> How many different types of hardware did you test this change on and
> what was the results?
>
> thanks,
>
> greg k-h
Hi Greg,

   I tested only on SC7180 and SC7280 devices. It was working on SC7280, 
(the first run of of_platform_populate made sure dwc3 probe is done).
On SC7180, during the first run of dwc3-qcom probe, we observed dwc3 
probe getting deferred after of_platform_populate.
As you suggested, I can try and check on other devices using this driver 
and confirm if only SC7180 has this issue. 🙂

Thanks,
Krishna,
