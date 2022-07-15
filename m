Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76B575BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiGOGh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiGOGhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5147542AC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317f6128c86so33983067b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7M+GYYtNjRF6j9wlPTn7oQQUyE7jpd1eRRPdaQ7NUb0=;
        b=G8OsOx9NQ5S44AxvV1eJpCSFqDL7WyhFawmnWQt1pl7AmVtgiowr6ISKMfY4j8r/1P
         ckki4/iFRs4CG9NEIx376vxZ+loqvCECslcc9KyPV3/iRMIJun/nesiLtQUzTfODVxPT
         dxcCAHnqRdtkaxrIJrXc3CQF9c6qM9USh1x1ciJy/4CAWpJi6PXo74x+CT3JtvG++2Io
         3gOaD0buaEquSfph1KhrsfodvXeiiILEc+KnJNq+vcjuXhA1MD03r/aCABrc4NJZZ6ru
         MODpbXHXW54ZODRLWyXZC3DLDzMPV97SQB+gNFbjT0QqJ3CqjObdWU28iHLpmpIoFS5s
         lWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7M+GYYtNjRF6j9wlPTn7oQQUyE7jpd1eRRPdaQ7NUb0=;
        b=Fx3MnBI9pzymD5wVtAZr5fNQ1DzsJXwvw5iwaL5WwnZQG2Qk5KZNUt4SfL00z0gL22
         KqWSJprNgwBkAPEEHWY/zG1k2mTFhT6lrWGu+32l19JVGIFua7ADeEijRRyd97SI6fDp
         iQHWGxG7B+H2U38wgmkr+y1qABZzvqC64BUIkCfvY+subY8tr/zt7Q4gbykhYjQDWtnr
         WF/NiVIEtPx2vGOCMuwziS9YEIFlQla9Nx4JjvqhdxgFdJ3swL+v+xjG5IjalQttSO5J
         YawTPM7Lw9ceU10d9Mb1WZ97fJ2cDQpM3+cCzfLuDSYahVR+IgKVlBvgYL0WGcDYuepv
         kA7Q==
X-Gm-Message-State: AJIora9BjOb2KpWg52/F58vfXJMQlxoWX2OoPLT+VPcn4bsRTGF3uhnn
        fb8RUpP8n63c5l3ZMCxIigJdXmT7PxT8
X-Google-Smtp-Source: AGRyM1sfq076xPFf7fCPFMLcz7pfQitfffjVWX1mfD0w39Vf5Q+0y+4WjiioFd8z497Furdboc0OdtrVApRe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:d7d6:0:b0:66e:47b3:35be with SMTP id
 o205-20020a25d7d6000000b0066e47b335bemr12494781ybg.140.1657867038611; Thu, 14
 Jul 2022 23:37:18 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:40 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-3-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 02/15] perf jevents: Add JEVENTS_ARCH make option
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.37.0.170.g444d1eabd0-goog

