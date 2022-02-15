Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF34B7AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbiBOW5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:57:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244711AbiBOW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:57:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E130D4CBA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lxDxiH7YdaguzLVLUSqqsB5d4iEpIHEpukWCHc1REm0=; b=EelEfSfmJZSj7jPR8xdrytLvOv
        vvUegttSQBNXTCISxTbXxPrmJ3ijUCphVHjWXzE5fzvUSjXjgspgCUuw/AooGJM3x20gIF2JvPJCV
        Gr7jF/6+VPXHTn5p6oQYvOOdahT4NrKPvmxVpYH9NobncBN9rut7BziYG9r9sb8oOrGxy9XBaXXIw
        lopSMV62eX5PhZgVOKfGsWjasY9ZBEuxFoA9uyQ5zoLd3Yw2uPBDcikP8sjKIweQuXrki7JmYHalt
        vJCwUxPIlS2v6dDqrKb0d4JKpxhOoVKrCGPHuRudPQBuWKe6sTGs3YVuOVr8AS7BIFdxRsIWKQdW/
        hq8pA/JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK6kL-00EEoo-QD; Tue, 15 Feb 2022 22:56:33 +0000
Date:   Tue, 15 Feb 2022 22:56:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/13] mm/munlock: mlock_page() munlock_page() batch
 by pagevec
Message-ID: <YgwvoaJj5BqpMOiR@casper.infradead.org>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
 <1abb94ee-fe72-dba9-3eb0-d1e576d148e6@google.com>
 <YgvXjwapRTOXQOuQ@casper.infradead.org>
 <ef1e285c-187a-f682-a62b-c6a0f42b5cbf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1e285c-187a-f682-a62b-c6a0f42b5cbf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:02:30PM -0800, Hugh Dickins wrote:
> On Tue, 15 Feb 2022, Matthew Wilcox wrote:
> > > +#define mlock_new(page) ((struct page *)((unsigned long)page + NEW_PAGE))
> > 
> > I'm going to change this to:
> > 
> > static inline struct page *mlock_lru(struct page *page)
> > {
> > 	return (struct page *)((unsigned long)page + LRU_PAGE);
> > }
> > 
> > (mutatis mutandi for mlock_new)
> 
> Okay, thanks.  (You're not naming your folio "page" :-?)

Worse, I tried passing it '&folio->page'.  That produced some ...
interesting compiler error messages.
