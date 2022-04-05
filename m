Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06714F4A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455015AbiDEWj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357413AbiDELQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:16:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B813CDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:43:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF62F1F390;
        Tue,  5 Apr 2022 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649155422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZV6J9Il753rBNuhU1RPeVKSIez37U0dfz5W2smwY0X4=;
        b=eb00yWHMq9w1ZkkiXOQR2T4sGf+wUVynhUp66A9hY0CVxtite1vGwNZ6BPzb1UlU2BL28d
        wTKf5ISHxuLw0xTrZeVg13mSC3JyfTO62/IGZv0f6GZutjtwNLvkg41UFt8cdhdaPGNu6A
        Jc6p/QZRaGS1QklGnXhx3JQS5q7ylDc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 95D3EA3B93;
        Tue,  5 Apr 2022 10:43:42 +0000 (UTC)
Date:   Tue, 5 Apr 2022 12:43:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mm: swap: locking in release_pages()
Message-ID: <YkwdRnuQBjoJ01YK@dhcp22.suse.cz>
References: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-04-22 12:20:15, Alexander Sverdlin wrote:
> Dear mm developers!
> 
> After experiencing a crash in release_pages() [1] I'm trying to understand the locking in the release_pages():
> 
> No matter if we consider v5.17 or v5.4 (as in my case), they both have similar locking patterns:

Similar but the notable difference is that 5.4 used per node lru locking
while newer versions 5.11+ kernels use per memcg locking. If you see the
issue on 5.4 then this is unlikely a regression.
[...]
> What I don't understand here is, what guarantees us that "if (PageLRU(page))" condition
> is still valid after we swap the locks in "if (pgdat != locked_pgdat)" case?

The underlying reasoning is that the PageLRU handling is done after the
last reference has been dropped. isolate_lru_page and others should
elevate the reference count before isolating page from LRU lists.
Some callers user TestClearPageLRU

> If we check under one lock and VM_BUG_ON_PAGE() under another lock, what actually stops
> it from crashing as below or BUG() from time to time?
G

> 
> 1. Crash of v5.4.170 on an ARM32 machine:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000104
> pgd = e138149d
> [00000104] *pgd=84d2fd003, *pmd=8ffd6f003
> Internal error: Oops: a07 [#1] PREEMPT SMP ARM
> ...
> CPU: 1 PID: 6172 Comm: AaSysInfoRColle Tainted: G    B      O      5.4.170-... #1
> Hardware name: Keystone
> PC is at release_pages+0x194/0x358
> LR is at release_pages+0x10c/0x358

Which LOC does this correspond to? (faddr2line should give you a nice
output).
-- 
Michal Hocko
SUSE Labs
