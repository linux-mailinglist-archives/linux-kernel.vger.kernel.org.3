Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFB4EC99F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348805AbiC3QZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiC3QZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:25:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE2BB0B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fGiP7eNYmR9hTYgNcpuVATSk7G3qVhmnTNIbk7YKHZ8=; b=lQ7Ifzm4AfUFqmAVF4hxGCdqqx
        1B/lx0Rzo6p288YDfLG5BpnykdaRUx7ONiFhybY4jjGCpACduAElPqYg//NSewCnBi+dpmIf8OGsC
        yWsngKf2uCewI8QsWgEhP6E+fad7r2tmrtRnj4LcTd0YCVEqe0DXRRgsY5BcohOB8h5dN7ALt6HNB
        k+Rc83xEGDVSdQ4s+J/pefGjBIuzdXQpu705spFQSfrjRfWvcUG+nQ9ny0OWzHUvsvrYFZM4+4/xy
        mXPrYy1oVhtB7eB8SNptwN41YRAOC1hE1e0gyXhs5MCj1HeknU9JjpNJVBXp+U0OFrgta4zDohz5C
        vU+mnN1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZb6V-001ORE-Mq; Wed, 30 Mar 2022 16:23:27 +0000
Date:   Wed, 30 Mar 2022 17:23:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm/vmscan: introduce helper function
 reclaim_page_list()
Message-ID: <YkSD/2g75i/v2VMW@casper.infradead.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-4-linmiaohe@huawei.com>
 <YkMOrjhxkqMx45Es@casper.infradead.org>
 <4880f7de-625c-1d93-3b65-81f6c849de7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4880f7de-625c-1d93-3b65-81f6c849de7b@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:04:54AM +0800, Miaohe Lin wrote:
> On 2022/3/29 21:50, Matthew Wilcox wrote:
> >> +	while (!list_empty(page_list)) {
> >> +		page = lru_to_page(page_list);
> >> +		list_del(&page->lru);
> >> +		putback_lru_page(page);
> > 
> > Why wouldn't you use a folio here?
> > 
> 
> I was just wanting to keep the code consistent with the previous one. Am I supposed to
> use a folio here ? If so, will do it in V2.

The distinction we're trying to make (and obviously we have a long way
to go before we're finished) is between the structure that describes
PAGE_SIZE bytes of memory and the structure that manages the memory
allocation.  This function is clearly handling the entire memory
allocation, so it should be using a folio.  Eventually, page->lru
should disappear, but there's 180 places to figure out what we need to
do instead.

