Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F74E3D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiCVLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiCVLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:07:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A86B098
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:06:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id r1so13384337qvr.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuSL+QxMbS0U0QUndRwl6D2gxTmGSO+ZRxuEuZ/Ya3o=;
        b=dk43yL4/ZQ0sR2tqOcbXgprBWl5VD3ZIPW5KMvzxKWYp/9NxAHWNTh/jc2G05OpZ5F
         8dU/PY3xTCIH0vgGpDKw0/pHCJKsigNU2gTwBn4u+t8URbifSzMzzVZoLFPG96t4jTL1
         fOhJg5fR2/mdZQXpUbOTWSMTnbmaA3WRlaFGqkTzmS46JA+cao4t66cIRphNiTrRxs2+
         rEKZWVXIYSaExXeK14L8uPz8WSbtReYWvhooy/p64o/9w+LYOt4zPy2zK6w3xadXMsJy
         xzdoEyI4U6Bz5f2Vhs+GqMrPqOWYEoy9N7w8hS9cMkVRdzd7sjIGrXgwfU6YP6u3IHjG
         XG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuSL+QxMbS0U0QUndRwl6D2gxTmGSO+ZRxuEuZ/Ya3o=;
        b=WHp/fVfseqMR3xvBtwfnGvnmeX1fnBZGc0ebRfCByj4pS8EAGRiOCDiNIK9KzVObiv
         PK1t/6gmhBjgIFLKBFXFZSCsrM4pgKauHqbv3i3KfQ4bsR4wL+wL8G7WZ6UUXVjWkHrm
         c+rmG6VjDsI9lhZG8zPCdWMhN3KAxHgWdQrTHzhUNewQqeChlBJTWiEO19EDfBEKs/s4
         B0VHqqRE9cmnID1nY+ZLz1Vl87RYmx6HUPa1/qqqNDuaGIhJWiC21LmhUxxMhpKsbTHd
         Yx/LCAp/PlQRh2/3zBF9AEXqc3XM4053ps3UiMhiuXGTaPeXcubBdYmjsGpTz2EKNl7l
         HdKA==
X-Gm-Message-State: AOAM530sDLHT52bt00uWp5W8dcHq2FpGlhM+8WzXxPOD9zB5SHm9kdOs
        j6+65fvyD866CuB4QbbwP80=
X-Google-Smtp-Source: ABdhPJzEipQGfEX0E/yScKf40M4KhluyIvmkv7Y4h6TidcHPBlm8r0YXn4rVVut1u3n94y5GhnbmAA==
X-Received: by 2002:a0c:f70d:0:b0:441:4558:b70c with SMTP id w13-20020a0cf70d000000b004414558b70cmr1657348qvn.82.1647947187250;
        Tue, 22 Mar 2022 04:06:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm14284668qtx.58.2022.03.22.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:06:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     bsingharora@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] delayacct: track delays from COW
Date:   Tue, 22 Mar 2022 11:04:45 +0000
Message-Id: <20220322110444.2340748-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Delay accounting does not track the delay of COW. When tasks trigger
much COW, it may spend a amount of time waiting for it. To get the
impact of tasks in COW, measure the delay when it happens. This
could help users to do tunnings, such as decide whether to use
ksm or not.

Also update tools/accounting/getdelays.c:

    / # ./getdelays -dl -p 231
    print delayacct stats ON
    listen forever
    PID     231

    CPU             count     real total  virtual total    delay total  delay average
                     6247     1859000000     2154070021     1674255063          0.268ms
    IO              count    delay total  delay average
                        0              0              0ms
    SWAP            count    delay total  delay average
                        0              0              0ms
    RECLAIM         count    delay total  delay average
                        0              0              0ms
    THRASHING       count    delay total  delay average
                        0              0              0ms
    COMPACT         count    delay total  delay average
                        3          72758              0ms
    COW             count    delay total  delay average
                     3635      271567604              0ms

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/delayacct.h      | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/taskstats.h |  6 +++++-
 kernel/delayacct.c             | 16 ++++++++++++++++
 mm/memory.c                    |  8 ++++++++
 tools/accounting/getdelays.c   |  8 +++++++-
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6b16a6930a19..89b202c695d3 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -45,9 +45,13 @@ struct task_delay_info {
 	u64 compact_start;
 	u64 compact_delay;	/* wait for memory compact */
 
+	u64 cow_start;
+	u64 cow_delay;	/* wait for cow */
+
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
 	u32 compact_count;	/* total count of memory compact */
+	u32 cow_count;	/* total count of cow */
 };
 #endif
 
