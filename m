Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EA4F816C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbiDGOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiDGOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:20:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9365156204
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iveGK1/Yuor96D4y10ufJ6G2Pghx6MVtRSQWDI/71jg=; b=Lau3m21l6fe80P7yOEfaJmxZIM
        Woq6nDA/hd61xO6MJxvkRU+zcJo2Ms/KlRHAaYEGaB1bf4t10T8POdWQxLt1TnCjyvBhtDs9YHKbJ
        cqZwDKgZHWLGfCkUSkwers4k8vzmUsLl7+HJnZ6mLI/Xm8q26rG2kj9+68OAAnhdrijztYaWk+0mm
        Lv+32woMRaSAwAzPaD/bHBFbuuMtcd4hWjOwaqxnRhubGdwvunbnXXIz0CywFvQmBT+ywTc9nnKGk
        KY7/gXQ1SfzNlA52cae4Yb35ywZdAlh/jr3jEY6oSL4PVJayJgHYrrePRS+GE1G6umuxmbw3DKe/4
        QjEOJAbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncSwx-008uHX-3R; Thu, 07 Apr 2022 14:17:27 +0000
Date:   Thu, 7 Apr 2022 15:17:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix kernel NULL pointer dereference in
 page_vma_mapped_walk
Message-ID: <Yk7yd5ho2a7jWNfS@casper.infradead.org>
References: <20220407064008.71869-1-pizhenwei@bytedance.com>
 <Yk7tIi4UKjiqQyoF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk7tIi4UKjiqQyoF@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:54:42PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 07, 2022 at 02:40:08PM +0800, zhenwei pi wrote:
> > size_to_hstate(4K) returns NULL pointer, this leads kernel BUG in
> > function page_vma_mapped_walk.
> 
> Yes, I think this is the right fix.  It's not immediately obvious from
> the bug and the patch, but what's going on is:
> 
> page_mapped_in_vma() sets nr_pages to 1.  This is correct because we
> usually only want to know about the precise page, and not about the
> folio containing it.  But hugetlbfs is special (... in so many ways ...)
> and actually wants to work on the entire folio.  We could set nr_pages
> specially for hugetlb pages, but it's better to ignore it in
> page_vma_mapped_walk() for the hugetlb case.
> 
> I'll fix up the changelog and add it to my pile of fixes that I'm
> sending tomorrow.
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next

I looked over the patch in context, and realised we now don't need to
call size_to_hstate since we're getting the hstate from the VMA.

https://git.infradead.org/users/willy/pagecache.git/commitdiff/98ea02597b9967c0817d29fee2f96d21b9e59ca5

