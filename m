Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0F4E34B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiCUXsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiCUXrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:47:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965C17008D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:46:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e5so2289639pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbLpdjW2a3Z77FyiwxxVmbQCohBMxIax2Hrp1fuD/LA=;
        b=fEGWCWqVnCnLnLeT8qvHs+keyf2zn6y7MxlIdE/AZ7u+6u/sGTCkF5RHMYbLtR/sfz
         j1/OF54YY9hksLpSEFaQyJvjeLstjHifgySeB6MfZk8i0FE/buyBBJ39/ZLbkpIcB/ZR
         nvGkdT50asiBPQzDG2xn2lFFVb8dupIJ5Q0KpFiLnfNP0mR7sPsceZGg26cbxmihvyId
         RJNRHWHTrF0DmD3bhDW28H6S3J/2LsEaG5hIVfzeDWjFz/iKDX5KtEt6b5loWc0JSyV4
         jIHiiGn5+fQOPhg/2YVZUDWrYyrKbAUOgLx5fR9vpiZ9o7HNVWjIBdCc+Ca8pO7gEU/z
         rB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hbLpdjW2a3Z77FyiwxxVmbQCohBMxIax2Hrp1fuD/LA=;
        b=ylI/EdgQt7oL8hkndyr7aLl3L1ZAVw4FlHV+MkzJUoeGJGkHFJx8iaazWTYU/HXl9x
         3KtxETsTj5AFp/Q0rbNGisHiffeqn7VuBWGHt6o5Dw5+A3+EFzbTH0B4VdgvOsaiYStG
         AJMn+jPN/M7oz0nl44pAtPkHAYiT40CaEQUhK4KOtj9pffMhEePtV4tovZNYa/bs4t/h
         ftEbWw1iEftMSdi8Ax9ASlNjOENjiV4lothA10mLXvKNbtIv+cph4hMuxaic2s0IVKch
         eQ8GBfScEAMUtyaYznnAc2Zh7AM5hLQ/bmiBWsqJNr1LkB0YFPsZTnhWHC71667LENRg
         KBsw==
X-Gm-Message-State: AOAM533rkrBgscc7lC4H2bKKoRm3Gbht+yRKAgegOczzPXO1B0gGWEg4
        zxmhZDyPHAHlQ1YAyea3X9u2AcWp1Gw=
X-Google-Smtp-Source: ABdhPJxMSaC4p/HtuJ5BPE9viA2AFRhgcLQpDTY/NUUB7teq25tlDsX/yXZjwiz3lQunp+1HxU7Klw==
X-Received: by 2002:a17:902:7204:b0:153:bffb:f348 with SMTP id ba4-20020a170902720400b00153bffbf348mr15137281plb.147.1647906372022;
        Mon, 21 Mar 2022 16:46:12 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:7a02:5319:bd43:9df9])
        by smtp.gmail.com with ESMTPSA id o7-20020a056a00214700b004c169d45699sm20168522pfk.184.2022.03.21.16.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:46:11 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 1/2] perf ftrace: Add -n/--use-nsec option for latency
Date:   Mon, 21 Mar 2022 16:46:08 -0700
Message-Id: <20220321234609.90455-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
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

Sometimes we want to see nano-second granularity.

  $ sudo perf ftrace latency -T dput -a sleep 1
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |    2098375 | #############################  |
       1 - 2    us |         61 |                                |
       2 - 4    us |         33 |                                |
       4 - 8    us |         13 |                                |
       8 - 16   us |        124 |                                |
      16 - 32   us |        123 |                                |
      32 - 64   us |          1 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          1 |                                |
     256 - 512  us |          0 |                                |
     512 - 1024 us |          0 |                                |
       1 - 2    ms |          0 |                                |
       2 - 4    ms |          0 |                                |
       4 - 8    ms |          0 |                                |
       8 - 16   ms |          0 |                                |
      16 - 32   ms |          0 |                                |
      32 - 64   ms |          0 |                                |
      64 - 128  ms |          0 |                                |
     128 - 256  ms |          0 |                                |
     256 - 512  ms |          0 |                                |
     512 - 1024 ms |          0 |                                |
       1 - ...   s |          0 |                                |

  $ sudo perf ftrace latency -T dput -a -n sleep 1
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |          0 |                                |
       1 - 2    ns |          0 |                                |
       2 - 4    ns |          0 |                                |
       4 - 8    ns |          0 |                                |
       8 - 16   ns |          0 |                                |
      16 - 32   ns |          0 |                                |
      32 - 64   ns |          0 |                                |
      64 - 128  ns |    1163434 | ##############                 |
     128 - 256  ns |     914102 | #############                  |
     256 - 512  ns |        884 |                                |
     512 - 1024 ns |        613 |                                |
       1 - 2    us |         31 |                                |
       2 - 4    us |         17 |                                |
       4 - 8    us |          7 |                                |
       8 - 16   us |        123 |                                |
      16 - 32   us |         83 |                                |
      32 - 64   us |          0 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          0 |                                |
     256 - 512  us |          0 |                                |
     512 - 1024 us |          0 |                                |
       1 - ...  ms |          0 |                                |

