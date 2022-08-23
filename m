Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90D59E7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbiHWQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245201AbiHWQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358F7DF43
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8kdBKGl71weZmKn4bSKogcjlxbB109HsgGUffsIt0g=;
        b=AOqcjs+t4UzvsWsGeH7n+KvaqmCiPXZLs3fiqx3tSmE3v7OUElsxX6q9S/dHD2lnm58RE6
        NO516N/cUl7nBcdr47yB+kfVwDyMN1MFCrFUIC6xxmEC0lvt8dP5+6/T9QRsOlATlFAX4l
        q3bT1BQ5yTESbuGsy7LEeSbo7fDIAPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-aRTE9L8FNGy2BCPWyo7E4g-1; Tue, 23 Aug 2022 09:09:26 -0400
X-MC-Unique: aRTE9L8FNGy2BCPWyo7E4g-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adfba4c000000b0021e7440666bso2231275wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=w8kdBKGl71weZmKn4bSKogcjlxbB109HsgGUffsIt0g=;
        b=DWkdb6idvuyAL5AShkg6i/MX9Q3zCEtuKgKVcPYYlSII709oQQ4FEHJh0HzPh4cLQQ
         C1S2lO2In8fQjvK19Jk9juVqcIQKVBJF7w68O9fr1+dVSY5d3ifNOTBLebZw8Bsz5ymv
         Gg5l1cewBfScf9uDVxDHBbdmdrOPp/FpkMp0u+8oa1p+cyZWguWCrtRrgQdbyQBObfA0
         r5RL+APrEvk2xL7JM6IJ4N4DxPqC/99WVQCu3qIWFRWtiB/DFFcsZPXvk6Bw64Ag1cNp
         +zlLSqDoWgUB9NJOBOiPz62BZwiitFujgqSo2sJxfMYOOaGOPDmAtCfOSvxKUHe7QzuG
         vyZQ==
X-Gm-Message-State: ACgBeo0bvaNnjPTvAGrSXOxjzgf/ID1PEdNxVwBDpGessdBr9TqjFTXT
        wAFxOeugfa0lUQEiLOlhs2eDFM3shSEiazIS+Vud94vDCKQvFt9hePV0ew4jlHk4E7mHrKKwrl6
        os0DNGkWBtn5pGgjpfIq1TY0h
X-Received: by 2002:a05:600c:410d:b0:3a6:1db8:b419 with SMTP id j13-20020a05600c410d00b003a61db8b419mr2143747wmi.119.1661260165311;
        Tue, 23 Aug 2022 06:09:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5mU7Ez4PSLMJo2g7PEaUmbNkIKfYQ+V6Bi9Vnw+oGoFj3xX1dzdH4M0PuWRhEY0Mq4I2cEiA==
X-Received: by 2002:a05:600c:410d:b0:3a6:1db8:b419 with SMTP id j13-20020a05600c410d00b003a61db8b419mr2143724wmi.119.1661260164944;
        Tue, 23 Aug 2022 06:09:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002253d865715sm11072769wru.87.2022.08.23.06.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 06:09:24 -0700 (PDT)
Message-ID: <01fd2b11-513d-eb91-5ce6-fcaa198f8d28@redhat.com>
Date:   Tue, 23 Aug 2022 15:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        pasha.tatashin@soleen.com, shakeelb@google.com, sieberf@amazon.com,
        sjpark@amazon.de, william.kucharski@oracle.com,
        willy@infradead.org, quic_pkondeti@quicinc.com, minchan@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1660830600-9068-1-git-send-email-quic_charante@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V4] mm: fix use-after free of page_ext after race with
 memory-offline
