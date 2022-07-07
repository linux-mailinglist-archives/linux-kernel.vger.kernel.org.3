Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF656A2E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiGGMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiGGMxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:53:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD312AEA;
        Thu,  7 Jul 2022 05:53:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e132so18341849pgc.5;
        Thu, 07 Jul 2022 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6cy31AaJrTdKl6fL2izFIU+5DjlDJpwVJm+i/nQovk=;
        b=Mw3+dLRsJC4e2NjNnGQ8GZOx403oBXgVn6D1eOVIPJvFVXSstetmEFSbhCsb8HhlUC
         RlYn7D6eaSp23TCtgAseziG3X2fBxSxj/39P0MOym+L5HtgW9NP205q+66DGL96v0D3T
         ax26+bD4qvd4oR1OL+ozcEEn1+ljrNCCrDgavzO5MPWV1M1qBltdfHBkH8PjOSffajyZ
         dVYRaWYd9aqqRewQYbslFTOUilBFaNa2ISPQGBDdGDTpOwl0lLRHqv8Ih/U0EMKeqQZ0
         FmDeMiJs6n5MEiTa7rdcqpxrIRo3gb6+O9Bu6NkgNEBjZ5M5bnaQiQCQRDeNV160o+WQ
         reog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6cy31AaJrTdKl6fL2izFIU+5DjlDJpwVJm+i/nQovk=;
        b=AaqjVPVqxELIr8Ai/rchRQO07j+mEiVkTV9Z6Dl3ql72t4eO+R+GF7+mbfleQMaQrW
         oOrb/a85RhmMClQHIUyDEmSTroGjcSOf/vT0oeqltlSTBDjKTHmcTHAuiFihidM/nuF9
         Tf9YOaA3VOtTBSFUeFFSusKl+TTIh0myUkrF04Cuqo+tAvken6f3tOsQc9NDHwNNIKZH
         /a699rLOL7VyRMrKdHw/yLiYPqw3lglC0f4TnOc53l9nL7+iWy+gfrEDDHLSOt5wMX8h
         ux6BhNWlzeV0a87YFJaeQfFTLCwvyOF7lroeJK6CuDyaqxPevCo9fx3GThGt3yu7b/72
         F+Cw==
X-Gm-Message-State: AJIora/W7jqO9aBMc0i1Gjgq8+YPU0j2vVRl1LePTjBvg/xDDLcanxIo
        Yrl6OhhWZr9DFo8su8RDXbc=
X-Google-Smtp-Source: AGRyM1sF8g/5GPUGhwsID/TrPiRGfdyrAfdsWsMgLol9kbQ1rpat6WTfw2GLXYGMztMfhQ8sIIIhaw==
X-Received: by 2002:a63:6d4c:0:b0:414:ec27:2c87 with SMTP id i73-20020a636d4c000000b00414ec272c87mr1348336pgc.495.1657198413868;
        Thu, 07 Jul 2022 05:53:33 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b0016a3b5a46f0sm27907831pln.241.2022.07.07.05.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:53:33 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH 4/4] arm64: support batched/deferred tlb shootdown during page reclamation
Date:   Fri,  8 Jul 2022 00:52:42 +1200
Message-Id: <20220707125242.425242-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125242.425242-1-21cnbao@gmail.com>
References: <20220707125242.425242-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <v-songbaohua@oppo.com>

on x86, batched and deferred tlb shootdown has lead to 90%
performance increase on tlb shootdown. on arm64, HW can do
tlb shootdown without software IPI. But sync tlbi is still
quite expensive.

Even running a simplest program which requires swapout can
prove this is true,
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>

 int main()
 {
 #define SIZE (1 * 1024 * 1024)
         volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);

         memset(p, 0x88, SIZE);

         for (int k = 0; k < 10000; k++) {
                 /* swap in */
                 for (int i = 0; i < SIZE; i += 4096) {
                         (void)p[i];
                 }

                 /* swap out */
                 madvise(p, SIZE, MADV_PAGEOUT);
         }
 }

