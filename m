Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D951D570EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiGLAgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGLAgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:36:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A83C8F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:36:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9876955pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WAek49bBLKkEe+owxVCfCub6H+seciPz++KKwv+pX/8=;
        b=QDw+FfNDyyo7ET4Yu6iVaWbAg7q7ADy3JRspXKlrjaWn4rW+kjvwl3M9GBsptsk0Dd
         pZX+NXWQXVQfhEgdkLv4nTSsGEjDUz6cBQ5BVm+Uir17aJT0eLwLGl03G1Tj5kwF5B4X
         hXIUESZLOkKYsa2A5MAWwBVnysAZSQvQ1bz8vhAK/XBUcrdwBrRPduPZPZT5KUjHTRsx
         ZH1m47BHO+5ECbo2cazzS2xbRLgv4WxteXUgav804PfV+dscEqDa2bysI3RCPyT4ALgg
         9zZkKm1KXPZsckkyOzAUoVxyUM5aKeu2KdmLIdDZ6oHEvH0j2B81td2UyEo6MRJZ25n3
         enig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WAek49bBLKkEe+owxVCfCub6H+seciPz++KKwv+pX/8=;
        b=B8tc+6MwtSEMzF/LFu3lx1WoKSHCRbH5V5Td7SSH6g9jPgAb1s1sZe3L1qpRwySeRc
         819xxdp6md5jGKSa72yvrpCDhZdBmPnUGtOxS7badFPvsf5vHX5Hd/ZjB/B6CawZ7hS2
         jomnq6yr1Oksg1Qbmr0LAcFjVLlOhib30heXTi4O9C8xThZODFh09WhlMsLlAIVghOLa
         pND/3mj3m64+Df5m8ciKW5ua4DJ51PURFMSp9nCfhBOiduUQIm173uXF+ggpo4YplSEx
         ay3lv4oFC8v5kq6FxV9rcZP0PHXXGw9VhYNgWYf0BGr6XWiSNHEKI/KiXvWAUv817fq1
         gpqg==
X-Gm-Message-State: AJIora+BTTh+4uW3bR7FrJcWnw9shw2HxTkvujU7eHOEMwgX/RJpxwf5
        +Wb86sRNWh5hh3IxuS57wOQ=
X-Google-Smtp-Source: AGRyM1ugPCkcRJ13KLoZL3PklL8129Ta2OlycUJbNj+aX35eV5I5+1+gCdFt7k7PWpiPss34srfJrw==
X-Received: by 2002:a17:902:ce05:b0:16c:2a1:c335 with SMTP id k5-20020a170902ce0500b0016c02a1c335mr21404368plg.5.1657586170126;
        Mon, 11 Jul 2022 17:36:10 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001635b86a790sm5337867plk.44.2022.07.11.17.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:36:09 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] x86/mm/tlb: Skip tracing when flush is not done
Date:   Mon, 11 Jul 2022 10:01:43 -0700
Message-Id: <20220711170143.2996-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Currently, if flush_tlb_func() does not flush for some reason, the
tracing of the flush will be done only in certain cases, depending on
the reason of the flush. Be consistent and just do not trace in all
cases when the flush was eventually not done.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

v1->v2:
* Remove comment [Andy]
---
 arch/x86/mm/tlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0f346c51dd99..f012445f6d94 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -736,7 +736,7 @@ static void flush_tlb_func(void *info)
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
 	bool local = smp_processor_id() == f->initiating_cpu;
-	unsigned long nr_invalidate = 0;
+	unsigned long nr_invalidate;
 	u64 mm_tlb_gen;
 
 	/* This code cannot presently handle being reentered. */
@@ -795,7 +795,7 @@ static void flush_tlb_func(void *info)
 		 * be handled can catch us all the way up, leaving no work for
 		 * the second flush.
 		 */
-		goto done;
+		return;
 	}
 
 	WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
@@ -870,8 +870,6 @@ static void flush_tlb_func(void *info)
 	/* Both paths above update our state to mm_tlb_gen. */
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
 
-	/* Tracing is done in a unified manner to reduce the code size */
-done:
 	trace_tlb_flush(!local ? TLB_REMOTE_SHOOTDOWN :
 				(f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN :
 						  TLB_LOCAL_MM_SHOOTDOWN,
-- 
2.25.1

