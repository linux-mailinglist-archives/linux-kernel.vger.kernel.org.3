Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80411467931
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381372AbhLCOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:16:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhLCOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:16:39 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3FB1F1FD3C;
        Fri,  3 Dec 2021 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638540794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YuUZJgfai8aZBSYulx5eyhjnGiU4iwqWBDGtGmY3Ows=;
        b=Vx5k4E6Dt3aM8OuP9h6yqyuBbGglcfKrIpf+8dpkEYQCKNdIUSLqI2yEHS69Uz5fPy9LOa
        R8nKFuAyeYuadcNqM3bkKRjPWXwR1A/5WRBqRdL/Qm28D4DlB4CjijQxJrnwZJu6e/I8kP
        rJLajlqbjRpGOr3re1nbj0qbDpwxZSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638540794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YuUZJgfai8aZBSYulx5eyhjnGiU4iwqWBDGtGmY3Ows=;
        b=UXGFi8yNmmX1K5YTMXm8Wn1utZgUQf5L2Yrt5lo/ylLk0EIqLWrkvG3k1NrvJ4KOdVdxCB
        859Fu9S0veXzrECg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8AFCDA3B85;
        Fri,  3 Dec 2021 14:13:13 +0000 (UTC)
Date:   Fri, 3 Dec 2021 14:13:06 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mtosatti@redhat.com, nilal@redhat.com,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Remotely drain per-cpu lists
Message-ID: <20211203141306.GG3301@suse.de>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
 <20211103170512.2745765-4-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211103170512.2745765-4-nsaenzju@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 06:05:12PM +0100, Nicolas Saenz Julienne wrote:
> Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
> drain work queued by __drain_all_pages(). So introduce new a mechanism
> to remotely drain the per-cpu lists. It is made possible by remotely
> locking 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this
> new scheme is that drain operations are now migration safe.
> 
> There was no observed performance degradation vs. the previous scheme.
> Both netperf and hackbench were run in parallel to triggering the
> __drain_all_pages(NULL, true) code path around ~100 times per second.
> The new scheme performs a bit better (~5%), although the important point
> here is there are no performance regressions vs. the previous mechanism.
> Per-cpu lists draining happens only in slow paths.
> 

netperf and hackbench are not great indicators of page allocator
performance as IIRC they are more slab-intensive than page allocator
intensive. I ran the series through a few benchmarks and can confirm
that there was negligible difference to netperf and hackbench.

However, on Page Fault Test (pft in mmtests), it is noticable. On a
2-socket cascadelake machine I get

pft timings
                                 5.16.0-rc1             5.16.0-rc1
                                    vanilla    mm-remotedrain-v2r1
Amean     system-1         27.48 (   0.00%)       27.85 *  -1.35%*
Amean     system-4         28.65 (   0.00%)       30.84 *  -7.65%*
Amean     system-7         28.70 (   0.00%)       32.43 * -13.00%*
Amean     system-12        30.33 (   0.00%)       34.21 * -12.80%*
Amean     system-21        37.14 (   0.00%)       41.51 * -11.76%*
Amean     system-30        36.79 (   0.00%)       46.15 * -25.43%*
Amean     system-48        58.95 (   0.00%)       65.28 * -10.73%*
Amean     system-79       111.61 (   0.00%)      114.78 *  -2.84%*
Amean     system-80       113.59 (   0.00%)      116.73 *  -2.77%*
Amean     elapsed-1        32.83 (   0.00%)       33.12 *  -0.88%*
Amean     elapsed-4         8.60 (   0.00%)        9.17 *  -6.66%*
Amean     elapsed-7         4.97 (   0.00%)        5.53 * -11.30%*
Amean     elapsed-12        3.08 (   0.00%)        3.43 * -11.41%*
Amean     elapsed-21        2.19 (   0.00%)        2.41 * -10.06%*
Amean     elapsed-30        1.73 (   0.00%)        2.04 * -17.87%*
Amean     elapsed-48        1.73 (   0.00%)        2.03 * -17.77%*
Amean     elapsed-79        1.61 (   0.00%)        1.64 *  -1.90%*
Amean     elapsed-80        1.60 (   0.00%)        1.64 *  -2.50%*

It's not specific to cascade lake, I see varying size regressions on
different Intel and AMD chips, some better and worse than this result.
The smallest regression was on a single CPU skylake machine with a 2-6%
hit. Worst was Zen1 with a 3-107% hit.

I didn't profile it to establish why but in all cases the system CPU
usage was much higher. It *might* be because the spinlock in
per_cpu_pages crosses a new cache line and it might be cold although the
penalty seems a bit high for that to be the only factor.

Code-wise, the patches look fine but the apparent penalty for PFT is
too severe.

-- 
Mel Gorman
SUSE Labs
