Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4F58E4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiHJBqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiHJBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:46:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F071BD3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:46:23 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A0vcc9026067;
        Wed, 10 Aug 2022 01:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rhJbcnxRPhu/oLXi3Wl/Io9q7+s74KwTA381kpUw5PM=;
 b=czg8enB74bqcBa1fyAH3jogIcJJlrplJXovk0oNhBLcYc5KPqFhHi3Q2c4mrIfme5v4Z
 p010BSy8wqaILQfXVI+9t4F5iP37z3+jOTJ1/P7UXnK7uTe+z9Rk13EJgtBH4sjJcKqV
 mRVmjfUHswTn/Py77YaPRMQRR81CixGpoomKGEftEIVYai/jDzXXOX86kLv1aPLlpnkO
 fg9S7xA/H13VmKchx2C5moz4E3RzFDJU/SzrtiA858FIXfwKUtOrKLoLv810QItcvWVz
 mo5JRJZp7xm8FyTM8+MuF/a31sd55DYlvLClcX4PdixC+p4Kimmf0aJDtXqVaUDldCeT WQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqgrt7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 01:46:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A1XVvp026584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 01:33:31 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 18:33:31 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 18:33:28 -0700
Message-ID: <8f64c6d5-940f-f081-7671-53e1507c8051@quicinc.com>
Date:   Wed, 10 Aug 2022 09:33:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v5] mm/page_owner.c: add llseek for page_owner
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        <akpm@linux-foundation.org>
CC:     <minchan@kernel.org>, <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220809024725.31980-1-quic_yingangl@quicinc.com>
 <ab4f79ea-0a02-9556-645f-cca32dea3cad@kernel.org>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <ab4f79ea-0a02-9556-645f-cca32dea3cad@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CxuCoQTBnctYzo-Lk92idM4oscov--7X
X-Proofpoint-ORIG-GUID: CxuCoQTBnctYzo-Lk92idM4oscov--7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100004
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2022 5:30 PM, Vlastimil Babka (SUSE) wrote:
> On 8/9/22 04:47, Kassey Li wrote:
>> There is usage to dump a given cma region page_owner
>> instead of all page's.
>>
>> This change allows to specify a ppos as start_pfn
>> by fseek.
>>
>> Any invalid ppos will be skipped, so it did not
>> broken the origin dump feature.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   Documentation/vm/page_owner.rst | 6 ++++++
>>   mm/internal.h                   | 5 +++++
>>   mm/page_owner.c                 | 9 ++++++---
>>   3 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
>> index f5c954afe97c..8d33d976da8a 100644
>> --- a/Documentation/vm/page_owner.rst
>> +++ b/Documentation/vm/page_owner.rst
>> @@ -95,6 +95,12 @@ Usage
>>   	PFN XXX ...
>>   	// Detailed stack
>>   
>> +   By default, it will do full pfn dump, to start with a given pfn,
>> +   page_owner supports fseek.
>> +
>> +   FILE *fp = fopen("/sys/kernel/debug/page_owner", "r");
>> +   fseek(fp, pfn_start, SEEK_SET);
>> +
>>      The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
>>      in buf, uses regexp to extract the page order value, counts the times
>>      and pages of buf, and finally sorts them according to the parameter(s).
>> diff --git a/mm/internal.h b/mm/internal.h
>> index c0f8fbe0445b..1ad8f86e6e33 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -189,6 +189,11 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
>>    */
>>   extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>>   
>> +/*
>> + * in mm/page_owner.c:
> 
> This should say where it's defined, not used from, and that's
> fs/proc/base.c. But it's already declared in fs/proc/internal.h so maybe
> page_owner.c could just include that header (although it's a bit meh).
ok, let's do it.
> 
>> + */
>> +extern loff_t mem_lseek(struct file *, loff_t, int);
>> +
>>   /*
>>    * in mm/page_alloc.c
>>    */
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index e4c6f3f1695b..dcbe05e206e1 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -497,8 +497,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   		return -EINVAL;
>>   
>>   	page = NULL;
>> -	pfn = min_low_pfn + *ppos;
>> -
>> +	if (*ppos == 0)
>> +		pfn= min_low_pfn;
> 
> missing space before '='

   my bad, for v6

./scripts/checkpatch.pl 
v6-0001-mm-page_owner.c-add-llseek-for-page_owner.patch
total: 0 errors, 0 warnings, 46 lines checked

v6-0001-mm-page_owner.c-add-llseek-for-page_owner.patch has no obvious 
style problems and is ready for submission.
> 
>> +	else
>> +		pfn = *ppos;
>>   	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>>   	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>>   		pfn++;
>> @@ -561,7 +563,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   			continue;
>>   
>>   		/* Record the next PFN to read in the file offset */
>> -		*ppos = (pfn - min_low_pfn) + 1;
>> +		*ppos = pfn + 1;
>>   
>>   		return print_page_owner(buf, count, pfn, page,
>>   				page_owner, handle);
>> @@ -660,6 +662,7 @@ static void init_early_allocated_pages(void)
>>   
>>   static const struct file_operations proc_page_owner_operations = {
>>   	.read		= read_page_owner,
>> +	.llseek 	= mem_lseek,
>>   };
>>   
>>   static int __init pageowner_init(void)
> 
