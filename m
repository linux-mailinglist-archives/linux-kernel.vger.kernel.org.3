Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E94D8BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbiCNSnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbiCNSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:43:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54073DDED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:42:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EHwF9C001444;
        Mon, 14 Mar 2022 18:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5oWMd/qg1Qhx0qmNX/eJWmpgcl1pm96z56Cq30n1zDo=;
 b=dS5egzFnFBwXIVM2tl+CUwFSrYvpP3EjxBMp5q+mvDzyX0I7PwYiKwUJRfFVJWR60D1p
 vjWkEvschsuhMYX65pR7QEFVF0m17+me0288+ic3AYqdaPP/q4UY29saEcA2e3c2GUKa
 zV1t3kW+fnaxKv/Ll66KWgDO6kMHIKygoToyTYNk/B8w3zk1kqIrw6ksp8eR1meiH4dw
 jLQlt2OTDCMmOHA+23oS1na8mRPmeW3dXDGPmPBo0e+sAt8RQMyNW1YhLxcVIS1E7ZSM
 TPxiHd+jnaAgvm1S+EsW6ETkZSk7JZi02M1FFpulskOKTfqgmV9QIAo6dXS7ertHRv/t ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu177v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:42:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EIZaNY054918;
        Mon, 14 Mar 2022 18:42:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3et64jduht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1cchmkruqtoTTce8SZy2D+su2YMGJNYbG5+JbjoC6Z7M7lETNpCC+/uP849xqxXmO34V7DGTgH7PqSNv3KrQ1AwJ7Gm3Q8Ajb2FtARfr+H5KRaTOQm53j1kzWjiDiEDyr6L3bi0iGLOdpLRgJuwgp9Ob6vTW+x6Dh4VmhmzlNXeY4S7swcnjnwgqLNDl18pjLFlTkr2OJj/Bc6RXD8EjfzvEc+yms3LTECwp84iHomiiKryaAihboVyOAWjeu6uJZu8HNRWsmtS0QF3Li1ofM8mQDpvmNiTRkptNNy5MJ//BsVje2+jvuZrRUdcVIRLpSlJap+eBjNKVOVeUjIkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oWMd/qg1Qhx0qmNX/eJWmpgcl1pm96z56Cq30n1zDo=;
 b=nlB2i02MKwhiC8GVpcjVqmP3+VK2iPFX/5lAox7z2s7AcZikWozkCugjI8ezY9lRj14RHoR/IspMzKtT4jPacUyBdsZ0nzH+sCpfxJJkNg4CHcuIgHUM8l6c9DjZlLGm+pTUFFAL73iYnWK3E7SvDR35/qCdzIc/0itn+AT08/uI34nIc3zPlP3DiObnmyDXR/r/Ii/b6YMIKjCv0uWTI2Dp+oSZEyPWfrLbNioMHeCqseXifV3zjF18Rm47aPhkycpMy0MK6X+MEOxL8135LqhGAQ2JXor9VLalGBsTHSYGaoKeIr2y1BsXmts1O5L3WrJGCCjHrnA5yHxVelnU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oWMd/qg1Qhx0qmNX/eJWmpgcl1pm96z56Cq30n1zDo=;
 b=BwBnq0DkMCxaeSKla0p0wPsJiONFcTfTQPjcRLyEm8gvm0yM7fPmxT3qorK4ObxYnGpWWDXxJjxTqzYGzdW55JT3glWUMWcr+D8DTFLf2y+wQ/AsClknl3APrTdIbBfX3mC757tAnRuIhV/PYt2wMbTD4eMMaQ8IINhfc3W1Gig=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2318.namprd10.prod.outlook.com (2603:10b6:301:2f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 18:42:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 18:42:01 +0000
Message-ID: <d90050b7-97e7-3975-8918-43350e93d01c@oracle.com>
Date:   Mon, 14 Mar 2022 11:41:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
 <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:300:117::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a3178be-ab90-4387-8ae5-08da05ea5397
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2318:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23188BE8C7CA5178A68DBB9EE20F9@MWHPR1001MB2318.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svJbo0FjX5VuAsVvbOXQ4DjKhc7sr+iFEy8hr5EmCohRjcCpMeNgu2Lou5MePtBxafN5ZNiSnIKRZ+ItKknu8jn999/Gv6MC9qOdGuadb2KyIABDZAFZ6WvgAPWxPpx0FzTqqaa/QbhxHRnuBHPS4ehrKgKuoQY6KRAryG0mrpIR5GOUzVOQu2i4YckDX3VkRmesT8LxVmsuPOv88jVDwfLffO01Vsg+cMFEIli68CxciWqqt2PBs4K9hQ2AmZTDFNSFSiYWEkuxP2t5lPmywxt0AjeZiblD/o0qkumLThAZvwKXrlO6Iks5Y0sb1AE6mGMoTawQJMXJ85f8YQgsWWSxyaiRAGQKn7N314HqojHPrK3eX99rjN3B8NoLKsMyk0hjkMPpjQrvjw3NzQkR6jhk1dc5igxWH7ZLtEipYtfWOH/61XJa1EphsarioMGnDNMOmetxsiB4TlIylXMVhhGLuRfMozqRQM/HR2QTf9ZUXIgiM0/DE0rrIW9rZ41s6iQ4RoJZlC1Mbmf2HyMVi6+aIxjEE2qR6nm1YapOVlAYtpq7ekCMz6tI1LTi0e1IHCCur6x7UdR/EjZ0lm7EVlRATBHkU1V5VEHkhhP7UCkgwUEqshgqVSzsebWDTxX//v6ZCpdGKzLrpoHwfJPIyhadwDpnqdoUpz97RLlhEJymPpbmvIHFr/CuONZ+4MbJJqEPf3FdEvQk37aLsIFvu0vW4aIFKWIyDpO9LyUJsWVR/YvDP6RPdjZXrkij5hHfes3MQev+GkTcvdIWh5wooA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(66476007)(66946007)(66556008)(53546011)(110136005)(316002)(6512007)(6506007)(2616005)(31696002)(186003)(26005)(52116002)(86362001)(6486002)(508600001)(38100700002)(44832011)(38350700002)(5660300002)(8936002)(31686004)(2906002)(36756003)(8676002)(83380400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpyc2lKNnFmMnp3aGJWWVJ6c2xqMXhhZjdmRFZuWUhnWm84czBxYnlsVkRJ?=
 =?utf-8?B?dUZiQzhtdWNPbjdLdk1CeW1MOStKbDVFeUMwaUthWm1PRmhTV2IrdVZLM3VM?=
 =?utf-8?B?THpsUjNmYVhVUDZ0amh1SFp5RTRuUnRsN2Q5bVcrTUJDV1R0K2xlS2syRXAw?=
 =?utf-8?B?NjV1V1QxK3BDNzBIUERqajdDRXhIbjBLdTlzbG9VSlJJbVAzWjB0OC9oKyt2?=
 =?utf-8?B?SWFTVXY0TnRaWk13YnBHS0tXdkJ3bEJRSWU5YkFCZTBaaDhWeTU4WTJoTEVN?=
 =?utf-8?B?K0R0MkRBMzZKeEdOWHdyaWVwVmVKK3pRdlAyZ0ZDTzhMK3F3eksvV0xpRzVL?=
 =?utf-8?B?KzBKcjQ2VnJTZ29hYjUyZDFIeC9GRHRXaDkwbWN1YmJObThtY202Yk5IOFB4?=
 =?utf-8?B?M3Fnd0ltbDNHUEV2MTI4eUdLUW1rSW1tVkM3WTdrNkxDQlZGWFQ3VUR3ZUtE?=
 =?utf-8?B?QTY3aFVRRXBzRHUzcDFvYmpWZ21ZN0dTQm9LMTl6bzkxSWZyZ3JEZnZJSEU1?=
 =?utf-8?B?NGhiSHVRMjVpYmNoN3ZrMm1uNlo1QStuVDhvdFhsNTdmVC9ZTCsrVS9QZC96?=
 =?utf-8?B?M2lsdjZhcHp0MWN6QSs4YmVjVUVrUXdNTzRaSUFMM2lDNXZwR1BCOEh5SEZN?=
 =?utf-8?B?MDVxY0RRdXV1M3N0VHk0M3hZaVJtZThoblVvOVVoNElTajFPUTd1WVNzY2ln?=
 =?utf-8?B?UmU3ZHIvSkVSTTlJODFJLzFPemxMc0pGeGZHTFRMUVlNQjE5ZGovd2xCUnZl?=
 =?utf-8?B?TjBsZHQ1bHZwWDR3WDBtV3c1ZHBVell1UVNsa2s4bzh5OTVOZGNWT3ZycjB1?=
 =?utf-8?B?UXh2R0JiVGsrejJoRGUwYnBFanpPR2FvZFhpWWpEOGg5YVZRT2xRWkVRR1Fm?=
 =?utf-8?B?bzNxY0Jhak5WSHBubUdoSmFYc3hjMUVsQmt5NVQ2dWlIRmE0Q09tMU91Ni9u?=
 =?utf-8?B?RnA4WkZkTUVIdFdzbHI2RktjM0VURkYvcnZIZjhtSHhML2M3Uk1TSU1lZHhx?=
 =?utf-8?B?NnFTbXE5TlVJU2dHcnlPYVlUU1BiUmtZSU9qaVYvUTdiYm9RNnJoV1ZsdW9x?=
 =?utf-8?B?cGlTRXpqbFJTcUErUmZvWTlLMlJ4b3NlZkhvMEtUN09ZRWQrVEdDMFhzSENG?=
 =?utf-8?B?OVBtdFdsQjVWTm00U1drOGlNc2JqRDY1WFgrTG5VdGR0ckxpR3RpajBVaE1D?=
 =?utf-8?B?Y1hkNkNWSmZ2UnBpMHNXcmNGVGFpZkRBa0dXcGFFbVgyWlF5TFVPRTl0RG5G?=
 =?utf-8?B?RWFZdXJ5ZzNFblFGdkU2YmpBOUlPSWtxZEptUW9mb0JqVnBSRnpQUXRuZFM1?=
 =?utf-8?B?anVVbkp6T3ZVT202SkJrUFZBLzVYaGlFUlRnVFNkcmkrTHdiTnA0TkcwZk5k?=
 =?utf-8?B?L1NENUpxWEVjTVgvektldDBxRGxybTRuRU5NbU9aMEVHVSsrM3VvcVlRREht?=
 =?utf-8?B?UHRwZll5ekJXWjlCUlhaMkV0d0ZsN2pDcjNBR1lackc1VUVIK3BnZEJaNmJZ?=
 =?utf-8?B?TjhJNEFWaDFTbXJ3WXRtWnZCVk9JaXBOUEY0QW5XM3VWTmwvVGlUeWVwUURN?=
 =?utf-8?B?ekZiT3JYMXI4emJXeTVCNkZISXM4RTg2RzJBbVF3dWd3TlpZc0w0UzNRWkw3?=
 =?utf-8?B?cWpHUS9VSkhkRThlZisvNGJXdEdyUGowWnZnZFFhTDdDUTh2NFJTbTVZSHhO?=
 =?utf-8?B?OW5tUitiSUs4ZVRELzRNa0s4V3BLZjR3MEdpRWhxZWl5Z3dDYk1qNjJRM3lE?=
 =?utf-8?B?RnExNDM4d0d6QUJISEt0Ty9SZWdjMmZheGg5aWJqZlQxRFl4Tmx6ZEI1alVG?=
 =?utf-8?B?Z3VCTitqVDIvUE41d1lNOVNlVFhpZmlXK0VKUDkyTSswcDJsMTdGbVdrQVZa?=
 =?utf-8?B?ekdKS0hXRWVsSk1ubDk5MmlwbGU5RU1BcVZRbXQ4Mmc5OERCVy8xZklCUjFL?=
 =?utf-8?B?NWtUWFpxZFVFbENxT2JKQ1RDUEkyVERKNW1OZVNmeDE5QitRc1pOenJyUTha?=
 =?utf-8?B?dUFiM1h5bDdRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3178be-ab90-4387-8ae5-08da05ea5397
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 18:42:01.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy2VVtZMRiVT863miYesV8XZFhFEmFf8zC7kNZZ24myWAJBg83hlKEYH2J65efNRHRfEWKrEyqhAoVviHoFQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2318
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140111
X-Proofpoint-GUID: ZaToNdcl2VXN3jo_mSQFSRA2DxanHNuZ
X-Proofpoint-ORIG-GUID: ZaToNdcl2VXN3jo_mSQFSRA2DxanHNuZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 00:10, Miaohe Lin wrote:
> On 2022/3/14 10:13, Naoya Horiguchi wrote:
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> There is a race condition between memory_failure_hugetlb() and hugetlb
>> free/demotion, which causes setting PageHWPoison flag on the wrong page
>> (which was a hugetlb when memory_failure() was called, but was removed
>> or demoted when memory_failure_hugetlb() is called).  This results in
>> killing wrong processes.  So set PageHWPoison flag with holding page lock,
> 
> It seems hold page lock could not help solve this race condition as hugetlb
> page demotion is not required to hold the page lock. Could you please explain
> this a bit more?

I think it would be 'more safe' to SetPageHWPoison on hugetlb head page when
holding hugetlb_lock.  I know that does not fit with the way memory error
handling works in general.  Just a thought.

-- 
Mike Kravetz

> 
> BTW:Is there some words missing or here should be 'page lock.' instead of 'page lock,' ?
> 
>>
>> The actual user-visible effect might be obscure because even if
>> memory_failure() works as expected, some random process could be killed.
>> Even worse, the actual error is left unhandled, so no one prevents later
>> access to it, which might lead to more serious results like consuming
>> corrupted data.
>>
>> This patch depends on Miaohe's patch titled "mm/memory-failure.c: fix
>> race with changing page compound again".
>>
>> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> ChangeLog v1 -> v2:
>> - pass subpage to get_hwpoison_huge_page() instead of head page.
>> - call compound_head() in hugetlb_lock to avoid race with hugetlb
>>   demotion/free.
>> ---
>>  mm/hugetlb.c        |  8 +++++---
>>  mm/memory-failure.c | 33 +++++++++++++++------------------
>>  2 files changed, 20 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f294db835f4b..345fed90842e 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6761,14 +6761,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>>  
>>  int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>>  {
>> +	struct page *head;
>>  	int ret = 0;
>>  
>>  	*hugetlb = false;
>>  	spin_lock_irq(&hugetlb_lock);
>> -	if (PageHeadHuge(page)) {
>> +	head = compound_head(page);
>> +	if (PageHeadHuge(head)) {
>>  		*hugetlb = true;
>> -		if (HPageFreed(page) || HPageMigratable(page))
>> -			ret = get_page_unless_zero(page);
>> +		if (HPageFreed(head) || HPageMigratable(head))
>> +			ret = get_page_unless_zero(head);
>>  		else
>>  			ret = -EBUSY;
>>  	}
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a9bfd04d2a3c..c40c00c3a261 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1193,7 +1193,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
>>  	int ret = 0;
>>  	bool hugetlb = false;
>>  
>> -	ret = get_hwpoison_huge_page(head, &hugetlb);
>> +	ret = get_hwpoison_huge_page(page, &hugetlb);
>>  	if (hugetlb)
>>  		return ret;
>>  
>> @@ -1280,11 +1280,10 @@ static int get_any_page(struct page *p, unsigned long flags)
>>  
>>  static int __get_unpoison_page(struct page *page)
>>  {
>> -	struct page *head = compound_head(page);
>>  	int ret = 0;
>>  	bool hugetlb = false;
>>  
>> -	ret = get_hwpoison_huge_page(head, &hugetlb);
>> +	ret = get_hwpoison_huge_page(page, &hugetlb);
>>  	if (hugetlb)
>>  		return ret;
>>  
>> @@ -1503,24 +1502,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>  	int res;
>>  	unsigned long page_flags;
>>  
>> -	if (TestSetPageHWPoison(head)) {
>> -		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>> -		       pfn);
>> -		res = -EHWPOISON;
>> -		if (flags & MF_ACTION_REQUIRED)
>> -			res = kill_accessing_process(current, page_to_pfn(head), flags);
>> -		return res;
>> -	}
>> -
>> -	num_poisoned_pages_inc();
>> -
>>  	if (!(flags & MF_COUNT_INCREASED)) {
>>  		res = get_hwpoison_page(p, flags);
>>  		if (!res) {
> 
> In this (res == 0) case, hugetlb page could be dissolved via __page_handle_poison.
> But since PageHWPoison is not set yet, we can't set the PageHWPoison to the correct
> page. Think about the below code in dissolve_free_huge_page:
> 	/*
> 	 * Move PageHWPoison flag from head page to the raw
> 	 * error page, which makes any subpages rather than
> 	 * the error page reusable.
> 	 */
> 	if (PageHWPoison(head) && page != head) {
> 		SetPageHWPoison(page);
> 		ClearPageHWPoison(head);
> 	}
> 
> SetPageHWPoison won't be called for the error page. Or am I miss something?
> 
>>  			lock_page(head);
>>  			if (hwpoison_filter(p)) {
>> -				if (TestClearPageHWPoison(head))
>> -					num_poisoned_pages_dec();
>>  				unlock_page(head);
>>  				return -EOPNOTSUPP;
>>  			}
>> @@ -1553,13 +1539,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>  	page_flags = head->flags;
>>  
>>  	if (hwpoison_filter(p)) {
>> -		if (TestClearPageHWPoison(head))
>> -			num_poisoned_pages_dec();
>>  		put_page(p);
>>  		res = -EOPNOTSUPP;
>>  		goto out;
>>  	}
>>  
>> +	if (TestSetPageHWPoison(head))
>> +		goto already_hwpoisoned;
>> +
>> +	num_poisoned_pages_inc();
>> +
>>  	/*
>>  	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>>  	 * simply disable it. In order to make it work properly, we need
>> @@ -1585,6 +1574,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>  out:
>>  	unlock_page(head);
>>  	return res;
>> +already_hwpoisoned:
>> +	put_page(p);
>> +	unlock_page(head);
> 
> Generally speaking, we should do unlock_page before put_page or page might be disappeared
> before we unlock the page. This should be ok when memory_failure succeeds to handle the
> page previously as it holds one extra page refcnt. But it might be problematic when
> memory_failure failed to handle the page last time. We might be the last user here.
> 
>> +	pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
>> +	res = -EHWPOISON;
>> +	if (flags & MF_ACTION_REQUIRED)
>> +		res = kill_accessing_process(current, page_to_pfn(head), flags);
>> +	return res;
>>  }
>>  
>>  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>
> 
> Many thanks for your path! :)

