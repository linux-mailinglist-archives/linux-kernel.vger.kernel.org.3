Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D215751BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiGNPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiGNPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:25:03 -0400
X-Greylist: delayed 1276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 08:25:02 PDT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA7459B0;
        Thu, 14 Jul 2022 08:25:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EDCErI018907;
        Thu, 14 Jul 2022 15:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rF5r7Kypego6SgKL/SYxpyiL3ibO/l3UR6kRmq8g/xk=;
 b=UbSOrxin8DTmKZXA6Sd49N1kWSXEAx0k6TzrcvTppbw3Am9ji+St58w8zcXIDQJm7Eu7
 pZ/0oJIk20WDZ7xG+srmR8hOuRlAy5eLFhGXudtcPhW9/XANC6TpJMvmXttPaXsALeYI
 hlAKVa7JiQIlzmNwoMdyeTLSF8N9gfN2oygryyj7GhymcOBlCV519eLuT8NIQILwoc+p
 W7Ks+eZlxNI7zLOX5rjX5SKyYbXwA1bBhzSCenwkseU1ogjqYAWQ3bf63Ad3P+25wLPY
 NndU7QJbPkCSRoE5CXBMD/GWaDFcWveHlQ62klt0AwwIbz15GlX2J/mgLtzaMVS9vyMa Pg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3habpcsemc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 15:03:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26EF3ZtB027627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 15:03:35 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 08:03:34 -0700
Received: from [10.216.25.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 08:03:31 -0700
Message-ID: <fb1398ed-3a75-a0f9-32b2-50c06dd0b55a@quicinc.com>
Date:   Thu, 14 Jul 2022 20:33:28 +0530
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
 <YtAv1U1VYkhIY1GA@kroah.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YtAv1U1VYkhIY1GA@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O0VrJnQMY3cKWQWBmaOaLQbrbMWGzNqe
X-Proofpoint-ORIG-GUID: O0VrJnQMY3cKWQWBmaOaLQbrbMWGzNqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_11,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=850 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2022 8:31 PM, Greg Kroah-Hartman wrote:
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
> I got 2 different copies of this change, what's the difference?
>
> confused,
>
> greg k-h
Sorry Greg, My bad, I thought the mail sending failed the first time. So 
I sent the same patch second time. Sorry for the confusion.
Regards,
Krishna,
