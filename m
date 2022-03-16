Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488354DB18F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbiCPNgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbiCPNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:36:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519454704D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:34:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s8so3888674pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FFUC79IimSnK/DZVddYsmMD3YBmhcKxrgWlWwNvz/c=;
        b=mBW9zvH4keJLen3B6/V50s5wCVcTUC+Irf+5Y7w51p+/8+56fLNv/RW39CsmQcpW+F
         5tTUnb3BW7VrdH7ry3kHBq0WxfNLtPFW/lmYip7YdAJuwnr6Vvo9JvDB3mC+y0LZ6dqf
         r1bf2gZTIs7A5eIXhxcwUtIP9e9GuOxHgUdebWY7atYRpw0YHLCPeekZVuxDdo8yHEaG
         iaXbuh69kf11ODVaY2TTo+Uitfw8eIsTpXweIzDTN5/Gc6teB9wcLrPWydio+yETIzcn
         a9cdEnBhSoDBQRPAJiQlObHMnvmk7/YfPvH+3yrV/j3JFxUXIepMZc4lttZ/ncHbAvvc
         D67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FFUC79IimSnK/DZVddYsmMD3YBmhcKxrgWlWwNvz/c=;
        b=sfrHZxPn+sX4FPQK+uYImA2Zr8Kf3R10JxwxGGeMC5WwUQGoL3uHAxX/G36yNrrfXZ
         9VtUmeWXMR4AqMCLN/dPRYeamoAjwRdLPU0FVKNTV1FW/B4BGhpzYFjY9/6fxYo6I4M2
         Yvsejp+vqsUItkWlXMLeavLfDH03qMu+JrwYkyCAw0YWsH2eDJnGoMdLpYFxt2eEexb5
         tN5Zpytv4TIUHtQNs0O6f/EvHoIiKSE8I4oN0UEJGEhPDrFOt3QM1fDpdVvItb8uibcT
         jnEeyHI/l5+qV4yJ/qKMWlZJkJTLmL2+18CTXF5eVDbUpUUqrIbVB5zi185uAM7dMnUN
         paBQ==
X-Gm-Message-State: AOAM530KQBxOTd8bn05hBJawwyBHZARpB9BmXLql1YHONffo19Q192vf
        /ghOPHg12D3+vh7A1bC4Fo1yfrk4Kmw=
X-Google-Smtp-Source: ABdhPJzjeRU4ZDJfzNUwpJfQG62LNcOzA29xh8uLuJ381O2a7qDTtKNuDD9aIVvl0cCOA4fH3FqczA==
X-Received: by 2002:a05:6a00:1806:b0:4f6:f3e8:b3a0 with SMTP id y6-20020a056a00180600b004f6f3e8b3a0mr33976415pfa.43.1647437697719;
        Wed, 16 Mar 2022 06:34:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o7-20020a056a00214700b004c169d45699sm3108407pfk.184.2022.03.16.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:34:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org
Cc:     yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] delayacct: track delays from ksm cow
Date:   Wed, 16 Mar 2022 13:34:21 +0000
Message-Id: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
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

Delay accounting does not track the delay of ksm cow.  When tasks
have many ksm pages, it may spend a amount of time waiting for ksm
cow.

To get the impact of tasks in ksm cow, measure the delay when ksm
cow happens. This could help users to decide whether to user ksm
or not.

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
    KSM             count    delay total  delay average
                     3635      271567604              0ms

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/delayacct.h      | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/taskstats.h |  6 +++++-
 kernel/delayacct.c             | 16 ++++++++++++++++
 mm/memory.c                    | 25 ++++++++++++++++++++++---
 tools/accounting/getdelays.c   |  8 +++++++-
 5 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6b16a6930a19..0fbe2cb25c23 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -45,9 +45,13 @@ struct task_delay_info {
 	u64 compact_start;
 	u64 compact_delay;	/* wait for memory compact */
 
+	u64 ksm_start;
+	u64 ksm_delay;	/* wait for ksm cow */
+
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
 	u32 compact_count;	/* total count of memory compact */
+	u32 ksm_count;	/* total count of ksm cow */
 };
 #endif
 
