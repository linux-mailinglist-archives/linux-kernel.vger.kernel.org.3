Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960D55E0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiF0Olq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiF0Oll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AE0CE04
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xri+uff54HOFYBvxFfiZF2KuK5hzUKaHppr36rCO3sk=; b=PN+RyByPMxfZAUHpL0gITPl4o1
        /9FJkI+OREdN14XarIWYsQ3xUW+tnm3EWHp0vkRFWloHbrrd1AR50ZJ8qeN3TicoX/rB1eoH+v4/H
        hvyChvOb0jnjMR99xef2TOeCuiXOiLx0nDy4+9L0AC85X2hWba3MRLNcPzOL37H2hpJU3YOrXAzoH
        482hvuOqw0pmwX1uy9kSmTuIXwwaJv9UsQ9hKcNXpnNr8X2+uYzuIC2Q0+F4LUbLzXlg52TQ5OKnU
        ne3Yubikb7JITFLM9LrzOdKAu8vtUPAkd+JLwdTAnqZM2GUi2m/LORmVR6AWX0MtBDf1lqS2npPcV
        4obdxg3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5pvf-00BRKk-T3; Mon, 27 Jun 2022 14:41:31 +0000
Date:   Mon, 27 Jun 2022 15:41:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Message-ID: <YrnBm9FGizF1iLsW@casper.infradead.org>
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 10:57:17PM +0800, Qi Zheng wrote:
> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
> helper") add set_huge_swap_pte_at() to handle swap entries on
> architectures that support hugepages consisting of contiguous ptes.
> And currently the set_huge_swap_pte_at() is only overridden by arm64.

Bleh.  I hate the way we handle these currently.

> +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
> +{
> +	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
> +
> +	return page_folio(pfn_to_page(swp_offset(entry)));
> +}

We haven't needed a pfn_to_folio() yet, but perhaps we should have one?

Related, how should we store migration entries for multi-order folios
in the page tables?  We can either encode the individual page in
question, or we can encode the folio.  Do we need to support folios
being mapped askew (ie unaligned), or will folios always be mapped
aligned?

> +	if (!pte_present(pte)) {
> +		struct folio *folio;
> +
> +		folio = hugetlb_swap_entry_to_folio(pte_to_swp_entry(pte));
> +		ncontig = num_contig_ptes(folio_size(folio), &pgsize);
> +
> +		for (i = 0; i < ncontig; i++, ptep++)
> +			set_pte_at(mm, addr, ptep, pte);
> +		return;
> +	}

It seems like a shame to calculate folio_size() only to turn it into a
number of pages.  Don't you want to just use:

		ncontig = folio_nr_pages(folio);