Perf result on snapdragon 888 with 8 cores by using zRAM
as the swap block device.

 ~ # perf record taskset -c 4 ./a.out
 [ perf record: Woken up 10 times to write data ]
 [ perf record: Captured and wrote 2.297 MB perf.data (60084 samples) ]
 ~ # perf report
 # To display the perf.data header info, please use --header/--header-only options.
 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 60K of event 'cycles'
 # Event count (approx.): 35706225414
 #
 # Overhead  Command  Shared Object      Symbol
 # ........  .......  .................  .............................................................................
 #
    21.07%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irq
     8.23%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
     6.67%  a.out    [kernel.kallsyms]  [k] filemap_map_pages
     6.16%  a.out    [kernel.kallsyms]  [k] __zram_bvec_write
     5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
     3.71%  a.out    [kernel.kallsyms]  [k] _raw_spin_lock
     3.49%  a.out    [kernel.kallsyms]  [k] memset64
     1.63%  a.out    [kernel.kallsyms]  [k] clear_page
     1.42%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock
     1.26%  a.out    [kernel.kallsyms]  [k] mod_zone_state.llvm.8525150236079521930
     1.23%  a.out    [kernel.kallsyms]  [k] xas_load
     1.15%  a.out    [kernel.kallsyms]  [k] zram_slot_lock

ptep_clear_flush() takes 5.36% CPU in the micro-benchmark
swapping in/out a page mapped by only one process. If the
page is mapped by multiple processes, typically, like more
than 100 on a phone, the overhead would be much higher as
we have to run tlb flush 100 times for one single page.
Plus, tlb flush overhead will increase with the number
of CPU cores due to the bad scalability of tlb shootdown
in HW, so those ARM64 servers should expect much higher
overhead.

Further perf annonate shows 95% cpu time of ptep_clear_flush
is actually used by the final dsb() to wait for the completion
of tlb flush. This provides us a very good chance to leverage
the existing batched tlb in kernel. The minimum modification
is that we only send async tlbi in the first stage and we send
dsb while we have to sync in the second stage.

With the above simplest micro benchmark, collapsed time to
finish the program decreases around 5%.

Typical collapsed time w/o patch:
 ~ # time taskset -c 4 ./a.out
 0.21user 14.34system 0:14.69elapsed
w/ patch:
 ~ # time taskset -c 4 ./a.out
 0.22user 13.45system 0:13.80elapsed

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/features/vm/TLB/arch-support.txt |  2 +-
 arch/arm64/Kconfig                             |  1 +
 arch/arm64/include/asm/tlbbatch.h              | 12 ++++++++++++
 arch/arm64/include/asm/tlbflush.h              | 13 +++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/tlbbatch.h

diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 1c009312b9c1..2caf815d7c6c 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..e94913a0b040 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -93,6 +93,7 @@ config ARM64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/arm64/include/asm/tlbbatch.h b/arch/arm64/include/asm/tlbbatch.h
new file mode 100644
index 000000000000..fedb0b87b8db
--- /dev/null
+++ b/arch/arm64/include/asm/tlbbatch.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARCH_ARM64_TLBBATCH_H
+#define _ARCH_ARM64_TLBBATCH_H
+
+struct arch_tlbflush_unmap_batch {
+	/*
+	 * For arm64, HW can do tlb shootdown, so we don't
+	 * need to record cpumask for sending IPI
+	 */
+};
+
+#endif /* _ARCH_ARM64_TLBBATCH_H */
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 412a3b9a3c25..b3ed163267ca 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -272,6 +272,19 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
+					struct mm_struct *mm,
+					struct vm_area_struct *vma,
+					unsigned long uaddr)
+{
+	flush_tlb_page_nosync(vma, uaddr);
+}
+
+static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+	dsb(ish);
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.25.1

