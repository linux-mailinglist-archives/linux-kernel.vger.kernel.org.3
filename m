Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5108548AB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiAKKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:25:10 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:36826 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237737AbiAKKZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:25:09 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id CA769C01C2;
        Tue, 11 Jan 2022 12:25:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1641896705; bh=VRwkhrPflUcUAwu4sRDNMn5rSRlD5FjXnGFErmqRxs8=;
        h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
         Content-Type:X-ESPOL:from:date;
        b=XR79L/Uygzf+mK1tEAn+kgVGjXvysfxJUNY3sSDQNZ69Fuqp8rWadpeFdNnKZDqhN
         YMrnnrLK/PvU5vUATpWqqjK1xP20CyFUcTrcWKEpkDzjHbS+nmjsgd5G94UpSdeokr
         0KZ5MgsmBEtF0rZKxiHP8SB4FTLc9yxH+XbEBdTg=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id BBAFEC0187;
        Tue, 11 Jan 2022 12:25:05 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 5wbv1OlHIic4; Tue, 11 Jan 2022 12:25:05 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 55137C00FC;
        Tue, 11 Jan 2022 12:25:05 +0200 (EET)
Date:   Tue, 11 Jan 2022 19:24:51 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org, hakavlad@gmail.com
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <20220111192451.1a853019@mail.inbox.lv>
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38cmnBBsMa9Lpgfme6kmZavNCkuvyHmvc49ixdFz9PMtNdrcW+QBYXxGwCl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some of my benchmarks MGLRU really gave unrivaled performance.
I assume the adoption of MGLRU into the kernel would save billions of
dollars and greatly reduce carbon dioxide emissions.

However, there are also cases where MGLRU loses.
There are cases where MGLRU does not achieve the performance that the
classic LRU gives (at least I got such results when testing MGLRU before[1],
but I did not report them here).

As a Linux user, I would like to see both variants of LRU in the kernel, so
that it is possible to switch to the suitable variant when needed: none of
the LRU variants allowed me to squeeze the maximum for all cases.

I hope to test MGLRU v6 later and show you some of its weaknesses and
anomalies with specific logs and benchmarks. 

[1] I didn't have enough time and energy to decipher the results at that time:
    https://github.com/hakavlad/cache-tests/tree/main/mg-LRU-v3_vs_classic-LRU
    (but you can try to guess what it all means)

