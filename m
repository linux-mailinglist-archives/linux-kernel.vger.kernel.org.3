Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE76550116
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiFRAJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiFRAJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:09:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA12544D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:09:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u67-20020a627946000000b0051b9c1256b0so2581687pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NN/VHTjMvFFwWljT35WfwKFzjyPlcfkcYjTW8hvHQro=;
        b=P5meH7puDld5c33SdRf6FPcHZdYF7HnRYNUFCr0OEwXUZfr6CZ10tqhnpPC+coUu4z
         LJ4cwOE5EfmyYql8OTUXJOE8rUThK9sCYten4lZBXWokeP51vO6gHxxklg5eaBHcwp1g
         dDqC4EX0gur+K/7fN/y0D6M/4IOW4NGhvX2DX18eYwLoiYp6zaSlNkzJDbX0uT4g3awk
         zqQELnQY7oh40vWB6s1afNMGnE4dKa+9RYFjb3rEcH75pK0V0Prvr2cyUa/+UiunHe/+
         53flx/l3X5vpjNoVNMWmZo+ITOI/ogRZWYoJ9774MBlB8tKvtV6D/ilkR+MK/A3U6Hw9
         geKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NN/VHTjMvFFwWljT35WfwKFzjyPlcfkcYjTW8hvHQro=;
        b=FDotQDPAdHeyGk3XTt0TFgsUQBPXorf5cqdvntBpxqR5Jy+Wey7gQUP5SoB8zkeqWo
         ZlgTC/jHiRHrBeJh2x8nYCD9Lj+vCy1qk9bqfE/G/gxJDAwHBsx26XQ5eQpRB1J7YRML
         Ii/9CNBbqKhcR6FRGF+5cDbqFSVOvHB0xXZ8YA/V6fMykz+Ls6fyz4W2MqAvfnPsGa0P
         13bFvP+jrkb/rDMm/r2uQtdq3CHOhBtHee9VlTO+0+Dh5Jq52NnmZFuUvrr1FTue3gTp
         xvpfGN1O+mRktHUmB9cGXZb/qqnZoC4OZcHIdOChIvkvVl5dUP9xvJ/YVuhv2vGhvDtz
         d4/Q==
X-Gm-Message-State: AJIora/SBpox3qI3nWV4Is42pVnPnw7p1Bs6h6hUOVSZ7Eh3rNScFFAK
        m2U1c65gibFSyCtAd1GBPs3XRWBAfQ6Y
X-Google-Smtp-Source: AGRyM1um+Fa/QqqI1CT+wNfhFLqkbp7WsmH7G9koY5QKIihb+m2b+HSCiKAVMLJO4mO46AL9weHu/em7mYCz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c89f:8969:c05d:79b6])
 (user=irogers job=sendgmr) by 2002:a63:e010:0:b0:401:afc3:5557 with SMTP id
 e16-20020a63e010000000b00401afc35557mr11371383pgh.133.1655510980865; Fri, 17
 Jun 2022 17:09:40 -0700 (PDT)
Date:   Fri, 17 Jun 2022 17:09:06 -0700
In-Reply-To: <20220618000907.433350-1-irogers@google.com>
Message-Id: <20220618000907.433350-4-irogers@google.com>
Mime-Version: 1.0
References: <20220618000907.433350-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v6 3/4] perf jevents: Switch build to use jevents.py
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
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

Generate pmu-events.c using jevents.py rather than the binary built from
jevents.c. Add a new config variable NO_JEVENTS that is set when there
is no architecture json or an appropriate python interpreter isn't present.
When NO_JEVENTS is defined the file pmu-events/empty-pmu-events.c is copied
and used as the pmu-events.c file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config               | 19 +++++++++++++++++++
 tools/perf/Makefile.perf                 |  1 +
 tools/perf/pmu-events/Build              | 11 +++++++++--
 tools/perf/pmu-events/empty-pmu-events.c | 21 +++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 16c1a87444b8..153c18909ff5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -889,6 +889,25 @@ else
   endif
 endif
 
+ifneq ($(NO_JEVENTS),1)
+  ifeq ($(wildcard pmu-events/arch/$(SRCARCH)/mapfile.csv),)
+    NO_JEVENTS := 1
+  endif
+endif
+ifneq ($(NO_JEVENTS),1)
+  NO_JEVENTS := 0
+  ifndef PYTHON
+    $(warning No python interpreter disabling jevent generation)
+    NO_JEVENTS := 1
+  else
+    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
+    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
+    ifneq ($(JEVENTS_PYTHON_GOOD), 1)
+      $(warning Python interpreter too old (older than 3.6) disabling jevent generation)
+      NO_JEVENTS := 1
+    endif
+  endif
+endif
 
 ifndef NO_LIBBFD
   ifeq ($(feature-libbfd), 1)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1e29c8936f71..dc6b177ac1de 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -655,6 +655,7 @@ JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+export NO_JEVENTS
 
 export JEVENTS
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..5e459e1c7a85 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -9,10 +9,17 @@ JSON		=  $(shell [ -d $(JDIR) ] &&				\
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
+JEVENTS_PY	=  pmu-events/jevents.py
 
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
 #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
-	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
+
+ifeq ($(NO_JEVENTS),1)
+$(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
+	$(Q)cp $< $@
+else
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+endif
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
new file mode 100644
index 000000000000..08fee615e015
--- /dev/null
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An empty pmu-events.c file used when there is no architecture json files in
+ * arch or when the jevents.py script cannot be run.
+ */
+#include "pmu-events/pmu-events.h"
+
+const struct pmu_events_map pmu_events_map[] = {
+	{
+		.cpuid = 0,
+		.version = 0,
+		.type = 0,
+		.table = 0,
+	},
+};
+
+const struct pmu_sys_events pmu_sys_event_tables[] = {
+	{
+		.table = 0
+	},
+};
-- 
2.36.1.476.g0c4daa206d-goog

