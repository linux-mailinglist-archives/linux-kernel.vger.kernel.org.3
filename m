Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51B51FD89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiEINMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiEINMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:12:14 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E923F3A1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:08:18 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id ED95DFA78E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:08:16 +0100 (IST)
Received: (qmail 17402 invoked from network); 9 May 2022 13:08:16 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 9 May 2022 13:08:16 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/6] Drain remote per-cpu directly v2
Date:   Mon,  9 May 2022 14:07:59 +0100
Message-Id: <20220509130805.20335-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Fix unsafe RT locking scheme
o Use spin_trylock on UP PREEMPT_RT

This series has the same intent as Nicolas' series "mm/page_alloc: Remote
per-cpu lists drain support" -- avoid interference of a high priority
task due to a workqueue item draining per-cpu page lists. While many
workloads can tolerate a brief interruption, it may be cause a real-time
task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
the draining in non-deterministic.

Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
The local_lock on its own prevents migration and the IRQ disabling protects
from corruption due to an interrupt arriving while a page allocation is
in progress. The locking is inherently unsafe for remote access unless
the CPU is hot-removed.

This series adjusts the locking. A spinlock is added to struct
per_cpu_pages to protect the list contents while local_lock_irq continues
to prevent migration and IRQ reentry. This allows a remote CPU to safely
drain a remote per-cpu list.

This series is a partial series. Follow-on work should allow the
local_irq_save to be converted to a local_irq to avoid IRQs being
disabled/enabled in most cases. Consequently, there are some TODO comments
highlighting the places that would change if local_irq was used. However,
there are enough corner cases that it deserves a series on its own
separated by one kernel release and the priority right now is to avoid
interference of high priority tasks.

Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
	and when it is storing per-cpu pages.

Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
	this is not necessary but it avoids per_cpu_pages consuming another
	cache line.

Patch 3 is a preparation patch to avoid code duplication.

Patch 4 is a simple micro-optimisation that improves code flow necessary for
	a later patch to avoid code duplication.

Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
	relying on local_lock to prevent migration, stabilise the pcp
	lookup and prevent IRQ reentrancy.

Patch 6 remote drains per-cpu pages directly instead of using a workqueue.

 include/linux/mm_types.h |   5 +
 include/linux/mmzone.h   |  12 +-
 mm/page_alloc.c          | 342 +++++++++++++++++++++++++--------------
 3 files changed, 230 insertions(+), 129 deletions(-)

-- 
2.34.1

