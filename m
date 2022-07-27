Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52311582555
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiG0LU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiG0LUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:20:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD4491DC;
        Wed, 27 Jul 2022 04:20:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so15858947pfb.4;
        Wed, 27 Jul 2022 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkdZeVnb2L54XNf7hcQ1lwAkfoZ0qp81Y2YNQVw3sB4=;
        b=AG1Q4iE/sFOaLrC1/CHD5OgmiGZBWFPe5SrNv+ACTax8wV/REBWPk3EYrcx8nadEdh
         ep7Bjq4SxgB9EPPXTGBeEMZ34pnfpgt16G0irI2XLQ3Rb7O13s5fAV0PNS1Yu+yR7Kjb
         tBWTQlSx5CXd4UpliB7dNbQVT0edNAoghcGx5t6/go91AIqz+2Rm1AbIYNG3Jt2cdCgT
         dMY7KCfieUl9kce1q4Fe41YOr3OgIGKUAkiyD2Ku840Xr58b+AZcsP666tosH/3Vw062
         3Pa6MUD5dbse/hSVYna5jaZCCyVhoJ1CPKteonEYCuPCGTY17GSs+5fjNYk4g9tQSE3c
         HRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkdZeVnb2L54XNf7hcQ1lwAkfoZ0qp81Y2YNQVw3sB4=;
        b=LaLAJOYMj74cFAdKfA3ij96P72IFE5vtBwwV0VHlcP7Kh4mWD6khmoqtRq9+4U4e2n
         ZCCaSMjGY7xaFf3REZvZuxK6cwKv/1pNjs13Nz6vQhCww5XL0iZN9HjAjasMuvsXpx2S
         x60ACblw99G+XlIikLI3AqT/q7vl5LZX4iYAlnLo/l1M0QhxbfeP9xTDrAI0pN0y2s/+
         Yk/iJFODDMC84Xz4IeSplQGzBxvtdCXmltn2xp2FgJnV/TQksVgfMDfmdjJCEALsoTLn
         VvKCkwF0uln/8+26RrZRm9nyG37clWR4qAsQb9kY/kgAL11i0cHMZtC8lYO80nqFzljQ
         29og==
X-Gm-Message-State: AJIora+XkJNRf941xCfh/8Skj/Sqavnk86218FV3Na/X6JrgrTgu0O0F
        9WS1EtjYCPmCJxnwajbdhCIrtYQUGePHxHv7
X-Google-Smtp-Source: AGRyM1urWDZ69c78WOO4XSWPcZS72+9fA0nrzo3GrymT38AxbzOYw2IhoUty3ePyS+PogNtTAA4glw==
X-Received: by 2002:a05:6a00:1249:b0:52b:3343:3dc7 with SMTP id u9-20020a056a00124900b0052b33433dc7mr21585595pfi.72.1658920843960;
        Wed, 27 Jul 2022 04:20:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e014:b9a7:c341:50d6:ad89:e8ac])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b0016c433f7c12sm13640212plg.271.2022.07.27.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:20:43 -0700 (PDT)
From:   gpavithrasha@gmail.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc:     gpavithrasha@gmail.com
Subject: [PATCH v1 4/4] perf mutex and cond: Updated every occurrence of pthread_mutex and pthread_cond
Date:   Wed, 27 Jul 2022 16:49:54 +0530
Message-Id: <20220727111954.105118-4-gpavithrasha@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727111954.105118-1-gpavithrasha@gmail.com>
References: <20220727111954.105118-1-gpavithrasha@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pavithra <gpavithrasha@gmail.com>

Structs using pthread_mutex_t and
pthread_cond_t were updated and all the
usage of them were replaced with the new
wrapped functions as per the declaration &
definition in mutex.h and mutex.c files. Header
files included in each file were modified so as
to avoid redefinition errors.