@@ -75,6 +79,8 @@ extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
 extern void __delayacct_compact_start(void);
 extern void __delayacct_compact_end(void);
+extern void __delayacct_cow_start(void);
+extern void __delayacct_cow_end(void);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -191,6 +197,24 @@ static inline void delayacct_compact_end(void)
 		__delayacct_compact_end();
 }
 
+static inline void delayacct_cow_start(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_cow_start();
+}
+
+static inline void delayacct_cow_end(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_cow_end();
+}
+
 #else
 static inline void delayacct_init(void)
 {}
@@ -225,6 +249,10 @@ static inline void delayacct_compact_start(void)
 {}
 static inline void delayacct_compact_end(void)
 {}
+static inline void delayacct_cow_start(void)
+{}
+static inline void delayacct_cow_end(void)
+{}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 12327d32378f..cfb9a2e0e95a 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	11
+#define TASKSTATS_VERSION	12
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -176,6 +176,10 @@ struct taskstats {
 	/* Delay waiting for memory compact */
 	__u64	compact_count;
 	__u64	compact_delay_total;
+
+	/* Delay waiting for cow */
+	__u64	cow_count;
+	__u64	cow_delay_total;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 2c1e18f7c5cf..c9a833270fe0 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -177,11 +177,14 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
 	tmp = d->compact_delay_total + tsk->delays->compact_delay;
 	d->compact_delay_total = (tmp < d->compact_delay_total) ? 0 : tmp;
+	tmp = d->cow_delay_total + tsk->delays->cow_delay;
+	d->cow_delay_total = (tmp < d->cow_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
 	d->thrashing_count += tsk->delays->thrashing_count;
 	d->compact_count += tsk->delays->compact_count;
+	d->cow_count += tsk->delays->cow_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -249,3 +252,16 @@ void __delayacct_compact_end(void)
 		      &current->delays->compact_delay,
 		      &current->delays->compact_count);
 }
+
+void __delayacct_cow_start(void)
+{
+	current->delays->cow_start = local_clock();
+}
+
+void __delayacct_cow_end(void)
+{
+	delayacct_end(&current->delays->lock,
+		      &current->delays->cow_start,
+		      &current->delays->cow_delay,
+		      &current->delays->cow_count);
+}
diff --git a/mm/memory.c b/mm/memory.c
index 4499cf09c21f..4111f97c91a0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3006,6 +3006,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	int page_copied = 0;
 	struct mmu_notifier_range range;
 
+	delayacct_cow_start();
+
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 
@@ -3030,6 +3032,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			put_page(new_page);
 			if (old_page)
 				put_page(old_page);
+
+			delayacct_cow_end();
 			return 0;
 		}
 	}
@@ -3128,12 +3132,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			free_swap_cache(old_page);
 		put_page(old_page);
 	}
+
+	delayacct_cow_end();
 	return page_copied ? VM_FAULT_WRITE : 0;
 oom_free_new:
 	put_page(new_page);
 oom:
 	if (old_page)
 		put_page(old_page);
+
+	delayacct_cow_end();
 	return VM_FAULT_OOM;
 }
 
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 11e86739456d..0f6e4831a77b 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -207,6 +207,8 @@ static void print_delayacct(struct taskstats *t)
 	       "THRASHING%12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n"
 	       "COMPACT  %12s%15s%15s\n"
+	       "      %15llu%15llu%15llums\n"
+	       "COW   %15s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n",
 	       "count", "real total", "virtual total",
 	       "delay total", "delay average",
@@ -234,7 +236,11 @@ static void print_delayacct(struct taskstats *t)
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->compact_count,
 	       (unsigned long long)t->compact_delay_total,
-	       average_ms(t->compact_delay_total, t->compact_count));
+	       average_ms(t->compact_delay_total, t->compact_count),
+	       "count", "delay total", "delay average",
+	       (unsigned long long)t->cow_count,
+	       (unsigned long long)t->cow_delay_total,
+	       average_ms(t->cow_delay_total, t->cow_count));
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.25.1