Cc: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c                 | 24 +++++++++++++--------
 tools/perf/util/bpf_ftrace.c                |  2 ++
 tools/perf/util/bpf_skel/func_latency.bpf.c |  6 ++++--
 tools/perf/util/ftrace.h                    |  1 +
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a8785dec5ca6..ad9ce1bfffa1 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -680,7 +680,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
-static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf)
+static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf,
+			   bool use_nsec)
 {
 	char *p, *q;
 	char *unit;
@@ -727,6 +728,9 @@ static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf)
 		if (!unit || strncmp(unit, " us", 3))
 			goto next;
 
+		if (use_nsec)
+			num *= 1000;
+
 		i = log2(num);
 		if (i < 0)
 			i = 0;
@@ -744,7 +748,7 @@ static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf)
 	strcat(linebuf, p);
 }
 
-static void display_histogram(int buckets[])
+static void display_histogram(int buckets[], bool use_nsec)
 {
 	int i;
 	int total = 0;
@@ -770,12 +774,12 @@ static void display_histogram(int buckets[])
 	for (i = 1; i < NUM_BUCKET - 1; i++) {
 		int start = (1 << (i - 1));
 		int stop = 1 << i;
-		const char *unit = "us";
+		const char *unit = use_nsec ? "ns" : "us";
 
 		if (start >= 1024) {
 			start >>= 10;
 			stop >>= 10;
-			unit = "ms";
+			unit = use_nsec ? "us" : "ms";
 		}
 		bar_len = buckets[i] * bar_total / total;
 		printf("  %4d - %-4d %s | %10d | %.*s%*s |\n",
@@ -785,8 +789,8 @@ static void display_histogram(int buckets[])
 
 	bar_len = buckets[NUM_BUCKET - 1] * bar_total / total;
 	printf("  %4d - %-4s %s | %10d | %.*s%*s |\n",
-	       1, "...", " s", buckets[NUM_BUCKET - 1], bar_len, bar,
-	       bar_total - bar_len, "");
+	       1, "...", use_nsec ? "ms" : " s", buckets[NUM_BUCKET - 1],
+	       bar_len, bar, bar_total - bar_len, "");
 
 }
 
@@ -913,7 +917,7 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 			if (n < 0)
 				break;
 
-			make_histogram(buckets, buf, n, line);
+			make_histogram(buckets, buf, n, line, ftrace->use_nsec);
 		}
 	}
 
@@ -930,12 +934,12 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 		int n = read(trace_fd, buf, sizeof(buf) - 1);
 		if (n <= 0)
 			break;
-		make_histogram(buckets, buf, n, line);
+		make_histogram(buckets, buf, n, line, ftrace->use_nsec);
 	}
 
 	read_func_latency(ftrace, buckets);
 
-	display_histogram(buckets);
+	display_histogram(buckets, ftrace->use_nsec);
 
 out:
 	close(trace_fd);
@@ -1171,6 +1175,8 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
 		    "Use BPF to measure function latency"),
 #endif
+	OPT_BOOLEAN('n', "--use-nsec", &ftrace.use_nsec,
+		    "Use nano-second histogram"),
 	OPT_PARENT(common_options),
 	};
 	const struct option *options = ftrace_options;
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index d756cc66eef3..4f4d3aaff37c 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -81,6 +81,8 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		}
 	}
 
+	skel->bss->use_nsec = ftrace->use_nsec;
+
 	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
 							    false, func->name);
 	if (IS_ERR(skel->links.func_begin)) {
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index ea94187fe443..9d01e3af7479 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -39,6 +39,7 @@ struct {
 int enabled = 0;
 int has_cpu = 0;
 int has_task = 0;
+int use_nsec = 0;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -80,6 +81,7 @@ int BPF_PROG(func_end)
 {
 	__u64 tid;
 	__u64 *start;
+	__u64 cmp_base = use_nsec ? 1 : 1000;
 
 	if (!enabled)
 		return 0;
@@ -97,9 +99,9 @@ int BPF_PROG(func_end)
 		if (delta < 0)
 			return 0;
 
-		// calculate index using delta in usec
+		// calculate index using delta
 		for (key = 0; key < (NUM_BUCKET - 1); key++) {
-			if (delta < ((1000UL) << key))
+			if (delta < (cmp_base << key))
 				break;
 		}
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 887f68a185f7..a34cd15733b8 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -17,6 +17,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
+	bool			use_nsec;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
-- 
2.35.1.894.gb6a874cedc-goog

