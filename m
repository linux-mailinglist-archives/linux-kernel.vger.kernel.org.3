Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E593537A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiE3Lmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiE3Lly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686B10C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so10357857pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THH8wa7TnqV/qE1Ao1QWNDBQ+CCTll+o2go/NvMpMcM=;
        b=IOuudsk7MsQjj6yf2WuomJioY7leWfVDpGdP+k9EDowGz+IOYCT98fRZbCOo0fSZa6
         OwXav1eeZO/2xqMD2B4kHGqx+hXeqXMS80as+AYnzGl1uSXDLIp9Uuw7F+qG/Oazzlye
         tRoiubYQ3jullshw8qbKH/L2jwjT/IBTKJfl/smvhRNkMM4QxAt0qNez/vFF68bWGRJo
         3ou/gYV+BSDT9NG10i598gv8yOCLvk8Ajsnye/+7Ns2WEnf/EctMFUjDMazcEklgvoAe
         wMdm6oc1CksDdOE4KCOuvJqWNTs7Tzp9M5sn9xG9pLdRzLWd1mq7xV7l72sxrLxdg+Xw
         PM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THH8wa7TnqV/qE1Ao1QWNDBQ+CCTll+o2go/NvMpMcM=;
        b=XAdVjH9YgIPHrmblLF9VMDXlEHJUih2UOu7Cq7WPFgmya0vp1AqNQGbf8ZN5HdMLkw
         9Yk8UxHkWDFWzb2nBqpYTOkRAy+rz2ZN3+3tSdHrrHfUjOpRhcqIZf7DVng9sQP/20te
         9zFmQ+lpalPUiCKX6/0zROId3aa/LQejfDCDdb1OnDerA9plllKVtNjj30Z5rCYwGQzq
         7W/p0wa4W4H6MYGi1O5Dxb9cX6IOQHpNXb0amffV6vtKuyzXYp0xDQbgYdJYa0oZx6TJ
         dyHg7N8q4NXpgtmwmsAAyjpNtjkhAQFChFcLFMot7nYN6hnlNLZb8sirfC7IUfzz5lL9
         sWaA==
X-Gm-Message-State: AOAM533v0hfPgsBDwFOBVDPQdkr4SgalcxgMCHdaNT4vCk/V07laEZM2
        pwwQ8DMaFB51RTvDLeDX7W1xcg==
X-Google-Smtp-Source: ABdhPJw9aP6CuPXiYhnsc021cGhUxiDsPVFpXzRlww3p0MkLdWVDKG8KZtY2KeZh69tpohnFpmRqyQ==
X-Received: by 2002:a63:6c44:0:b0:3fa:ec6b:33e7 with SMTP id h65-20020a636c44000000b003faec6b33e7mr20976033pgc.435.1653910903028;
        Mon, 30 May 2022 04:41:43 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:42 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 09/12] perf c2c: Refactor display string
Date:   Mon, 30 May 2022 19:40:33 +0800
Message-Id: <20220530114036.3225544-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
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

The display type is shown by combination the display string array and a
suffix string "HITMs", which is not friendly to extend display for other
sorting type (e.g. extension for peer operations).

This patch moves the suffix string "HITMs" into display string array for
HITM types, so it can allow us to not necessarily to output string
"HITMs" for new incoming display type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e76219034588..725b23d9104b 100644
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

