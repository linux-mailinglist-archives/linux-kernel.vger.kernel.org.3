Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA95558D68C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbiHIJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiHIJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7FF4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FBB60F2B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15779C433C1;
        Tue,  9 Aug 2022 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660037449;
        bh=oKG/HlfgFJO5wLk1gfL3LTkzUR7OvhxkjvEoE0NwXW0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bia3MxU+fd/0wY5vhYRyrJvU5N10BRDJJGq0dWRi0y2QQ6RuYrzT5O1WnBVnI3IuQ
         IAgRPmvU+HtJ5iJabVEhG0Q5grVNqXwqKKsBSMW613ZH4NsDz7OxcKnz5rcL/GoQVF
         VgAl3JjckgQ33ugS8kLYY/R+trOxrKGYknJ9v1kHoe9M4k1S3FZoYiVrasCmtPL9qy
         85kTXXlnd2s9R9RnlDpHpfWjUpsML9lO7aPOc4VsmrJcRnXu6BqhElyf2Tm39CXAFj
         fgOGCJNyHtSseEogj8CCAXI3IpQEPP1O74pVbovDfqLJ4neGJalFJ9b4H622PywGE7
         iVh9laEA/uuJw==
Message-ID: <ab4f79ea-0a02-9556-645f-cca32dea3cad@kernel.org>
Date:   Tue, 9 Aug 2022 11:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v5] mm/page_owner.c: add llseek for page_owner
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org
Cc:     minchan@kernel.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220809024725.31980-1-quic_yingangl@quicinc.com>
Content-Language: en-US
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220809024725.31980-1-quic_yingangl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 04:47, Kassey Li wrote:
> There is usage to dump a given cma region page_owner
> instead of all page's.
> 
> This change allows to specify a ppos as start_pfn
> by fseek.
> 
> Any invalid ppos will be skipped, so it did not
> broken the origin dump feature.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  Documentation/vm/page_owner.rst | 6 ++++++
>  mm/internal.h                   | 5 +++++
>  mm/page_owner.c                 | 9 ++++++---
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index f5c954afe97c..8d33d976da8a 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -95,6 +95,12 @@ Usage
>  	PFN XXX ...
>  	// Detailed stack
>  
> +   By default, it will do full pfn dump, to start with a given pfn,
> +   page_owner supports fseek.
> +
> +   FILE *fp = fopen("/sys/kernel/debug/page_owner", "r");
> +   fseek(fp, pfn_start, SEEK_SET);
> +
>     The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
>     in buf, uses regexp to extract the page order value, counts the times
>     and pages of buf, and finally sorts them according to the parameter(s).
> diff --git a/mm/internal.h b/mm/internal.h
> index c0f8fbe0445b..1ad8f86e6e33 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -189,6 +189,11 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
>   */
>  extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>  
> +/*
> + * in mm/page_owner.c:

This should say where it's defined, not used from, and that's
fs/proc/base.c. But it's already declared in fs/proc/internal.h so maybe
page_owner.c could just include that header (although it's a bit meh).

> + */
> +extern loff_t mem_lseek(struct file *, loff_t, int);
> +
>  /*
>   * in mm/page_alloc.c
>   */
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..dcbe05e206e1 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -497,8 +497,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		return -EINVAL;
>  
>  	page = NULL;
> -	pfn = min_low_pfn + *ppos;
> -
> +	if (*ppos == 0)
> +		pfn= min_low_pfn;

missing space before '='

> +	else
> +		pfn = *ppos;
>  	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>  	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>  		pfn++;
> @@ -561,7 +563,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  			continue;
>  
>  		/* Record the next PFN to read in the file offset */
> -		*ppos = (pfn - min_low_pfn) + 1;
> +		*ppos = pfn + 1;
>  
>  		return print_page_owner(buf, count, pfn, page,
>  				page_owner, handle);
> @@ -660,6 +662,7 @@ static void init_early_allocated_pages(void)
>  
>  static const struct file_operations proc_page_owner_operations = {
>  	.read		= read_page_owner,
> +	.llseek 	= mem_lseek,
>  };
>  
>  static int __init pageowner_init(void)

