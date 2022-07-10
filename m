Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF956D601
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiGKHK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiGKHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:09:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04010B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:08:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z1so3715329plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gadZ2vlA0vhG8v4UXRsB+M5kKIdI90uIBWjUdQuHTNc=;
        b=D5MgeewHNkpkpqDDGFH3D80y0Da/7tBDDUUtBY0dz+iSjWpsLsHib/uFA8dZ4NSr+M
         lFWnI+v3sWNqFBp9F761RtlFHl6/obN4DUkTE+nhabIQ30fIfV+4R43ptqfiFyNeti1c
         oJPELdFS6UJy3HwUlfVEd7BzB5GnTHE618HCcaG+ldnoeD+Z/sMAjVXbueiehq0/0fHq
         UIiZtNWXfrRp6y8cRvFBcbEmT6hy+/f02iG4/Hfz+migmqhSGMThOJhJLsgnaQY7wOs5
         D9eU+zxxJQch59qxvc1EcAUyFYeSAcdTTLJmjqQWqOUCidQwrve+/03xHbrQMPVsXrxV
         sH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gadZ2vlA0vhG8v4UXRsB+M5kKIdI90uIBWjUdQuHTNc=;
        b=1m2yS1z7c26h7I95PZeaB+3GjGleDICUJGk/fGweuwsLeD/evP+OnaDGD63HUz5iNq
         BSZVdX8HHCowQOx1/YrsSpu5xKo3yHntPyk90D8JROr0/U28ImxyAvM5DgvSl5HtDi3r
         rqVJ8OM95qZdLiZrNZeJq+zRArpZ1BNoHbQnU8QGAEPbGwrKhNB+Qjn93QoC6oN9TQTt
         oXjgYT5TQCeg7JifrSSTugJv7JNHcP+O+ZK3e5ugvXs6CRtzUUx/Skjr8Vaz6xNKhCe/
         hIuGQ4zN3eIwZmeknnIoDmFX/Jn4I2hS2z6mP/ev/bctgm2efQ4zg1S/s8X2dQ3GcBOQ
         zC+Q==
X-Gm-Message-State: AJIora/YUvFGYQp1Rvje8NnvtU+fXgam0nzQzdnveZrJsXpV3UJ3zx2j
        wREJYTrtJ7wC/1MD5fgxY/G/2xTqbRQ=
X-Google-Smtp-Source: AGRyM1vkch1kARi9+43efKCVChFZNhmprUPtukujgVbk1oomBgpudfZ208drnPRfnRXj5F25t/VQOQ==
X-Received: by 2002:a17:90a:4704:b0:1ef:f369:bd0e with SMTP id h4-20020a17090a470400b001eff369bd0emr15844315pjg.20.1657523318876;
        Mon, 11 Jul 2022 00:08:38 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o65-20020a625a44000000b0052ac99c2c1csm1945705pfb.83.2022.07.11.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:08:38 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/mm/tlb: Skip tracing when flush is not done
Date:   Sun, 10 Jul 2022 16:33:55 -0700
Message-Id: <20220710233355.4066-1-namit@vmware.com>
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
 arch/x86/mm/tlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0f346c51dd99..5c17b86b928d 100644
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
@@ -871,7 +871,6 @@ static void flush_tlb_func(void *info)
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
 
 	/* Tracing is done in a unified manner to reduce the code size */
-done:
 	trace_tlb_flush(!local ? TLB_REMOTE_SHOOTDOWN :
 				(f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN :
 						  TLB_LOCAL_MM_SHOOTDOWN,
-- 
2.25.1

