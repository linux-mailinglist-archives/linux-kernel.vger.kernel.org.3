Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD3585B67
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiG3R3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiG3R3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 13:29:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5117598
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGFGvJoR+Jxr6T31gt4WNXR0yqCHEGj/HDLPrpa20+k=; b=VLEVdVRHYadFUc0e7jesIG6pe4
        OxX+e1r0SeLDlMHk1aPTOqyMKW8Y/B6T2D9Agqf4KrITfeykv+XnCj5mW5I5Xh0u9os70ssvLQ/Fb
        FRS358pnU9hnybW47PWlMomuDKoBhSfPLECbGJgxo82+S8i7zgt4AKJkKxUFwpzkx/bGZY5Io8z3P
        EHygezyqVxIenfMYY7GGQG+1dq5ocq2EUYqlvG0F8kaZ6OZ1c5QezBpiZTI4wHKTd4ZNgl1f2/k3v
        2kG7qr4Osagm84RYP6zt7VzU47DPIafLh2TSfSV337DV3eI6+q2K1zfvYwNOmpM8EoSAbNcoWVvNO
        f86vyHrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHqHF-005j6b-Jw; Sat, 30 Jul 2022 17:29:25 +0000
Date:   Sat, 30 Jul 2022 18:29:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm: add last level page table numa info to
 /proc/pid/numa_pgtable
Message-ID: <YuVqdcY8Ibib2LJa@casper.infradead.org>
References: <20220730163528.48377-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730163528.48377-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 12:35:28AM +0800, Xin Hao wrote:
> In many data center servers, the shared memory architectures is
> Non-Uniform Memory Access (NUMA), remote numa node data access
> often brings a high latency problem, but what we are easy to ignore
> is that the page table remote numa access, It can also leads to a
> performance degradation.
> 
> So there add a new interface in /proc, This will help developers to
> get more info about performance issues if they are caused by cross-NUMA.

Interesting.  The implementation seems rather more complex than
necessary though.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2d04e3470d4c..a51befb47ea8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1999,4 +1999,133 @@ const struct file_operations proc_pid_numa_maps_operations = {
>  	.release	= proc_map_release,
>  };
> 
> +struct pgtable_numa_maps {
> +	unsigned long node[MAX_NUMNODES];
> +};
> +
> +struct pgtable_numa_private {
> +	struct proc_maps_private proc_maps;
> +	struct pgtable_numa_maps md;
> +};

struct pgtable_numa_private {
	struct proc_maps_private proc_maps;
	unsigned long node[MAX_NUMNODES];
};

> +static void gather_pgtable_stats(struct page *page, struct pgtable_numa_maps *md)
> +{
> +	md->node[page_to_nid(page)] += 1;
> +}
> +
> +static struct page *can_gather_pgtable_numa_stats(pmd_t pmd, struct vm_area_struct *vma,
> +		unsigned long addr)
> +{
> +	struct page *page;
> +	int nid;
> +
> +	if (!pmd_present(pmd))
> +		return NULL;
> +
> +	if (pmd_huge(pmd))
> +		return NULL;
> +
> +	page = pmd_page(pmd);
> +	nid = page_to_nid(page);
> +	if (!node_isset(nid, node_states[N_MEMORY]))
> +		return NULL;
> +
> +	return page;
> +}
> +
> +static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
> +		unsigned long end, struct mm_walk *walk)
> +{
> +	struct pgtable_numa_maps *md = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct page *page;
> +
> +	if (pmd_huge(*pmd)) {
> +		struct page *pmd_page;
> +
> +		pmd_page = virt_to_page(pmd);
> +		if (!pmd_page)
> +			return 0;
> +
> +		if (!node_isset(page_to_nid(pmd_page), node_states[N_MEMORY]))
> +			return 0;
> +
> +		gather_pgtable_stats(pmd_page, md);
> +		goto out;
> +	}
> +
> +	page = can_gather_pgtable_numa_stats(*pmd, vma, addr);
> +	if (!page)
> +		return 0;
> +
> +	gather_pgtable_stats(page, md);
> +
> +out:
> +	cond_resched();
> +	return 0;
> +}

static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
		unsigned long end, struct mm_walk *walk)
{
	struct pgtable_numa_private *priv = walk->private;
	struct vm_area_struct *vma = walk->vma;
	struct page *page;
	int nid;

	if (pmd_huge(*pmd)) {
		page = virt_to_page(pmd);
	} else {
		page = pmd_page(*pmd);
	}

	nid = page_to_nid(page);
	priv->node[nid]++;

	return 0;
}

