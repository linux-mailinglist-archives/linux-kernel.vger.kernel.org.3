Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561CC5A1861
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiHYSJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiHYSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:09:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF8BD14F;
        Thu, 25 Aug 2022 11:08:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBLHS9015534;
        Thu, 25 Aug 2022 18:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BcXe+Mq2OdbFM6VJjcOacCP0r4hwAGD5KEuc5dav7bA=;
 b=DjRS/fTc9WjBHEc0kKHaCfYy4ra7aZaRCiGTaDLH05d09kQrsQR24jwHa9aBalZZbgpR
 jnqrNFKgwsLlgfvuilo736HS+lm0orChmyNWEls5sow8awjumEyUVWFcv3FtA9HxaAPM
 05/+uvJhdWV8OMsh+t7+dwakHE1YQkSApClHpj/OxEy+TLO+7r+//GoDyAGb77XCWcOt
 FdiUNo47TD/vf5qw712GUBeLDxOnJ9VnKQdnzLXpyD0OYagNHLO4NtITzey0ClI24pcB
 FDDZzC2qM+MCSqg1abS3iQ75YuG+i1t/493JuCk5VhrwwpmNCP0YpXfzSnyZt+CFm3WH vQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6072bbrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 18:08:21 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PI8KGn008317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 18:08:20 GMT
Received: from [10.110.120.38] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 11:08:19 -0700
Message-ID: <fd9129d7-5688-20de-a716-738ce5076b50@quicinc.com>
Date:   Thu, 25 Aug 2022 11:08:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Bart Van Assche <bvanassche@acm.org>,
        Can Guo <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <mani@kernel.org>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
 <ea877f4f-1acd-2da4-a6f5-10df02dfee74@acm.org>
 <4471ed41-516c-95d4-003d-28077df7dce4@quicinc.com>
 <3326ad2e-e82f-7254-7e6b-bb0a120288f8@acm.org>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <3326ad2e-e82f-7254-7e6b-bb0a120288f8@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hzZhKO_tdECaID8Lg1bJzE9wMDsqwhqu
X-Proofpoint-ORIG-GUID: hzZhKO_tdECaID8Lg1bJzE9wMDsqwhqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2022 11:04 AM, Bart Van Assche wrote:
> On 8/24/22 18:42, Asutosh Das (asd) wrote:
>> On 8/18/2022 7:41 PM, Bart Van Assche wrote:
>>> On 8/11/22 03:33, Can Guo wrote:
>>>> +static inline void ufshcd_mcq_process_event(struct ufs_hba *hba,
>>>> +                        struct ufs_hw_queue *hwq)
>>>> +{
>>>> +    struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
>>>> +    int tag;
>>>> +
>>>> +    tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
>>>> +    ufshcd_compl_one_task(hba, tag, cqe);
>>>> +}
>>>
>>> Consider changing "process_event" into "process_cqe". Consider 
>>> renaming ufshcd_compl_one_task() into ufshcd_compl_one_cqe().
>>>
>> The preparatory patch that would precede this change would define 
>> ufshcd_compl_one_task() in ufshcd.c. Since this function would be 
>> invoked both from Single Doorbell mode and MCQ mode, 
>> ufshcd_compl_one_task() sounds more relevant. What say?
> 
> The name "task" is confusing since in SCSI standard documents it refers 
> to "task management" while ufshcd_compl_one_task() is not related to 
> SCSI task management at all. So I would appreciate it if another name is 
> chosen than ufshcd_compl_one_task().
> 
Ok, makes sense. Will change the name in the next version.

Thanks,
-asd

