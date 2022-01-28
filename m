Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9097349FA83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348898AbiA1NTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:30 -0500
Received: from server.lespinasse.org ([63.205.204.226]:37829 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348517AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=PMJHeJsdyCtcxmhvT1hkJdcSx4UXS3jkGHIYYcslNmc=;
 b=DE7JPUDN+5KEWQTiOjalJIcy92ZNfeEc8SEWgHr0RVYH5eatrZM7nrSmUqyMCL/n2mmYI
 SK140SxEgrzfZLtAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=PMJHeJsdyCtcxmhvT1hkJdcSx4UXS3jkGHIYYcslNmc=;
 b=M5ntAzna6rTFurGazsaqcxoyi+L0bXjLH2rIvjqudwJrJwL9WMXjOY0I7laiC7fX5MTFl
 4/JUz0rzpcvK2f1Qk9XffCcqKNRdjGE1yIZK80CA/13QQHFQst3yIdWO5xixiFhEuHaqC9C
 fNRUPAANLj5n6Jge03J2/6fCAr99RzpHiq/AgiQIpwTkLg3RXi8xes0CczjsIfwuGA0GC6f
 8bQBaTbAZEhkvAUANfnaSMig99mgjzQCRYKJB9KxgAWRDKHbH7J7OtIugqfa2NaoNaCONmC
 HJwVnzfD9CFvkxrtcthuve1OoGhywt0zPAzhIIUs5sF4WNhbkHFuaxFr7gPw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id EC614160964;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id D6C6320472; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 08/35] mm: add FAULT_FLAG_SPECULATIVE flag
Date:   Fri, 28 Jan 2022 05:09:39 -0800
Message-Id: <20220128131006.67712-9-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the new FAULT_FLAG_SPECULATIVE flag, which indicates when we are
attempting speculative fault handling (without holding the mmap lock).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..7f7aa3f0a396 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -461,7 +461,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_SPECULATIVE,	"SPECULATIVE" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9db36dc5d4cf..0ae3bf854aad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -790,6 +790,7 @@ typedef struct {
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_SPECULATIVE: The fault is handled without holding the mmap lock.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -821,6 +822,7 @@ enum fault_flag {
 	FAULT_FLAG_REMOTE =		1 << 7,
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+	FAULT_FLAG_SPECULATIVE =	1 << 10,
 };
 
 #endif /* _LINUX_MM_TYPES_H */
-- 
2.20.1

