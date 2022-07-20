Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC957BCC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiGTRgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbiGTRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:36:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D256052C;
        Wed, 20 Jul 2022 10:36:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGlQDi031128;
        Wed, 20 Jul 2022 17:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KoYN6t2ojX51eMCu42S4f7m7B8qXBwHa6ASD9qlPSh8=;
 b=iSPu9XFZSMAkgoAiQqlXoC5Dsbqjs6VsDvJCpE90kZlaw6zOGmqkCgBq/sSjEUENCK4X
 kal8ASE4/Os9Hz8VhHYBNm8chLMGb/j66P8faTMGMqRvaTzHHpGQwnJdLx6RD06g4/fq
 6f3ePZBcGfwxNBTHyz9lDkMR+KkGdTI6/X2Mmn+BMUmQ+qJSNOR77RjeAB+I7C9U2Vsj
 /o14bV5SHQp2KCr9pVpXOxnNUP1PmIKP2O6uv35SHmf5P3/qwPA9n0/dbvkpszNMGwQP
 fz34xTW+q4SpGB9zwj6mpnAzq4vZdLiI1/jqrpjnl6b9paDSD5TJefuKK3lU45fyn92n zg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3he90k23dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 17:36:34 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KHaXsu015729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 17:36:33 GMT
Received: from [10.46.161.58] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 10:36:32 -0700
Message-ID: <cd6e30b2-55da-eca8-d4fc-fdc143f340f7@quicinc.com>
Date:   Wed, 20 Jul 2022 10:34:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Bart Van Assche <bvanassche@acm.org>,
        Can Guo <quic_cang@quicinc.com>, <stanley.chu@mediatek.com>,
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
 <574ad23b-45c9-1bc3-0a86-c7cb73ea07bf@acm.org>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <574ad23b-45c9-1bc3-0a86-c7cb73ea07bf@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BITM_wsmMmEOn15-5vKT8R9JTdDi_tRK
X-Proofpoint-GUID: BITM_wsmMmEOn15-5vKT8R9JTdDi_tRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_10,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 7/19/2022 4:07 PM, Bart Van Assche wrote:
> On 7/19/22 00:01, Can Guo wrote:
>> Adds MCQ support to UFS driver.
> 
> The description of this patch is too short. It should be explained how 
> the UFSHCI queues are made visible to the block layer. It should also be 
> explained which roles are assigned to queues and how (HCTX_TYPE_*). How 
> the MAXQ configuration register is handled should also be explained.
> 
> The host lock is obtained in multiple UFSHCI 3.0 code paths. Information 
> about the role of the host lock in MCQ code should be provided.
> 
> Thanks,
> 
> Bart.
Thanks for having taken a look.
I'll check the comments and upload a next version.

-asd
