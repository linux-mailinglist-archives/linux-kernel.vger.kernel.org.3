Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3005A6C05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiH3SYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiH3SX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B34F689
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661883837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ir5bMIFXiZONcKjtB/Oq1xcLlKJ3S8ekcvj8t7HWk6Q=;
        b=MRgX0vmsN/+At5l58zch/I7BjOJpuxWX9obtA02MORy+LhY0LfoEVTNaI2LRL8WbCq8j+i
        JDsEwBsg24Z6kuubodmUXt/LsiXYKI0uxQBRoSME05kQqKDhGM8G+4kNeqec3cb5kNvJJt
        rpP8gFX1iYFg27p0vIXC7WbkIpFOXc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-DetVjwetPf65Nthl2j4zrQ-1; Tue, 30 Aug 2022 14:23:56 -0400
X-MC-Unique: DetVjwetPf65Nthl2j4zrQ-1
Received: by mail-wr1-f69.google.com with SMTP id j4-20020adfa544000000b002255264474bso1929170wrb.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Ir5bMIFXiZONcKjtB/Oq1xcLlKJ3S8ekcvj8t7HWk6Q=;
        b=s0Ys0YxQ9M24qC2quS6FxeISsAQXLwZ4WXj6xCczoSihqL0W097MahvBuQpUP49AN+
         Y/tHrtZ5QZ4SooXhHo46GNtRyVDALS8RmoEoNVYBDKz7pl46/kTGbxUOG2HqPphIbkv7
         iI5hkqEnZQ6civkOnktM/kjcMXr1uX/6nbvX64d0QGUplgD1ZZi24H9acaIQUGsNdrhV
         kHvSc9o1WCqmAVwsIFVdoAYQkR7rnwelLgFyaYrZfMaVd3vaP7o9ttEV55iZuAliPXLp
         s/FFWjQRByAMa0+ekQV0OL5ldmlwR1mEk0E+atL6Lnj2K4HfYsAQ/DQErLzV6YSFF/pU
         1vww==
X-Gm-Message-State: ACgBeo1UDGx/vCSXhF2Qtsq4qvdoud0hiQy06jyAHTO0E/Jg0Ulf5pjO
        eLasyAbS8V1wsul749PwMGptC3qOftOtDSTkzmHL5XkY9p6foGkr5KTamEwW0Zc4hvq6hJeWqRq
        0jUavbydj3ndr30Ox4mQzH8unTMNlWYPPPdD6SdGBcZlt3aWlCWk/OW6Pc8dwXQGiyZt/EtiR
X-Received: by 2002:a05:600c:4e0f:b0:3a5:e065:9b50 with SMTP id b15-20020a05600c4e0f00b003a5e0659b50mr10494561wmq.35.1661883834506;
        Tue, 30 Aug 2022 11:23:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4oOp4zxQ/thee2JZtJ0alh2W3O9idTGxyH9xQar4vvfTNOtE/WqskpiaC27YCXMgTh0Fj/gQ==
X-Received: by 2002:a05:600c:4e0f:b0:3a5:e065:9b50 with SMTP id b15-20020a05600c4e0f00b003a5e0659b50mr10494538wmq.35.1661883834131;
        Tue, 30 Aug 2022 11:23:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b003a30fbde91dsm12810957wma.20.2022.08.30.11.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:23:53 -0700 (PDT)
Message-ID: <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
Date:   Tue, 30 Aug 2022 20:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
Organization: Red Hat
In-Reply-To: <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
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

On 26.08.22 16:59, David Hildenbrand wrote:
> On 25.08.22 18:46, David Hildenbrand wrote:
>> There seems to be no reason why FOLL_FORCE during GUP-fast would have to
>> fallback to the slow path when stumbling over a PROT_NONE mapped page. We
>> only have to trigger hinting faults in case FOLL_FORCE is not set, and any
>> kind of fault handling naturally happens from the slow path -- where
>> NUMA hinting accounting/handling would be performed.
>>
>> Note that the comment regarding THP migration is outdated:
>> commit 2b4847e73004 ("mm: numa: serialise parallel get_user_page against
>> THP migration") described that this was required for THP due to lack of PMD
>> migration entries. Nowadays, we do have proper PMD migration entries in
>> place -- see set_pmd_migration_entry(), which does a proper
>> pmdp_invalidate() when placing the migration entry.
>>
>> So let's just reuse gup_can_follow_protnone() here to make it
>> consistent and drop the somewhat outdated comments.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/gup.c | 14 +++-----------
>>  1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a1355dbd848e..dfef23071dc8 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2350,11 +2350,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>  		struct page *page;
>>  		struct folio *folio;
>>  
>> -		/*
>> -		 * Similar to the PMD case below, NUMA hinting must take slow
>> -		 * path using the pte_protnone check.
>> -		 */
>> -		if (pte_protnone(pte))
>> +		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
>>  			goto pte_unmap;
>>  
>>  		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
>> @@ -2736,12 +2732,8 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>>  
>>  		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
>>  			     pmd_devmap(pmd))) {
>> -			/*
>> -			 * NUMA hinting faults need to be handled in the GUP
>> -			 * slowpath for accounting purposes and so that they
>> -			 * can be serialised against THP migration.
>> -			 */
>> -			if (pmd_protnone(pmd))
>> +			if (pmd_protnone(pmd) &&
>> +			    !gup_can_follow_protnone(flags))
>>  				return 0;
>>  
>>  			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
> 
> 
> I just stumbled over something interesting. If we have a pte_protnone()
> entry, ptep_clear_flush() might not flush, because the !pte_accessible()
>  does not hold.
> 
> Consequently, we could be in trouble when using ptep_clear_flush() on a
> pte_protnone() PTE to make sure that GUP cannot run anymore.
> 
> Will give this a better thought, but most probably I'll replace this
> patch by a proper documentation update here.

... and looking into the details of TLB flush and GUP-fast interaction
nowadays, that case is no longer relevant. A TLB flush is no longer
sufficient to stop concurrent GUP-fast ever since we introduced generic
RCU GUP-fast.

-- 
Thanks,

David / dhildenb

