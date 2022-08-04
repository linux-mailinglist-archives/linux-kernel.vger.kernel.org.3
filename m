Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6448D5899AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbiHDJCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiHDJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:02:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B374D4C3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 648F0CE2544
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F41C433C1;
        Thu,  4 Aug 2022 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659603747;
        bh=FAPfqA1BxBDBpuGmMp4lrKxBMRFkiCvMfk1ZhdaiILU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FWyGBxsrtOB1KMNgNyEQbv3S8yu+winatVk5BpuKktdEOAdZZyG4yBO8hOV44MAFm
         dkVdd9K/+tjAQeGziwZ3kJOZdW/ayltIfNPNc6ushjpaDUtz6jHGwbfoGtWbTAQ5zC
         5rwzdvm1Dqr0Vlbj18K2fHedmqWAwOfJajvqxmZuHzqDpci8GFqVNFiY3IGx+JzztU
         CdlpMiWhzvrip4bDiEhzLpGihy59smtyrXLe24Sune6EnWx/XNjwjiVwHfl5zfcGKf
         +b5hhB9DHoAsChP4WlKuilVqQ0HOpZS5ztTtNbgHVvsvWKVYHKhgbPNEy/CNOboynf
         KTupq2v4yVTwg==
Message-ID: <c6ff0967-eae8-9ec1-6024-16c9b654e917@kernel.org>
Date:   Thu, 4 Aug 2022 11:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] mm/smaps: Don't access young/dirty bit if pte unpresent
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
References: <20220803220329.46299-1-peterx@redhat.com>
Content-Language: en-US
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220803220329.46299-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 00:03, Peter Xu wrote:
> These bits should only be valid when the ptes are present.  Introducing two
> booleans for it and set it to false when !pte_present().
> 
> Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries", 2012-05-31)
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/proc/task_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9913f3be9fd2..482f91577f8c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool migration = false;
> +	bool migration = false, young = false, dirty = false;
>  
>  	if (pte_present(*pte)) {
>  		page = vm_normal_page(vma, addr, *pte);
> +		young = pte_young(*pte);
> +		dirty = pte_dirty(*pte);
>  	} else if (is_swap_pte(*pte)) {
>  		swp_entry_t swpent = pte_to_swp_entry(*pte);
>  
> @@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	if (!page)
>  		return;
>  
> -	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
> -		      locked, migration);
> +	smaps_account(mss, page, false, young, dirty, locked, migration);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE

