Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117D5520B30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiEJCc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiEJCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:32:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070D31A8E3A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qVEOoGsIlooEpfnjcilZ8EKGRE3sSWxS4g1FKGjMuzQ=; b=sghlFxVgp9mMCsYDnyEhX8rGzt
        pODjDgmXBMdUHve+PBFiy6rLDIwmRC08E6XgoQc1VWp8FNzeGJyrZNtGAVmRkEyWLM3AhW/GUjKiw
        PAlqx3UV0l+rmimlsEHElHfBjndfPCLoHgEdjQSq/0ZJ3K+hyOmuRuWRXv0JOfbgCVAKq3hFopcWR
        uHntW3bn3MuaAZjzMyiE4/igsw9Ak6Ym13OPF9Z+csD2dH2FL2n/otj5ZLFAj7oawg3onTPKjbY3i
        /8GifdJP/gsGEMfqQXHlh6vozZOEfKVst+IzMfXe6rsO1dBDqlp8AUJyGIPHKPd5DVYx3Tdnlvaoc
        jDBWdb9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noFbZ-004177-LN; Tue, 10 May 2022 02:28:05 +0000
Date:   Tue, 10 May 2022 03:28:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Message-ID: <YnnNteG8+V6dTNna@casper.infradead.org>
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 02:32:20PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> The following VM_BUG_ON_FOLIO() is triggered when memory error event
> happens on the (thp/folio) pages which are about to be freed:

So the real problem is that we're calling dump_page() when we don't
have a reference to the page, right?  Otherwise it wouldn't be freed.

>  out:
>  	if (ret == -EIO)
> -		dump_page(p, "hwpoison: unhandlable page");
> +		pr_err("Memory failure: %#lx: unhandlable page.\n", page_to_pfn(p));

It would be nice to get some more information out of the page than that
,.. but taking a refcount inside dump_page() conflicts with the other
"would be nice", which is for dump_page() to take a const struct page *
so we can (eg) make folio_test_uptodate() take a const struct folio *.

We've had some other problems with inconsistent pages being printed in
dump_page().  It can be quite confusing when debugging.  I still don't
have a good solution to that either.

I do have a proposal for reforming mapcount which will solve this
particular problem, but I'm not quite sure when I'll get to it.
This patch is probably the best thing to do for now.
