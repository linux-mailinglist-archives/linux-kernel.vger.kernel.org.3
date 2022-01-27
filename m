Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB69249D67D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiA0ABJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiA0ABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:01:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD89C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:01:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e16so754696pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bDlE2QWvzROS/x4MoT8MwkxZD4NwyUX21PPI5rsM0c=;
        b=pdanNWyifAAf4OgnVpHijgYbyAJwh3mzlt3SmK8HZF4HhKAJ0P4RmVfYVtKHocwYnX
         OJG4tZr46SaGRNschqIOHutPxEdEToSHVnomWzSVjxuK72SNNRrkHtYkg20Anqg9nL3N
         za1jfzCT52cDtHQP4iQ2uTvBooBdgr1Gl6RXjexrkshPL+bRJpB/CXCH34V212dXs8Ct
         qj6ybkrpD0RtUKw1Qm+A2qcYY7PCr+91OX2N3L44WWr5Ow05Sd20qVxNkYeS5ERYYBJD
         F9ChCSHA+qU4DztW5doTjl4Y6Iy3kOE1qsJbNMjMeut8UU2crnFIa9x6n/ezVCzTI2Vk
         StbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4bDlE2QWvzROS/x4MoT8MwkxZD4NwyUX21PPI5rsM0c=;
        b=hy4h8oXpW7ltupKG4f/88l+8nKGSCLxClNYoNdSvDAC/P6VMiWgIR8d0R+vkGENqiZ
         +NeSlyVPx7sw5V0NsTO8XZJ+1QRFsJwsQEBk4JN8ZWADdPY7lZH0XesnesvTlsfB6MHc
         Xy1ZKCnh5yawoXBgn1PZ9ERxEZTt2Dh3i4GM8QwLfhq3VR2Np/9WmiVTYkuxBm6bwPd9
         oISeHDMIonjXiXijQ4vOOMryTF0UksWPbtkGhuUEVjT/igx7aIuQiKbgs8LsMDW77xri
         8g2epUZ0etNsVXWPfO8OjmrtlsEQ/NBxkehOTck857k+nlHcM4DoaKVYHMZ35cyT3wgg
         pnxA==
X-Gm-Message-State: AOAM530HRbBB1Z2qOcRAp/1EayBWc3z93KY5oU4teV1iwdPjN+k7T4iq
        X5OpGRQq8NAytaRrWVW8rTk=
X-Google-Smtp-Source: ABdhPJxSyN7O6Uy1h4qme9btAqAPREF+EJwoUXjT3VueVuwvPIavh+fd3iekicIt3PO0kZP7BO+ogQ==
X-Received: by 2002:a05:6a00:b54:: with SMTP id p20mr827707pfo.49.1643241662711;
        Wed, 26 Jan 2022 16:01:02 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:01:02 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 5/6] perf lock: Add -c/--combine-locks option
Date:   Wed, 26 Jan 2022 16:00:49 -0800
Message-Id: <20220127000050.3011493-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -c or --combine-locks option is to merge lock instances in the
same class into a single entry.  It compares the name of the locks
and marks duplicated entries using lock_stat->combined.

 # perf lock report
                Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)

       rcu_read_lock     251225          0               0               0               0               0
 &(ei->i_block_re...       8731          0               0               0               0               0
 &sb->s_type->i_l...       8731          0               0               0               0               0
  hrtimer_bases.lock       5261          0               0               0               0               0
  hrtimer_bases.lock       2626          0               0               0               0               0
  hrtimer_bases.lock       1953          0               0               0               0               0
  hrtimer_bases.lock       1382          0               0               0               0               0
    cpu_hotplug_lock       1350          0               0               0               0               0
  hrtimer_bases.lock       1273          0               0               0               0               0
  hrtimer_bases.lock       1269          0               0               0               0               0

 # perf lock report -c
                Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)

       rcu_read_lock     251225          0               0               0               0               0
  hrtimer_bases.lock      39450          0               0               0               0               0
 &sb->s_type->i_l...      10301          1             662             662             662             662
    ptlock_ptr(page)      10173          2             701            1402             760             642
 &(ei->i_block_re...       8732          0               0               0               0               0
        &xa->xa_lock       8088          0               0               0               0               0
         &base->lock       6705          0               0               0               0               0
         &p->pi_lock       5549          0               0               0               0               0
 &dentry->d_lockr...       5010          4            1274            5097            1844             789
           &ep->lock       3958          0               0               0               0               0

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++
 tools/perf/builtin-lock.c              | 68 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 1b4d452923d7..f5eb95788969 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -54,6 +54,10 @@ REPORT OPTIONS
         Sorting key. Possible values: acquired (default), contended,
 	avg_wait, wait_total, wait_max, wait_min.
 
+-c::
+--combine-locks::
+	Merge lock instances in the same class (based on name).
+
 INFO OPTIONS
 ------------
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index f6adf3cdd1e2..bbfeba79426a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -65,6 +65,7 @@ struct lock_stat {
 	u64			wait_time_max;
 
 	int			discard; /* flag of blacklist */
+	int			combined;
 };
 
 /*
@@ -115,6 +116,8 @@ struct thread_stat {
 
 static struct rb_root		thread_stats;
 
+static bool combine_locks;
+
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -241,6 +244,7 @@ static const char		*sort_key = "acquired";
 
 static int			(*compare)(struct lock_stat *, struct lock_stat *);
 
+static struct rb_root		sorted; /* place to store intermediate data */
 static struct rb_root		result;	/* place to store sorted data */
 
 #define DEF_KEY_LOCK(name, fn_suffix)	\
@@ -274,6 +278,49 @@ static int select_key(void)
 	return -1;
 }
 
