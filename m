Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2F4EAE24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiC2NKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiC2NKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:10:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9F5F99
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wpco1Q/eEi8aY7+QQt48HMppPX+YBcw1colLd/STuVk=; b=Xjh5zsk14IxefscN8QozLeefcE
        hInBviNQnC99d/BzMZ2+cu+ZqSOFnM0lCj4+z8dJW0PnOuRawxL3sF3k/rfKiFb9tAWKgfCQQ/RKX
        G7wuZfgOxUiU/ynQJdRyvdoRbCWp3sitcXyPm4vAIDz79F9iw+cCHNuUz8QL7wwrc1WCoTfp8CL7B
        4M+HvY1/7v0p4rKtrh4xm8sKsr16AvGSgaiku4cAzXH1zKz1NTFRUairi2wpfVTJsGdKGRpWGWY00
        67JUpZ/VqDnhAx9W3GDOXfUq1FatC1j6FL/uR3O3UD2fBU10QbftfdXLlTpqRbHmW9QzIBno85iqY
        FGM8Lutg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZBaC-000Ilg-K8; Tue, 29 Mar 2022 13:08:24 +0000
Date:   Tue, 29 Mar 2022 14:08:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/2] mm: fix contiguous memmap assumptions about
 alloc/free pages
Message-ID: <YkMEyH9QB8MyzW37@casper.infradead.org>
References: <20220329130928.266323-1-chenwandun@huawei.com>
 <20220329130928.266323-3-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329130928.266323-3-chenwandun@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:09:28PM +0800, Chen Wandun wrote:
> +#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))

Could we avoid reintroducing page_nth()?  It is a terrible name.

> @@ -1213,7 +1213,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
>  		ret = 0;
>  		goto out;
>  	}
> -	switch (page - head_page) {
> +	switch (page_nth(head_page, page)) {
>  	case 1:
>  		/* the first tail page: ->mapping may be compound_mapcount() */
>  		if (unlikely(compound_mapcount(page))) {

This is the only place you use it.  I'd suggest free_tail_pages_check()
should take 'i' as its second parameter instead of 'page + i', then
there's no need to convert back to i.
