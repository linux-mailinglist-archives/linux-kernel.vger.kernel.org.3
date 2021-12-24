Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4343C47EE91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352567AbhLXL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352570AbhLXL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:28:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA328C061401;
        Fri, 24 Dec 2021 03:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UTCfNQCyD438ho5mZD1blh1IBvxHi5tE4tHPn0hLp3E=; b=eL5+U1RLNxQPkfIlwi7NLwFY7O
        LACU7hyCMnJFWPZ6OpfMTz4gpv4N4xJ+ptyMN9utDwAY1Nv4WzqEGtG7RvFdLw+UVwbTLre8yCOpG
        QBbuMJfdiq8WSfernbtc/LXIWVcLc85AfDdK24OSChsV5LohL86n76FQ1tZc9CwympvKLursS3Rd2
        X/q1YBEDsiMxm8BWVUjYGuFw1ElBS+nWS+EydesrTOrKVO0VHdaEL+/Qo4/MUGOZDsyiORfmXC+EO
        ce44XgnzzQjcDLINOiAjEkSrW1MSPSp7daap/5VKF/QP5QTySEZ8tHraMsikSYmIWQkhInGcF4dH3
        egE4a4XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0ijp-0053YJ-3h; Fri, 24 Dec 2021 11:27:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B31B30018A;
        Fri, 24 Dec 2021 12:27:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40DE620CF2F6A; Fri, 24 Dec 2021 12:27:50 +0100 (CET)
Date:   Fri, 24 Dec 2021 12:27:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YcWutpu7BDeG+dQ2@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214205358.701701555@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 09:44:48PM +0100, Peter Zijlstra wrote:

> The big assumption this whole thing is build on is that
> pin_user_pages() preserves user mappings in so far that
> pagefault_disable() will never generate EFAULT (unless the user does
> munmap() in which case it can keep the pieces).
> 
> shrink_page_list() does page_maybe_dma_pinned() before try_to_unmap()
> and as such seems to respect this constraint.
> 
> unmap_and_move() however seems willing to unmap otherwise pinned (and
> hence unmigratable) pages. This might need fixing.

AFAICT this should mostly do,.. I still need to check if
get_user_pages_fast() is itself sufficient to avoid all races or if we
need to strengthen/augment that too.

---
 mm/migrate.c  | 10 +++++++++-
 mm/mprotect.c |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00f03c8..3850b33c64eb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1472,7 +1472,15 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			nr_subpages = thp_nr_pages(page);
 			cond_resched();
 
-			if (PageHuge(page))
+			/*
+			 * If the page has a pin then expected_page_refs() will
+			 * not match and the whole migration will fail later
+			 * anyway, fail early and preserve the mappings.
+			 */
+			if (page_maybe_dma_pinned(page))
+				rc = -EAGAIN;
+
+			else if (PageHuge(page))
 				rc = unmap_and_move_huge_page(get_new_page,
 						put_new_page, private, page,
 						pass > 2, mode, reason,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 9a105fce5aeb..093db725d39f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -105,6 +105,12 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				if (page_is_file_lru(page) && PageDirty(page))
 					continue;
 
+				/*
+				 * Can't migrate pinned pages, avoid touching them.
+				 */
+				if (page_maybe_dma_pinned(page))
+					continue;
+
 				/*
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.

