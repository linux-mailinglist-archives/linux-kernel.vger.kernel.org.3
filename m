Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E74557F52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiFWQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiFWQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:07:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B143B44A1C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RB9/m8uHQQCll+yG7QN8tRCGkMzH5JCZ3P5+Y2rpVfU=; b=Ny0nEvwFdfc6EVSrWqfXikAfTJ
        VgknjhOz4xAbwFEFOeseKN/4eOP8DYT9LwHUj18zA1L/753iiyDB7aY9JONqxSAgQQCjxsi0yNFeT
        +vG4j9zLO6wE/tQ3fhgaWIvIeYD7fatkAnZK69SdEcZdA6q79Drrb0D4eMHV2INpiaKBMMXbUZaD3
        og2lJeSB7+L8gHJpwvFefJIu0xnA6MUfVtys8ZT+sNkEtIyI0PPJUuYpUZrmzBj0/pCbOX2KltNh8
        Cr9I/OsTx/XOhnYEVfi+2Evl4z4MJ9FsxqSbcgPVEoVBijUoY0XzKHOt7B0o7IL1tlDehhbn5lWJ8
        evAcpCpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4PMQ-007zFY-4Z; Thu, 23 Jun 2022 16:07:14 +0000
Date:   Thu, 23 Jun 2022 17:07:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] mm: Factor out the pagetable pages account
 into new helper function
Message-ID: <YrSPsqJHJTRcCmph@casper.infradead.org>
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <e094c4a2e07ff66708f7a3a9f6b86eb694f33cf0.1655887440.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e094c4a2e07ff66708f7a3a9f6b86eb694f33cf0.1655887440.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:58:52PM +0800, Baolin Wang wrote:
> +static inline void pgtable_set_and_inc(struct page *page)
> +{
> +	__SetPageTable(page);
> +	inc_lruvec_page_state(page, NR_PAGETABLE);
> +}

I don't like the names.  The accounting is also wrong for non-order-0
allocations.  It should be

	mod_lruvec_page_state(page, NR_PAGETABLE, compound_nr(page))

but it's probably better to change the API to pass in the number of
pages instead of recalculating it.

I can't think of a good name.  What's wrong with just adding

static inline bool pgtable_pud_page_ctor(struct page *page)

to go along with the pte and pmd variants?

