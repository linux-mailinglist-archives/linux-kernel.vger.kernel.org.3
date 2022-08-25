Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32115A06FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiHYBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiHYBvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:51:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D677567;
        Wed, 24 Aug 2022 18:44:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P1BJI9003283;
        Thu, 25 Aug 2022 01:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1IqX6MUoNZzcYl6uTl8ytU0e5VUhZBjo8yJiqNMWhSU=;
 b=L4Q2AiJxDLIK0PFWu9KHzsrbALagC3DKsWxrggQQSsexUMzQ6NdL/i3m4FyvL3jh87yd
 mi4+LH4fY9mzFeHlrWdVyVPfEfXxDxKf0dkOvDTI6bce0FJCmloracrKp7Nm6XlI1XX1
 X6ahiIKCH/EeY41p5or9h/He6sFNSPb/6iSi6oQ1UaYL83+Pp5n6223Y1fHpO08rIMOS
 97hI+gyL8z/t28XVgSFIXduYyxfj7wcRk2uKR0e1sIOAFtBQzqDo8kTQw1WPkLzn1erb
 Kw4u3iqcm4QLsxCn5YUoF8Him91jiICZBMfaeYikKW6C0fNs0JV1w5v1Hy+S50119Of6 Bw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pj54wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 01:43:00 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27P1gxAx007793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 01:42:59 GMT
Received: from [10.110.120.38] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 18:42:58 -0700
Message-ID: <4471ed41-516c-95d4-003d-28077df7dce4@quicinc.com>
Date:   Wed, 24 Aug 2022 18:42:57 -0700
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
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <ea877f4f-1acd-2da4-a6f5-10df02dfee74@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ACHtjs5nBAdx44EA2fh3EbMsc-TM1-7Z
X-Proofpoint-ORIG-GUID: ACHtjs5nBAdx44EA2fh3EbMsc-TM1-7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_01,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250004
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bart,

Thanks for taking a look.

Sorry for the delay in response.

Please find the response to your comments below.

On 8/18/2022 7:41 PM, Bart Van Assche wrote:
> On 8/11/22 03:33, Can Guo wrote:
[...]
>> +    /* One more reserved for dev_cmd_queue */
>> +    hba->nr_hw_queues = host->nr_hw_queues + 1;
> 
> Should '1' above perhaps be changed into 'dev_cmd_queue'? Are you sure 
> that the comment above is in sync with the code?
> 
>> +    ret = ufshcd_mcq_vops_config_rop(hba);
>> +    if (ret) {
>> +        dev_err(hba->dev, "MCQ Runtime Operation Pointers not 
>> configured\n");
>> +        goto out_err;
>> +    }
[...]
>> +static inline void ufshcd_mcq_process_event(struct ufs_hba *hba,
>> +                        struct ufs_hw_queue *hwq)
>> +{
>> +    struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
>> +    int tag;
>> +
>> +    tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
>> +    ufshcd_compl_one_task(hba, tag, cqe);
>> +}
> 
> Consider changing "process_event" into "process_cqe". Consider renaming 
> ufshcd_compl_one_task() into ufshcd_compl_one_cqe().
> 
The preparatory patch that would precede this change would define 
ufshcd_compl_one_task() in ufshcd.c. Since this function would be 
invoked both from Single Doorbell mode and MCQ mode, 
ufshcd_compl_one_task() sounds more relevant. What say?

>> +unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
>> +                       struct ufs_hw_queue *hwq)
>> +{
>> +    unsigned long completed_reqs, flags;
>> +
>> +    spin_lock_irqsave(&hwq->cq_lock, flags);
>> +    completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
>> +    spin_unlock_irqrestore(&hwq->cq_lock, flags);
>> +
>> +    return completed_reqs;
>> +}
> 
> Why are interrupts disabled around ufshcd_mcq_poll_cqe_nolock() calls?
> 
> Why are the ufshcd_mcq_poll_cqe_nolock() protected by a spinlock?
> 
Because ufshcd_mcq_poll_cqe_lock() is invoked by ufshcd_poll() which may 
be invoked simultaneously from different CPUs.
But only spin_[un]lock() variant can suffice here.

[...]

>> +static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
>> +{
>> +    struct ufs_hw_queue *hwq;
>> +    unsigned long outstanding_cqs;
>> +    unsigned int nr_queues;
>> +    int i, ret;
>> +    u32 events;
>> +
>> +    ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
>> +    if (ret)
>> +        outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
>> +
>> +    /* Exclude the poll queues */
>> +    nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
>> +    for_each_set_bit(i, &outstanding_cqs, nr_queues) {
>> +        hwq = &hba->uhq[i];
>> +
>> +        events = ufshcd_mcq_read_cqis(hba, i);
>> +        if (events)
>> +            ufshcd_mcq_write_cqis(hba, events, i);
>> +
>> +        if (events & UFSHCD_MCQ_CQIS_TEPS)
>> +            ufshcd_mcq_poll_cqe_nolock(hba, hwq);
>> +    }
>> +
>> +    return IRQ_HANDLED;
>> +}
> 
> Why the loop over the completion queues? Shouldn't UFSHCI 4.0 compliant 
> controllers support one interrupt per completion queue?
> 
MCQ specification doesn't define that UFSHCI 4.0 compliant HC should 
support one interrupt per completion queue. I guess it would depend on 
HC vendors. But it specifies ESI as an alternate method; which is 
implemented in this patch.

>> -/* Complete requests that have door-bell cleared */
>> +/*
>> + * Complete requests that have door-bell cleared and/or pending 
>> completion
>> + * entries on completion queues if MCQ is enabled
>> + */
> 
> Since the above comment has been changed, please spell the word doorbell 
> correctly (no hyphen).
> 
>> @@ -6823,7 +6947,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct 
>> ufs_hba *hba,
>>                       enum query_opcode desc_op)
>>   {
>>       DECLARE_COMPLETION_ONSTACK(wait);
>> -    const u32 tag = hba->reserved_slot;
>> +    u32 tag = hba->reserved_slot;
> 
> Why has the 'const' keyword been removed?
> 
>> +    if (hba->nutrs != old_nutrs) {
>> +        ufshcd_release_sdb_queue(hba, old_nutrs);
>> +        ret = ufshcd_memory_alloc(hba);
>> +        if (ret)
>> +            return ret;
>> +        ufshcd_host_memory_configure(hba);
>> +    }
> 
> Can this freeing + reallocating be avoided?
> 
Umm, we thought about this. Only after reading the device params, the 
ext_iid support and the device queue depth be determined. So didn't look 
like there's any other way than this. If you have any ideas, please let 
us know.

Agree with the rest of the suggestions, would address it in the next 
version.

-asd/can
