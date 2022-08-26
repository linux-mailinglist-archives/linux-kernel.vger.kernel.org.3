Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C55A2069
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbiHZFpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiHZFpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:45:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1AB6368;
        Thu, 25 Aug 2022 22:45:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4Aviq007923;
        Fri, 26 Aug 2022 05:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PkVIGNJRBk4dislyu2Kr/mee6RfgQJSfYgLye2tNm2g=;
 b=dnvCyePDO4qcUmjA0kDjYWc3aZz98qjUmqgTDKiXR/U5HxmWDsoJH7mmCMK17WxES58x
 Dj1H66UEWDhxpy+GR6kXpvqZKo5z0kPo4tCMEF6IqvR2TjmuCJpPUUTA3vTpIhDPNobT
 OMn4J3hth1zmdYdy6I2hKWpUDr10O/BS15ahdmrIWYgWChfOE6H90vljOKrUweAG96oC
 QoYra9B3wowc31tt+dTtPtcA8OibmGlnmaXf4M4UcuFxgjuSeFCmtKINRw687YsuqMcB
 oQ4eDzDGETEaHu9nXja58bzPyCxmyvVWMR483Vrpg7xjFp32y6dDjKDqVKxMUTBl9zCZ TQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j63v3makq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:44:54 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27Q5irOE017381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:44:53 GMT
Received: from [10.216.58.196] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 22:44:50 -0700
Message-ID: <f6b58663-c414-1996-4951-7435070bec58@quicinc.com>
Date:   Fri, 26 Aug 2022 11:14:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 3/3] remoteproc: qcom: wcss: Use dev_err_probe()
 helper in q6v5_wcss_init_clock()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
References: <20220826014511.2270433-1-yangyingliang@huawei.com>
 <20220826014511.2270433-3-yangyingliang@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220826014511.2270433-3-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E_AmhqMYjXmuiWhfFjYh-EwikXrco8wK
X-Proofpoint-GUID: E_AmhqMYjXmuiWhfFjYh-EwikXrco8wK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260021
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
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/remoteproc/qcom_q6v5_wcss.c | 90 ++++++++++-------------------
>   1 file changed, 30 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
> index 209fc1bd1424..ec9ad2c019aa 100644
> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
> @@ -902,87 +902,57 @@ static int q6v5_wcss_init_clock(struct q6v5_wcss *wcss)
>   	int ret;
>   
>   	wcss->xo = devm_clk_get(wcss->dev, "xo");
> -	if (IS_ERR(wcss->xo)) {
> -		ret = PTR_ERR(wcss->xo);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get xo clock");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->xo))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->xo),
> +				     "failed to get xo clock");
>   
>   	wcss->gcc_abhs_cbcr = devm_clk_get(wcss->dev, "gcc_abhs_cbcr");
> -	if (IS_ERR(wcss->gcc_abhs_cbcr)) {
> -		ret = PTR_ERR(wcss->gcc_abhs_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get gcc abhs clock");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->gcc_abhs_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->gcc_abhs_cbcr),
> +				     "failed to get gcc abhs clock");
>   
>   	wcss->gcc_axim_cbcr = devm_clk_get(wcss->dev, "gcc_axim_cbcr");
> -	if (IS_ERR(wcss->gcc_axim_cbcr)) {
> -		ret = PTR_ERR(wcss->gcc_axim_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get gcc axim clock\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->gcc_axim_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->gcc_axim_cbcr),
> +				     "failed to get gcc axim clock\n");
>   
>   	wcss->ahbfabric_cbcr_clk = devm_clk_get(wcss->dev,
>   						"lcc_ahbfabric_cbc");
> -	if (IS_ERR(wcss->ahbfabric_cbcr_clk)) {
> -		ret = PTR_ERR(wcss->ahbfabric_cbcr_clk);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get ahbfabric clock\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->ahbfabric_cbcr_clk))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->ahbfabric_cbcr_clk),
> +				     "failed to get ahbfabric clock\n");
>   
>   	wcss->lcc_csr_cbcr = devm_clk_get(wcss->dev, "tcsr_lcc_cbc");
> -	if (IS_ERR(wcss->lcc_csr_cbcr)) {
> -		ret = PTR_ERR(wcss->lcc_csr_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get csr cbcr clk\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->lcc_csr_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->lcc_csr_cbcr),
> +				     "failed to get csr cbcr clk\n");
>   
>   	wcss->ahbs_cbcr = devm_clk_get(wcss->dev,
>   				       "lcc_abhs_cbc");
> -	if (IS_ERR(wcss->ahbs_cbcr)) {
> -		ret = PTR_ERR(wcss->ahbs_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get ahbs_cbcr clk\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->ahbs_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->ahbs_cbcr),
> +				     "failed to get ahbs_cbcr clk\n");
>   
>   	wcss->tcm_slave_cbcr = devm_clk_get(wcss->dev,
>   					    "lcc_tcm_slave_cbc");
> -	if (IS_ERR(wcss->tcm_slave_cbcr)) {
> -		ret = PTR_ERR(wcss->tcm_slave_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get tcm cbcr clk\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->tcm_slave_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->tcm_slave_cbcr),
> +				     "failed to get tcm cbcr clk\n");
>   
>   	wcss->qdsp6ss_abhm_cbcr = devm_clk_get(wcss->dev, "lcc_abhm_cbc");
> -	if (IS_ERR(wcss->qdsp6ss_abhm_cbcr)) {
> -		ret = PTR_ERR(wcss->qdsp6ss_abhm_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get abhm cbcr clk\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->qdsp6ss_abhm_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->qdsp6ss_abhm_cbcr),
> +				     "failed to get abhm cbcr clk\n");
>   
>   	wcss->qdsp6ss_axim_cbcr = devm_clk_get(wcss->dev, "lcc_axim_cbc");
> -	if (IS_ERR(wcss->qdsp6ss_axim_cbcr)) {
> -		ret = PTR_ERR(wcss->qdsp6ss_axim_cbcr);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get axim cbcr clk\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->qdsp6ss_axim_cbcr))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->qdsp6ss_axim_cbcr),
> +				     "failed to get axim cbcr clk\n");
>   
>   	wcss->lcc_bcr_sleep = devm_clk_get(wcss->dev, "lcc_bcr_sleep");
> -	if (IS_ERR(wcss->lcc_bcr_sleep)) {
> -		ret = PTR_ERR(wcss->lcc_bcr_sleep);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wcss->dev, "failed to get bcr cbcr clk\n");
> -		return ret;
> -	}
> +	if (IS_ERR(wcss->lcc_bcr_sleep))
> +		return dev_err_probe(wcss->dev, PTR_ERR(wcss->lcc_bcr_sleep),
> +				     "failed to get bcr cbcr clk\n");
>   
>   	return 0;

LGTM.

Reviewed-by:Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh


>   }
