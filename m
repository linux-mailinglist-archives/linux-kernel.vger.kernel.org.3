Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEEF5A9FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiIATKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiIATKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:10:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9485283C;
        Thu,  1 Sep 2022 12:10:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281G35Jt016941;
        Thu, 1 Sep 2022 19:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4PleBgeMONeA37xO6rcOQP2wCqPTjgMSgvj6AgQ7JKQ=;
 b=Pj3jeaPVRnbWs5rHNdVRj9pfdVZiTnfVPXFb1dE/daS8fht06tj5qAWYCYc2sAvMKE+A
 Mo7gFhpdikn+K9KR8GYA7cMoNpotWGNnMS5wrioJfXpE0LUWfwt9I/++9/NmMFi+ce2Q
 VqboIZWkWPCAYVNCQg73x3KH5e+VGB+la1fPN5JjPaH245mw4L94mt58aGFvPbnoQQT1
 fzSblDivzyIehnTrFtxxuUs1KosyBDkliFNS4B7I+hHUqv4STFuLNhNYKYZASpNrthhX
 k/xPEGhbMng3dbdLXHnqi1jgHaLd3MzNhU7M8qULH27ATYg/f1dA0hmuU26jQN0gAlDu tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jahc4uegs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 19:10:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281JAYJi031253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 19:10:34 GMT
Received: from [10.110.58.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 12:10:33 -0700
Message-ID: <2f96c186-39d1-dc82-7504-bb770b59b44e@quicinc.com>
Date:   Thu, 1 Sep 2022 12:10:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/5] usb: dwc3: Avoid unmapping USB requests if endxfer
 is not complete
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>
References: <20220831183242.27826-1-quic_wcheng@quicinc.com>
 <20220831183242.27826-2-quic_wcheng@quicinc.com> <YxC9UBEvpMD3n7xF@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <YxC9UBEvpMD3n7xF@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kw17ykLBJrIixPIAoIxUwkaM3JN9BiXA
X-Proofpoint-ORIG-GUID: kw17ykLBJrIixPIAoIxUwkaM3JN9BiXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=691 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2022 7:10 AM, Greg KH wrote:
> On Wed, Aug 31, 2022 at 11:32:38AM -0700, Wesley Cheng wrote:
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
> 
> As the kernel-test robot reported, this patch doesn't even build.  How
> did you test it?
> 
Sorry Greg, didn't get a chance to test it before submitting, but fixed 
the build errors in v6.  I had initially missed the argument changes to 
the APIs.

V6 works as expected.

Thanks
Wesley Cheng
