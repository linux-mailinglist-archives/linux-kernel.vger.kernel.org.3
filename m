Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43758D965
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiHINda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHINd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:33:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F513E83
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nt29pWAyIoYYn65mIhjhIKSl4BVL+y3jhFR1hUvUa2Y=; b=gt651B3yXlJR9xDJENunGu+z7E
        Bg1qkpbYMDKsEB0uhLdunPvwS6qNFqBvDJX52s7prEnZfkb12ScWfbEbUc8uM6gob9rYj0Qa/jIQX
        rTVHG0Fk7Qh6v7js+pSNfJhOSW8DskL5iBZjKPvN8gIzYVBeRiVmIVE9exiRU2fVBgl6NPHD1LBSR
        waHpAuUMNLFVt4rU7IigfVX8Us5v5S28IywcPTZvt9oEdIb0QYhjarUQN6QJ3jhklVR1KEBsOMvJ5
        Xw/w3RRJ0wCT7Lk995nES5h48qbT45ivUXF+xfzn6yJuH1FH51Al+ap8TfQ5TT4uheZyRMh/7bE8G
        q8C+Kk2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLPMB-00FOLk-DD; Tue, 09 Aug 2022 13:33:15 +0000
Date:   Tue, 9 Aug 2022 14:33:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     alexlzhu@fb.com
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] mm: add thp_utilization metrics to debugfs
Message-ID: <YvJiG3oviaRgPSVC@casper.infradead.org>
References: <20220809014950.3616464-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809014950.3616464-1-alexlzhu@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 06:49:50PM -0700, alexlzhu@fb.com wrote:
> +int thp_number_utilized_pages(struct page *page)
> +{
> +	unsigned long page_index, page_offset, value;
> +	int thp_nr_utilized_pages = HPAGE_PMD_NR;
> +	int step_size = sizeof(unsigned long);
> +	bool is_all_zeroes;
> +	void *kaddr;
> +
> +	if (!page || !is_anon_transparent_hugepage(page))
> +		return -1;
> +
> +	kaddr = kmap_local_page(compound_head(page));
> +	for (page_index = 0; page_index < HPAGE_PMD_NR; page_index++) {
> +		is_all_zeroes = true;
> +		for (page_offset = 0; page_offset < PAGE_SIZE; page_offset += step_size) {
> +			value = *(unsigned long *)(kaddr + page_index * PAGE_SIZE + page_offset);
> +			if (value != 0) {
> +				is_all_zeroes = false;
> +				break;
> +			}
> +		}
> +		if (is_all_zeroes)
> +			thp_nr_utilized_pages--;
> +	}
> +	kunmap_local(kaddr);

You haven't tested this on 32-bit maachines with HIGHMEM, have you?
kmap_local_page() only maps PAGE_SIZE bytes, so you need to map it and
unmap each page.  Also, why are you calling compound_head()?  Surely
you're already assuming that page is a head page here?

(this is why I introduced the struct folio type, so you know whether
a pointer is already to a head page and you don't need to call
compound_head() again).

