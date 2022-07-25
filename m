Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B658038B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiGYRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiGYRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:36:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D9A46D;
        Mon, 25 Jul 2022 10:36:01 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PBOhFt021964;
        Mon, 25 Jul 2022 17:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ba3NBpgik/RlbZcSqjI7hnyK8Rl8xqoqOnzZmmYjne0=;
 b=c8+q7S06y+NHXK6h8iFEg9GIBR3T1qNLy+2Lb6dC0p9wOLVXwbR2xaQ8OlHhodttrfGd
 eoNhfq1gYTVMpNU0mjOP6US2S3QVXp0JHIyQkehAG55Tt4b8q0OD0illXvSx1Pl27XkP
 xU5f3PrEv9T4AkAPD22D0QtaUqMUjwVq/F/gAW2AwQl2NqoRkW8JgxMG/Ke+LZFGWzOR
 cKvrGszp1mbgk8Y4eiS6IQ0wUPtYK6FW5o3w/roZ0dop6gChSSTh20PLi9PiLgwzsv+F
 hK5E6PBZFJMdHsdB1G12fVqJY5ak4rwTzFwOAyluwot7IEgo4R/ox33lL6HMsjhXeNo0 mQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hg97andm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 17:35:49 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PHZmSn008588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 17:35:48 GMT
Received: from [10.110.113.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 10:35:47 -0700
Message-ID: <2f13e07d-744f-5c59-492c-846e2f31d202@quicinc.com>
Date:   Mon, 25 Jul 2022 10:35:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Bean Huo <huobean@gmail.com>, Can Guo <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <quic_nguyenb@quicinc.com>, <quic_ziqichen@quicinc.com>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <9f4c233f8f6f9288b17859efab0cb22df2452777.camel@gmail.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <9f4c233f8f6f9288b17859efab0cb22df2452777.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9I1utxZBljj_yp9u6V4xLRU4FLgCo7Ww
X-Proofpoint-GUID: 9I1utxZBljj_yp9u6V4xLRU4FLgCo7Ww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2022 2:54 PM, Bean Huo wrote:
> 
> Hi Can/Asutosh
> 
> A few questions about MCQ configuration:
> 
> 

Hello Bean,
Thanks for the review.

> On Tue, 2022-07-19 at 00:01 -0700, Can Guo wrote:
>> From: Asutosh Das <quic_asutoshd@quicinc.com>
>>
>> Adds MCQ support to UFS driver.
>>
>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>
>> +void ufshcd_mcq_config_mac(struct ufs_hba *hba)
>> +{
>> +       u32 val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
>> +
>> +       val &= ~MCQ_CFG_MAC_MASK;
>> +       val |= hba->dev_info.bqueuedepth << MCQ_CFG_MAC_OFFSET;
>> +       ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
> 
> Here you set MaxActiveCommand to dev_info.bqueuedepth (this limit comes
> from UFS devices). I see in the qsize configuration that you want to
> set the queue depth in each HW queue to be hba->nutrs (this limit comes
> from UFSHCI),  should not it be min(device limit, ufshci limit)?
> 
Yes, looks like it should be. Let me relook this logic.
>> +}
>> +EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
>> +
>>
> ...
>> +
>> +       for_each_hw_queue(hba, i) {
>> +               hwq = &hba->uhq[i];
>> +               hwq->id = i;
>> +               qsize = hwq->max_entries * MCQ_ENTRY_SIZE_IN_DWORD -
>> 1;
> 
> qsize is hba->nutrs, 32*8-1 = 255 =256DW,  per draft spec , should not
> be 8DW in 4.0?
> 
>> +
>> +               /* SQLBA */
>> +               ufsmcq_writel(hba, lower_32_bits(hwq->sqe_dma_addr),
>> +                             MCQ_CFG_n(REG_SQLBA, i));
>> +               /* SQUBA */
>> +               ufsmcq_writel(hba, upper_32_bits(hwq->sqe_dma_addr),
>> +                             MCQ_CFG_n(REG_SQUBA, i));
>> +               /* SQDAO */
>> +               ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQD, i),
>> +                             MCQ_CFG_n(REG_SQDAO, i));
>>
> 
> ...
> 
>>         }
>> +
>> +out:
>> +       hba->mcq_base = res->base;
>> +       return 0;
>> +
>> +out_err:
>> +       ufshcd_mcq_release_resource(hba);
>> +       return ret;
>> +}
>> +
>> +int ufshcd_mcq_init(struct ufs_hba *hba)
>> +{
>> +       struct Scsi_Host *host = hba->host;
>> +       struct ufs_hw_queue *hwq;
>> +       int i, ret = 0;
>> +
>> +       if (!is_mcq_supported(hba))
>> +               return 0;
>> +
>> +       ret = ufshcd_mcq_config_resource(hba);
>> +       if (ret) {
>> +               dev_err(hba->dev, "Failed to config MCQ resource\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = ufshcd_vops_config_mcq_rop(hba);
>> +       if (ret) {
>> +               dev_err(hba->dev, "MCQ Runtime Operation Pointers not
>> configured\n");
>> +               goto out_err;
>> +       }
>> +
>> +       hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
> 
> 4.0 supports maximum number of queues is 32. for cpus < 32, cpu to
> queue will be 1x1, how about cpus > 32?
> 
Good point. Will check and fix it.
>> +       hba->nr_queues[HCTX_TYPE_READ] = 0;
>> +       hba->nr_queues[HCTX_TYPE_POLL] = 1;
>> +
>> +       for (i = 0; i < HCTX_MAX_TYPES; i++)
>> +               host->nr_hw_queues += hba->nr_queues[i];
>> +
>> +       host->can_queue = hba->nutrs;
> 
> Also here, can_queue is inlined with ufshci limitation, not the UFS
> device limit.
> 
Yes, will take a look.
>> +       host->cmd_per_lun = hba->nutrs;
>> +
>> +       /* One more reserved for dev_cmd_queue */
>> +       hba->nr_hw_queues = host->nr_hw_queues + 1;
>> +
>> +       hba->uhq = devm_kmalloc(hba->dev,
> ...
>>   
>>          ufshcd_tune_unipro_params(hba);
>> @@ -9641,6 +9775,10 @@ int ufshcd_init(struct ufs_hba *hba, void
>> __iomem *mmio_base, unsigned int irq)
>>                  goto out_disable;
>>          }
>>   
>> +       err = ufshcd_mcq_init(hba);
> 
> The driver will force the customer to use MCQ, how about adding a
> configuration option for the customer to choose (like eMMC CMDQ does)?
> 
Let me check what eMMC does and see if that can be adopted here.

> Kind regards,
> Bean
> 
> 

-asd
