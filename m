Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191F5B12B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIHDBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:01:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07DC2775;
        Wed,  7 Sep 2022 20:01:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28821R2r015754;
        Thu, 8 Sep 2022 03:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ySt9FJ6x3mGnRfyzAKzow8pvjFUROJ1IzTdK3nLCeMU=;
 b=j7/Xi8at2D9OlFS+dd5R5s80Ou0Sm9el+rRU1gQ3CNngKTQPfvvJWpcV/APMAXB8kjEZ
 1ujb7iLSsBOBDFofR/Zg9tOGb66dP3FROzMbwF/z4MuGrDik101prwM7mkhCZFBxVYkt
 SHOM795DFQ1L9yQihKTXuOzrZXbSahgctkFnlWiJ5FT+ThgT1rJLPZpDRn20cXS+VHTi
 QKJ8LHUhWSqefdvk85qKxAykljTlcUgWuOJqGRCAtAuOn8yGn9xVc6H3WE7uXqIOQSeD
 yZRJpV/uKylSOcnqQo7FfZHIj7FgbJbRrb4gUfJZWQp3C34zTqeuzRg5leskUSJ3o2Wx 5A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jer7nk8wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 03:00:58 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28830wxJ021453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 03:00:58 GMT
Received: from [10.110.102.110] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 20:00:57 -0700
Message-ID: <df32bbd5-4109-903b-c7ba-7777a298f5aa@quicinc.com>
Date:   Wed, 7 Sep 2022 20:00:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular
 queue support
To:     Bean Huo <huobean@gmail.com>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <quic_cang@quicinc.com>,
        <beanhuo@micron.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
 <6e594dc2ce6103884b7768c2fed55eabec0d5ed8.camel@gmail.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <6e594dc2ce6103884b7768c2fed55eabec0d5ed8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aHbGIs9xG8BwgCooqlkcgG6Z4IhUCl21
X-Proofpoint-GUID: aHbGIs9xG8BwgCooqlkcgG6Z4IhUCl21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_02,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080008
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

On 9/5/2022 5:26 AM, Bean Huo wrote:
> Asutosh,
> 
> 
[...]
> 
>>   static inline
>> -void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>> +void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb
>> *lrbp)
>>   {
>> -       struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>> +       int task_tag = lrbp->task_tag;
>>          unsigned long flags;
>>   
>>          lrbp->issue_time_stamp = ktime_get();
>>          lrbp->compl_time_stamp = ktime_set(0, 0);
>> -       ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
>> +       ufshcd_add_command_trace(hba, lrbp, UFS_CMD_SEND);
>>          ufshcd_clk_scaling_start_busy(hba);
>>          if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>>                  ufshcd_start_monitor(hba, lrbp);
>> @@ -2553,9 +2554,10 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct
>> ufshcd_lrb *lrbp, u8 upiu_flags)
>>          /* command descriptor fields */
>>          ucd_req_ptr->header.dword_0 = UPIU_HEADER_DWORD(
>>                                  UPIU_TRANSACTION_COMMAND, upiu_flags,
>> -                               lrbp->lun, lrbp->task_tag);
>> +                               lrbp->lun, lrbp->task_tag & 0xff);
>>          ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
>> -                               UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
>> +                               UPIU_COMMAND_SET_TYPE_SCSI, 0, 0,
>> +                               (lrbp->task_tag & 0xf00) << 4);
>>   
> 
> Are you sure here "(lrbp->task_tag & 0xf00) << 4" is correct?
> 
EXT_IID is the higher nibble in DWORD1. So this looks correct to me.

COMMAND UPIU
0 	    1 	  2 	3
xx000001b Flags LUN Task Tag
4 			5 	6 	7
IID Command Set Type Reserved Reserved EXT_IID | Reserved
> 
> this will overwrite other fields, see UPIU_HEADER_DWORD:
> 
> #define UPIU_HEADER_DWORD(byte3, byte2, byte1, byte0)\
>                          cpu_to_be32((byte3 << 24) | (byte2 << 16) |\
>                           (byte1 << 8) | (byte0))
> 
> 
> 
>>
>>   
>> -       ufshcd_send_command(hba, tag);
>> +       ufshcd_send_command(hba, lrbp);
>>          err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
>>          ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR :
>> UFS_QUERY_COMP,
>>                                      (struct utp_upiu_req *)lrbp-
>>> ucd_rsp_ptr);
>> @@ -4513,6 +4515,7 @@ int ufshcd_make_hba_operational(struct ufs_hba
>> *hba)
>>                          REG_UTP_TRANSFER_REQ_LIST_BASE_L);
>>          ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
>>                          REG_UTP_TRANSFER_REQ_LIST_BASE_H);
>> +
>>          ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
>>                          REG_UTP_TASK_REQ_LIST_BASE_L);
>>          ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
>> @@ -5320,6 +5323,32 @@ static void ufshcd_release_scsi_cmd(struct
>> ufs_hba *hba,
>>          ufshcd_clk_scaling_update_busy(hba);
>>   }
>>   
>> +void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag)
> 
> This function does only complete one task. What does cqe stand for?
> 
CQE - Completion Queue Entry. The term 'task' is used for TM commands in 
scsi, hence there was a comment to change it to CQE.

>> +{
>> +       struct ufshcd_lrb *lrbp;
>> +       struct scsi_cmnd *cmd;
>> +
>> +       lrbp = &hba->lrb[task_tag];
>> +       lrbp->compl_time_stamp = ktime_get();
>> +       cmd = lrbp->cmd;
>> +       if (cmd) {
>> +               if (unlikely(ufshcd_should_inform_monitor(hba,
>> lrbp)))
>> +                       ufshcd_update_monitor(hba, lrbp);
>> +               ufshcd_add_command_trace(hba, lrbp, UFS_CMD_COMP);
>> +               cmd->result = ufshcd_transfer_rsp_status(hba, lrbp);
>> +               ufshcd_release_scsi_cmd(hba, lrbp);
>> +               /* Do not touch lrbp after scsi done */
>> +               scsi_done(cmd);
>> +       } else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
>> +                  lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
>> +               if (hba->dev_cmd.complete) {
>> +                       ufshcd_add_command_trace(hba, lrbp,
>> UFS_DEV_COMP);
>> +                       complete(hba->dev_cmd.complete);
>> +                       ufshcd_clk_scaling_update_busy(hba);
>> +               }
>> +       }
>> +}
>> +
> 
> 
> Kind regards,
> Bean
> 