+static void combine_lock_stats(struct lock_stat *st)
+{
+	struct rb_node **rb = &sorted.rb_node;
+	struct rb_node *parent = NULL;
+	struct lock_stat *p;
+	int ret;
+
+	while (*rb) {
+		p = container_of(*rb, struct lock_stat, rb);
+		parent = *rb;
+
+		if (st->name && p->name)
+			ret = strcmp(st->name, p->name);
+		else
+			ret = !!st->name - !!p->name;
+
+		if (ret == 0) {
+			p->nr_acquired += st->nr_acquired;
+			p->nr_contended += st->nr_contended;
+			p->wait_time_total += st->wait_time_total;
+
+			if (p->nr_contended)
+				p->avg_wait_time = p->wait_time_total / p->nr_contended;
+
+			if (p->wait_time_min > st->wait_time_min)
+				p->wait_time_min = st->wait_time_min;
+			if (p->wait_time_max < st->wait_time_max)
+				p->wait_time_max = st->wait_time_max;
+
+			st->combined = 1;
+			return;
+		}
+
+		if (ret < 0)
+			rb = &(*rb)->rb_left;
+		else
+			rb = &(*rb)->rb_right;
+	}
+
+	rb_link_node(&st->rb, parent, rb);
+	rb_insert_color(&st->rb, &sorted);
+}
+
 static void insert_to_result(struct lock_stat *st,
 			     int (*bigger)(struct lock_stat *, struct lock_stat *))
 {
@@ -281,6 +328,9 @@ static void insert_to_result(struct lock_stat *st,
 	struct rb_node *parent = NULL;
 	struct lock_stat *p;
 
+	if (combine_locks && st->combined)
+		return;
+
 	while (*rb) {
 		p = container_of(*rb, struct lock_stat, rb);
 		parent = *rb;
@@ -833,6 +883,21 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
+static void combine_result(void)
+{
+	unsigned int i;
+	struct lock_stat *st;
+
+	if (!combine_locks)
+		return;
+
+	for (i = 0; i < LOCKHASH_SIZE; i++) {
+		hlist_for_each_entry(st, &lockhash_table[i], hash_entry) {
+			combine_lock_stats(st);
+		}
+	}
+}
+
 static void sort_result(void)
 {
 	unsigned int i;
@@ -896,6 +961,7 @@ static int __cmd_report(bool display_info)
 	if (display_info) /* used for info subcommand */
 		err = dump_info();
 	else {
+		combine_result();
 		sort_result();
 		print_result();
 	}
@@ -970,6 +1036,8 @@ int cmd_lock(int argc, const char **argv)
 	OPT_STRING('k', "key", &sort_key, "acquired",
 		    "key for sorting (acquired / contended / avg_wait / wait_total / wait_max / wait_min)"),
 	/* TODO: type */
+	OPT_BOOLEAN('c', "combine-locks", &combine_locks,
+		    "combine locks in the same class"),
 	OPT_PARENT(lock_options)
 	};
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

