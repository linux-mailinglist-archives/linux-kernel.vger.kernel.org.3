Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C75A6BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiH3SOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiH3SOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:14:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8798D12;
        Tue, 30 Aug 2022 11:14:10 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFx86p001451;
        Tue, 30 Aug 2022 18:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ptp6lUe9nsKYl0kW5xnrFUHhLtp7FtLC9xKOZrhuvpg=;
 b=GbbomZcHwQueWS41sAp8akENeBoVE7TGinTCF3mOUjiwxoEeW33jsuDW0Dcf97IYO6/2
 PD5dVWuwPWeL0WB4NqsXKV63QIdEDYkbxXrs/07dOCwtMStOtBzHMYNpW7PkNAmIJ5YG
 p4HkHQU2GW+Z/AhOSK8egGJAv3cRTAGVwjf/fS5MrtXZCvAMrnejRshAIi/wD380AB3C
 w5Low/9p2WkicmGDXNsPqYQoBe/opYfl8C1hUouAUOIYhPSVCOecaeSNLBDIDHQVv8Lr
 hDKVHv4TCEeLt65up4gxN7T/h4sTK/EmG/W4Ke8p2oCjYOzkRwdy/3Esz+4BU4ubX9SA Kw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9n860jn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 18:14:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27UIE55g006699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 18:14:05 GMT
Received: from [10.110.18.131] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 11:14:05 -0700
Message-ID: <91415092-e622-a636-3bc4-d81fb56b2f66@quicinc.com>
Date:   Tue, 30 Aug 2022 11:13:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 5/9] usb: dwc3: Avoid unmapping USB requests if endxfer
 is not complete
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>
References: <20220817182359.13550-1-quic_wcheng@quicinc.com>
 <20220817182359.13550-6-quic_wcheng@quicinc.com> <Yw4Z191jbRJc9EuR@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Yw4Z191jbRJc9EuR@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yKkWE4tlyRYBkQxQa85TT1mCzwMKUUn6
X-Proofpoint-ORIG-GUID: yKkWE4tlyRYBkQxQa85TT1mCzwMKUUn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=799 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 8/30/2022 7:08 AM, Greg KH wrote:
> On Wed, Aug 17, 2022 at 11:23:55AM -0700, Wesley Cheng wrote:
>> If DWC3_EP_DELAYED_STOP is set during stop active transfers, then do not
>> continue attempting to unmap request buffers during dwc3_remove_requests().
>> This can lead to SMMU faults, as the controller has not stopped the
>> processing of the TRB.  Defer this sequence to the EP0 out start, which
>> ensures that there are no pending SETUP transactions before issuing the
>> endxfer.
>>
>> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.h   | 3 +++
>>   drivers/usb/dwc3/ep0.c    | 5 ++++-
>>   drivers/usb/dwc3/gadget.c | 6 +++++-
>>   3 files changed, 12 insertions(+), 2 deletions(-)
>>
> 
> This commit does not apply to my usb-testing branch.  I've taken the
> first 4, please rebase and resend the rest.
> 

Sure resubmit it later today.  Sorry about that and thanks for the heads up.

Thanks
Wesley Cheng
