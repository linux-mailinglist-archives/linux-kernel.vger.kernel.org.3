Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11355958AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiHPKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiHPKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:40:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E126E1AA4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:56:11 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G6rYEg026269;
        Tue, 16 Aug 2022 09:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FQp52PLFgVbJw2aht4M/bASp8ZYFDR4UuvYTkFhDuyY=;
 b=XrCaKDNGEo1+OY3FO1PREM4pIoZ1XR/1Z3gLVFFp5l2+sbHZc8AcBDoUnowGjqW4VJ5g
 D9Y+Ih9vjzFulAmUhagq25uowNRa6zdOS1rPvqqh1XWdnATEdfDSy9tzaQNK9V4l+iZT
 ttpYd1i5+TjNNoXlDZuyF11ZN4ouf1WTfAjr62ZxYGLQoWEGwYZiI0+Weh+1h3M4Y7O+
 a6f58FG5aO+lH8sTh3Gn6ckm1t8ELc7xz/GwdlihZjTtHoCqaa2Rle4HcuLVVYfm3DJw
 vpo/uZQodPktxI9HuxY1jRHVP3PmqVbNAzRE9V2AiYDfJI+QnUHiAD6AUTHfQ9Lc45NA 0A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j06c0rh55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:55:58 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27G9WU5r029316;
        Tue, 16 Aug 2022 09:34:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3hxnebq3xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:34:09 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27G9Y9sk031703;
        Tue, 16 Aug 2022 09:34:09 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 27G9Y9Fk031701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:34:09 +0000
