Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309AD495204
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376866AbiATQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347042AbiATQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:09:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EAEC061574;
        Thu, 20 Jan 2022 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=P7lCKswW2dVYa2ibcKWxMvFcXeaAwTyHA88lMKA84Q0=; b=v7q1B2c2V4kGj/vOH2Qdqb5AKJ
        76RBDZVgd7MjqInz8C+SyL+O21TLFjpBnB9bDU/iIQKKOTGFfhHqTFJQeo46nd2QuEF5OuO1/5Q5P
        IGmCd8OOQR8jn8YWkYEHjoXkIRAz84a4V+M3tRHG8NcV0UYLjLBXBK5Pi5eozySrqtnGkVsHvGYlh
        ziR8vby2lcAhDf3TwpHJdzZYUaiSL6rXPgAHcBf9/eGxduU9+ombCT4go8+vnMznRoTnlU5IuWXjU
        qFuD1HIRpWpXIj8zQxq2sy+iM4gdh9HCQxCeLbZ5kJc34VhIVjrACnOK+XK3wWkXotFLdOqNnbMsD
        k4D9FEiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZza-00EQ4H-3u; Thu, 20 Jan 2022 16:08:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB9AC3004AD;
        Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8F83120291FE3; Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Message-ID: <20220120160822.666778608@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Jan 2022 16:55:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
References: <20220120155517.066795336@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a guarantee for Anon pages that pin_user_page*() ensures the
user-mapping of these pages stay preserved. In order to ensure this
all rmap users have been audited:

 vmscan:	already fails eviction due to page_maybe_dma_pinned()

 migrate:	migration will fail on pinned pages due to
		expected_page_refs() not matching, however that is
		*after* try_to_migrate() has already destroyed the
		user mapping of these pages. Add an early exit for
		this case.

 numa-balance:	as per the above, pinned pages cannot be migrated,
		however numa balancing scanning will happily PROT_NONE
		them to get usage information on these pages. Avoid
		this for pinned pages.

None of the other rmap users (damon,page-idle,mlock,..) unmap the
page, they mostly just muck about with reference,dirty flags etc.

This same guarantee cannot be provided for Shared (file) pages due to
dirty page tracking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/migrate.c  |   10 +++++++++-
 mm/mprotect.c |    6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1472,7 +1472,15 @@ int migrate_pages(struct list_head *from
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
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -106,6 +106,12 @@ static unsigned long change_pte_range(st
 					continue;
 
 				/*
+				 * Can't migrate pinned pages, avoid touching them.
+				 */
+				if (page_maybe_dma_pinned(page))
+					continue;
+
+				/*
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */


