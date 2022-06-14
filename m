Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8354B34A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbiFNOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiFNOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542136B60
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:34:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s23-20020a257717000000b00660719d9f2fso7746394ybc.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jlLUXMLBK64yscSUpLZfKbiaF8vfOQAkVnrzfyvEsEQ=;
        b=Rq2LH/kH8h16OGkoEDqaZztuc/ZNrRQpln9CWWY2rlmxP6xfWs+uX7GPgsLdw9hhbK
         iI/w0ywcMZ0+Jcuuu7SGFyOEUki/nvJsuSn+8WNytUMuCbFnMMvBIw+3T8hcj0/raMiP
         YV2/fFagV5ebYC8CoBSloDp60zD0BcYN03U6nZ9V8VbHO2TYxC4LMNTO6tjrCIWL2NPT
         l76f05GB8Kp+BKCIPnYqbGTTCEUSKU3VnJT+6nB+nQu8xkcaKfxi39W3k5psa2GNti7w
         lGxaB9Hw0jiBOFVV0tIL+ZqkV8ZRq6j6pcsVGYg7NOFJZskT+ramiaVCIy0bK5FfOc0v
         90lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlLUXMLBK64yscSUpLZfKbiaF8vfOQAkVnrzfyvEsEQ=;
        b=KYrzLLgIqskUJ4kmPZUnUsiVGEpV9HIThD3tle9+PMyQ1sAc3greDCznfO7EUkQQV3
         SSNE2Avsl6iR6nAEgrpN5prEr4bj4aCyDkEXpDMTDW20RLYEivHUR+3bmw/qFFAnYHeW
         J5XVsdeh79NFSvWboOiu8QLW53N4vhf3F5caqklzq5Wz8qQiF/Al0Gyn3g+iHX8zfVv1
         3UibtrRjouwX2mRkr4UhuF0DDLxVzmSvDDFXdbOWwWuRdyM2l4rqD3JqyOlj92JRTxyr
         O8oC8mPNrrdf9BhQGT+P7UhVz8kZYGeOZn7nBBKNcqYYvncoyqr0bUS0ZDMyNoyrP6eF
         hN8g==
X-Gm-Message-State: AJIora+BAf28EU9n9Fj6p56sxbiE71dV9Hnfi+J0s4w8Umdtdap4oDMk
        6jfhkjYTAw6MtWR3+ybnCHF+feFGsrN8
X-Google-Smtp-Source: AGRyM1tFploq+20UVqYMG2V2Ds3SMLs4FHX4Vl/ncalQoNGj9rQow5MxoLBUK3lObTvjj6Lrd91tYger8G4/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b55a:aaa7:a:1b17])
 (user=irogers job=sendgmr) by 2002:a25:b884:0:b0:664:7ce8:38f0 with SMTP id
 w4-20020a25b884000000b006647ce838f0mr5266397ybj.503.1655217246623; Tue, 14
 Jun 2022 07:34:06 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:33:50 -0700
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
Message-Id: <20220614143353.1559597-4-irogers@google.com>
Mime-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 3/6] perf cpumap: Compute mask size in constant time
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

