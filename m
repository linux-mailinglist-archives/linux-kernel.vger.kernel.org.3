Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC07658A354
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiHDWkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHDWkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B433248EE
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4C861862
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 22:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE68EC433D7;
        Thu,  4 Aug 2022 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659652851;
        bh=HC3VLcyNerHzBCf5Q7tnpfnSFobvXPDPWfF49Lx8cz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OX3gFSgcbaDGFfMXilhc5jn1RKyrYRvXBk9fvrjbTsBnN5Mb7B1RpKicgbcf12l9y
         j29F6tp81PnKPHHJUjRwbpccWE/+3LYgjjIKDEZfMEwKrFwCHYwsohyzClVCFS6OZg
         HifyYlqyvM3ckjWoalvRjxmXyaddw6S9wtbDydOQ=
Date:   Thu, 4 Aug 2022 15:40:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Shi <shy828301@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH] mm/smaps: Don't access young/dirty bit if pte unpresent
Message-Id: <20220804154050.e6ab9f8c38e2445acc5b57b1@linux-foundation.org>
In-Reply-To: <20220803220329.46299-1-peterx@redhat.com>
References: <20220803220329.46299-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Aug 2022 18:03:29 -0400 Peter Xu <peterx@redhat.com> wrote:

> These bits should only be valid when the ptes are present.  Introducing two
> booleans for it and set it to false when !pte_present().

Please (always) describe the user visible runtime effects of the bug
which is being fixed?


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
> -- 
> 2.32.0
