Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0D49FA92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349141AbiA1NUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348727AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFB8C061755
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=RZET6KbJQW7VW1QW9ZpHlj8GvOwKrY4N8XGYpxkjsRk=;
 b=lg7mwIi1UUybUJbUCaCkKGLFeyjCzcgmEUUUtMqA2m435D54fPR9BuFNzrtW1IzZHziPP
 IZmxP4OfpkTNZIZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=RZET6KbJQW7VW1QW9ZpHlj8GvOwKrY4N8XGYpxkjsRk=;
 b=I5CUBm8DMAq9QhQZuDTlz8HPE2GIJe8Pl3qJLv9+aAuCuvlUoLHPmQcQy4o+btcgoFyJW
 3Y7vobYfMEpLBYKSi+cUmMCTZmiDcDl9/0RST+kJVyF9iQstS//R4caHv/PgITt2zBu5Yqr
 Gbf03b8Kb9YrDIUKGUSbIFHu7CjsWATo32dn+aB5Kn4rvTcVkILtwbJNea7ub2Yc6ff0esG
 y0U2jbBv910miMShGu4zYhfJNj6ssvqdDUaNOZfYyHezMQlfu9JyzcjMlEooD06liuQ1w+G
 iP51OphoqkfoVswBHn3l8LMgiQgbkAt1EBXgCT9AJwbLwtb4u87lUpO7PAIw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 34E4D160AAF;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 116CF20561; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 25/35] mm: add mmu_notifier_trylock() and mmu_notifier_unlock()
Date:   Fri, 28 Jan 2022 05:09:56 -0800
Message-Id: <20220128131006.67712-26-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new functions are to be used when firing MMU notifications
without holding any of the mmap or rmap locks, as is the case with
speculative page fault handlers.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mmu_notifier.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index ace76fe91c0c..d0430410fdd8 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -772,4 +772,29 @@ static inline void mmu_notifier_synchronize(void)
 
 #endif /* CONFIG_MMU_NOTIFIER */
 
+#if defined(CONFIG_MMU_NOTIFIER) && defined(CONFIG_SPECULATIVE_PAGE_FAULT)
+
+static inline bool mmu_notifier_trylock(struct mm_struct *mm)
+{
+	return percpu_down_read_trylock(mm->mmu_notifier_lock);
+}
+
+static inline void mmu_notifier_unlock(struct mm_struct *mm)
+{
+	percpu_up_read(mm->mmu_notifier_lock);
+}
+
+#else
+
+static inline bool mmu_notifier_trylock(struct mm_struct *mm)
+{
+	return true;
+}
+
+static inline void mmu_notifier_unlock(struct mm_struct *mm)
+{
+}
+
+#endif
+
 #endif /* _LINUX_MMU_NOTIFIER_H */
-- 
2.20.1

