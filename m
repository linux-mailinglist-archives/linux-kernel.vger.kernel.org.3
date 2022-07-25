Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4458057D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiGYUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiGYUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:24:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA2220F4;
        Mon, 25 Jul 2022 13:24:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PKLTcP023683;
        Mon, 25 Jul 2022 20:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Yxa2DKXFeSRUqLnxqH8PzN4Dvhs5EWeSMDfLydV/Vro=;
 b=gNTdVO0sJxDxZBONi/cGd5HX8UKxwWu6spxeD0F957cnmwJuW2dffqp6gi/3SUMAp7Gr
 PlCdnmvvofwsDpNNfqlYafqJss8Camw8BWknb0tZeFfchN3rmCIm+wboVea4UMZmkp9h
 zCvkIcuB5tpu2VXCAxBBcTnuMX+dmoqfBHaO7LfN6Gl+iAMTd0kMT0sD/5HBk9M4oDP2
 Xe9tGFoqqHwC0To/Pg7HyST5azkl6vHxW+X/OQJxWTeSnOTDDCEtwIHFmorGCgSRZEGI
 7hz3fBkcaMCdRrqrdk3gOLXeg05jtkPpTNUiP0mFdvH4Ea83+E2MSn6Eo+uaWffNW3Vk yg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hga9fwqs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 20:24:35 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PKOYA6013850
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 20:24:34 GMT
Received: from [10.110.113.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 13:24:33 -0700
Message-ID: <1d1b6814-6d3f-084a-d5bc-7364a98200db@quicinc.com>
Date:   Mon, 25 Jul 2022 13:24:32 -0700
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
 <a46700a8-585f-ddcb-ccaa-806afcb31ec3@quicinc.com>
 <DM6PR04MB65752C063B1C9D06A3CB44DAFC959@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <DM6PR04MB65752C063B1C9D06A3CB44DAFC959@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ztMQ9c_ltrnm1PsDj0dG8lZXUiYTqOQf
X-Proofpoint-GUID: ztMQ9c_ltrnm1PsDj0dG8lZXUiYTqOQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2022 12:50 PM, Avri Altman wrote:
>   
>> On 7/23/2022 1:22 PM, Avri Altman wrote:
>>>> -static void ufshcd_host_memory_configure(struct ufs_hba *hba)
>>>> +static int ufshcd_host_memory_configure(struct ufs_hba *hba)
>>>>    {
>>>>           struct utp_transfer_req_desc *utrdlp;
>>>>           dma_addr_t cmd_desc_dma_addr; @@ -3721,6 +3764,9 @@ static
>>>> void ufshcd_host_memory_configure(struct
>>>> ufs_hba *hba)
>>>>           int cmd_desc_size;
>>>>           int i;
>>>>
>>>> +       if (is_mcq_enabled(hba))
>>>> +               return ufshcd_mcq_memory_configure(hba);
>>>> +
>>>>           utrdlp = hba->utrdl_base_addr;
>>>>
>>>>           response_offset =
>>>> @@ -3759,6 +3805,8 @@ static void
>> ufshcd_host_memory_configure(struct
>>>> ufs_hba *hba)
>>>>
>>>>                   ufshcd_init_lrb(hba, &hba->lrb[i], i);
>>> If is_mcq_enabled, do you still call ufshcd_init_lrb?
>>>
>>> Thanks,
>>> Avri
>>>
>>>>           }
>> Another function ufshcd_mcq_init_lrb() is called.
> But you are still calling ufshcd_init_lrb anyway.
> 
I checked the patch, but couldn't find where ufshcd_init_lrb() is being 
invoked if mcq is enabled.
Please can you point it to me?

In ufshcd_host_memory_configure(), it goes as:
if (is_mcq_enabled(hba))
	return ufshcd_mcq_memory_configure(hba);

And ufshcd_init_lrb() is only invoked from ufshcd_host_memory_configure().

Am I missing something?

> Thanks,
> Avri
> 
>>

-asd
