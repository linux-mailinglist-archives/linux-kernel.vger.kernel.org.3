Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD20C56BC37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiGHOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiGHOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:45:47 -0400
Received: from outbound-smtp59.blacknight.com (outbound-smtp59.blacknight.com [46.22.136.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2865A47A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:44:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp59.blacknight.com (Postfix) with ESMTPS id BE235FA77D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:44:08 +0100 (IST)
Received: (qmail 14303 invoked from network); 8 Jul 2022 14:44:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jul 2022 14:44:08 -0000
Date:   Fri, 8 Jul 2022 15:44:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm/page_alloc: replace local_lock with normal spinlock -fix
 -fix
Message-ID: <20220708144406.GJ27531@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcpu_spin_unlock and pcpu_spin_unlock_irqrestore both unlock
pcp->lock and then enable preemption. This lacks symmetry against
both the pcpu_spin helpers and differs from how local_unlock_* is
implemented. While this is harmless, it's unnecessary and it's generally
better to unwind locks and preemption state in the reverse order as
they were acquired.

This is a fix on top of the mm-unstable patch
mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 934d1b5a5449..d0141e51e613 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -192,14 +192,14 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 
 #define pcpu_spin_unlock(member, ptr)					\
 ({									\
-	spin_unlock(&ptr->member);					\
 	pcpu_task_unpin();						\
+	spin_unlock(&ptr->member);					\
 })
 
 #define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
 ({									\
-	spin_unlock_irqrestore(&ptr->member, flags);			\
 	pcpu_task_unpin();						\
+	spin_unlock_irqrestore(&ptr->member, flags);			\
 })
 
 /* struct per_cpu_pages specific helpers. */
