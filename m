Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4D4847B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiADSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiADSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E259C06179B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:21:05 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id y9so4900774pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MH2/l/XaIDENocS0eiJpofOumdFMx8cfyENMyQr+bzw=;
        b=blZxsP+Z5s4y1NYHc2CCHBNyXLHlMkz3gd+KptbZn3+oy0SJ/Qmk7uxPCjmEA9FVLW
         GFXBEB7V5XqPUWjTKZEoNW2aczbMcaomUN2qSTfUfv2yLdD1LPH/TSYelwfFcB+f3kPZ
         gXAEPtUJWuRBzSjDcCJCP0Mq52wb/opb6ooR5gpgKICZWrQpA/CMS3P1Q0Qxw+7sFtjm
         aXPMqpmDl8jU4DIMDiL2R2Kg0NRMYVbz7nwEqs05mXfua0K6AZt34Ww2tlziZq8DYvq/
         aqwuyBKnKegwDUOD0t0jUCkX1OoM9CLsw7mx2UTs690as8WvcQKtRSoQaOKlpeFsdndO
         oYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MH2/l/XaIDENocS0eiJpofOumdFMx8cfyENMyQr+bzw=;
        b=H47Hjw8m7r5pJPfh7UPruk/PweR5EUBfXSEvv2A85OKr4TS/AREvRkXdv/Fhj/TzPp
         Yd4rwMuGQi32gUVPIJ5GKlI51ppG5UtxQ/TvUBswy8yuXXnUe5Go62WRwqG/CS9dkH89
         vc+bJRklLoRd6paYmg1ZOTEDelsGXIz31/rwkNQL+nKn+/KCs+xvpR0qBMtW3D7yre7N
         DR3HFuZzTj2uOwxUzV8fiT0QIxWUm1wXPLJWi1bDBttsmt6boWV7dXJb17tM3Hem6sGQ
         qhfeF+Nmv7xwpH+nGqXOrLn+vMlw8xjjbRK09CkgHa79gKFeITBbSgO49YasugnecirT
         gP2w==
X-Gm-Message-State: AOAM530eJz9IyL36ZgNWaFUoeabMLQ2A498FnqPGmvWX0P9KitYQyc6Y
        9yn94PUZC1nKtRV6PIdWdoE=
X-Google-Smtp-Source: ABdhPJye4BBRfYBsKA8bgowl/YjW9rPtL5TpLcl3mmyVBxf1nxhraXx2ksNL1ofyukDBq9PV2DpJHg==
X-Received: by 2002:a63:7983:: with SMTP id u125mr36769622pgc.569.1641320464518;
        Tue, 04 Jan 2022 10:21:04 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:21:04 -0800 (PST)
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
Date:   Tue,  4 Jan 2022 10:20:53 -0800
Message-Id: <20220104182054.25009-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
References: <20220104182054.25009-1-namhyung@kernel.org>
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
2.34.1.448.ga2b2bfdf31-goog