@@ -75,6 +79,8 @@ extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
 extern void __delayacct_compact_start(void);
 extern void __delayacct_compact_end(void);
+extern void __delayacct_ksm_start(void);
+extern void __delayacct_ksm_end(void);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -191,6 +197,24 @@ static inline void delayacct_compact_end(void)
 		__delayacct_compact_end();
 }
 
+static inline void delayacct_ksm_start(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_ksm_start();
+}
+
+static inline void delayacct_ksm_end(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_ksm_end();
+}
+
 #else
 static inline void delayacct_init(void)
 {}
@@ -225,6 +249,10 @@ static inline void delayacct_compact_start(void)
 {}
 static inline void delayacct_compact_end(void)
 {}
+static inline void delayacct_ksm_start(void)
+{}
+static inline void delayacct_ksm_end(void)
+{}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 12327d32378f..a851c032dfb8 100644
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
+	/* Delay waiting for ksm cow */
+	__u64	ksm_count;
+	__u64	ksm_delay_total;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 2c1e18f7c5cf..11accef0c2bd 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -177,11 +177,14 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
 	tmp = d->compact_delay_total + tsk->delays->compact_delay;
 	d->compact_delay_total = (tmp < d->compact_delay_total) ? 0 : tmp;
+	tmp = d->ksm_delay_total + tsk->delays->ksm_delay;
+	d->ksm_delay_total = (tmp < d->ksm_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
 	d->thrashing_count += tsk->delays->thrashing_count;
 	d->compact_count += tsk->delays->compact_count;
+	d->ksm_count += tsk->delays->ksm_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -249,3 +252,16 @@ void __delayacct_compact_end(void)
 		      &current->delays->compact_delay,
 		      &current->delays->compact_count);
 }
+
+void __delayacct_ksm_start(void)
+{
+	current->delays->ksm_start = local_clock();
+}
+
+void __delayacct_ksm_end(void)
+{
+	delayacct_end(&current->delays->lock,
+		      &current->delays->ksm_start,
+		      &current->delays->ksm_delay,
+		      &current->delays->ksm_count);
+}
diff --git a/mm/memory.c b/mm/memory.c
index 4499cf09c21f..23dfc3b24d28 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3249,6 +3249,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	vm_fault_t ret = 0;
+	bool delayacct = false;
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3294,7 +3296,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 *
 		 * PageKsm() doesn't necessarily raise the page refcount.
 		 */
-		if (PageKsm(page) || page_count(page) > 3)
+		if (PageKsm(page)) {
+			delayacct = true;
+			goto copy;
+		}
+		if (page_count(page) > 3)
 			goto copy;
 		if (!PageLRU(page))
 			/*
@@ -3308,7 +3314,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			goto copy;
 		if (PageSwapCache(page))
 			try_to_free_swap(page);
-		if (PageKsm(page) || page_count(page) != 1) {
+		if (PageKsm(page)) {
+			delayacct = true;
+			unlock_page(page);
+			goto copy;
+		}
+		if (page_count(page) != 1) {
 			unlock_page(page);
 			goto copy;
 		}
@@ -3328,10 +3339,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
+	if (delayacct)
+		delayacct_ksm_start();
+
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return wp_page_copy(vmf);
+	ret = wp_page_copy(vmf);
+
+	if (delayacct)
+		delayacct_ksm_end();
+
+	return ret;
 }
 
 static void unmap_mapping_range_vma(struct vm_area_struct *vma,
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 11e86739456d..3e77c9ff7fcf 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -207,6 +207,8 @@ static void print_delayacct(struct taskstats *t)
 	       "THRASHING%12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n"
 	       "COMPACT  %12s%15s%15s\n"
+	       "      %15llu%15llu%15llums\n"
+	       "KSM   %15s%15s%15s\n"
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
+	       (unsigned long long)t->ksm_count,
+	       (unsigned long long)t->ksm_delay_total,
+	       average_ms(t->ksm_delay_total, t->ksm_count));
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.25.1

