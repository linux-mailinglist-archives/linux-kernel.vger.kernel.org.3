Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBE49FA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349027AbiA1NT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:59 -0500
Received: from server.lespinasse.org ([63.205.204.226]:45043 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348670AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=N1bCyCqlqCPmn3u4dr/qGIvPJEOlMd8KVKMJcaELgEw=;
 b=GcBReqmwDZ82aVnHS0hCCWXYruQ1qrdcFPqUv1QkU6UoqgPLM+nRmvNS0Y8AYDNay6K1/
 WrF/45/SfCMN4X4Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=N1bCyCqlqCPmn3u4dr/qGIvPJEOlMd8KVKMJcaELgEw=;
 b=0fIaqi5/e6TyDkW5DpsQrirQBlbVLQ6vD67HM9rQxnG/ldkbMS/1aO1AiQET+/+D1Wxp3
 Vo3HWduaw/24aWGBGAOG7sRUAqxQa9gvY5TqSrmEIbhtiNXIFrxZzvVmTqly4Issy95x4JZ
 XpUoZZcE5SnkHhoHB10UfCAVkkVE2c9veNH+HcRiGCIJE7VAJr7oiNuou1QLzhuQ9Algvkf
 igQLboMXPIsg3bvd3gxPJfjO6ges3d0MKFpLCjlXZt+yUAlXlhwjVP8IkEAW9tPE7bRVYLM
 kP474IHw4IXNCpCJ02BnlHqMo47/ZINoDZlC8r5J6BYzN2BgvHhe5CoZbTdA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 33BE8160AAE;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 19D0820FB1; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 28/35] mm: disable speculative faults for single threaded user space
Date:   Fri, 28 Jan 2022 05:09:59 -0800
Message-Id: <20220128131006.67712-29-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance tuning: single threaded userspace does not benefit from
speculative page faults, so we turn them off to avoid any related
(small) extra overheads.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6ba109413396..d6f8d4967c49 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1328,6 +1328,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 #endif
 
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	/*
+	 * No need to try speculative faults for kernel or
+	 * single threaded user space.
+	 */
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
 	count_vm_event(SPF_ATTEMPT);
 	seq = mmap_seq_read_start(mm);
 	if (seq & 1)
@@ -1362,7 +1369,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 spf_abort:
 	count_vm_event(SPF_ABORT);
-#endif
+no_spf:
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 	/*
 	 * Kernel-mode access to the user address space should only occur
-- 
2.20.1

