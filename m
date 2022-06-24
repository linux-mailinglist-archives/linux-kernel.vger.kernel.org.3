Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA05599F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiFXMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFXMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:54:38 -0400
Received: from outbound-smtp11.blacknight.com (outbound-smtp11.blacknight.com [46.22.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0816625A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:54:36 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 093D31C3BC0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:54:35 +0100 (IST)
Received: (qmail 6834 invoked from network); 24 Jun 2022 12:54:34 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 24 Jun 2022 12:54:34 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v5 00/7] Drain remote per-cpu directly
Date:   Fri, 24 Jun 2022 13:54:16 +0100
Message-Id: <20220624125423.6126-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the existing version on mm-unstable. While there are
some fixes, this is mostly refactoring of patch 5 based on Vlastimil's
feedback to reduce churn in later patches. The level of refactoring made
-fix patches excessively complicated.

Changelog since v4
o Fix lockdep issues in patch 7
o Refactor patch 5 to reduce churn in patches 6 and 7
o Rebase to 5.19-rc3

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
lists. The local_lock on its own prevents migration and the IRQ disabling
protects from corruption due to an interrupt arriving while a page
allocation is in progress.

This series adjusts the locking.  A spinlock is added to struct
per_cpu_pages to protect the list contents while local_lock_irq is
ultimately replaced by just the spinlock in the final patch.  This allows
a remote CPU to safely. Follow-on work should allow the spin_lock_irqsave
to be converted to spin_lock to avoid IRQs being disabled/enabled in
most cases. The follow-on patch will be one kernel release later as it
is relatively high risk and it'll make bisections more clear if there
are any problems.

Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
	and when it is storing per-cpu pages.

Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
	this is not necessary but it avoids per_cpu_pages consuming another
	cache line.

Patch 3 is a preparation patch to avoid code duplication.

Patch 4 is a minor correction.

Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
	relying on local_lock to prevent migration, stabilise the pcp
	lookup and prevent IRQ reentrancy.

Patch 6 remote drains per-cpu pages directly instead of using a workqueue.

Patch 7 uses a normal spinlock instead of local_lock for remote draining

Nicolas Saenz Julienne (1):
  mm/page_alloc: Remotely drain per-cpu lists

 include/linux/mm_types.h |   5 +
 include/linux/mmzone.h   |  12 +-
 mm/page_alloc.c          | 386 ++++++++++++++++++++++++---------------
 3 files changed, 250 insertions(+), 153 deletions(-)

-- 
2.35.3

