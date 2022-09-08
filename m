Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79515B12BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIHDCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiIHDCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:02:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4BC6EBF;
        Wed,  7 Sep 2022 20:02:12 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2882iKuW007817;
        Thu, 8 Sep 2022 03:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CtCov/HTtvkaw18uY3TwBF/vS9gZM0HZDatDbWzyo0M=;
 b=Bfmdo1LDYDb9gIObixjvHxbiaiCDsZWG+4Oi/0L+BuEO07BOSZayf9oRxevnoXcUhxtZ
 Kt+zGtMiTmses9uFtRmhTrJMKep0mQQvP90zZVfncTK+VhkQb+kNBmIZOoHU+YcKbCYn
 amRnIKpVMAmbTVRFPn7/ce0YsYd4ZHSqcBjIPHkjAQyG85javJwYa/xVVc7sQoOv9rq6
 W52rGuuT3Q/rSfyuADn1vz5gVqz+KZys/O0XC3FJmNWbTDgiyENPj0JBCg2DHJlQBhF9
 sS+R2PWyS3YIqeX6UqguGEpj/6MhZ6lop1ZQyVFD9RwCnXLlxk5np/9YjZA+CxNLxw6Z ow== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jequfk8wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 03:01:38 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28831bXW020433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 03:01:37 GMT
Received: from [10.110.102.110] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 20:01:36 -0700
Message-ID: <4caaf07f-115a-eb2c-ed53-f62698167802@quicinc.com>
Date:   Wed, 7 Sep 2022 20:01:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH v3 2/4] ufs: core: mcq: Adds Multi-Circular Queue
 support
To:     Bean Huo <huobean@gmail.com>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <quic_cang@quicinc.com>,
        <beanhuo@micron.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
 <c3d2d8b307f7e11b7a2be751673220049b9a1a77.camel@gmail.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <c3d2d8b307f7e11b7a2be751673220049b9a1a77.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8zpRFCoviYprsjCSSEhq823F5RdlOb66
X-Proofpoint-ORIG-GUID: 8zpRFCoviYprsjCSSEhq823F5RdlOb66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_02,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080008
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bean
Thanks for your comments. Responses inline.

On 9/5/2022 9:27 AM, Bean Huo wrote:
> On Fri, 2022-09-02 at 15:41 -0700, Asutosh Das wrote:
>>
>> +
>> +static void ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>> +{
>> +       int i, rem;
>> +       u32 hbaq_cap, cmp;
>> +       struct Scsi_Host *host = hba->host;
>> +
>> +       hbaq_cap = hba->mcq_capabilities & 0xff;
>> +
>> +       rem = hbaq_cap - dev_cmd_queue;
>> +       /* min() compares variables of same type */
>> +       hba->nr_queues[HCTX_TYPE_DEFAULT] = min(hbaq_cap -
>> dev_cmd_queue,
> 
>   hba->nr_queues[HCTX_TYPE_DEFAULT] = min(rem, num_possible_cpus());
> 
min() compares variables of same type only.
>> +                                               num_possible_cpus());
>> +       rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
>> +       if (rem <= 0)
>> +               goto out;
>> +       cmp = rem;
>> +       hba->nr_queues[HCTX_TYPE_POLL] = min(cmp, poll_queues);
>> +       rem -= hba->nr_queues[HCTX_TYPE_POLL];
>> +       if (rem <= 0)
>> +               goto out;
>> +       cmp = rem;
>> +       hba->nr_queues[HCTX_TYPE_READ] = min(cmp, read_queues);
> 
> static read_queues is not initialized.
> 
It would be initialized to 0. But I think we should configure it as a 
module parameter which is missing. Let me add it in the next version.
>>
> .....
>> +static inline void ufshcd_inc_tp(struct ufs_hw_queue *q)
>> +{
>> +       u32 mask = q->max_entries - 1;
>> +       u32 val;
>> +
>> +       q->sq_tp_slot = (q->sq_tp_slot + 1) & mask;
>> +       val = q->sq_tp_slot * sizeof(struct utp_transfer_req_desc);
>> +       writel(val, q->mcq_sq_tp);
>> +}
> 
> This function just accesses the submission queue tail pointer. The
> function name should clearly explain this.
> 
The reason for this naming was that only SQ's tail pointer can be 
updated by SW. I can add a _sq_ to this function in the next version. 
Plmk if you prefer a better name.

> 
> 
> 

