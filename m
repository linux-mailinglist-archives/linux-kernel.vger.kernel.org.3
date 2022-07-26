Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC06F5809B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGZC4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiGZC4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:56:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8142611441;
        Mon, 25 Jul 2022 19:56:23 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q0oJGH012131;
        Tue, 26 Jul 2022 02:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eh7lwV78QvbkO6UqWgVk7uxqFlg4dBXN/Goh4UfRBYI=;
 b=k/y7wPYT++cECz42lbSsiSPquF0/DEf6rYO00e/son/i/eKtJWLxWWupK+ZDup9Zka9f
 PEe0ec90ec587kStHYInG26q7ixTyolJZZQmCC+FazaB3WRMbJfHBlPYMLOnZOSb8kOH
 gcZ3GqWnUm4vrNNJcmIPOp/jyZxH3hAYtN2bb6h1wq8ecg0v/CUGRyRAflJcVJAZNKw9
 YlqS7qsrZyKHfluJnM8iX2IEcpSVsPilcTtcJn46llfprQHYjiZPFeU/QbpcBwOcY8AM
 ShqyDV+SVRIBsGndl6kuJSR053XQeoyPUeF++ok2/gdneYeNpfMQ9d7nuM2o7+b/WYy7 Ow== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hhs84jc3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 02:55:59 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26Q2tw3A019793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 02:55:58 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 19:55:57 -0700
Received: from [10.253.34.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 19:55:52 -0700
Message-ID: <2975315f-f59b-0787-a662-e50766aaf470@quicinc.com>
Date:   Tue, 26 Jul 2022 10:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB6575048E121B56FDA56DA27DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <DM6PR04MB6575048E121B56FDA56DA27DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7aVkLI4sa6HQ-IZBTWliXdILxzYlZQwP
X-Proofpoint-GUID: 7aVkLI4sa6HQ-IZBTWliXdILxzYlZQwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207260010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

On 7/23/2022 10:59 PM, Avri Altman wrote:
>> +#define MCQ_ROP_OFFSET_n(p, i) \
>> +       hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i)
> Can you please explain the 0x100 stride thing?
> Theoretically, each rop set is 48Bytes long, or did I get it wrong?

In the draft, there are 4 sets of MCQ Operation & Runtime Registers, 
i.e. SQD_n, SQIS_n, CQD_n and CQIS_n.

They may be interleaved or segregated, depends on realistic HW designs.

For example, either #1 or #2 can be the case, and QCOM uses case #1, in 
which 'stride' means the size (in bytes)

that one register has to hop over to reach the same register on next 
round (for example, addr of SQHP_n == (addr of SQHP_0) + (stride * n)).

To allow flexibility, SoC vendors, depends on realistic HW designs, (by 
using vops_config_mcq_rop) can manipulate

the 'offset' and 'stride' of each MCQ Operation & Runtime Register such 
that SQDAO_n, SQISAO_n, CQDAO_n and

CQISAO_n are programmed with wanted offsets/values.

#1 -

SQHP_0
SQTP_0
SQRTC_0
SQCTI_0
SQRTS_0
SQIS_0
SQIE_0
CQHP_0
CQTP_0
CQIS_0
CQIE_0
CQIACR_0
SQHP_1
SQTP_1
SQRTC_1
SQCTI_1
SQRTS_1
SQIS_1
SQIE_1
CQHP_1
CQTP_1
CQIS_1
CQIE_1
CQIACR_1
...
SQHP_n
SQTP_n
SQRTC_n
SQCTI_n
SQRTS_n
SQIS_n
SQIE_n
CQHP_n
CQTP_n
CQIS_n
CQIE_n
CQIACR_n


#2 -

SQHP_0
SQTP_0
SQRTC_0
SQCTI_0
SQRTS_0
SQHP_1
SQTP_1
SQRTC_1
SQCTI_1
SQRTS_1
...
SQHP_n
SQTP_n
SQRTC_n
SQCTI_n
SQRTS_n


SQIS_0
SQIE_0
SQIS_1
SQIE_1
...
SQIS_n
SQIE_n


CQHP_0
CQTP_0
CQHP_1
CQTP_1
...
CQHP_n
CQTP_n


CQIS_0
CQIE_0
CQIACR_0
CQIS_1
CQIE_1
CQIACR_1
...
CQIS_n
CQIE_n
CQIACR_n


Thanks,

Can Guo.

> Thanks,
> Avri
