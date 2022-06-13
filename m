Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3067C549A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiFMRdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbiFMRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:32:41 -0400
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019D554BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:56:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 9C80EBAAA9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:56:33 +0100 (IST)
Received: (qmail 27785 invoked from network); 13 Jun 2022 12:56:33 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 13 Jun 2022 12:56:33 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 00/7] Drain remote per-cpu directly
Date:   Mon, 13 Jun 2022 13:56:15 +0100
Message-Id: <20220613125622.18628-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
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

This replaces the existing version on mm-unstable. The biggest difference
is replacing local_lock entirely which is the last patch. The other changes
are minor fixes reported by Hugh and Vlastimil.

Changelog since v3
o Checkpatch fixes from mm-unstable					(akpm)
o Replace local_lock with spinlock					(akpm)
o Remove IRQ-disabled check in free_unref_page_list as it triggers
  a false positive							(hughd)
o Take an unlikely check out of the rmqueue fast path			(vbabka)

Some setups, notably NOHZ_FULL CPUs, may be running realtime or
latency-sensitive applications that cannot tolerate interference due to
per-cpu drain work queued by __drain_all_pages().  Introduce a new
mechanism to remotely drain the per-cpu lists. It is made possible by
remotely locking 'struct per_cpu_pages' new per-cpu spinlocks.  This has
two advantages, the time to drain is more predictable and other unrelated
tasks are not interrupted.

This series has the same intent as Nicolas' series "mm/page_alloc: Remote
per-cpu lists drain support" -- avoid interference of a high priority task
due to a workqueue item draining per-cpu page lists.  While many workloads
can tolerate a brief interruption, it may cause a real-time task running
on a NOHZ_FULL CPU to miss a deadline and at minimum, the draining is
non-deterministic.

Currently an IRQ-safe local_lock protects the page allocator per-cpu
lists.  The local_lock on its own prevents migration and the IRQ disabling
protects from corruption due to an interrupt arriving while a page
allocation is in progress.

This series adjusts the locking.  A spinlock is added to struct
per_cpu_pages to protect the list contents while local_lock_irq is
ultimately replaced by just the spinlock in the final patch.  This allows
a remote CPU to safely. Follow-on work should allow the local_irq_save
to be converted to a local_irq to avoid IRQs being disabled/enabled in
most cases.

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

Patch 7 uses a normal spinlock instead of local_lock for remote draining

 include/linux/mm_types.h |   5 +
 include/linux/mmzone.h   |  12 +-
 mm/page_alloc.c          | 404 ++++++++++++++++++++++++---------------
 3 files changed, 266 insertions(+), 155 deletions(-)

-- 
2.35.3

