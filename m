Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA452763A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiEOHTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiEOHTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:19:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C273DDEB
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:19:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p12so11400391pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4UESYPhTIfdiPcSwAlLoaQh1V1ETBUfuPGHTU50vcU=;
        b=Xn0rwinHIs/xrHvH1ljPc7wOOw9cTqxIJhCf3smWLB1bKl8iy69EObF1sNzacWM+1Q
         f7OzMmllQrb6YuIawnK44ZIANgAhae7bEhvgfchhHOWEarCKO7QkL5MfsV7CkNXDouni
         rLm5mZmnewwvf0qHCokaOZf67ZFRDss+BjE/PkHnXBos/+lV11AP9r0U3NXlbCbbbsS7
         gB2xcT14GDrw79/7Nm8dRu+Mj/ufWPOhkgB1b618jyldkYzVX7Mj95QQpCEVSlvUtJJ+
         1Aze4HsuKv7gN/4miuzJqCE/1ZbQhbZtH9srX9Ju7R+s9MzZBuFTXXjH30CgsCGkbZEf
         56yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4UESYPhTIfdiPcSwAlLoaQh1V1ETBUfuPGHTU50vcU=;
        b=ZNCb0F/yJdmYoMY9fVti39/qsPdqA2NzTk0jSS+5fszVcQl6Vkgd/cSFenHX21OOVR
         pFBtewg83GB3PqkHpe6BZTvJ8HGX4wL/Oy+yn29FzXBOFkUZgabBwXZfs2TaA/vasmV0
         G5Mvi3Usg2PbCrulMm1GtkwPmi5kvZ8UYyfNiB0HOqNvLTKZMgilSS8bXOGIFKfe+ncV
         Cf4IXY/I1nYffawVUH8Lpj8yScANnGISVnAyEiyOfokE5VF5fbGRWGL2xUQ5bRDRWXH0
         KBHjK5YiwuAqxQAY/i28utPt5xHeC9AcjHTKS7BLXERofTZd1r54tVDRP+6mmus7nTi5
         vMaQ==
X-Gm-Message-State: AOAM531GvoPA2cBwamgLItR31wn5u/cfEyXqQ5m+53gP2edUjWixokWO
        vPtGFdPAUK93RCeMEVL+sxKwHw==
X-Google-Smtp-Source: ABdhPJzbNbQIOG0SD82waFBlcUSoTadsBsvuhyY5h3hKN/ymaIQHhGSUFmGIkhfFmaV19oqUW8khSg==
X-Received: by 2002:a63:2009:0:b0:3c1:922b:3e76 with SMTP id g9-20020a632009000000b003c1922b3e76mr10713957pgg.558.1652599150842;
        Sun, 15 May 2022 00:19:10 -0700 (PDT)
Received: from localhost.localdomain ([104.245.96.71])
        by smtp.gmail.com with ESMTPSA id t19-20020a63dd13000000b003c2698d199bsm4461943pgg.25.2022.05.15.00.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:19:10 -0700 (PDT)
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
Subject: [PATCH v5 1/2] perf scripting python: Expose dso and map information
Date:   Sun, 15 May 2022 15:18:37 +0800
Message-Id: <20220515071838.3077178-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515071838.3077178-1-leo.yan@linaro.org>
References: <20220515071838.3077178-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

