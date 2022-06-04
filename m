Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815E53D57B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiFDEap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350584AbiFDEaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:30:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4759967
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:30:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b135so8540964pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/anDZ34daG+85MmjwzCfXxdj0aLtzUmSEbQG6hZDGaY=;
        b=ZSgUAjs/iyd+/yOHU9WOOXWFIZAH/tEVcBfbYlRXAWIz72CKAnHcy7II0fLfwcHjgg
         0nlOAhkYTaWLB46m5ZFXlTozKxoQqmDrGs9SMOMgcP9qobe0CUJmMTFs97ZGZ/vVnl+f
         wReklBKF8axeI1h5UHc3pkn6FNNIcFym2A+VmhmkvVcOBxOblrKy/1yEOXc4HTsxwMJs
         4A4zaXTJ5NOtDr5GC3gV1+snpQW+zxiJeAuZHuF9okoC08je2sxSrVF7TrMsajjh5zL8
         pjXDxeUkShl2gYGQ4mn5UU8BG4r9ca/8mrWCnJbptWGYC6x3nOUWdDBBqOT5vcIsQAQd
         NoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/anDZ34daG+85MmjwzCfXxdj0aLtzUmSEbQG6hZDGaY=;
        b=newbzoukMR0VlgPDilmM2nCCNpWW0fJZN86MhPHJo7+3aSE6fyeunO1wCGK+fgZjpE
         AscgysCkpCy8cvI/TgGsiVjagpzeXr2G7CQWJTFF2b9drt+f8OukJ0AW4+jSEIcdY9y4
         8lpG6DTdN0x/lMdmOF0vcGsi4fR+O9yVjmohmSY4EAJWoCjQ/b5ERhLK9lkpBnbTApJG
         YaZKLXVEGlrByo6LsUiGOozewihj+4Esj3WluQMhPgV05+e5VpD2Sx3EVN/ldzZGv0oK
         0tvFu2sJXFA9fwXbHIb2mlFCc8QKqr+fQSnwSRYTYZXBewYMkYEop2X6nh3DXmckYnOd
         4Tcw==
X-Gm-Message-State: AOAM530fLCbGqhWC+dYhiuWAtK9QhpBi63Fo12OhAO94qnz9BiGp5bIC
        d0IeBmkugwuaRuAYA3Nq7FZniA==
X-Google-Smtp-Source: ABdhPJw3IWosOX54sjK+dNbd2n0Kc3LJ61oEhjOzEXktZyWZSSYxOfr5NiN6efueMz7t0QrZBMsEsg==
X-Received: by 2002:a65:6e8b:0:b0:3ab:a3fb:e95a with SMTP id bm11-20020a656e8b000000b003aba3fbe95amr11435178pgb.433.1654317002236;
        Fri, 03 Jun 2022 21:30:02 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:30:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 14/17] perf c2c: Refactor display string
Date:   Sat,  4 Jun 2022 12:28:17 +0800
Message-Id: <20220604042820.2270916-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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

The display type is shown by combination the display string array and a
suffix string "HITMs", which is not friendly to extend display for other
sorting type (e.g. extension for peer operations).

This patch moves the suffix string "HITMs" into display string array for
HITM types, so it can allow us to not necessarily to output string
"HITMs" for new incoming display type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 49a9b8480b41..8b7c1fd35380 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -122,9 +122,9 @@ enum {
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL_HITM] = "Local",
-	[DISPLAY_RMT_HITM] = "Remote",
-	[DISPLAY_TOT_HITM] = "Total",
+	[DISPLAY_LCL_HITM] = "Local HITMs",
+	[DISPLAY_RMT_HITM] = "Remote HITMs",
+	[DISPLAY_TOT_HITM] = "Total HITMs",
 };
 
 static const struct option c2c_options[] = {
@@ -2489,7 +2489,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2646,7 +2646,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
-- 
2.25.1

