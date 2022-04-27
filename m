Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672D51241C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiD0UwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiD0UwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C643DA7B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAA5B82AC5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFFEC385A7;
        Wed, 27 Apr 2022 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651092524;
        bh=8SaRoR3ysXvyQTRc6V4t38Ura/+4OgWqk8Q5dIGAVSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uGblpJngQTrV9F4jH6x3xSZXkXdrSknRMapcn4OP+nfIzHv2Q1DUl7yR5p4he7N9W
         h4HAUS2tbG6eIDzHoKwqw5J2MQIa4TovvI5nhXrVVNCmUIVLwfSvd2LgGLrHjrBqbe
         U5/WyXOpUMvlPH1vsnyNOMLdwJDReETxH8qMqlEs=
Date:   Wed, 27 Apr 2022 13:48:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Message-Id: <20220427134843.576f0a18bea28de9e798004a@linux-foundation.org>
In-Reply-To: <20220317065024.2635069-1-maobibo@loongson.cn>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 02:50:24 -0400 Bibo Mao <maobibo@loongson.cn> wrote:

> collapse huge page will copy huge page from general small pages,
> dest node is calculated from most one of source pages, however
> THP daemon is not scheduled on dest node. The performance may be
> poor since huge page copying across nodes, also cache is not used
> for target node. With this patch, khugepaged daemon switches to
> the same numa node with huge page. It saves copying time and makes
> use of local cache better.
> 
> With this patch, specint 2006 base performance is improved with 6%
> on Loongson 3C5000L platform with 32 cores and 8 numa nodes.
> 

Are there any acks for this one please?

> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1066,6 +1066,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
>  	gfp_t gfp;
> +	const struct cpumask *cpumask;
>  
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
> @@ -1079,6 +1080,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	 * that. We will recheck the vma after taking it again in write mode.
>  	 */
>  	mmap_read_unlock(mm);
> +
> +	/* sched to specified node before huage page memory copy */
> +	if (task_node(current) != node) {
> +		cpumask = cpumask_of_node(node);
> +		if (!cpumask_empty(cpumask))
> +			set_cpus_allowed_ptr(current, cpumask);
> +	}
>  	new_page = khugepaged_alloc_page(hpage, gfp, node);
>  	if (!new_page) {
>  		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> -- 
> 2.31.1
> 
