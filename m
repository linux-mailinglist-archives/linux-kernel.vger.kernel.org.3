Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FE5802A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGYQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:26:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3FE1C93D;
        Mon, 25 Jul 2022 09:26:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PBOR2B022309;
        Mon, 25 Jul 2022 16:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=krRtdK0Cy6Im8bsE90b9X4dbN1lTV7/1hoasOmSFsOE=;
 b=eov2DKX8ywa9IBi/Oaauz7PLJ33mo9t5LQ028xlUxQ/ZQ9mQ+5n9mCU4VGvmDVkNrtGN
 Gw0iNvdk+QfK62XJrbCnrS74/DMuykOgIgCywjBeluqo7b2hilNtHmKa2bTgF+kSyT7y
 sliD3D9eqDa3v3egFPorlHfsxEOcPeav9+j9DJhAlveLQgHLxZXzdjxKiFmQQqJrfu1A
 otlH5tmwxzRuGSqwE9/6l2WvJWcj8d9MeI0cz+A3fHzfBu321IWNLnUkKzC8K0DOJg+U
 7zoVedm9scySkip8VOwqN5O/TltRTzoKCZjJlBbnCQbec72z6krC+KXlXoCtKlu18w6p Cw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hga9fw1v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:26:30 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PGQTH3003260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:26:29 GMT
Received: from [10.110.113.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 09:26:28 -0700
Message-ID: <a46700a8-585f-ddcb-ccaa-806afcb31ec3@quicinc.com>
Date:   Mon, 25 Jul 2022 09:26:28 -0700
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
 <DM6PR04MB65756C2EF5D9F23B5EC9E3A7FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <DM6PR04MB65756C2EF5D9F23B5EC9E3A7FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0NSP2KJnivg6ArFZeYIj8slNfXCcLzFj
X-Proofpoint-GUID: 0NSP2KJnivg6ArFZeYIj8slNfXCcLzFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2022 1:22 PM, Avri Altman wrote:
>> -static void ufshcd_host_memory_configure(struct ufs_hba *hba)
>> +static int ufshcd_host_memory_configure(struct ufs_hba *hba)
>>   {
>>          struct utp_transfer_req_desc *utrdlp;
>>          dma_addr_t cmd_desc_dma_addr;
>> @@ -3721,6 +3764,9 @@ static void ufshcd_host_memory_configure(struct
>> ufs_hba *hba)
>>          int cmd_desc_size;
>>          int i;
>>
>> +       if (is_mcq_enabled(hba))
>> +               return ufshcd_mcq_memory_configure(hba);
>> +
>>          utrdlp = hba->utrdl_base_addr;
>>
>>          response_offset =
>> @@ -3759,6 +3805,8 @@ static void ufshcd_host_memory_configure(struct
>> ufs_hba *hba)
>>
>>                  ufshcd_init_lrb(hba, &hba->lrb[i], i);
> If is_mcq_enabled, do you still call ufshcd_init_lrb?
> 
> Thanks,
> Avri
> 
>>          }
Another function ufshcd_mcq_init_lrb() is called.

-asd
