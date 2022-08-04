Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7058A326
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiHDWSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbiHDWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812B6E8BB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:18:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f4b76446aso7338997b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=3zB40Ep346GFOYo22jSNwM76yKmEJRv1RJmbyyWyLHU=;
        b=E6Txk7uEstiYdwC8uzQETuPMRpo8BmaaDqinpQxoLfk0uI9AQjhfYYH3HqoMxCw+3u
         5N+dq3kX1h3my3fjW59H5ATiAPRBr4n7e9YZRCYRV4aK4abjUnTtcbvp6lHt+T5Zvk9D
         tB1+HDnx+9UzYK0okdF15reIkcSlL2XEX1DIT31RgQVVnVToVaeJ48Even3TbWVK7n3q
         BSmv3J9CWXZINfCIVhtZkYsVmILVfLouies1TSdpJbP8XZhO8ZC05tvS/pBJ/OpgOxYD
         7X7qKspHiCGI4NtyrJe2jT8zf9JNdJJAWOZ4+Bn1LjLrDSSOhk4sM7kgQkX2cKXm3THf
         Zaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=3zB40Ep346GFOYo22jSNwM76yKmEJRv1RJmbyyWyLHU=;
        b=F9RI/OFe1Ynu601ISl1t4kC8Uv5Ls8jgmu5k4MyKS9vEtyJY8gpxVgJLsg8OIz5Tdy
         vdICWvaPH9C+dug5VBzzwCWbeii+qYRqxJNKvIb6j7fW9RojyB+Cpth1D+YxVIJvnFo3
         lUS+R6tZFNX1G+ybutcHfMpeds9f56lyUpuwfoTizpK8PKcoXtQzmkkL9+O8GmweoeDm
         PS4tzaySWTYktFM9liGxUZ2LOFeRxTNDS1mAoB/VOd54j+Qg4ARbBytGs9NpK6U6IMPb
         rPKOCqjbzb6zlqSPWw/MqBEX+ok851ythr5nLzx1fpCPAu2yn6ltZUYfYxlSTim9cuj3
         GE0g==
X-Gm-Message-State: ACgBeo3wpOpP+poutdN44aU5youR8PFsH1Og5VhvuegQdpupTX4mRwzm
        h9vjBq485A4OuLdBE75Vc0Koye9jHS3Z
X-Google-Smtp-Source: AA6agR4fb4lCgBnjP7KBoxfNpkhYZA7oNOwumbQtO618B3WSAI3h5KQJV9FhksGoli47MgpbdpMkWxqNVy2J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a81:1014:0:b0:324:6c13:dc01 with SMTP id
 20-20020a811014000000b003246c13dc01mr3500805ywq.115.1659651510685; Thu, 04
 Aug 2022 15:18:30 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:02 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-4-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 03/17] perf jevents: Add JEVENTS_ARCH make option
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the architecture built into pmu-events.c to be set on the make
command line with JEVENTS_ARCH.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 28a9d01b08af..04ef95174660 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -7,6 +7,10 @@ JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
 JEVENTS_PY	=  pmu-events/jevents.py
 
+ifeq ($(JEVENTS_ARCH),)
+JEVENTS_ARCH=$(SRCARCH)
+endif
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
@@ -19,5 +23,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
 else
 $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
 endif
-- 
2.37.1.559.g78731f0fdb-goog