In-Reply-To: <1660830600-9068-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.22 15:50, Charan Teja Kalla wrote:
> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.
> 
> process1		              process2
> ---------                             ---------
> a)doing /proc/page_owner           doing memory offline
> 			           through offline_pages.
> 
> b)PageBuddy check is failed
> thus proceed to get the
> page_owner information
> through page_ext access.
> page_ext = lookup_page_ext(page);
> 
> 				    migrate_pages();
> 				    .................
> 				Since all pages are successfully
> 				migrated as part of the offline
> 				operation,send MEM_OFFLINE notification
> 				where for page_ext it calls:
> 				offline_page_ext()-->
> 				__free_page_ext()-->
> 				   free_page_ext()-->
> 				     vfree(ms->page_ext)
> 			           mem_section->page_ext = NULL
> 
> c) Check for the PAGE_EXT flags
> in the page_ext->flags access
> results into the use-after-free(leading
> to the translation faults).
> 
> As mentioned above, there is really no synchronization between page_ext
> access and its freeing in the memory_offline.
> 
> The memory offline steps(roughly) on a memory block is as below:
> 1) Isolate all the pages
> 2) while(1)
>   try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
> 3) delete the pages from this buddy list.
> 4) Then free page_ext.(Note: The struct page is still alive as it is
> freed only during hot remove of the memory which frees the memmap, which
> steps the user might not perform).
> 
> This design leads to the state where struct page is alive but the struct
> page_ext is freed, where the later is ideally part of the former which
> just representing the page_flags (check [3] for why this design is
> chosen).
> 
> The above mentioned race is just one example __but the problem persists
> in the other paths too involving page_ext->flags access(eg:
> page_is_idle())__.
> 
> Fix all the paths where offline races with page_ext access by
> maintaining synchronization with rcu lock and is achieved in 3 steps:
> 1) Invalidate all the page_ext's of the sections of a memory block by
> storing a flag in the LSB of mem_section->page_ext.
> 
> 2) Wait till all the existing readers to finish working with the
> ->page_ext's with synchronize_rcu(). Any parallel process that starts
> after this call will not get page_ext, through lookup_page_ext(), for
> the block parallel offline operation is being performed.
> 
> 3) Now safely free all sections ->page_ext's of the block on which
> offline operation is being performed.
> 
> Note: If synchronize_rcu() takes time then optimizations can be done in
> this path through call_rcu()[2].
> 
> Thanks to David Hildenbrand for his views/suggestions on the initial
> discussion[1] and Pavan kondeti for various inputs on this patch.
> 
> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> [2] https://lore.kernel.org/all/a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com/T/#u
> [3] https://lore.kernel.org/all/6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>


In general, LGTM, one comment below.

>  
>  static ssize_t
> @@ -508,6 +527,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  	/* Find an allocated page */
>  	for (; pfn < max_pfn; pfn++) {
>  		/*
> +		 * This temporary page_owner is required so
> +		 * that we can avoid the context switches while holding
> +		 * the rcu lock and copying the page owner information to
> +		 * user through copy_to_user() or GFP_KERNEL allocations.
> +		 */
> +		struct page_owner page_owner_tmp;
> +
> +		/*
>  		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
>  		 * validate the area as existing, skip it if not
>  		 */
> @@ -525,7 +552,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  			continue;
>  		}
>  
> -		page_ext = lookup_page_ext(page);
> +		page_ext = page_ext_get(page);
>  		if (unlikely(!page_ext))
>  			continue;
>  
> @@ -534,14 +561,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		 * because we don't hold the zone lock.
>  		 */
>  		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
> -			continue;
> +			goto loop;
>  
>  		/*
>  		 * Although we do have the info about past allocation of free
>  		 * pages, it's not relevant for current memory usage.
>  		 */
>  		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
> -			continue;
> +			goto loop;
>  
>  		page_owner = get_page_owner(page_ext);
>  
> @@ -550,7 +577,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		 * would inflate the stats.
>  		 */
>  		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
> -			continue;
> +			goto loop;
>  
>  		/*
>  		 * Access to page_ext->handle isn't synchronous so we should
> @@ -558,13 +585,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		 */
>  		handle = READ_ONCE(page_owner->handle);
>  		if (!handle)
> -			continue;
> +			goto loop;
>  
>  		/* Record the next PFN to read in the file offset */
>  		*ppos = (pfn - min_low_pfn) + 1;
>  
> +		page_owner_tmp = *page_owner;
> +		page_ext_put(page_ext);
>  		return print_page_owner(buf, count, pfn, page,
> -				page_owner, handle);
> +				&page_owner_tmp, handle);
> +loop:
> +		page_ext_put(page_ext);
>  	}
>  
>  	return 0;
> @@ -617,18 +648,20 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  			if (PageReserved(page))
>  				continue;
>  
> -			page_ext = lookup_page_ext(page);
> +			page_ext = page_ext_get(page);
>  			if (unlikely(!page_ext))
>  				continue;
>  
>  			/* Maybe overlapping zone */
>  			if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
> -				continue;
> +				goto loop;
>  
>  			/* Found early allocated page */
>  			__set_page_owner_handle(page_ext, early_handle,
>  						0, 0);
>  			count++;
> +loop:
> +			page_ext_put(page_ext);
>  		}

I kind-of dislike the "loop" labels. Can we come up with a more
expressive name?

"put_continue"

or something?


One alternative would be to add to the beginning of the loop, and after
the loop sth like

if (page_ext) {
	page_ext_put(page_ext);
	page_ext = NULL;
}

One could wrap that in a function, but not sure if that improves the
situation.

-- 
Thanks,

David / dhildenb

