Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E125E52448E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbiELEtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348630AbiELEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:48:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C12E6BB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:48:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fv2so4084842pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAkVk8BocAZi8xx5Bbj7xf1f4YzNOFw5okdpKa0iEI4=;
        b=4bvOJsiJ7H+iMwovOmEJ5MKB1IDLljeiHiJiueX8hJKXz5TRqTUl6cs8YEF5NwkuBJ
         y/Q476QhqxIldjs/AjjGbcleQyJW7zI5MJOwIcluYLylkV+G5mDdMb4Rwv3732ttjN1H
         nkkHr15gXUytyH61fQ3gR2anIT8xtgAsjlGqO6IoH9B9A4FvV+ZD5gr9x6WFG64JyrSD
         HMXC0xlyyXElKGcmcTWZG5JuxuKg1+q6aChs29bRPgrR6ILFtmfzFo/Y9JStvIUNx8Vl
         UfFlivFPn5pW5Gmr1/B0HO4TNaZtyo6LVt4B4K2nQ3uxbBY2F/2TBU+ebJFIYC8ym15D
         qgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAkVk8BocAZi8xx5Bbj7xf1f4YzNOFw5okdpKa0iEI4=;
        b=67r70554dDYYO1mRNkqVnkHHWiCsOf2xGbUjptcJO60TCk70bcyt+MNEedJ6pYwGVt
         TN5Cgl7r78htmCwlC52qqBzgIvQbYfhSrJCprfQOXBBImvejuI79KrXiKbTF07S5welO
         TujCpX+NWZgjpcQnuZ9xLZeY1V77AF1gC/T0hNOQ1untmpxn62rcdqg0nuRmvTJ9dRen
         BfisPrYFQCcrepTk5ctZPEoqVex8OEzmZxNXiXNYVbAtUxBVSjHZSWXByqQ3a3oc5ssx
         JYZQCQAb1IR76uRJjThCAqdJPyTIVTKvJljDDQCfPAhr+1C2wvR8pH6kgookxUnY+YI6
         J3xw==
X-Gm-Message-State: AOAM530O4J235aBYYQVDoK2axscqiaO/KmQfp1wfAgUyvT9OqDi0Wyyh
        ym9LQcOO32hWR8U0kiuWFq+zSw==
X-Google-Smtp-Source: ABdhPJwtlc8Y2778hioM4oj564Xo0tmJ8W2pJn6pGvZxfL4ENesOAjEz5OnGrxBVyxU0aRv0Y9pRzA==
X-Received: by 2002:a17:902:cec7:b0:15e:b8b0:b9c8 with SMTP id d7-20020a170902cec700b0015eb8b0b9c8mr29329217plg.155.1652330891750;
        Wed, 11 May 2022 21:48:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015edc07dcf3sm2790824plk.21.2022.05.11.21.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:48:11 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 4/5 v1] mm: enable per numa node rss_stat count
Date:   Thu, 12 May 2022 12:46:33 +0800
Message-Id: <20220512044634.63586-5-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have all the infrastructure ready. Modify `get/add/inc/dec_mm_counter`,
`sync_mm_rss`, `add_mm_counter_fast` and `add_mm_rss_vec` to enable per numa
node rss_stat count.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/mm.h | 42 +++++++++++++++++++++++++++++++++++-------
 mm/memory.c        | 20 ++++++++++++++++++--
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cde5529285d6..f0f21065b81b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1994,8 +1994,18 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member, int node)
 {
-	long val = atomic_long_read(&mm->rss_stat.count[member]);
+	long val;
 
+	WARN_ON(node == NUMA_NO_NODE && member == MM_NO_TYPE);
+
+	if (node == NUMA_NO_NODE)
+		val = atomic_long_read(&mm->rss_stat.count[member]);
+	else
+#ifdef CONFIG_NUMA
+		val = atomic_long_read(&mm->rss_stat.numa_count[node]);
+#else
+		val = 0;
+#endif
 #ifdef SPLIT_RSS_COUNTING
 	/*
 	 * counter is updated in asynchronous manner and may go to minus.
@@ -2012,23 +2022,41 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member, long member_count, int
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value, int node)
 {
-	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+	long member_count = 0, numa_count = 0;
 
-	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, value);
+	if (member != MM_NO_TYPE)
+		member_count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+#ifdef CONFIG_NUMA
+	if (node != NUMA_NO_NODE)
+		numa_count = atomic_long_add_return(value, &mm->rss_stat.numa_count[node]);
+#endif
+	mm_trace_rss_stat(mm, member, member_count, node, numa_count, value);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member, int node)
 {
-	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+	long member_count = 0, numa_count = 0;
 
-	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, 1);
+	if (member != MM_NO_TYPE)
+		member_count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+#ifdef CONFIG_NUMA
+	if (node != NUMA_NO_NODE)
+		numa_count = atomic_long_inc_return(&mm->rss_stat.numa_count[node]);
+#endif
+	mm_trace_rss_stat(mm, member, member_count, node, numa_count, 1);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member, int node)
 {
-	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+	long member_count = 0, numa_count = 0;
 
-	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, -1);
+	if (member != MM_NO_TYPE)
+		member_count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+#ifdef CONFIG_NUMA
+	if (node != NUMA_NO_NODE)
+		numa_count = atomic_long_dec_return(&mm->rss_stat.numa_count[node]);
+#endif
+	mm_trace_rss_stat(mm, member, member_count, node, numa_count, -1);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/mm/memory.c b/mm/memory.c
index 2d3040a190f6..f7b67da772b2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -188,6 +188,14 @@ void sync_mm_rss(struct mm_struct *mm)
 			current->rss_stat.count[i] = 0;
 		}
 	}
+#ifdef CONFIG_NUMA
+	for_each_node(i) {
+		if (current->rss_stat.numa_count[i]) {
+			add_mm_counter(mm, MM_NO_TYPE, current->rss_stat.numa_count[i], i);
+			current->rss_stat.numa_count[i] = 0;
+		}
+	}
+#endif
 	current->rss_stat.events = 0;
 }
 
@@ -195,9 +203,12 @@ static void add_mm_counter_fast(struct mm_struct *mm, int member, int val, int n
 {
 	struct task_struct *task = current;
 
-	if (likely(task->mm == mm))
+	if (likely(task->mm == mm)) {
 		task->rss_stat.count[member] += val;
-	else
+#ifdef CONFIG_NUMA
+		task->rss_stat.numa_count[node] += val;
+#endif
+	} else
 		add_mm_counter(mm, member, val, node);
 }
 #define inc_mm_counter_fast(mm, member, node) add_mm_counter_fast(mm, member, 1, node)
@@ -508,6 +519,11 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss, int *numa_rss)
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (rss[i])
 			add_mm_counter(mm, i, rss[i], NUMA_NO_NODE);
+#ifdef CONFIG_NUMA
+	for_each_node(i)
+		if (numa_rss[i] != 0)
+			add_mm_counter(mm, MM_NO_TYPE, numa_rss[i], i);
+#endif
 }
 
 /*
-- 
2.20.1

