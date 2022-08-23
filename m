Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1659EB43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiHWSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiHWSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:42:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18989CD8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:06:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NGjIc4001176;
        Tue, 23 Aug 2022 17:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HV8WM+dW2+H51o3dKFpF7a72MrER+U6gm98D/qYGaq4=;
 b=jlsdZXe7BXVQwwimGAo+4mLAi7DcPAc8yzhT2L/Qd4m3WwsLaKvg8uJhrbQt/ITQOhkr
 FhfQQhxYUFfmEUie3BRD+ATx9XnBruAvtUSJ2URHGsATp/CMHnSfUJnN6j2OyamO4zdi
 lDfJjk3spSGjmvSibVmjhfWUsjC+qgU9hkvYjeHtpeGKVhKGp0sP7GNFVKmNRc1kTstu
 5AlH7GWaIYBkvnUyhG1OJPKROEa8grqNaj6iA2Yuiu+eTLf0z/e8+xxYpgL/qDu+Bp9A
 WGmuhBuL82KvLQDgkH2Bbzcy3uw++mwPqp6EmTv05eyFUi7BAudIEe5Gyqj9JbPS+esH 9Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pkr2uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 17:05:42 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27NH33oH021285;
        Tue, 23 Aug 2022 17:05:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3j2rpkuhjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 17:05:41 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27NH5f7f023964;
        Tue, 23 Aug 2022 17:05:41 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 27NH5fR3023961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 17:05:41 +0000
Received: from [10.216.3.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 10:05:36 -0700
Message-ID: <113fd59f-e4c0-4ee1-4196-6c926677947c@quicinc.com>
Date:   Tue, 23 Aug 2022 22:35:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <pasha.tatashin@soleen.com>,
        <shakeelb@google.com>, <sieberf@amazon.com>, <sjpark@amazon.de>,
        <william.kucharski@oracle.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <minchan@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1660830600-9068-1-git-send-email-quic_charante@quicinc.com>
 <01fd2b11-513d-eb91-5ce6-fcaa198f8d28@redhat.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <01fd2b11-513d-eb91-5ce6-fcaa198f8d28@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1VDEDJLSafmEw3XUW1tNNcSghKR3NYNs
X-Proofpoint-GUID: 1VDEDJLSafmEw3XUW1tNNcSghKR3NYNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=749 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David for the inputs.

On 8/23/2022 6:39 PM, David Hildenbrand wrote:
>>  static ssize_t
>> @@ -508,6 +527,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>  	/* Find an allocated page */
>>  	for (; pfn < max_pfn; pfn++) {
>>  		/*
>> +		 * This temporary page_owner is required so
>> +		 * that we can avoid the context switches while holding
>> +		 * the rcu lock and copying the page owner information to
>> +		 * user through copy_to_user() or GFP_KERNEL allocations.
>> +		 */
>> +		struct page_owner page_owner_tmp;
>> +
>> +		/*
>>  		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
>>  		 * validate the area as existing, skip it if not
>>  		 */
>> @@ -525,7 +552,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>  			continue;
>>  		}
>>  
>> -		page_ext = lookup_page_ext(page);
>> +		page_ext = page_ext_get(page);
>>  		if (unlikely(!page_ext))
>>  			continue;
>>  
>> @@ -534,14 +561,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>  		 * because we don't hold the zone lock.
>>  		 */
>>  		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
>> -			continue;
>> +			goto loop;
>>  
>>  		/*
>>  		 * Although we do have the info about past allocation of free
>>  		 * pages, it's not relevant for current memory usage.
>>  		 */
>>  		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
>> -			continue;
>> +			goto loop;
>>  
>>  		page_owner = get_page_owner(page_ext);
>>  
>> @@ -550,7 +577,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>  		 * would inflate the stats.
>>  		 */
>>  		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
>> -			continue;
>> +			goto loop;
>>  
>>  		/*
>>  		 * Access to page_ext->handle isn't synchronous so we should
>> @@ -558,13 +585,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>  		 */
>>  		handle = READ_ONCE(page_owner->handle);
>>  		if (!handle)
>> -			continue;
>> +			goto loop;
>>  
>>  		/* Record the next PFN to read in the file offset */
>>  		*ppos = (pfn - min_low_pfn) + 1;
>>  
>> +		page_owner_tmp = *page_owner;
>> +		page_ext_put(page_ext);
>>  		return print_page_owner(buf, count, pfn, page,
>> -				page_owner, handle);
>> +				&page_owner_tmp, handle);
>> +loop:
>> +		page_ext_put(page_ext);
>>  	}
>>  
>>  	return 0;
>> @@ -617,18 +648,20 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>>  			if (PageReserved(page))
>>  				continue;
>>  
>> -			page_ext = lookup_page_ext(page);
>> +			page_ext = page_ext_get(page);
>>  			if (unlikely(!page_ext))
>>  				continue;
>>  
>>  			/* Maybe overlapping zone */
>>  			if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
>> -				continue;
>> +				goto loop;
>>  
>>  			/* Found early allocated page */
>>  			__set_page_owner_handle(page_ext, early_handle,
>>  						0, 0);
>>  			count++;
>> +loop:
>> +			page_ext_put(page_ext);
>>  		}
> I kind-of dislike the "loop" labels. Can we come up with a more
> expressive name?
> 
> "put_continue"
> 
> or something?
> 
> 
> One alternative would be to add to the beginning of the loop, and after
> the loop sth like
> 
> if (page_ext) {
> 	page_ext_put(page_ext);
> 	page_ext = NULL;
> }

I think, moving this to beginning of the loop looks cleaner than the
goto statement.  Will spin V5.


> 
> One could wrap that in a function, but not sure if that improves the
> situation.
