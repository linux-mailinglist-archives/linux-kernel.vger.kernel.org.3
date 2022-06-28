Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5455D9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiF1Deo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiF1Dej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:34:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5825E2315F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:34:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d5so9871693plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pZ+/evlGnsJ8jD6C9tMwnqlQXDJt8JhJGnpn4OPCdjs=;
        b=ZKbAeK5dLgm2DXSIg5wecdROkd4oaR5bX00Hgrpx3CycC+gycPH90r8HsP89MIggwQ
         Tgue21oNaVdD1QixnmeuatxNcsmJG4xKnv5Gp+DxvrMF89AnWKUGEelvc0PlxtyZQ98G
         gRIANjbvmLyMraCLSQKxlpOsnPK+SulUvHUW7egM/R2LRJjKiT5EpDedRPJxzTVsmiol
         iQyxuXdUdrSqbd4vg9WhMKMZGwzXpEjFJdSGjQZIDiX08h4PJTmF0avQSLtwZfOnSyX8
         OcFZz2Kc/mQjCSMoB6dKyXJXSiNEZOxcLLNhniWqQszFiShJRUMnJs8r8vqXCcFFYZFe
         CJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pZ+/evlGnsJ8jD6C9tMwnqlQXDJt8JhJGnpn4OPCdjs=;
        b=EN5GGiQajD+yLmrdCnxpAKL8V9wL30DLqEqmrjCsNWKNYR9yG0rS8wBEEWqoX4IK54
         P+qR3R+UOablLWSxhQ3A7gbLozJy5PdTh+CR/npjOu38m8Ym30ogpIZIwIoih9Ly/2cL
         /lS8loO3uaPTK/wJXSCso7NugmBb3PY7wW4M911XwvWs3J1ANU49U1DQL3R/AxVUHa+9
         GkvDRowyH70VOYSJm1+bMKMln/Mutx3plHpzSZ+Sbytug41vgVhwWgiSfg22bjkw2f4D
         lh2Q5OhYbZjIyKN2hAGsZRYA/APU9HvARjCT2slwO+nq5BMuqH1zFbCKIxcN5Y4rt01C
         kNTQ==
X-Gm-Message-State: AJIora/aMx13cFr4bbnxap9reQYtR1V2LqbfhZBJ/zsL9K4J6iqsJ7ft
        DSndBhn+7hpSR9vLzHdjkp2/Wg==
X-Google-Smtp-Source: AGRyM1uTk/gqugCXTP+8MBHLnYa3VLEn9+TuUj54C7lV4fs/Sl3H+2Kf2QtAKD6V0UZkAx7Wg9hRgg==
X-Received: by 2002:a17:90b:3ece:b0:1ed:13a9:8531 with SMTP id rm14-20020a17090b3ece00b001ed13a98531mr24513558pjb.183.1656387277925;
        Mon, 27 Jun 2022 20:34:37 -0700 (PDT)
Received: from [10.4.214.173] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id j10-20020aa78d0a000000b00522c3f34362sm8036655pfe.215.2022.06.27.20.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:34:37 -0700 (PDT)
Message-ID: <f3d8aabe-3d02-8851-b5e9-b0dcdb7c0b6e@bytedance.com>
Date:   Tue, 28 Jun 2022 11:34:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
 <YrnBm9FGizF1iLsW@casper.infradead.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <YrnBm9FGizF1iLsW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/27 22:41, Matthew Wilcox wrote:
> On Sun, Jun 26, 2022 at 10:57:17PM +0800, Qi Zheng wrote:
>> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
>> helper") add set_huge_swap_pte_at() to handle swap entries on
>> architectures that support hugepages consisting of contiguous ptes.
>> And currently the set_huge_swap_pte_at() is only overridden by arm64.
> 
> Bleh.  I hate the way we handle these currently.
> 
>> +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
>> +{
>> +	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
>> +
>> +	return page_folio(pfn_to_page(swp_offset(entry)));
>> +}
> 
> We haven't needed a pfn_to_folio() yet, but perhaps we should have one?

Hi,

IMO, it would be better to have a pfn_to_folio(), which can save the
redundant page_folio() call in the current case.

But this is not related to the current patch, maybe it can be a
separate optimization patch.

> 
> Related, how should we store migration entries for multi-order folios
> in the page tables?  We can either encode the individual page in
> question, or we can encode the folio.  Do we need to support folios
> being mapped askew (ie unaligned), or will folios always be mapped
> aligned?

Do we currently have a scenario where we need to use skew mapped folios?
Maybe it can be used in pte-mapped THP? Hmm, I have no idea.

> 
>> +	if (!pte_present(pte)) {
>> +		struct folio *folio;
>> +
>> +		folio = hugetlb_swap_entry_to_folio(pte_to_swp_entry(pte));
>> +		ncontig = num_contig_ptes(folio_size(folio), &pgsize);
>> +
>> +		for (i = 0; i < ncontig; i++, ptep++)
>> +			set_pte_at(mm, addr, ptep, pte);
>> +		return;
>> +	}
> 
> It seems like a shame to calculate folio_size() only to turn it into a
> number of pages.  Don't you want to just use:
> 
> 		ncontig = folio_nr_pages(folio);

We can't use folio_nr_pages() here, because for PMD_SIZE we only need
one entry instead of the PTRS_PER_PTE entries returned by
folio_nr_pages().

Thanks,
Qi

> 

-- 
Thanks,
Qi
