Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1858EE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiHJOdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiHJOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:32:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978222A72C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:32:36 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AEN3KX018167;
        Wed, 10 Aug 2022 14:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CM3nGdOxR6jBokQaLb4dVJJcgFMF8rivQEQwDoBmaK4=;
 b=ICSz4RnAxgj5cH+TmHSPSYaCaj5L9wWOLEa8Mji/RJpqYD97FvywFrCDAPXNpeS3x47W
 CwsiJEW9xlOogCx7ao+k1Trnwp/qsgpO0ndzaQIlk6ffx3Mi35MLHNgRMl0EKifMoj0i
 /UNcItOFFDqjqZG4jNCtUK2FNG/Qq0Q4JWjJjYjVnSAebTCxHthLCuTgYslD1QqHm8MD
 X2ydVJNCKF8GI4jluTAcxoHyqjhPZCKWlPKNhro5u7i1/x+V0fuRCk5ce1X7QuAcmZdU
 UB6u0uuhaCpSnrbTLWADDyaCNwQedGUZtlHFaRDjpQ5bK3/ZOYMDb3tHOkhQuW+08ekD JQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvdg1r71u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 14:32:06 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27AEW675017024;
        Wed, 10 Aug 2022 14:32:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3hshckfx9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 14:32:06 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27AESUl1010083;
        Wed, 10 Aug 2022 14:32:06 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 27AEW6WQ017010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 14:32:06 +0000
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 07:32:05 -0700
Received: from [10.216.32.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 07:32:01 -0700
Message-ID: <68557e80-90f1-7c39-1c88-22b392dab439@quicinc.com>
Date:   Wed, 10 Aug 2022 20:01:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <david@redhat.com>, <pasha.tatashin@soleen.com>,
        <sieberf@amazon.com>, <shakeelb@google.com>, <sjpark@amazon.de>,
        <dhowells@redhat.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <f5fd4942-b03e-1d1c-213b-9cd5283ced91@suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <f5fd4942-b03e-1d1c-213b-9cd5283ced91@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EtsSqvgRg-LnazVyoYtFruEM_olS0UV7
X-Proofpoint-ORIG-GUID: EtsSqvgRg-LnazVyoYtFruEM_olS0UV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=766 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vlastimil for the inputs!!

On 8/10/2022 5:10 PM, Vlastimil Babka wrote:
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -141,7 +141,7 @@ void __reset_page_owner(struct page *page,
>> unsigned short order)
>>       struct page_owner *page_owner;
>>       u64 free_ts_nsec = local_clock();
>>   -    page_ext = lookup_page_ext(page);
>> +    page_ext = page_ext_get(page);
>>       if (unlikely(!page_ext))
>>           return;
>>   @@ -153,6 +153,7 @@ void __reset_page_owner(struct page *page,
>> unsigned short order)
>>           page_owner->free_ts_nsec = free_ts_nsec;
>>           page_ext = page_ext_next(page_ext);
>>       }
>> +    page_ext_put();
>>   }
>>     static inline void __set_page_owner_handle(struct page_ext *page_ext,
>> @@ -183,19 +184,26 @@ static inline void
>> __set_page_owner_handle(struct page_ext *page_ext,
>>   noinline void __set_page_owner(struct page *page, unsigned short order,
>>                       gfp_t gfp_mask)
>>   {
>> -    struct page_ext *page_ext = lookup_page_ext(page);
>> +    struct page_ext *page_ext = page_ext_get(page);
>>       depot_stack_handle_t handle;
>>         if (unlikely(!page_ext))
>>           return;
>> +    page_ext_put();
>>         handle = save_stack(gfp_mask);
>> +
>> +    /* Ensure page_ext is valid after page_ext_put() above */
>> +    page_ext = page_ext_get(page);
> 
> Why not simply do the save_stack() first and then page_ext_get() just
> once? It should be really rare that it's NULL, so I don't think we save
> much by avoiding an unnecessary save_stack(), while the overhead of
> doing two get/put instead of one will affect every call.
> 
I am under the assumption that save_stack can take time when it goes for
GFP_KERNEL allocations over page_ext which is mere rcu_lock + few
arithmetic operations. Am I wrong here?

But yes it is rare that page_ext can be NULL here, so I am fine to
follow your suggestion, which atleast improve the code readability, IMO.

>> +    if (unlikely(!page_ext))
>> +        return;
>>       __set_page_owner_handle(page_ext, handle, order, gfp_mask);
>> +    page_ext_put();
>>   }
>>     void __set_page_owner_migrate_reason(struct page *page, int reason)
>>   {
>> -    struct page_ext *page_ext = lookup_page_ext(page);
>> +    struct page_ext *page_ext = page_ext_get(page);
>>       struct page_owner *page_owner;
>>         if (unlikely(!page_ext))
>> @@ -203,12 +211,13 @@ void __set_page_owner_migrate_reason(struct page
>> *page, int reason)
>>         page_owner = get_page_owner(page_ext);
>>       page_owner->last_migrate_reason = reason;
>> +    page_ext_put();
>>   }
>>     void __split_page_owner(struct page *page, unsigned int nr)
>>   {
>>       int i;
>> -    struct page_ext *page_ext = lookup_page_ext(page);
>> +    struct page_ext *page_ext = page_ext_get(page);
>>       struct page_owner *page_owner;
>>         if (unlikely(!page_ext))
>> @@ -219,16 +228,24 @@ void __split_page_owner(struct page *page,
>> unsigned int nr)
>>           page_owner->order = 0;
>>           page_ext = page_ext_next(page_ext);
>>       }
>> +    page_ext_put();
>>   }
>>     void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>>   {
>> -    struct page_ext *old_ext = lookup_page_ext(&old->page);
>> -    struct page_ext *new_ext = lookup_page_ext(&newfolio->page);
>> +    struct page_ext *old_ext;
>> +    struct page_ext *new_ext;
>>       struct page_owner *old_page_owner, *new_page_owner;
>>   -    if (unlikely(!old_ext || !new_ext))
>> +    old_ext = page_ext_get(&old->page);
>> +    if (unlikely(!old_ext))
>> +        return;
>> +
>> +    new_ext = page_ext_get(&newfolio->page);
> 
> The second one can keep using just lookup_page_ext() and we can have a
> single page_ext_put()? I don't think it would be dangerous in case the
> internals change, as page_ext_put() doesn't have a page parameter anyway
> so it can't be specific to a page.

Actually we did hide the lookup_page_ext() while exposing only a single
interface i.e. page_ext_get/put().  And this suggestion requires to
expose the lookup_page_ext as well which leaves two interfaces to get
the page_ext which seems not look good, IMO. Please let me know If you
think otherwise here.

> 
>> +    if (unlikely(!new_ext)) {
>> +        page_ext_put();
>>           return;
>> +    }
>>         old_page_owner = get_page_owner(old_ext);
>>       new_page_owner = get_page_owner(new_ext);
>> @@ -254,6 +271,8 @@ void __folio_copy_owner(struct folio *newfolio,
>> struct folio *old)
>>        */
>>       __set_bit(PAGE_EXT_OWNER, &new_ext->flags);
>>       __set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
>> +    page_ext_put();
>> +    page_ext_put();
>>   }
>>     void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>> @@ -307,12 +326,12 @@ void pagetypeinfo_showmixedcount_print(struct
>> seq_file *m,
>>               if (PageReserved(page))
>>                   continue;
>>   -            page_ext = lookup_page_ext(page);
>> +            page_ext = page_ext_get(page);
>>               if (unlikely(!page_ext))
>>                   continue;
>>                 if (!test_bit(PAGE_EXT_OWNER_ALLOCATED,
>> &page_ext->flags))
>> -                continue;
>> +                goto loop;
>>                 page_owner = get_page_owner(page_ext);
>>               page_mt = gfp_migratetype(page_owner->gfp_mask);
>> @@ -323,9 +342,12 @@ void pagetypeinfo_showmixedcount_print(struct
>> seq_file *m,
>>                       count[pageblock_mt]++;
>>                     pfn = block_end_pfn;
>> +                page_ext_put();
>>                   break;
>>               }
>>               pfn += (1UL << page_owner->order) - 1;
>> +loop:
>> +            page_ext_put();
>>           }
>>       }
>>   @@ -435,7 +457,7 @@ print_page_owner(char __user *buf, size_t count,
>> unsigned long pfn,
>>     void __dump_page_owner(const struct page *page)
>>   {
>> -    struct page_ext *page_ext = lookup_page_ext(page);
>> +    struct page_ext *page_ext = page_ext_get((void *)page);
>>       struct page_owner *page_owner;
>>       depot_stack_handle_t handle;
>>       gfp_t gfp_mask;
>> @@ -452,6 +474,7 @@ void __dump_page_owner(const struct page *page)
>>         if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
>>           pr_alert("page_owner info is not present (never set?)\n");
>> +        page_ext_put();
>>           return;
>>       }
>>   @@ -482,6 +505,7 @@ void __dump_page_owner(const struct page *page)
>>       if (page_owner->last_migrate_reason != -1)
>>           pr_alert("page has been migrated, last migrate reason: %s\n",
>>               migrate_reason_names[page_owner->last_migrate_reason]);
>> +    page_ext_put();
>>   }
>>     static ssize_t
>> @@ -508,6 +532,14 @@ read_page_owner(struct file *file, char __user
>> *buf, size_t count, loff_t *ppos)
>>       /* Find an allocated page */
>>       for (; pfn < max_pfn; pfn++) {
>>           /*
>> +         * This temporary page_owner is required so
>> +         * that we can avoid the context switches while holding
>> +         * the rcu lock and copying the page owner information to
>> +         * user through copy_to_user() or GFP_KERNEL allocations.
>> +         */
>> +        struct page_owner page_owner_tmp;
>> +
>> +        /*
>>            * If the new page is in a new MAX_ORDER_NR_PAGES area,
>>            * validate the area as existing, skip it if not
>>            */
>> @@ -525,7 +557,7 @@ read_page_owner(struct file *file, char __user
>> *buf, size_t count, loff_t *ppos)
>>               continue;
>>           }
>>   -        page_ext = lookup_page_ext(page);
>> +        page_ext = page_ext_get(page);
>>           if (unlikely(!page_ext))
>>               continue;
>>   @@ -534,14 +566,14 @@ read_page_owner(struct file *file, char __user
>> *buf, size_t count, loff_t *ppos)
>>            * because we don't hold the zone lock.
>>            */
>>           if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
>> -            continue;
>> +            goto loop;
>>             /*
>>            * Although we do have the info about past allocation of free
>>            * pages, it's not relevant for current memory usage.
>>            */
>>           if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
>> -            continue;
>> +            goto loop;
>>             page_owner = get_page_owner(page_ext);
>>   @@ -550,7 +582,7 @@ read_page_owner(struct file *file, char __user
>> *buf, size_t count, loff_t *ppos)
>>            * would inflate the stats.
>>            */
>>           if (!IS_ALIGNED(pfn, 1 << page_owner->order))
>> -            continue;
>> +            goto loop;
>>             /*
>>            * Access to page_ext->handle isn't synchronous so we should
>> @@ -558,13 +590,17 @@ read_page_owner(struct file *file, char __user
>> *buf, size_t count, loff_t *ppos)
>>            */
>>           handle = READ_ONCE(page_owner->handle);
>>           if (!handle)
>> -            continue;
>> +            goto loop;
>>             /* Record the next PFN to read in the file offset */
>>           *ppos = (pfn - min_low_pfn) + 1;
>>   +        memcpy(&page_owner_tmp, page_owner, sizeof(struct
>> page_owner));
>> +        page_ext_put();
>>           return print_page_owner(buf, count, pfn, page,
>> -                page_owner, handle);
>> +                &page_owner_tmp, handle);
>> +loop:
>> +        page_ext_put();
>>       }
>>         return 0;
>> @@ -617,18 +653,20 @@ static void init_pages_in_zone(pg_data_t *pgdat,
>> struct zone *zone)
>>               if (PageReserved(page))
>>                   continue;
>>   -            page_ext = lookup_page_ext(page);
>> +            page_ext = page_ext_get(page);
>>               if (unlikely(!page_ext))
>>                   continue;
>>                 /* Maybe overlapping zone */
>>               if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
>> -                continue;
>> +                goto loop;
>>                 /* Found early allocated page */
>>               __set_page_owner_handle(page_ext, early_handle,
>>                           0, 0);
>>               count++;
>> +loop:
>> +            page_ext_put();
>>           }
>>           cond_resched();
> 
> This is called from init_page_owner() where races with offline are
> impossible, so it's unnecessary. Although it won't hurt.

Totally agree. Infact in V2, this change is not there. And there are
some other places too that it is not required to go for
page_ext_get/put, eg: page_owner_migration, but these changes are done
as we have exposed a single interface to get the page_ext.

> 

Thanks,
Chararan