Received: from [10.216.44.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 02:34:05 -0700
Message-ID: <286e47e7-3d63-133c-aa6c-05100b557d42@quicinc.com>
Date:   Tue, 16 Aug 2022 15:04:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <pasha.tatashin@soleen.com>, <sieberf@amazon.com>,
        <shakeelb@google.com>, <sjpark@amazon.de>, <dhowells@redhat.com>,
        <willy@infradead.org>, <quic_pkondeti@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S-duNGSCNRSsd3EgSFzJ9C-7F0IYt5ZO
X-Proofpoint-GUID: S-duNGSCNRSsd3EgSFzJ9C-7F0IYt5ZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal!!

On 8/15/2022 8:36 PM, Michal Hocko wrote:
> On Tue 09-08-22 20:16:43, Charan Teja Kalla wrote:
> [...]
>> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
>> index fabb2e1..0e259da 100644
>> --- a/include/linux/page_ext.h
>> +++ b/include/linux/page_ext.h
> [...]
>> @@ -87,5 +83,14 @@ static inline void page_ext_init_flatmem_late(void)
>>  static inline void page_ext_init_flatmem(void)
>>  {
>>  }
>> +
>> +static inline struct page *page_ext_get(struct page *page)
> struct page_ext *
> 
oops!! It didn't get caught as this is in !CONFIG_PAGE_EXTENSION.
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline void page_ext_put(void)
>> +{
>> +}
>>  #endif /* CONFIG_PAGE_EXTENSION */
>>  #endif /* __LINUX_PAGE_EXT_H */
> [...]
>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index 3dc715d..91d7bd2 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/page_owner.h>
>>  #include <linux/page_idle.h>
>>  #include <linux/page_table_check.h>
>> +#include <linux/rcupdate.h>
>>  
>>  /*
>>   * struct page extension
>> @@ -59,6 +60,10 @@
>>   * can utilize this callback to initialize the state of it correctly.
>>   */
>>  
>> +#ifdef CONFIG_SPARSEMEM
>> +#define PAGE_EXT_INVALID       (0x1)
>> +#endif
>> +
>>  #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
>>  static bool need_page_idle(void)
>>  {
>> @@ -84,6 +89,7 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
>>  unsigned long page_ext_size = sizeof(struct page_ext);
>>  
>>  static unsigned long total_usage;
>> +static struct page_ext *lookup_page_ext(const struct page *page);
>>  
>>  static bool __init invoke_need_callbacks(void)
>>  {
>> @@ -125,6 +131,37 @@ static inline struct page_ext *get_entry(void *base, unsigned long index)
>>  	return base + page_ext_size * index;
>>  }
>>  
>> +/*
>> + * This function gives proper page_ext of a memory section
>> + * during race with the offline operation on a memory block
>> + * this section falls into. Not using this function to get
>> + * page_ext of a page, in code paths where extra refcount
>> + * is not taken on that page eg: pfn walking, can lead to
>> + * use-after-free access of page_ext.
> I do not think this is really useful comment, it goes into way too much
> detail about memory hotplug yet not enough to actually understand the
> interaction because there are no references to the actual
> synchronization scheme. I would go with something like:
> 
> /*
>  * Get a page_ext associated with the given page. Returns NULL if
>  * no such page_ext exists otherwise ensures that the page_ext will
>  * stay alive until page_ext_put is called.
>  * This implies a non-sleeping context.
>  */

Will update as per the Matthew input @
https://lore.kernel.org/all/YvplthTjM8Ez5DIq@casper.infradead.org/
>> + */
>> +struct page_ext *page_ext_get(struct page *page)
>> +{
>> +	struct page_ext *page_ext;
>> +
>> +	rcu_read_lock();
>> +	page_ext = lookup_page_ext(page);
>> +	if (!page_ext) {
>> +		rcu_read_unlock();
>> +		return NULL;
>> +	}
>> +
>> +	return page_ext;
>> +}
>> +
>> +/*
>> + * Must be called after work is done with the page_ext received
>> + * with page_ext_get().
>> + */
>> +
>> +void page_ext_put(void)
>> +{
>> +	rcu_read_unlock();
>> +}
> Thinking about this some more I am not sure this is a good interface. It
> doesn't have any reference to the actual object this is called for. This
> is nicely visible in __folio_copy_owner which just calles page_ext_put()
> twice because there are 2 page_exts and I can already see how somebody
> might get confused this is just an error and send a patch to drop one of
> them.
> 
> I do understand why you went this way because having a parameter which
> is not used will likely lead to the same situation. On the other hand it
> could be annotated to not raise warnings. One potential way to
> workaround that would be
> 
> void page_ext_put(struct page_ext *page_ext)
> {
> 	if (unlikely(!page_ext))
> 		return;
> 	
> 	rcu_read_unlock();
> }
> 
> which would help to make the api slightly more robust in case somebody
> does page_ext_put in a branch where page_ext_get returns NULL.
> 
Looks better. Will change this accordingly.

> No strong opinion on that though. WDYI?
> 
>>  #ifndef CONFIG_SPARSEMEM
>>  
>>  
> [...]
>> @@ -183,19 +184,26 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>>  noinline void __set_page_owner(struct page *page, unsigned short order,
>>  					gfp_t gfp_mask)
>>  {
>> -	struct page_ext *page_ext = lookup_page_ext(page);
>> +	struct page_ext *page_ext = page_ext_get(page);
>>  	depot_stack_handle_t handle;
>>  
>>  	if (unlikely(!page_ext))
>>  		return;
> Either add a comment like this
> 	/* save_stack can sleep in general so we have to page_ext_put */


Vlastimil suggested to go for save stack first since !page_ext is mostly
unlikely.  Snip from his comments:
Why not simply do the save_stack() first and then page_ext_get() just
once? It should be really rare that it's NULL, so I don't think we save
much by avoiding an unnecessary save_stack(), while the overhead of
doing two get/put instead of one will affect every call.

https://lore.kernel.org/all/f5fd4942-b03e-1d1c-213b-9cd5283ced91@suse.cz/
>> +	page_ext_put();
>>  
>>  	handle = save_stack(gfp_mask);
> or just drop the initial page_ext_get altogether. This function is
> called only when page_ext is supposed to be initialized and !page_ext
> case above should be very unlikely. Or is there any reason to keep this?
> 


>> +
>> +	/* Ensure page_ext is valid after page_ext_put() above */
>> +	page_ext = page_ext_get(page);
>> +	if (unlikely(!page_ext))
>> +		return;
>>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>> +	page_ext_put();
>>  }
>>  
> [...]
>> @@ -558,13 +590,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>  		 */
>>  		handle = READ_ONCE(page_owner->handle);
>>  		if (!handle)
>> -			continue;
>> +			goto loop;
>>  
>>  		/* Record the next PFN to read in the file offset */
>>  		*ppos = (pfn - min_low_pfn) + 1;
>>  
>> +		memcpy(&page_owner_tmp, page_owner, sizeof(struct page_owner));
>> +		page_ext_put();
> why not
> 		page_owner_tmp = *page_owner;

Done!!
> 
>>  		return print_page_owner(buf, count, pfn, page,
>> -				page_owner, handle);
>> +				&page_owner_tmp, handle);
>> +loop:
>> +		page_ext_put();
>>  	}
>>  
>>  	return 0;
