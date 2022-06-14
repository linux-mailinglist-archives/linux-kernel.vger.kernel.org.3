Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1754B362
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiFNOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354578AbiFNOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A73B2B7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:34:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-313cfb0c181so26560927b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+TZFSQCPo2Ju+GzmGovbnxDwp60NNa1c3IUVi64MUwE=;
        b=SM8KtAmpm2Ys3z8A/gDTRuvBA26+5U/1BsRykFz7fxva9Fy1jl5Va4R8L6nR/9DN1h
         ljm7gte7eNCVXnwatRY6PGYjXZWAomXm1T45myPY+P/NjYyQUl+P9MfmbniWzfDgkybs
         0uztR1XXCaEa98Y3R3e54joIQ7S4QXneo9AFhkAPuMXZKGTw2sIZ3jjqUbEQ9nKLPtlt
         H9jOrzAqpEaW6VJJftaIBGw14zJ9kbcgHlLD4Srn/LO0j1PFPElfXbmPo2f7zr5+HHS4
         A8P6QJ0fl0/diPiStE7yIz1575/sLY7AnWkRz4ocMtVFRBIpXcXE7m5ZojkvrJ0zZDkw
         8JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+TZFSQCPo2Ju+GzmGovbnxDwp60NNa1c3IUVi64MUwE=;
        b=sZE8b6jsBTrLbOVG7KS2PLADLSewl1+z5psJdn28tK3VxGum8YZikRj6z2K67gcWoO
         7Qz/PAt/cYGSWGD4rcXCm6WdOk03TB4PJlirgxdIGLXJpNeSpGUC18PPjnPBwH1d5B+e
         Mz0yKCBzsRyAR0qvGKWV5YoorrFi91i4pALCKb+g+Anf2Dell2gp+5EzqH+LNMHoALHC
         bUKRC0D1N4vPoxpkDRcQS8oe8RluuvDZMwTJDwt62CxL12DgEGTB/dMYYdeMO9kGx9pm
         dh8Rx6FXOLMiA8mvSlXePhxXnhmubDxd1/RUzdVVB0XxZT15RSBH9aYsX9+oMmUPNZUx
         YAKg==
X-Gm-Message-State: AJIora/Kw4sPaa4p7Gw048GsgZruYl6ihqBu4K0M9KRLq5HDXlyfX3xh
        OUP5cQOKOFd11D5gR3epGLMGmMUjb5S3
X-Google-Smtp-Source: AGRyM1upxurQe3D8oHjt7njhWp6P1sk7HMXsEASFWzXkOiyjCYAjTePFki+v0C3+Zjsyt9r1UYqAf4bfCc40
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b55a:aaa7:a:1b17])
 (user=irogers job=sendgmr) by 2002:a25:dcd1:0:b0:65c:d01c:f730 with SMTP id
 y200-20020a25dcd1000000b0065cd01cf730mr5738453ybe.372.1655217242022; Tue, 14
 Jun 2022 07:34:02 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:33:48 -0700
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
Message-Id: <20220614143353.1559597-2-irogers@google.com>
Mime-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 1/6] perf cpumap: Const map for max
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows max to be used with const perf_cpu_maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 2 +-
 tools/lib/perf/include/perf/cpumap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 384d5e076ee4..6cd0be7c1bb4 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -309,7 +309,7 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
-struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
+struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
 		.cpu = -1
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 24de795b09bb..03aceb72a783 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -23,7 +23,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
-LIBPERF_API struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map);
+LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
-- 
2.36.1.476.g0c4daa206d-goog

