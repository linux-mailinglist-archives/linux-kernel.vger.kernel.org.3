Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB254D8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349584AbiFPDim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358352AbiFPDie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C95711CFDF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655350709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFzr2E+FUsPvuAdky+sKb7/FHs2DJkhTPX65ZqWaGYc=;
        b=eU7ie91tSWgkhbySxYIBStG9C8pLMi795YIszu1Ao38EI1vGa8eFSinyXJYuPrclTgSc3l
        iF9vq41fJ35SSaiw7jsB9XmujCEXxlvgARYzNYIrOrlEfDopZv6r+pNfAtwY927FTbrlqF
        KhLp0SfpqxLdtv1etAepTiU97ux8HdU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-QjeyGEqIMSq1_7SWfd595Q-1; Wed, 15 Jun 2022 23:38:27 -0400
X-MC-Unique: QjeyGEqIMSq1_7SWfd595Q-1
Received: by mail-lf1-f72.google.com with SMTP id n5-20020a0565120ac500b0047da8df6b2cso109155lfu.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cFzr2E+FUsPvuAdky+sKb7/FHs2DJkhTPX65ZqWaGYc=;
        b=x7alK0h54Um5/hrk0+HLh7N3KJeFvsygUsnxxSnRtxRKdf/c1OB7OWsw9vAg8SSHnV
         oHj2Fd6bNFwI53OPPgZabxKs0B7GNc/BJ7H7gmM7AgIqbzc5ntbt3ODYzLjosDIaMOZ4
         TlK+8g8NT3YyJLq3ZWdFGXYEak2bq1kXK1I7hWUFDrLqQZSGEwmZG4/+LGkJ8jgCzpRf
         5GASMr1SZ9hRyPSq/PlbEPUxBuy29RWBosJaUvG/YFlUdFQIqNI39r2pfP7D3ig5jr4/
         Wx8ne2+zKz8jmWSSoZ2YkKIjRXyVWMSppKhbPUAq3iR/+8CmKhBj/XSTOfhQSN0B3Rmr
         1fuA==
X-Gm-Message-State: AJIora9q7HgOKHT4Tc2VSjsUDTR5ABaCxbbfbOvN1gw8tK6MLsw+/b3r
        +e2Uj3p39bpMLEc9h5R5NOP+1/OE5tObutGsKB5qNYBA/JDLn4Wk71KcwtcIlFAdkbMt8XuglP+
        WEskA4DLe4zVeMflvyyVj100=
X-Received: by 2002:a05:6512:3e11:b0:473:9f5f:feda with SMTP id i17-20020a0565123e1100b004739f5ffedamr1535273lfv.244.1655350705796;
        Wed, 15 Jun 2022 20:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v1ZdIAMusneuEpa7Ml/fakuCLmIleSNBUOaFLpZsXR8phBRki5MDYyzoTL83c6PrXp1QV9FA==
X-Received: by 2002:a05:6512:3e11:b0:473:9f5f:feda with SMTP id i17-20020a0565123e1100b004739f5ffedamr1535255lfv.244.1655350705518;
        Wed, 15 Jun 2022 20:38:25 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id x27-20020a19e01b000000b0047900ad3f90sm64618lfg.29.2022.06.15.20.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 20:38:25 -0700 (PDT)
Message-ID: <2857942a-6a26-6391-8359-94676afd616a@redhat.com>
Date:   Thu, 16 Jun 2022 06:38:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] mm/khugepaged: try to free transhuge swapcache when
 possible
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-8-linmiaohe@huawei.com> <YqoTU7SNM7d3MlNs@google.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <YqoTU7SNM7d3MlNs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.6.2022 20.13, Zach O'Keefe wrote:
> On 11 Jun 16:47, Miaohe Lin wrote:
>> Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
>> It's because release_pte_page() is not called for these pages and
>> thus free_page_and_swap_cache can't grab the page lock. These pages
>> won't be freed from swap cache even if we are the only user until
>> next time reclaim. It shouldn't hurt indeed, but we could try to
>> free these pages to save more memory for system.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   include/linux/swap.h | 5 +++++
>>   mm/khugepaged.c      | 1 +
>>   mm/swap.h            | 5 -----
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 8672a7123ccd..ccb83b12b724 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -456,6 +456,7 @@ static inline unsigned long total_swapcache_pages(void)
>>   	return global_node_page_state(NR_SWAPCACHE);
>>   }
>>   
>> +extern void free_swap_cache(struct page *page);
>>   extern void free_page_and_swap_cache(struct page *);
>>   extern void free_pages_and_swap_cache(struct page **, int);
>>   /* linux/mm/swapfile.c */
>> @@ -540,6 +541,10 @@ static inline void put_swap_device(struct swap_info_struct *si)
>>   /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>>   #define free_swap_and_cache(e) is_pfn_swap_entry(e)
>>   
>> +static inline void free_swap_cache(struct page *page)
>> +{
>> +}
>> +
>>   static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
>>   {
>>   	return 0;
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index ee0a719c8be9..52109ad13f78 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -756,6 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
>>   		list_del(&src_page->lru);
>>   		release_pte_page(src_page);
>> +		free_swap_cache(src_page);
>>   	}
>>   }
> 
> Aside: in __collapse_huge_page_isolate() (and also here) why can't we just check
> PageCompound(page) && page == compound_head(page) to only act on compound pages
> once? AFAIK this would alleviate this compound_pagelist business..



It is for pte mapped compound pages. Things like lock/unlock page and 
isolate/putback lru have to operate on head pages and you have to do 
operations like copy from tail pages before releasing heads. So while 
maybe you could add tests for head/tail here and there, work pages 
backwards etc it easily gets messier than the current solution with 
compound_pagelist.



> 
> Anyways, as-is, free_page_and_swap_cache() won't be able to do
> try_to_free_swap(), since it can't grab page lock, put it will call put_page().
> I think (?) the last page ref might be dropped in release_pte_page(), so should
> free_swap_cache() come before it?
> 
>>   
>> diff --git a/mm/swap.h b/mm/swap.h
>> index 0193797b0c92..863f6086c916 100644
>> --- a/mm/swap.h
>> +++ b/mm/swap.h
>> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct page *page,
>>   void delete_from_swap_cache(struct page *page);
>>   void clear_shadow_from_swap_cache(int type, unsigned long begin,
>>   				  unsigned long end);
>> -void free_swap_cache(struct page *page);
>>   struct page *lookup_swap_cache(swp_entry_t entry,
>>   			       struct vm_area_struct *vma,
>>   			       unsigned long addr);
>> @@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>>   	return NULL;
>>   }
>>   
>> -static inline void free_swap_cache(struct page *page)
>> -{
>> -}
>> -
>>   static inline void show_swap_cache_info(void)
>>   {
>>   }
>> -- 
>> 2.23.0
>>
>>
> 

--Mika

