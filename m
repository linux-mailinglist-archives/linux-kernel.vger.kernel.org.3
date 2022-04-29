Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2C514056
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354038AbiD2BoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354030AbiD2BoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D46211F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5076662206
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5BCC385AC;
        Fri, 29 Apr 2022 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651196466;
        bh=QaiGLwnV4ie7NhguJL5G5yOfx2MqdqKnJRaCmm3yGmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqyGSyfwAWMJPosrNjo78l7QttkzKimLp5uEz2Z1f4ZdZ8kQZokKGtHZHhICNHK/t
         u9xiipupnG/DRSra8Gn0kq0EN8MHaev+9Bu5wqjjzUcbzrY0YCbNFWabCipzNHg7Ym
         7tvu0nshPqWb8w6UVZnF/tpAiqu5hUIR3Fe59FnQmfwbVG2a/sIjUtxY1so1Bbg1dY
         oNW3Er5zKsWxSMAkQUcME3VHVqxVZb6dZ/T97k8NTlGvN6HxzSOo45aABmEFhibkZF
         kI8+2HyG9BfDaf3qP+/WHMdlxjxNXSo1aeyT8K+tVzx9tRG13FVGbhfL0uuuzTaI32
         s6Cxxt3dNsr3w==
Date:   Thu, 28 Apr 2022 19:41:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm/dmapool: replace linked list with xarray
Message-ID: <YmtCL0wzshmW02Xr@kbusch-mbp.dhcp.thefacebook.com>
References: <20220428202714.17630-1-kbusch@kernel.org>
 <20220428202714.17630-2-kbusch@kernel.org>
 <YmsOVVfcycVdbzUs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmsOVVfcycVdbzUs@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:59:49PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 28, 2022 at 02:27:13PM -0600, kbusch@kernel.org wrote:
> > @@ -316,13 +316,14 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
> >  {
> >  	unsigned long flags;
> >  	struct dma_page *page;
> > +	unsigned long i;
> >  	size_t offset;
> >  	void *retval;
> >  
> >  	might_alloc(mem_flags);
> >  
> >  	spin_lock_irqsave(&pool->lock, flags);
> > -	list_for_each_entry(page, &pool->page_list, page_list) {
> > +	xa_for_each(&pool->pages, i, page) {
> >  		if (page->offset < pool->allocation)
> >  			goto ready;
> >  	}
> 
> A further optimisation you could do is use xarray search marks to
> search for only pages which have free entries.

That's an interesting idea. I didn't consider setting marks since patch 2
replaces this search with essentially a stack pop. If a marked entry can be
returned in a similar time, though, I could drop patch 2. I can't tell from the
xarray code if that operation time is in the same ballpark, though, so I'll
just rerun the the benchmark. :)
