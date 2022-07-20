Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426AF57B847
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiGTOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:15:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697ED4504E;
        Wed, 20 Jul 2022 07:15:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KDgirm018209;
        Wed, 20 Jul 2022 14:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vrlyZOKTCMRIMtatTcSfwYllArIo6cJDJKYV+GStnBQ=;
 b=ERNNMbWKi3fEHNNSriMhKnk3jO4qxYE09FTBPvUD/yjC/yuH6g2wBLaPRZXMWwygL835
 UfPyuCGBmnQ1Y0ZTHG4LCXBgMxD1WTd/O8wZyELM/JM/MTNQ0kFzvsXFhKlIjHa4w6cX
 YCBNIXTtnsZUnghNtXHt/0mQ2jmilsxtEv8Ivy/zpRyacAFHsGsRmg7TQD7UmpmpTFk6
 L6lcz6vXan/P496MWJPV+UMLy5IjGWuuhWMjiDj4HiupDsUSeP1F25oVeorgjW4h1+Z5
 adbkC3pzwQobml8rl1AfwTj2LG6rswwUcSzQiZRc5ug+PO1z1h0EYUf97gXhPrUZC/pA 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv17sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 14:15:33 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KEFXBH027730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 14:15:33 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 07:15:32 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 07:15:31 -0700
Message-ID: <b56c0dfb-2858-c1f4-9cff-9e1d786e672a@quicinc.com>
Date:   Wed, 20 Jul 2022 08:15:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/1] bus: mhi: host: Fix up null pointer access in
 mhi_irq_handler
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>, <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <1658311454-4707-1-git-send-email-quic_qianyu@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1658311454-4707-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EVlz8ryf-a3ejSGIOq4-mmIhyHwA-xbh
X-Proofpoint-ORIG-GUID: EVlz8ryf-a3ejSGIOq4-mmIhyHwA-xbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2022 4:04 AM, Qiang Yu wrote:
> The irq handler for a shared IRQ ought to be prepared for running
> even now it's being freed. So let's check the pointer used by
> mhi_irq_handler to avoid null pointer access since it is probably
> released before freeing IRQ.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>   drivers/bus/mhi/host/main.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index f3aef77a..7959457 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -430,12 +430,20 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>   {
>   	struct mhi_event *mhi_event = dev;
>   	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
> -	struct mhi_event_ctxt *er_ctxt =
> -		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> +	struct mhi_event_ctxt *er_ctxt;
>   	struct mhi_ring *ev_ring = &mhi_event->ring;
> -	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
> +	dma_addr_t ptr;
>   	void *dev_rp;
>   
> +	if (!mhi_cntrl->mhi_ctxt) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"mhi_ctxt has been freed\n");

dev_dbg since you identified a scenario where this is expected?

> +		return IRQ_HANDLED;
> +	}
> +
> +	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> +	ptr = le64_to_cpu(er_ctxt->rp);
> +
>   	if (!is_valid_ring_ptr(ev_ring, ptr)) {
>   		dev_err(&mhi_cntrl->mhi_dev->dev,
>   			"Event ring rp points outside of the event ring\n");

