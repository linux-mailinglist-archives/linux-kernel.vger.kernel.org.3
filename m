Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5E52F742
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350544AbiEUBIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiEUBIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:08:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00A1B12C9;
        Fri, 20 May 2022 18:08:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 10so5198459plj.0;
        Fri, 20 May 2022 18:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ji13lEeBgsRyJT8yE25tZtjfkPv0XmmN2x27D7WlY+o=;
        b=NZJVrK66VNSFRDqKMnrcyzWaoxtPLWF1MnUC638QLoqK7fPMtdqrqALk+kPoWQ06DT
         J9FCYqWuSLOJJdWQAw4RhfDNZ1D2g2WloS0HVnZzwY41Yv3XucUXdyBhoGcY6K615bYP
         zfZMxmNKP3+P4lgJIhKgRxGxvBj6qvpEFeYSbYK/8hUyJrgGv7XC901umG61Jr9moghq
         qKVNI1HwbdSLf4xolThi17hm3dWmjfVmVkKKylWjWF/CqcM2h81bzOjaa9STfDwC6oSO
         BEd8D5tct6uxvQJ+YuZyG3K7Ut2kpm4gmldPPx5C1DvMW2F2tUn96swGe28vmpw+kpYI
         62kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Ji13lEeBgsRyJT8yE25tZtjfkPv0XmmN2x27D7WlY+o=;
        b=RhKudQNgdnHoYILgwRrDKKYgVuvhFR16OwLeMqlDeO41YoszpQXyqwVwTI6FDHBO/1
         GBfMvYftB9T35OUoTI2zcXHvr66NqjglN7zCCFEPyvMAh0ZxmKnd2Q9gcM+yAQBie5Oi
         NnehRL4WCEzETWll7OB4T3Eitt/5DsaxuHf9r3CO0PNtwKy0+z9KRImKNNFDas6SokE/
         6LxleKb6yLmP9K1B8MflArgP1x6nSfTLgSQbpBr51mcPl60nTN2tF87K5BXQeZJlTHPH
         uDNJpSrFKbVhVcSrmwCSvNTscI5fHus0r9zZLB5dHX7XwiNN1uIQasdwH6pQ+YMprp9G
         mzDA==
X-Gm-Message-State: AOAM531+yFb4JgpUiKrmvZus2g20pS6Nvps5sRwjgWCQgMKGkWjw9uW/
        ZfCh0wPNGgl3xlbZf4Do1HcDzRL96B4=
X-Google-Smtp-Source: ABdhPJxgqay1CGNE1XFEDhC/WqcB7nntT/SzEBWeaJ1bpOAc+geSBJkrdp36V4Uj2Yet+XJBel2fbg==
X-Received: by 2002:a17:902:ce8a:b0:161:af5e:a7b9 with SMTP id f10-20020a170902ce8a00b00161af5ea7b9mr11771569plg.167.1653095292857;
        Fri, 20 May 2022 18:08:12 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:9d03:75a4:742c:9d77])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b0015e8d4eb2d1sm313025pln.283.2022.05.20.18.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 18:08:12 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf lock: Do not discard broken lock stats
Date:   Fri, 20 May 2022 18:08:10 -0700
Message-Id: <20220521010811.932703-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it discards a lock_stat for a lock instance when there's a
broken lock_seq_stat in a single task for the lock.  But it also means
that the existing (and later) valid lock stat info for that lock will
be discarded as well.

This is not ideal since we can lose many valuable info because of a
single failure.  Actually those failures are indepent to the existing
stat.  So we can only discard the broken lock_seq_stat but keep the
valid lock_stat.

The discarded lock_seq_stat will be reallocated in a subsequent event
with SEQ_STATE_UNINITIALIZED which will be ignored until it see the
start of the next sequence.  So it should be ok just free it.