Signed-off-by: pavithra <gpavithrasha@gmail.com>
---
 tools/perf/builtin-inject.c       |  1 -
 tools/perf/builtin-top.c          | 42 +++++++++++++++----------------
 tools/perf/ui/browsers/annotate.c |  4 +--
 tools/perf/util/annotate.c        |  8 +++---
 tools/perf/util/annotate.h        |  3 ++-
 tools/perf/util/hist.c            |  6 ++---
 tools/perf/util/hist.h            |  3 ++-
 tools/perf/util/symbol.c          |  2 +-
 tools/perf/util/top.h             |  5 ++--
 9 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 81eaed8da207..570472c597c3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -395,7 +395,6 @@ static int dso__read_build_id(struct dso *dso)
 		dso->has_build_id = true;
 		return 0;
 	}
-
 	return -1;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1f60124eb19b..e3ca3ba8fcfb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -132,10 +132,10 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	if (!symbol__hists(sym, top->evlist->core.nr_entries)) {
-		pthread_mutex_unlock(&notes->lock);
+		mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
 		sleep(1);
@@ -151,7 +151,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		pr_err("Couldn't annotate %s: %s\n", sym->name, msg);
 	}
 
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 	return err;
 }
 
@@ -204,19 +204,19 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 
 	notes = symbol__annotation(sym);
 
-	if (pthread_mutex_trylock(&notes->lock))
-		return;
+	if(mutex_trylock(&notes->lock))
+	return;
 
 	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
 
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 
 	if (unlikely(err)) {
 		/*
 		 * This function is now called with he->hists->lock held.
 		 * Release it before going to sleep.
 		 */
-		pthread_mutex_unlock(&he->hists->lock);
+		mutex_unlock(&he->hists->lock);
 
 		if (err == -ERANGE && !he->ms.map->erange_warned)
 			ui__warn_map_erange(he->ms.map, sym, ip);
@@ -226,7 +226,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 			sleep(1);
 		}
 
-		pthread_mutex_lock(&he->hists->lock);
+		mutex_lock(&he->hists->lock);
 	}
 }
 
@@ -246,7 +246,7 @@ static void perf_top__show_details(struct perf_top *top)
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	symbol__calc_percent(symbol, evsel);
 
@@ -267,7 +267,7 @@ static void perf_top__show_details(struct perf_top *top)
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
 out_unlock:
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 static void perf_top__resort_hists(struct perf_top *t)
@@ -824,13 +824,13 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		else
 			iter.ops = &hist_iter_normal;
 
-		pthread_mutex_lock(&hists->lock);
+		mutex_lock(&hists->lock);
 
 		err = hist_entry_iter__add(&iter, &al, top->max_stack, top);
 		if (err < 0)
 			pr_err("Problem incrementing symbol period, skipping event\n");
 
-		pthread_mutex_unlock(&hists->lock);
+		mutex_unlock(&hists->lock);
 	}
 
 	addr_location__put(&al);
@@ -886,10 +886,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		perf_mmap__consume(md);
 
 		if (top->qe.rotate) {
-			pthread_mutex_lock(&top->qe.mutex);
+			mutex_lock(&top->qe.mutex);
 			top->qe.rotate = false;
-			pthread_cond_signal(&top->qe.cond);
-			pthread_mutex_unlock(&top->qe.mutex);
+			cond_signal(&top->qe.cond);
+			mutex_unlock(&top->qe.mutex);
 		}
 	}
 
@@ -1094,10 +1094,10 @@ static void *process_thread(void *arg)
 
 		out = rotate_queues(top);
 
-		pthread_mutex_lock(&top->qe.mutex);
+		mutex_lock(&top->qe.mutex);
 		top->qe.rotate = true;
-		pthread_cond_wait(&top->qe.cond, &top->qe.mutex);
-		pthread_mutex_unlock(&top->qe.mutex);
+		cond_wait(&top->qe.cond, &top->qe.mutex);
+		mutex_unlock(&top->qe.mutex);
 
 		if (ordered_events__flush(out, OE_FLUSH__TOP))
 			pr_err("failed to process events\n");
@@ -1211,8 +1211,8 @@ static void init_process_thread(struct perf_top *top)
 	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
 	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
 	top->qe.in = &top->qe.data[0];
