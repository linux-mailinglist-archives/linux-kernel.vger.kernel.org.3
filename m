Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8449FA84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348899AbiA1NTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:32 -0500
Received: from server.lespinasse.org ([63.205.204.226]:48735 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=DmGgYXIxuiNl6v6cMRPQigMIgjtXtbGpaAKFRJYhv/I=;
 b=GDRiMZ9S0azV2Kn+iE+ZKlmXOxOZS3W4CUWO2Lkt9Jj7y0ZoRy+qf3ZSGPIvMindJ9Gyz
 LoMV0lL00tULmr4DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=DmGgYXIxuiNl6v6cMRPQigMIgjtXtbGpaAKFRJYhv/I=;
 b=L6qKz8mphs/6Uaryogzhb4PKZ5qz9HjmJQd+AZeOj1NOq9q5tybwmX0BNHaFxsV5/DXz6
 0MGNbCfUxasUG+9tMD+dPkuI8Jk+6YyvkqYg+bnKJ5g7ynn0d4IQz6bRWASZuLEvx5kNene
 fF6zuzmUfbqPSDrnVqLWp8KF6vK0r9yHlgH2Po92eGQPFK/ewtkz/3kXsu5goMvFClEV7Qy
 mDtoB3MYnR+xH7P1zYg8BQWDJ1flAwNafjNvoUx+q7k6oBniGmVuEcm2f98ca9PERRtme62
 HgZYhvNQ9vue4+4h5skh1rMhkUq7ET6b0rZzg/Uur0ZxGrp9Rlz+1KSmgjdQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id E651116095D;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id D12602044E; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 06/35] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Date:   Fri, 28 Jan 2022 05:09:37 -0800
Message-Id: <20220128131006.67712-7-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the code needed to
handle speculative page fault.

This is enabled by default on supported architectures with SMP and MMU set.

The architecture support is needed since the speculative page fault handler
is called from the architecture's page faulting code, and some code has to
be added there to try speculative fault handling first.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..d304fca0f293 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -894,4 +894,26 @@ config ANON_VMA_NAME
 
 source "mm/damon/Kconfig"
 
+config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
+       def_bool n
+
+config SPECULATIVE_PAGE_FAULT
+	bool "Speculative page faults"
+	default y
+	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT && MMU && SMP
+	help
+	  Try to handle user space page faults without holding the mmap lock.
+
+	  Instead of blocking writers through the use of mmap lock,
+	  the page fault handler merely verifies, at the end of the page
+	  fault, that no writers have been running concurrently with it.
+
+	  In high concurrency situations, the speculative fault handler
+	  gains a throughput advantage by avoiding having to update the
+	  mmap lock reader count.
+
+	  If the check fails due to a concurrent writer, or due to hitting
+	  an unsupported case, the fault handler falls back to classical
+	  processing using the mmap read lock.
+
 endmenu
-- 
2.20.1