Before:

  $ perf lock report -F acquired,contended,avg_wait

  Warning:
  Processed 1401603 events and lost 18 chunks!

  Check IO/CPU overload!

                  Name   acquired  contended   avg wait (ns)

         rcu_read_lock     251225          0               0
   &(ei->i_block_re...       8731          0               0
   &sb->s_type->i_l...       8731          0               0
    hrtimer_bases.lock       5261          0               0
    hrtimer_bases.lock       2626          0               0
    hrtimer_bases.lock       1953          0               0
    hrtimer_bases.lock       1382          0               0
      cpu_hotplug_lock       1350          0               0
    hrtimer_bases.lock       1273          0               0
    hrtimer_bases.lock       1269          0               0
    hrtimer_bases.lock       1198          0               0
   ...

New:
                  Name   acquired  contended   avg wait (ns)

         rcu_read_lock     251225          0               0
   tk_core.seq.seqc...      54074          0               0
          &xa->xa_lock      17470          0               0
        &ei->i_es_lock      17464          0               0
       &ei->i_raw_lock       9391          0               0
   &mapping->privat...       8734          0               0
       &ei->i_data_sem       8731          0               0
   &(ei->i_block_re...       8731          0               0
   &sb->s_type->i_l...       8731          0               0
   jiffies_seq.seqc...       6953          0               0
        &mm->mmap_lock       6889          0               0
             balancing       5768          0               0
    hrtimer_bases.lock       5261          0               0
   ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 64 +++++++++++++++------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index cdfe1d4ced4b..7ceb12e30719 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -65,7 +65,7 @@ struct lock_stat {
 	u64			wait_time_min;
 	u64			wait_time_max;
 
-	int			discard; /* flag of blacklist */
+	int			broken; /* flag of blacklist */
 	int			combined;
 };
 
@@ -384,9 +384,6 @@ static void combine_lock_stats(struct lock_stat *st)
 			ret = !!st->name - !!p->name;
 
 		if (ret == 0) {
-			if (st->discard)
-				goto out;
-
 			p->nr_acquired += st->nr_acquired;
 			p->nr_contended += st->nr_contended;
 			p->wait_time_total += st->wait_time_total;
@@ -399,10 +396,7 @@ static void combine_lock_stats(struct lock_stat *st)
 			if (p->wait_time_max < st->wait_time_max)
 				p->wait_time_max = st->wait_time_max;
 
-			/* now it got a new !discard record */
-			p->discard = 0;
-
-out:
+			p->broken |= st->broken;
 			st->combined = 1;
 			return;
 		}
@@ -415,15 +409,6 @@ static void combine_lock_stats(struct lock_stat *st)
 
 	rb_link_node(&st->rb, parent, rb);
 	rb_insert_color(&st->rb, &sorted);
-
-	if (st->discard) {
-		st->nr_acquired = 0;
-		st->nr_contended = 0;
-		st->wait_time_total = 0;
-		st->avg_wait_time = 0;
-		st->wait_time_min = ULLONG_MAX;
-		st->wait_time_max = 0;
-	}
 }
 
 static void insert_to_result(struct lock_stat *st,
@@ -560,8 +545,6 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
-	if (ls->discard)
-		return 0;
 
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
@@ -599,9 +582,11 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	case SEQ_STATE_ACQUIRING:
 	case SEQ_STATE_CONTENDED:
 broken:
-		/* broken lock sequence, discard it */
-		ls->discard = 1;
-		bad_hist[BROKEN_ACQUIRE]++;
+		/* broken lock sequence */
+		if (!ls->broken) {
+			ls->broken = 1;
+			bad_hist[BROKEN_ACQUIRE]++;
+		}
 		list_del_init(&seq->list);
 		free(seq);
 		goto end;
@@ -629,8 +614,6 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
-	if (ls->discard)
-		return 0;
 
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
@@ -657,9 +640,11 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	case SEQ_STATE_RELEASED:
 	case SEQ_STATE_ACQUIRED:
 	case SEQ_STATE_READ_ACQUIRED:
-		/* broken lock sequence, discard it */
-		ls->discard = 1;
-		bad_hist[BROKEN_ACQUIRED]++;
+		/* broken lock sequence */
+		if (!ls->broken) {
+			ls->broken = 1;
+			bad_hist[BROKEN_ACQUIRED]++;
+		}
 		list_del_init(&seq->list);
 		free(seq);
 		goto end;
@@ -688,8 +673,6 @@ static int report_lock_contended_event(struct evsel *evsel,
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
-	if (ls->discard)
-		return 0;
 
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
@@ -709,9 +692,11 @@ static int report_lock_contended_event(struct evsel *evsel,
 	case SEQ_STATE_ACQUIRED:
 	case SEQ_STATE_READ_ACQUIRED:
 	case SEQ_STATE_CONTENDED:
-		/* broken lock sequence, discard it */
-		ls->discard = 1;
-		bad_hist[BROKEN_CONTENDED]++;
+		/* broken lock sequence */
+		if (!ls->broken) {
+			ls->broken = 1;
+			bad_hist[BROKEN_CONTENDED]++;
+		}
 		list_del_init(&seq->list);
 		free(seq);
 		goto end;
@@ -740,8 +725,6 @@ static int report_lock_release_event(struct evsel *evsel,
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
-	if (ls->discard)
-		return 0;
 
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
@@ -767,9 +750,11 @@ static int report_lock_release_event(struct evsel *evsel,
 	case SEQ_STATE_ACQUIRING:
 	case SEQ_STATE_CONTENDED:
 	case SEQ_STATE_RELEASED:
-		/* broken lock sequence, discard it */
-		ls->discard = 1;
-		bad_hist[BROKEN_RELEASE]++;
+		/* broken lock sequence */
+		if (!ls->broken) {
+			ls->broken = 1;
+			bad_hist[BROKEN_RELEASE]++;
+		}
 		goto free_seq;
 	default:
 		BUG_ON("Unknown state of lock sequence found!\n");
@@ -854,10 +839,11 @@ static void print_result(void)
 	bad = total = 0;
 	while ((st = pop_from_result())) {
 		total++;
-		if (st->discard) {
+		if (st->broken)
 			bad++;
+		if (!st->nr_acquired)
 			continue;
-		}
+
 		bzero(cut_name, 20);
 
 		if (strlen(st->name) < 20) {
-- 
2.36.1.124.g0e6072fb45-goog

