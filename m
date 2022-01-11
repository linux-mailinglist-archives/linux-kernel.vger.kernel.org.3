Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E548AF71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiAKOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:23:04 -0500
Received: from shark1.inbox.lv ([194.152.32.81]:42170 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241320AbiAKOXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:23:02 -0500
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id 9691A1118111;
        Tue, 11 Jan 2022 16:23:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1641910980; bh=B3zsr1uon94rGfrYjljVprXCVNZ2sigVuz8YLB4vUUA=;
        h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
         Content-Type:X-ESPOL:from:date;
        b=JK87VbXvkOz1CYeEvjisnByo3iRn6ANTTZf6nyRROSoGK+1vUzuoM1wQI6qTP8TjL
         0rS+Sc7zZEeS+eyUSupsICe/9A3Xun9amhUMAWH+sW6n2hSK7vYMih5merlhaAB2AR
         4Xk2wDn2nf9h/x0aDl+19LheJtAcw5tTcXFa5SfY=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 8F78E11180F5;
        Tue, 11 Jan 2022 16:23:00 +0200 (EET)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id y1a1K5F5vyMK; Tue, 11 Jan 2022 16:23:00 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 09BF311180EC;
        Tue, 11 Jan 2022 16:23:00 +0200 (EET)
Date:   Tue, 11 Jan 2022 23:22:48 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>, hakavlad@gmail.com
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <20220111232248.1629f794@mail.inbox.lv>
In-Reply-To: <YdxSUuDc3OC4pe+f@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
        <20220104202227.2903605-7-yuzhao@google.com>
        <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
        <YdjOazilBEkdUT7x@google.com>
        <YdxSUuDc3OC4pe+f@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38cmnBBsMa9Lpgfme6kmZavLzouui7kz70193NHtLHdwK14EgqJeffiGwWl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I do not really see any arguments why an userspace based trashing
> detection cannot be used for those.

Firsly,
because this is the task of the kernel, not the user space. 
Memory is managed by the kernel, not by the user space. 
The absence of such a mechanism in the kernel is a fundamental problem.
The userspace tools are ugly hacks:
some of them consume a lot of CPU [1], 
some of them consume a lot of memory [2], 
some of them cannot into process_mrelease() (earlyoom, nohang), 
some of them kill only the whole cgroup (systemd-oomd, oomd) [3]
and depends on systemd and cgroup_v2 (oomd, systemd-oomd).
One of the biggest challenges for userspace oom-killers is to potentially
function under intense memory pressure and are prone to getting stuck in
memory reclaim themselves [4].

It is strange that after decades of user complaints about thrashing and
not-working OOM killer I have to explain the obvious things.
The basic mechanism must be implemented in the kernel.
Stop shifting responsibility to the user space!

Secondly,
the real reason for the min_ttl_ms mechanism is that without it, 
multi-minute stalls are possible [5] even when the killer is expected to
arrive, and memory pressure is closed to 100 at this period [6].
This fixes a bug that does not exist in the mainline LRU (this is
MGLRU-specific bug). BTW, the similar symptoms were recently fixed in the
mainline [7].

[1] https://github.com/facebookincubator/oomd/issues/79
[2] https://github.com/hakavlad/nohang#memory-and-cpu-usage
[3] https://github.com/facebookincubator/oomd/issues/125
[4] https://lore.kernel.org/all/CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com/
[5] https://github.com/zen-kernel/zen-kernel/issues/223
[6] https://raw.githubusercontent.com/hakavlad/cache-tests/main/mg-LRU-v3_vs_classic-LRU/3-firefox-tail-OOM/mg-LRU-1/psi2
[7] https://lore.kernel.org/linux-mm/20211202150614.22440-1-mgorman@techsingularity.net/

[I am duplicating a previous message here - it was not delivered to mailing lists]
