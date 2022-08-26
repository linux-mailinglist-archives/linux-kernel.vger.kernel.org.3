Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD35A2058
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbiHZFdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiHZFdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:33:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AAFCD78C;
        Thu, 25 Aug 2022 22:33:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4fDRc010624;
        Fri, 26 Aug 2022 05:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RgbRa2n+exPX5WxL6dLo7ofOBhMN+C554eerUIVIQpo=;
 b=HLHFM2YUk1SYFIEDPHfdwuCah9w8/HoczJDTCKG19HLJ6/zz+7JZRCnW8xyIXCm6mEuG
 e0ngGnGggzgdXSzeT0ZkudqCk/Y+Aqfk0B4bbtQAYExY/LEoCCpmOSrEpCXsxe24rPHe
 ej/q8wT1o3bZjnh3yEQA8nf+1zP0Coc+HkUKIT3Ze9jk2tk5j0j9InH5I5F2dOPcVfQo
 H9fRAMbvj3ScF/rDIl2e0HaR6y0IpPNjIxPx/V/Z1v7/5tLPxRmJRBXZPqTKeveYit3+
 MqL0YPn4nNnOhzZFt9iXGya1kicTBPDDlzMETNKPBY3eL0BDhKTsGrwkTinzr0b/OhVg EA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j64h7m5at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:33:28 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27Q5XSGM017932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:33:28 GMT
Received: from [10.216.58.196] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 22:33:24 -0700
Message-ID: <63f86e67-23ce-0c53-e2dd-d7937584508b@quicinc.com>
Date:   Fri, 26 Aug 2022 11:03:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 1/3] remoteproc: qcom: wcss: check return value
 after calling platform_get_resource_byname()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
References: <20220826014511.2270433-1-yangyingliang@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220826014511.2270433-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AJWFdAJeJ1ONSPLpsDfHCR81MH524ii5
X-Proofpoint-GUID: AJWFdAJeJ1ONSPLpsDfHCR81MH524ii5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2022 7:15 AM, Yang Yingliang wrote:
> If platform_get_resource_byname() fails, 'res' will be set to null pointer,
> it will cause null-ptr-deref when it used in devm_ioremap(), so we need check
> the return value.
> 
> Fixes: 0af65b9b915e ("remoteproc: qcom: wcss: Add non pas wcss Q6 support for QCS404")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/remoteproc/qcom_q6v5_wcss.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
> index bb0947f7770e..017ee225dc32 100644
> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
> @@ -827,6 +827,8 @@ static int q6v5_wcss_init_mmio(struct q6v5_wcss *wcss,
>   	int ret;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qdsp6");
> +	if (!res)
> +		return -EINVAL;

LGTM.

Reviewed-by:Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   	wcss->reg_base = devm_ioremap(&pdev->dev, res->start,
>   				      resource_size(res));
>   	if (!wcss->reg_base)
