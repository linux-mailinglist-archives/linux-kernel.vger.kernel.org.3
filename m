Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821E5802D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiGYQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiGYQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:38:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311ED107;
        Mon, 25 Jul 2022 09:38:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PBOf4f019345;
        Mon, 25 Jul 2022 16:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c++ABr6WVFhTzwBu/66qNkuHmrHdCTXeJWQZ5Zyknwk=;
 b=WY8uaWTsPO/od86duUEBlMceFeIjPTg9R+tMgnfwpKhci3ecfkPHBcCKzzvxBesL9eBe
 p5EwJ6iZU9m6Q7xMwOtgP3LM+6s+PY3tHLHkof1SxaKGpDcqIHpv430KEK81cLWSooVM
 ZtRSRefHrV7BWHM1m0gEddJUx5FM9l0hSUqFccVIuuA6OqDa9JXyG6n8is1UNhZry1kQ
 8Ac+NDyL3D9F87tF3YFpYUF+kL78kiCXGYA1eXyOtdxmwQndS5htF5utB3CLutYqnABk
 L0pDSJBVQSeS2CQEchQxfwJilHD7Cgma/O9S8sNU+df8WKcOYlRpbf0+RKdi0WIQaTLN bA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hga5sn47h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:38:37 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PGcaFq017562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:38:36 GMT
Received: from [10.110.113.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 09:38:35 -0700
Message-ID: <99294805-d8b0-1c40-5f44-ebd9d0e6abb4@quicinc.com>
Date:   Mon, 25 Jul 2022 09:38:35 -0700
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
 <DM6PR04MB65757CEC7F66AB732EF5FC48FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <DM6PR04MB65757CEC7F66AB732EF5FC48FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tYjHNPKQ1rer7b1Ggbb2Fa9kLhzKoJ4i
X-Proofpoint-GUID: tYjHNPKQ1rer7b1Ggbb2Fa9kLhzKoJ4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207250067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2022 9:07 PM, Avri Altman wrote:
>> @@ -2558,7 +2587,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct
>> ufshcd_lrb *lrbp, u8 upiu_flags)
>>                                  UPIU_TRANSACTION_COMMAND, upiu_flags,
>>                                  lrbp->lun, lrbp->task_tag);
>>          ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
>> -                               UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
>> +                               UPIU_COMMAND_SET_TYPE_SCSI |
>> +                               (lrbp->hw_queue_id << 4), 0, 0, 0);
> This is fine, as long as we have 16 queues or less.
> Otherwise, we need to fill the EXT_IID as well (only if bEXTIIDEn = 1).
> 
Yes, correct. Will add the code for EXT_IID in the next version.

> Also, don't we need to do this for query commands as well?
> Or at least add a comment that the queue id for query command is 0.
> 
Query commands would use the reserved queue whose id = 0.
I agree a comment should be added detailing this.
Will add in the next version.

> Thanks,
> Avri

