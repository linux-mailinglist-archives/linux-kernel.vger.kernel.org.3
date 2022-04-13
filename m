Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5A4FF384
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiDMJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiDMJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4365F344DA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649842223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUAWCEtJ7W8Lp2MMf8nQbTxa4Gjk9+/HNaILcWqE2Ig=;
        b=eleBN7IQOYNwqhzyp8UOTfP934gm8Gd8zrWmM2UKQtts8In4H47RE5PI4D7pXWRFbLRVQ/
        lrHjdNldjjBianOZ/MgMjrFCbtrJdM7dMtX4pzVs8Z/xSP5XI2WBw5h5RzQMA88B4KZFOS
        PCMgiuD6AZswUKdSIZXo00YuNdC9tGg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-HwBSZAyTNPyHnOcoLml6Kw-1; Wed, 13 Apr 2022 05:30:22 -0400
X-MC-Unique: HwBSZAyTNPyHnOcoLml6Kw-1
Received: by mail-wr1-f72.google.com with SMTP id f2-20020a056000036200b00207a14a1f96so210378wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=sUAWCEtJ7W8Lp2MMf8nQbTxa4Gjk9+/HNaILcWqE2Ig=;
        b=nDiu+LTCtry4vVABXlGYbONLPocMkdbJHUPJ+ydIpokvH1APjNWQVmvlBV65Wh6ytc
         Lu9FRUFO3ORjDg3jm2WKw+F1GJ1kKLGONqXnc0Xuffas2GutfJCi1fvKZk87kvRFFtuC
         raC2itn+HmEpouHjpmKXSlK6eJZKupPdvl3Z8tiApucY8o3svU5ex/NytV9mSGqmhAPF
         f9C2ZzOo1Q1MhJL/xX8yUDn8dNTaOFJr9xXejogi8e1a7YrO+OIwJpWtFC2laWp/6z00
         6czX4jtxiGNotDxoN2v1TJ7LdwqxVcggaZ5Qlg9yupK5qUEac0vhV59lNAxX31ypR9rZ
         1zGw==
X-Gm-Message-State: AOAM532JNYMLajuUWG/ELSOolX1pE9Q5nkkiuGP3Gv8OYGmzKPq3rQHT
        5bIooCW1y+tcYdj5/d4kkQcYnodBQbzD0N8sHw6OjxfR1l4QcoHp0jAnuuOW+/ofejjLeyXbPkH
        fg4K1DeTlfjW2zPQXGxCn3RWK
X-Received: by 2002:a05:600c:3ac7:b0:38e:c6ef:ff0 with SMTP id d7-20020a05600c3ac700b0038ec6ef0ff0mr7356601wms.8.1649842220991;
        Wed, 13 Apr 2022 02:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd3XaLEhPCG4J24HCG8pKWKl8usohh+7J5bIP+p03v6bOndnNfB1jN1ExM+RVo0C4IS9g7NA==
X-Received: by 2002:a05:600c:3ac7:b0:38e:c6ef:ff0 with SMTP id d7-20020a05600c3ac700b0038ec6ef0ff0mr7356584wms.8.1649842220717;
        Wed, 13 Apr 2022 02:30:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b0038e9c5924d6sm1958059wmq.29.2022.04.13.02.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:30:20 -0700 (PDT)
Message-ID: <374d2be1-e13d-e605-ff80-b9d5eee4c40e@redhat.com>
Date:   Wed, 13 Apr 2022 11:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-2-david@redhat.com>
 <28142e3e-2556-0ca2-7ac5-7420ef862259@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
In-Reply-To: <28142e3e-2556-0ca2-7ac5-7420ef862259@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 10:58, Miaohe Lin wrote:
> On 2022/3/30 0:43, David Hildenbrand wrote:
>> Currently, we clear PG_anon_exclusive in try_to_unmap() and forget about
> ...
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 14618f446139..9060cc7f2123 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -792,6 +792,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  						&src_mm->mmlist);
>>  			spin_unlock(&mmlist_lock);
>>  		}
>> +		/* Mark the swap entry as shared. */
>> +		if (pte_swp_exclusive(*src_pte)) {
>> +			pte = pte_swp_clear_exclusive(*src_pte);
>> +			set_pte_at(src_mm, addr, src_pte, pte);
>> +		}
>>  		rss[MM_SWAPENTS]++;
>>  	} else if (is_migration_entry(entry)) {
>>  		page = pfn_swap_entry_to_page(entry);
>> @@ -3559,6 +3564,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  	struct page *page = NULL, *swapcache;
>>  	struct swap_info_struct *si = NULL;
>>  	rmap_t rmap_flags = RMAP_NONE;
>> +	bool exclusive = false;
>>  	swp_entry_t entry;
>>  	pte_t pte;
>>  	int locked;
>> @@ -3724,6 +3730,46 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
>>  
>> +	/*
>> +	 * Check under PT lock (to protect against concurrent fork() sharing
>> +	 * the swap entry concurrently) for certainly exclusive pages.
>> +	 */
>> +	if (!PageKsm(page)) {
>> +		/*
>> +		 * Note that pte_swp_exclusive() == false for architectures
>> +		 * without __HAVE_ARCH_PTE_SWP_EXCLUSIVE.
>> +		 */
>> +		exclusive = pte_swp_exclusive(vmf->orig_pte);
>> +		if (page != swapcache) {
>> +			/*
>> +			 * We have a fresh page that is not exposed to the
>> +			 * swapcache -> certainly exclusive.
>> +			 */
>> +			exclusive = true;
>> +		} else if (exclusive && PageWriteback(page) &&
>> +			   !(swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
> 
> Really sorry for late respond and a newbie question. IIUC, if SWP_STABLE_WRITES is set,
> it means concurrent page modifications while under writeback is not supported. For these
> problematic swap backends, exclusive marker is dropped. So the above if statement is to
> filter out these problematic swap backends which have SWP_STABLE_WRITES set. If so, the
> above check should be && (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)), i.e. no "!".
> Or am I miss something?

Oh, thanks for your careful eyes!

Indeed, SWP_STABLE_WRITES indicates that the backend *requires* stable
writes, meaning, we must not modify the page while writeback is active.

So if and only if that is set, we must drop the exclusive marker.

This essentially corresponds to previous reuse_swap_page() logic:

bool reuse_swap_page(struct page *page)
{
...
	if (!PageWriteback(page)) {
		...
	} else {
		...
		if (p->flags & SWP_STABLE_WRITES) {
			spin_unlock(&p->lock);
			return false;
		}
...
}

Fortunately, this only affects such backends. For backends without
SWP_STABLE_WRITES, the current code is simply sub-optimal.


So yes, this has to be

} else if (exclusive && PageWriteback(page) &&
	   (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {


Let me try finding a way to test this, the tests I was running so far
were apparently not using a backend with SWP_STABLE_WRITES.

-- 
Thanks,

David / dhildenb

