Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523914C821D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiCAETY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiCAETX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:19:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D52E0C1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kWYz8Vj6+e73fhwY2HejnGDpRm1xZpM7chYm13xZiRE=; b=Mj0eHI4ii7CLrujUOqvCZpyP/0
        50SRuyQxPPqqWWCcpOI57nW9WFI0+TnRPYh9h5+l4RExlWtuO3W2axrsFhuLS+4bAFb0jk+FybZqw
        oZC0B2tIj/EMc7smzUjQ6TQNmPYIZ0kCijjX+VZs3psXAgRB9SDprtoCDoYRL3SEN3snzzvgiyWCB
        29ZGyoT5nkep3iz6jKKhFd1jf58Ij1Jos7KrBWGym5F04rilKPkatuKWYb+r5G5Sozzr6lV4SgjVL
        VzOIz+4DU60lEcCjHzgWYho4RM6CSNyvCgcAqV500T7+Kq6SW09QaeIO1og49p8qjw3fAaYTJZKkf
        s9tjnIxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOty9-009E6R-Jl; Tue, 01 Mar 2022 04:18:37 +0000
Date:   Tue, 1 Mar 2022 04:18:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] mm/thp: fix collapse_file()'s try_to_unmap(folio,)
Message-ID: <Yh2enUcd2AMP4gq4@casper.infradead.org>
References: <3f187b6c-e5e8-e66d-e0c0-7455ca6abb4c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f187b6c-e5e8-e66d-e0c0-7455ca6abb4c@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 06:22:47PM -0800, Hugh Dickins wrote:
> The foliation of THP collapse_file()'s call to try_to_unmap() is
> currently wrong, crashing on a test in rmap_walk() when xas_next()
> delivered a value (after which page has been loaded independently).

Argh.  I have a fear of this exact bug, and I must have missed checking
for it this time.  I hate trying to keep two variables in sync, so my
preferred fix for this is to remove it for this merge window:

+++ b/mm/khugepaged.c
@@ -1699,8 +1699,7 @@ static void collapse_file(struct mm_struct *mm,
 
        xas_set(&xas, start);
        for (index = start; index < end; index++) {
-               struct folio *folio = xas_next(&xas);
-               struct page *page = &folio->page;
+               struct page *page = xas_next(&xas);
 
                VM_BUG_ON(index != xas.xa_index);
                if (is_shmem) {
@@ -1835,7 +1834,8 @@ static void collapse_file(struct mm_struct *mm,
                }
 
                if (page_mapped(page))
-                       try_to_unmap(folio, TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
+                       try_to_unmap(page_folio(page),
+                                       TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
 
                xas_lock_irq(&xas);
                xas_set(&xas, index);

(ie revert the first hunk).  I'll come back to khugepaged in the next
merge window and convert this function properly.  It's going to take
some surgery to shmem in order to use folios there first ...
