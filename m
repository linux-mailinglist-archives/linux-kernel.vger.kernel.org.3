Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA152FC8B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbiEUNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbiEUNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:05:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF525FF39
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:05:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so9912211pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZetKCNDhJaesUzgnzjA4KRdWctxKfuE7ldwoX0e6QTU=;
        b=zEHZoKRyt2B2aOZlRdz41LA98wlXzI8nX77bvKRw0tPzdE/bDvoseAesCdyoGhqOn+
         KIUYFOI0MexR+M0n69UEcU0YKM3SY8LufUNc+6d5e/ZviEfnA7CwrC1JuoDwjAT36tii
         L3MfMiJ45755jLXJTIiBoOboEwOaHotbVe7R8+MiIrpfpdMRLk8GA8Boz8LIi7wAu44/
         YJptKFUAObrJfrDSyn8ut5sy7yvaW2uKefN7/OpX1Rfw9bY9VYSWVF4J1dLfBQBxrN+g
         BRY+w7lnABVbcdMzfGuWzz/EygrwpHXQIFS1+iO8lgfAihICrPSvhsnovkdNQ0CITYhz
         sItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZetKCNDhJaesUzgnzjA4KRdWctxKfuE7ldwoX0e6QTU=;
        b=7NlykMnLu3/vKU6m2OeQwuG/oLBURYn0VQt0vlJwAsTD+rqCujDD9wo9eD7tTlVms4
         TMafcx2/fPic/Fz2atGOZfaAa7lZuNXVC4UeHcpZ1sd/MXqZZ98pXw07N+GpOCp4xs36
         liu+YvzAfLqNSFwUNasO/uAtX9F9Ji71JelbosD65uMqbd4iCJ83o9MGyezQtPJvM7ML
         xxx7M45Rm7IEkMKPGvMmi3O+p/d1XBuMdxQQSs+HaaQdtItz5cyg0SHo4QVihxwHizrw
         Ld3kyB+ZL3T4q/9LDCa5q+cbLfIFerQQbxR185Y5G8ZUri1Dmw+b+Z/XyH1nVTIQvNUA
         zt8w==
X-Gm-Message-State: AOAM530yvt0KHcpoLJXvBd/flNq0UmIUq2NGUSC8S2sd8JqWbzcICJQV
        mWY3ksd4Y4Kx27BQi57YQr30KA==
X-Google-Smtp-Source: ABdhPJwwXfZUA1hH+I0gwVmGzZ2G5eXXQ+Zbt/vL+jjMpwP5CnNPSJwojs41GV+g5wMcH7fOEUDHhw==
X-Received: by 2002:a63:241:0:b0:3c5:fc11:ab56 with SMTP id 62-20020a630241000000b003c5fc11ab56mr12848322pgc.193.1653138303026;
        Sat, 21 May 2022 06:05:03 -0700 (PDT)
Received: from leo-build-box.lan (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0050dc7628160sm3724874pfm.58.2022.05.21.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:05:02 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 1/2] perf scripting python: Expose dso and map information
Date:   Sat, 21 May 2022 21:04:45 +0800
Message-Id: <20220521130446.4163597-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220521130446.4163597-1-leo.yan@linaro.org>
References: <20220521130446.4163597-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds dso build_id and corresponding map's start and end
address.  The info of dso build_id can be used to find dso file path,
and we can validate if a branch address falls into the range of map's
start and end addresses.

In addition, the map's start address can be used as an offset for
disassembly.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripting-engines/trace-event-python.c    | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 659eb4e4b34b..adba01b7d9dd 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -755,12 +755,22 @@ static void set_regs_in_dict(PyObject *dict,
 }
 
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
-			    const char *dso_field, const char *sym_field,
-			    const char *symoff_field)
+			    const char *dso_field, const char *dso_bid_field,
+			    const char *dso_map_start, const char *dso_map_end,
+			    const char *sym_field, const char *symoff_field)
 {
+	char sbuild_id[SBUILD_ID_SIZE];
+
 	if (al->map) {
 		pydict_set_item_string_decref(dict, dso_field,
 			_PyUnicode_FromString(al->map->dso->name));
+		build_id__sprintf(&al->map->dso->bid, sbuild_id);
+		pydict_set_item_string_decref(dict, dso_bid_field,
+			_PyUnicode_FromString(sbuild_id));
+		pydict_set_item_string_decref(dict, dso_map_start,
+			PyLong_FromUnsignedLong(al->map->start));
+		pydict_set_item_string_decref(dict, dso_map_end,
+			PyLong_FromUnsignedLong(al->map->end));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -840,7 +850,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			(const char *)sample->raw_data, sample->raw_size));
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
-	set_sym_in_dict(dict, al, "dso", "symbol", "symoff");
+	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
+			"symbol", "symoff");
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -856,7 +867,9 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	if (addr_al) {
 		pydict_set_item_string_decref(dict_sample, "addr_correlates_sym",
 			PyBool_FromLong(1));
-		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_symbol", "addr_symoff");
+		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
+				"addr_dso_map_start", "addr_dso_map_end",
+				"addr_symbol", "addr_symoff");
 	}
 
 	if (sample->flags)
-- 
2.25.1