-	pthread_mutex_init(&top->qe.mutex, NULL);
-	pthread_cond_init(&top->qe.cond, NULL);
+	mutex_init(&top->qe.mutex);
+	cond_init(&top->qe.cond);
 }
 
 static int __cmd_top(struct perf_top *top)
@@ -1330,7 +1330,7 @@ static int __cmd_top(struct perf_top *top)
 out_join:
 	pthread_join(thread, NULL);
 out_join_thread:
-	pthread_cond_signal(&top->qe.cond);
+	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	return ret;
 }
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 82207db8f97c..af87e3fd3b86 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -309,7 +309,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 	browser->entries = RB_ROOT;
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	symbol__calc_percent(sym, evsel);
 
@@ -421,7 +421,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	notes = symbol__annotation(dl->ops.target.sym);
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->core.nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e830eadfca2a..35b377b382b2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -803,7 +803,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
@@ -811,7 +811,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 			memset(notes->src->cycles_hist, 0,
 				symbol__size(sym) * sizeof(struct cyc_hist));
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 static int __symbol__account_cycles(struct cyc_hist *ch,
@@ -1063,7 +1063,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 	notes->hit_insn = 0;
 	notes->cover_insn = 0;
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
@@ -1082,7 +1082,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			notes->have_cycles = true;
 		}
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d94be9140e31..942776db8e41 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <pthread.h>
 #include <asm/bug.h>
 #include "symbol_conf.h"
+#include "mutex.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -268,7 +269,7 @@ struct annotated_source {
 };
 
 struct annotation {
-	pthread_mutex_t		lock;
+	struct mutex lock;
 	u64			max_coverage;
 	u64			start;
 	u64			hit_cycles;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..07d51c029375 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1565,13 +1565,13 @@ struct rb_root_cached *hists__get_rotate_entries_in(struct hists *hists)
 {
 	struct rb_root_cached *root;
 
-	pthread_mutex_lock(&hists->lock);
+	mutex_lock(&hists->lock);
 
 	root = hists->entries_in;
 	if (++hists->entries_in > &hists->entries_in_array[1])
 		hists->entries_in = &hists->entries_in_array[0];
 
-	pthread_mutex_unlock(&hists->lock);
+	mutex_unlock(&hists->lock);
 
 	return root;
 }
@@ -2731,7 +2731,7 @@ int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list)
 	hists->entries_in = &hists->entries_in_array[0];
 	hists->entries_collapsed = RB_ROOT_CACHED;
 	hists->entries = RB_ROOT_CACHED;
-	pthread_mutex_init(&hists->lock, NULL);
+	mutex_init(&hists->lock);
 	hists->socket_filter = -1;
 	hists->hpp_list = hpp_list;
 	INIT_LIST_HEAD(&hists->hpp_formats);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6a186b668303..214d908c1be3 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,6 +8,7 @@
 #include "evsel.h"
 #include "color.h"
 #include "events_stats.h"
+#include "util/mutex.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -88,7 +89,7 @@ struct hists {
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
-	pthread_mutex_t		lock;
+	struct mutex lock;
 	struct events_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4b711b13f915..3ab882cce094 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -278,7 +278,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 	if (symbol_conf.priv_size) {
 		if (symbol_conf.init_annotation) {
 			struct annotation *notes = (void *)sym;
-			pthread_mutex_init(&notes->lock, NULL);
+			mutex_init(&notes->lock);
 		}
 		sym = ((void *)sym) + symbol_conf.priv_size;
 	}
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index f117d4f4821e..4fd3eb48c073 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -5,6 +5,7 @@
 #include "tool.h"
 #include "evswitch.h"
 #include "annotate.h"
+#include "mutex.h"
 #include "ordered-events.h"
 #include "record.h"
 #include <linux/types.h>
@@ -49,8 +50,8 @@ struct perf_top {
 		struct ordered_events	*in;
 		struct ordered_events	 data[2];
 		bool			 rotate;
-		pthread_mutex_t		 mutex;
-		pthread_cond_t		 cond;
+		struct mutex mutex;
+		struct cond cond;
 	} qe;
 };
 
-- 
2.25.1

