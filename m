Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FEE4E34EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiCUXsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiCUXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:47:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957CE170DB9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:46:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o23so11406070pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcQ+/R/hzFrIzv0+RhT/lAyOwDxZGwiW01nuReYcHjQ=;
        b=jNQy/GIkLAXPUbKbKVqyMOGsZl7m4SgwCghSX6dyYhU9FSgUWzbo45FcqSH2fWFXnf
         qs649G87q3OZCAo0LMbso7nGrtRh4I3FGIAsCZYAa8s/V5nTpuzSDD8IMmg7Wd/b6H0Q
         bwCGDezwUfFf0AcNTQc5EVkLkSP9oGKdgby/v/kVXkii6NamYBNyCawFtdO2w6CuJklG
         wwTmp9tYqrQoTuPwIVIuKTkt2xo+MTSrQ+Y01BRB9sk8fcw/toRdd9/9k67c0+o4ofcp
         KsrghCzQASS56R+iGKC8OhJpvdRvM8AxKRf9hcDLuOTuJQ0/fgVLKZqqpYe4SSbIgiT8
         X2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bcQ+/R/hzFrIzv0+RhT/lAyOwDxZGwiW01nuReYcHjQ=;
        b=pBqnDhG94T11phSP5JEOX4R8uMkPshu5s6BSxOFDk4ABztQ6fYZpSlF8+0Pqw+VhBD
         MvhYNGCXxumrN0rLXomPwH2cHBDgukvur0Tht6b77rE3l7uyw4LBmswrQD1Mg1OH9FGZ
         T3pbHKy+q7grsNd8uSEnXAIu3GGMcxFbe3KyHd53iSkBKqJ9FKsS6A77721NrMtYMXwK
         igfZiv6UQ6Aq+f7uofcc/WT50qlLtG/mu5FUx1PClSSSwarsbA948QmxP+znNBANIMzJ
         Wem/4X0X+tKScwe/z+lZd1LRwR/SSXNfDaaHNO9t1W6MfdTAFDCMA6MESjxE5jcWi3f9
         stYw==
X-Gm-Message-State: AOAM533OlviwpTy5q22myRTcVNgwvlyVVLJHUswGEmZ/NtZ9KMR1oa/5
        nlz5ySmuzuBUZIDZHcQXz7N4Fo63vos=
X-Google-Smtp-Source: ABdhPJy/bukJA7DpzqKp9ceRFoi5jrbWFOpvLetQI0TGvF58IuOTZ2p5WuYYCTHZC4USZ6S9pkR3eQ==
X-Received: by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id j18-20020a056a00131200b004e158c4ddfdmr26303545pfu.65.1647906374025;
        Mon, 21 Mar 2022 16:46:14 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:7a02:5319:bd43:9df9])
        by smtp.gmail.com with ESMTPSA id o7-20020a056a00214700b004c169d45699sm20168522pfk.184.2022.03.21.16.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:46:13 -0700 (PDT)
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
Subject: [PATCH 2/2] perf ftrace: Update documentation of ftrace command
Date:   Mon, 21 Mar 2022 16:46:09 -0700
Message-Id: <20220321234609.90455-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321234609.90455-1-namhyung@kernel.org>
References: <20220321234609.90455-1-namhyung@kernel.org>
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

Add description of perf ftrace latency subcommand.

Cc: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt | 75 ++++++++++++++++--------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 6e82b7cc0bf0..df4595563801 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -9,32 +9,24 @@ perf-ftrace - simple wrapper for kernel's ftrace functionality
 SYNOPSIS
 --------
 [verse]
-'perf ftrace' <command>
+'perf ftrace' {trace|latency} <command>
 
 DESCRIPTION
 -----------
-The 'perf ftrace' command is a simple wrapper of kernel's ftrace
-functionality.  It only supports single thread tracing currently and
-just reads trace_pipe in text and then write it to stdout.
+The 'perf ftrace' command provides a collection of subcommands which use
+kernel's ftrace infrastructure.
 
-The following options apply to perf ftrace.
+  'perf ftrace trace' is a simple wrapper of the ftrace.  It only supports
+  single thread tracing currently and just reads trace_pipe in text and then
+  write it to stdout.
 
-OPTIONS
--------
+  'perf ftrace latency' calculates execution latency of a given function
+  (optionally with BPF) and display it as a histogram.
 
--t::
---tracer=::
-	Tracer to use when neither -G nor -F option is not
-	specified: function_graph or function.
+The following options apply to perf ftrace.
 
--v::
---verbose::
-        Increase the verbosity level.
-
--F::
---funcs::
-        List available functions to trace. It accepts a pattern to
-        only list interested functions.
+COMMON OPTIONS
+--------------
 
 -p::
 --pid=::
@@ -43,10 +35,6 @@ OPTIONS
 --tid=::
 	Trace on existing thread id (comma separated list).
 
--D::
---delay::
-	Time (ms) to wait before starting tracing after program start.
-
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
@@ -61,6 +49,28 @@ OPTIONS
 	Ranges of CPUs are specified with -: 0-2.
 	Default is to trace on all online CPUs.
 
+-v::
+--verbose::
+        Increase the verbosity level.
+
+
+OPTIONS for 'perf ftrace trace'
+-------------------------------
+
+-t::
+--tracer=::
+	Tracer to use when neither -G nor -F option is not
+	specified: function_graph or function.
+
+-F::
+--funcs::
+        List available functions to trace. It accepts a pattern to
+        only list interested functions.
+
+-D::
+--delay::
+	Time (ms) to wait before starting tracing after program start.
+
 -m::
 --buffer-size::
 	Set the size of per-cpu tracing buffer, <size> is expected to
@@ -114,6 +124,25 @@ OPTIONS
 	  thresh=<n>   - Setup trace duration threshold in microseconds.
 	  depth=<n>    - Set max depth for function graph tracer to follow.
 
+
+OPTIONS for 'perf ftrace latency'
+---------------------------------
+
+-T::
+--trace-funcs=::
+	Set the function name to get the histogram.  Unlike perf ftrace trace,
+	it only allows single function to calculate the histogram.
+
+-b::
+--use-bpf::
+	Use BPF to measure function latency instead of using the ftrace (it
+	uses function_graph tracer internally).
+
+-n::
+--use-nsec::
+	Use nano-second instead of micro-second as a base unit of the histogram.
+
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
-- 
2.35.1.894.gb6a874cedc-goog

