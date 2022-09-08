Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532335B12BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIHDCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIHDB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:01:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D657C6CE8;
        Wed,  7 Sep 2022 20:01:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2882u8Kl017013;
        Thu, 8 Sep 2022 03:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ySWtRERC12xwzT1oRObQXgd4LYRI7Eh+/mjUULrxqME=;
 b=TwU4srDMsT6ALFwWwUQMHup45yfUnLoEptMo1K5j67RLsIcNmROIjNISZmxczQQiO3dG
 hUYCqQTuKHOXOXZh1/ioC3IlRiEXgmNDDFRGluWuVE8CAu5fVSVaWMEK60wJjy+nL8MD
 JcvFbymaQvD9OZv0RuxK0Tu+FtWuNB/9aOHXcLL+sn1+ZM0xCv9mrDmU96vhWBs+KtNe
 X1hP5fgv1RFOU1ntlX8RRGI9qoLEzAyTs6AyhQ8mgE/4UY5Twpi1igKvt39lrl3VuYMG
 yP/Q96UCneTQALZfcvHBd0eOlqif1vmMKpBtCCINrXddRErMXVGMsv9Q3f9bGogA0Lzl Tw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1swrphw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 03:01:21 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28831JBj023345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 03:01:19 GMT
Received: from [10.110.102.110] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 20:01:19 -0700
Message-ID: <d53ed27c-024f-8f50-1c9b-8b639b52a1c8@quicinc.com>
Date:   Wed, 7 Sep 2022 20:01:18 -0700
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
 <748f9c294e304cc5b5ccd9804fa647afc39c8bc3.camel@gmail.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <748f9c294e304cc5b5ccd9804fa647afc39c8bc3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _InkazLZ6IYSn6AVwKFML1EFpSKnZzGW
X-Proofpoint-ORIG-GUID: _InkazLZ6IYSn6AVwKFML1EFpSKnZzGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_02,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On 9/5/2022 6:48 AM, Bean Huo wrote:
> On Fri, 2022-09-02 at 15:41 -0700, Asutosh Das wrote:
>> +/**
>> + * ufshcd_mcq_decide_queue_depth - decide the queue depth
>> + * @hba - per adapter instance
>> + *
>> + * MAC - Max. Active Command of the Host Controller (HC)
>> + * HC wouldn't send more than this commands to the device.
>> + * The default MAC is 32, but the max. value may vary with
>> + * vendor implementation.
>> + * Calculates and adjusts the queue depth based on the depth
>> + * supported by the HC, ufs device and if ext_iid is supported.
>> + */
>> +u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
>> +{
>> +       u32 qd, val;
>> +       int mac;
>> +
>> +       mac = ufshcd_mcq_vops_get_hba_mac(hba);
>> +       if (mac < 0) {
>> +               val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
>> +               mac = (val & MCQ_CFG_MAC_MASK) >> MCQ_CFG_MAC_OFFSET;
>> +       }
>> +
>> +       /*  MAC is a 0 based value. */
>> +       mac += 1;
>> +       qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
>> +       if (!qd)
>> +               qd = mac;
>> +
>> +       /* Adjust queue depth based on ext_iid support. */
>> +       if (qd > 256 && (!hba->ext_iid_sup || !hba-
>>> dev_info.b_ext_iid_en))
>> +               qd = 256;
>> +       else if (qd > 4096 && hba->ext_iid_sup && hba-
>>> dev_info.b_ext_iid_en)
>> +               qd = 4096;
>> +
> 
> Astosh,
> 
> I don't understand here.  How can qd be 4096?  MAC in UFSHCI  is 9 bits
> width, the maximum depth will be 512, and hba->dev_info.bqueuedepth is
> one byte width, maximum will be 256.
> 
Correct. The spec is fuzzy about it. Because ext_iid provides a 
provision to increase the Queue depth to 2^12. Even though the 
parameters that you referred to don't support it now.

Will remove this part in the next version.

> Kind regards,
> Bean
> 

