Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF23487479
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiAGJGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:06:10 -0500
Received: from foss.arm.com ([217.140.110.172]:37346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236746AbiAGJGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:06:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D45A13A1;
        Fri,  7 Jan 2022 01:06:06 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.72.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EA6E3F774;
        Fri,  7 Jan 2022 01:06:02 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Drop unused trace events hugepage_[invalidate|splitting]
Date:   Fri,  7 Jan 2022 14:35:51 +0530
Message-Id: <1641546351-15109-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace events hugepage_[invalidate|splitting], were added via the commit
9e813308a5c1 ("powerpc/thp: Add tracepoints to track hugepage invalidate").
Afterwards their call sites i.e trace_hugepage_[invalidate|splitting] were
just dropped off, leaving these trace points unused.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.16-rc8

trace_hugepage_splitting() dropped via the commit 7aa9a23c69ea
trace_hugepage_invalidate() dropped via the commit 7900757ce1b4

 include/trace/events/thp.h | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
index d7fbbe551841..ffa4b37d02a9 100644
--- a/include/trace/events/thp.h
+++ b/include/trace/events/thp.h
@@ -8,24 +8,6 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(hugepage_invalidate,
-
-	    TP_PROTO(unsigned long addr, unsigned long pte),
-	    TP_ARGS(addr, pte),
-	    TP_STRUCT__entry(
-		    __field(unsigned long, addr)
-		    __field(unsigned long, pte)
-		    ),
-
-	    TP_fast_assign(
-		    __entry->addr = addr;
-		    __entry->pte = pte;
-		    ),
-
-	    TP_printk("hugepage invalidate at addr 0x%lx and pte = 0x%lx",
-		      __entry->addr, __entry->pte)
-);
-
 TRACE_EVENT(hugepage_set_pmd,
 
 	    TP_PROTO(unsigned long addr, unsigned long pmd),
@@ -65,24 +47,6 @@ TRACE_EVENT(hugepage_update,
 
 	    TP_printk("hugepage update at addr 0x%lx and pte = 0x%lx clr = 0x%lx, set = 0x%lx", __entry->addr, __entry->pte, __entry->clr, __entry->set)
 );
-TRACE_EVENT(hugepage_splitting,
-
-	    TP_PROTO(unsigned long addr, unsigned long pte),
-	    TP_ARGS(addr, pte),
-	    TP_STRUCT__entry(
-		    __field(unsigned long, addr)
-		    __field(unsigned long, pte)
-		    ),
-
-	    TP_fast_assign(
-		    __entry->addr = addr;
-		    __entry->pte = pte;
-		    ),
-
-	    TP_printk("hugepage splitting at addr 0x%lx and pte = 0x%lx",
-		      __entry->addr, __entry->pte)
-);
-
 #endif /* _TRACE_THP_H */
 
 /* This part must be outside protection */
-- 
2.25.1

