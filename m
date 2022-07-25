Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6286D5802C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiGYQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiGYQfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:35:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C9D107;
        Mon, 25 Jul 2022 09:35:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PBOwxI026705;
        Mon, 25 Jul 2022 16:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cEnwduPpwyucOzJXFfJGKfXaIW8eArB4jOH+nPzZ/ys=;
 b=OMoD2qvVlzw+rrR6uY4NlPQcExQG+2UcZYtsheKnskuPZ+mZXOu05+/6E3aB6NnFvOkG
 iw6w/6GZWAUcE8krES+K/Md8734K/g+O1W0IsbIUO9gJnGZDRaEtAZ4UecplC4GM4XQj
 3x3xYqfJbWveL1EUO6oG+kNc1NpLJPSMbUb3qGqpPBq/YKamfhuZkG1tlsWs8cH3mRpX
 6cwT7uw7yr34lWWyvfbezkN0Sc/6RxjBjgaOfM8oRiau6kNhssxz81S7Z2P/UXtp+ZYU
 63CxvDMOFnWVm9PMgeash7q9EjimicE3zJi1inC1/KZ2058CAt4EpA3da5lyjLofOC33 fg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hhs84h6q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:35:19 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PGZIAr006910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:35:18 GMT
Received: from [10.110.113.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 09:35:18 -0700
Message-ID: <78495ab6-358d-4d91-e710-140331f37843@quicinc.com>
Date:   Mon, 25 Jul 2022 09:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Avri Altman <Avri.Altman@wdc.com>, Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
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
 <DM6PR04MB65756C5A6C5F674B19091F7DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <DM6PR04MB65756C5A6C5F674B19091F7DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ESPoP9rufNSTrlSh0hXFVCj6eX04fc2H
X-Proofpoint-GUID: ESPoP9rufNSTrlSh0hXFVCj6eX04fc2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207250067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2022 2:23 PM, Avri Altman wrote:
>>   static inline
>> -void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>> +void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
>> +                        struct ufs_hw_queue *hwq)
>>   {
>> -       struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>>          unsigned long flags;
>>
>>          lrbp->issue_time_stamp = ktime_get();
>>          lrbp->compl_time_stamp = ktime_set(0, 0);
>> -       ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
>> +       ufshcd_add_command_trace(hba, lrbp, UFS_CMD_SEND);
>>          ufshcd_clk_scaling_start_busy(hba);
>>          if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>>                  ufshcd_start_monitor(hba, lrbp);
>>
>> -       spin_lock_irqsave(&hba->outstanding_lock, flags);
>> -       if (hba->vops && hba->vops->setup_xfer_req)
>> -               hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
>> -       __set_bit(task_tag, &hba->outstanding_reqs);
>> -       ufshcd_writel(hba, 1 << task_tag,
>> REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> -       spin_unlock_irqrestore(&hba->outstanding_lock, flags);
>> +       if (is_mcq_enabled(hba)) {
>> +               int utrd_size = sizeof(struct utp_transfer_req_desc);
> Maybe we can map some designated ops, so all those if (is_mcq) can be avoided in the data-path.
Umm, I couldn't find any ops in scsi_host_template {...}. Do you have 
any further insight into how this check can be avoided?
> Also maybe we can constify sizeof(struct utp_transfer_req_desc) which is used now few times.
> 
Ok, agree to make sizeof(struct utp_transfer_req_desc) a constant in the 
next version.

-asd
