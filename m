Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928FB548228
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbiFMIr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiFMIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:47:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204ABEA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30047b94aa8so48070447b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jlLUXMLBK64yscSUpLZfKbiaF8vfOQAkVnrzfyvEsEQ=;
        b=RfB964hLBJrDKExStE8k0QOIu75yatipiO8Iiqq7WJbfSWN1bWRwpLOzyy3J+RICyP
         83DUqBuw5HOJgOZLGp8bNTnWaylkOrlllBgHMgGYSlsntH/oR/xPlFiRK/nTx12twbHJ
         MMnezexBjAr9MRNILwqxWsu27tEEfC4Kt3BtfIhfkgq7TYQ5AB+9nUxPD4rLbrYtWHCr
         jT6XHl4AerQFmApFGOf3Z0OwFCHJz1KU2DPa1ZrW0z6QhMp247QLW9YP2SKqhF6dLCWw
         VBBSjubaUjeJc6J/uvreVhFOmGPI34GUExK/QWiTbnr6WFR+3Lf8SGPx9o9DODzW2W7U
         vvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlLUXMLBK64yscSUpLZfKbiaF8vfOQAkVnrzfyvEsEQ=;
        b=eg/lOBO72PjY1PJ4T5jdAKwYitXhr1oBR3EH2BKvDEwVB/HxRRM8122qkZNSxFaZf7
         ikc3R/AnWSrulq5/tmADBKAuIj9N6vM7zTN0UnLI11HAHsmAwn6sR8DNYDtewUXN2yRj
         iaNIpaBx2zyQd91o2MrymuRJWTR4RVm2vyqgXUumYGvq7x1WyJrnxGM3vHPnlcy+UDZA
         qSPkK7iinrfJihkZNjxo++WdU+LLkuTz0WsdjeiEYyKlBAcKIVNxS/OjJnudFFNFzp/G
         xprWUR+sWC4miugkBNS6TQg7+OzCs9gSvc/rPy5qIyJGgNs7YopQqQgbTHVtiMCWMkEA
         +XDg==
X-Gm-Message-State: AOAM532/eoXCaVXMs9FnK+kF/G0J19z5XVoGkxsUh3PBHRsYysICsryh
        90J9HDLm0tJQn3fpoct0odsnr4nmv1fz
X-Google-Smtp-Source: ABdhPJxchkJW4bSVxtcOJJyVI2IbgadBLF6NhqZ5Z4PGrMlksMIAVMRRTAfO07jwisCbyuv4/r0Nt2YT12P9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1256:a8b4:594a:9164])
 (user=irogers job=sendgmr) by 2002:a05:6902:134f:b0:664:6767:b57a with SMTP
 id g15-20020a056902134f00b006646767b57amr16001891ybu.441.1655110070611; Mon,
 13 Jun 2022 01:47:50 -0700 (PDT)
Date:   Mon, 13 Jun 2022 01:47:36 -0700
In-Reply-To: <20220613084739.1159111-1-irogers@google.com>
Message-Id: <20220613084739.1159111-4-irogers@google.com>
Mime-Version: 1.0
References: <20220613084739.1159111-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 3/6] perf cpumap: Compute mask size in constant time
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

perf_cpu_map__max computes the cpumap's maximum value, no need to
iterate over all values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b8a42a096502..0d87df20ec44 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1213,18 +1213,7 @@ static size_t cpus_size(const struct perf_cpu_map *map)
 
 static size_t mask_size(const struct perf_cpu_map *map, int *max)
 {
-	int i;
-
-	*max = 0;
-
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		/* bit position of the cpu is + 1 */
-		int bit = perf_cpu_map__cpu(map, i).cpu + 1;
-
-		if (bit > *max)
-			*max = bit;
-	}
-
+	*max = perf_cpu_map__max(map).cpu;
 	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
 }
 
-- 
2.36.1.476.g0c4daa206d-goog

