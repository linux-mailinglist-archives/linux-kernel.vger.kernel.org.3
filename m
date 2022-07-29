Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78831584CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiG2HoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiG2HoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965965666
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so3298778yba.22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=RmaMHRM7ZCMs2/Sqd/a9cdMCmqaHieNXVHN4Vuvjr+TsV/F8AClPvTIRagoDGDteWP
         JtTrLV93NxFRO9qxISgnIVfKmNRq7AhrSL9eH75+iyu2fez+WJO0lxUj+jqV/oKCfe3i
         nuyp1wAIJyjwZvdYgpNF0Ol7SaSvyWX3/OmBZc8xGOSfwNMMDJu83rG8aYZjNa9VjNGX
         68nHrV2nLH2zt4bKDZntZlSECtedzjURSUOIwFLvjqkwwAKOEq7Zao1TaGUi05MPmxbF
         xOeW23WnznBfPNyM8bDBJvTUDbitnImpHaGkGAe9c5bPYLuz2XRTTC+A6k5lQej39y3d
         o5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=FHkmyE6B/1Dh187i8Fpq6O+gcPB/BtFXXCN4zHKQv216t00PlhO3noSPz0TYyaSS87
         JhIZV0NTn9JtlhtrhBrAR2Fq1m7RBUsEjGlAuk1qc5+pU6RO8ah8yK4bxBeLbdmniXej
         IkU9oYlcaCTTdhO98TjOsZ0uVGVF2rnBt+rhRpfvC85rXOrVbnVlbae8mRYx6wgnz5i/
         Mj2YWPwAqsrqv0sxc5JUTp5bDzHZXHfo1WS+84zXXI/qnDxL0EMFEtaA/Kc+UG8YKg7L
         BLGcDhBNWtNaf4Z3IiZEO4sIcBYlCyLG2zltolNKv5Mk3sWcCDW9CQG42cbiCqlZqIkv
         CQ7g==
X-Gm-Message-State: ACgBeo3RqrVp/4O3QT8XvzavcLyA6YG5HOnmmF/fUMnE/ICtKbyIfCBj
        HzMUsS7uZ42Q9+2afF/WigHhl8pWvYm0
X-Google-Smtp-Source: AA6agR74CvzVSNoMfgJMhkgoW3tzfGVsYV/loT9yHflje8Np4KrnICz0V3tzbIuEozNJGPQW5nvajE6RSnDh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:aa2e:0:b0:674:d1f6:4480 with SMTP id
 s43-20020a25aa2e000000b00674d1f64480mr1535820ybi.591.1659080649673; Fri, 29
 Jul 2022 00:44:09 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:37 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-4-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 03/17] perf jevents: Add JEVENTS_ARCH make option
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
2.37.1.455.g008518b4e5-goog

