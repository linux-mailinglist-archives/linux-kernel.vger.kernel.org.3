Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029D599340
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbiHSC5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiHSC5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:57:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0CD4765;
        Thu, 18 Aug 2022 19:57:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J2orfM022561;
        Fri, 19 Aug 2022 02:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eOWeYvnq+hhJ6pgEMpEp5YO8QoMaKAyHxvKs//mf80Y=;
 b=IYTMnKDmJ4CW1hVPP1PtdYAiTw/23EXiawBn8n3jWPsX4aFl73BOLYRyXoGjSQm+AfFO
 W7pageVwfsjjiqexdeMY2eF+kjE/Ctv1eM0OlGbdgKCrU1xJ9/sn1fIQi1kvyF3ncBwT
 /jspt5vui7MTr3kpO1jtFiOWOQJ8BLPdOZkyv4QqjgePMS513T4SVGkx1lqvC6vUyrSj
 A0/pi7WEJVPiMjhA+41UrC5IGYbOZ2EFi+2bySPVtaQG04PUtfk58Q6tY1Ezemx3VM9P
 XmT1UuayHFr1FW68d7NmAQeVA5e56rJfJkBf54NNgLW81EOE6gVWbuXKYu1cyR1feuTT Cg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j21v5017c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 02:57:13 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27J2vCT3025982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 02:57:12 GMT
Received: from [10.110.112.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 19:57:12 -0700
Message-ID: <cd1c0266-a1be-f6c3-fbf3-0b75ecf4e3df@quicinc.com>
Date:   Thu, 18 Aug 2022 19:57:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
 <20220812091012.GB4956@thinkpad>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <20220812091012.GB4956@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oMKno0sqaVorl75j_usux10ICB_V-32r
X-Proofpoint-GUID: oMKno0sqaVorl75j_usux10ICB_V-32r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_18,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manivannan,

Thanks for taking a look.

Sorry for the late reponse, was a bit caught up.

On 8/12/2022 2:10 AM, Manivannan Sadhasivam wrote:
> On Thu, Aug 11, 2022 at 03:33:03AM -0700, Can Guo wrote:
>> From: Asutosh Das <quic_asutoshd@quicinc.com>
>>
>> Adds MCQ support to UFS.
>>
>> The design uses shared tags across all the hw queues.
>> The queue-depth is chosen within range supported by controller &
>> device. It also takes EXT_IID into account while choosing the queue
>> depth.
>>
>> It supports default, read, poll and a dev cmd queue.
>> It enables MCQ after determining the queue-depth that the ufs
>> device supports.
>>
>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> 
> As per the Documentation, "Co-developed-by" should be followed by
> "Signed-off-by" of the author. So you can just move this "Co-developed-by"
> below Asutosh's S-o-b and that should be fine.
> 
Ok.
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/ufs/core/Makefile  |   2 +-
>>   drivers/ufs/core/ufs-mcq.c | 524 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/ufs/core/ufshcd.c  | 394 ++++++++++++++++++++++++++--------
>>   include/ufs/ufs.h          |   5 +
>>   include/ufs/ufshcd.h       | 223 ++++++++++++++++++-
>>   include/ufs/ufshci.h       |  77 +++++++
>>   6 files changed, 1135 insertions(+), 90 deletions(-)
> 
> This patch is too big to review. Could you please split it into multiple
> patches?
> 
The current changes make up a single functional base MCQ driver.
Usually splitting into multiple changes are per feature based.
Since this is a single feature, it makes sense to be separated out into 
core and host only. Refer 7a3e97b0d - the base ufs driver.

> 
> 
> s/qd/depth
> 
Here queue depth is abbreviated to qd which I think is inline with what 
the function does. So I prefer to keep it as qd.

>> +
>> +	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> 
> 
>> +struct ufs_hw_queue {
>> +	void *sqe_base_addr;
> 
> s/sqe_base_addr/sqe_base
>  >> +	dma_addr_t sqe_dma_addr;
> 
> s/sqe_dma_addr/sqe_dma
> 
>> +	struct cq_entry *cqe_base_addr;
> 
> s/cqe_base_addr/cqe_base
> 
>> +	dma_addr_t cqe_dma_addr;
> 
> s/cqe_dma_addr/cqe_dma
> 
Existing ufs driver dma addresses have the suffix addr, Refer struct 
ufshcd_lrb. So it is in line with the current naming convention.

>> +	u32 max_entries;
>> +	u32 id;
>> +
>> +	void __iomem *mcq_sq_hp;
>> +	void __iomem *mcq_sq_tp;
>> +	void __iomem *mcq_cq_hp;
>> +	void __iomem *mcq_cq_tp;
[...]

>> +			      MCQ_CFG_n(REG_SQATTR, i));
> If you are writing to the same memory region, like in this case "mcq_base",
> then you should be able to use _relaxed variants as the writes to the same
> device memory are guaranteed to be in-order.
> 
Not sure if I understand this correctly. Let me check this internally 
and get back.

> This also removes the overhead associated with __iowmb included in writel.
> 
> Please audit this change throught the driver and use _relaxed variants where
> applicable.
> 

-asd

>> -- 
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
> 

