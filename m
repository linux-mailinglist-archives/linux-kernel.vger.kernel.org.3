Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3658483A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiG1W2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiG1W2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:28:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A737179ED3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6-20020a25b7c6000000b00670862c5b16so2537749ybj.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=HObRHFStBoemg6GfI4+h5JYgUZukoxtFMi2PAd2Rato78ijb6eCh0S2Rt4+0kbGtOU
         GDQz1AnPxYqghWmBpbEm/Pn7gEf4QlqJIpikzSE67GKHZgxOflw887q1I6b6BOH+PSyf
         obqRKJOdaJf/oK0pmMmZU62j3Cy2KozQJvbEsOlYYO1gXAol1hlyg5ax6+UwD6B/Kupz
         /LR73Zuo1A2HNLhs08nhjoAYbXKKBdTbyJOgbA42u9Z3TjhwR6NNxv3iJgjcXDuvNnvQ
         BkPNAKKNP1FVCVBWo1fjgIoXi4taTzcX8Xsfa1W5JLgC84/CcBN7ZNr5ooilyedMiHMf
         w1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=Vooij/y4rls5i6BBPO6LVGIkKcFqkdjTcP9DPvBSS6ErVhw3haRJrPsPXrNx9rOjVd
         pNg463MuTypsshi170Ot6bIsOBITLcfYd1hDl08IoKQq0552mVUaNFI5kGCIpPE0ejyY
         EtV2aN7RKBGYO6xqspfKYXYHoeabQpk1+IvlcKqUBQBFLNU+ddPF6kSg5OYdCwaXYiRQ
         8LALgvl3kGyVfeiG69M23TavqWivkLkP5xuv8emblYSXcYGEd91H27f43DK7hjcNmqnz
         6Vy2Grj9d/QI7Yis9MGCTzOm1Y/zwKyQ1WA3rY2mHTeLH84nLsksLM8dsBmJWuiT8tDa
         bH0g==
X-Gm-Message-State: ACgBeo0efUTrR9chwcIY87qloQ6liUbcmVDfI0v2SG4jPcnDMpBqSI3E
        F48ftrlIGNfCE40+HtchgcO/GNqQU+5X
X-Google-Smtp-Source: AA6agR4KMM6ibROk6K6x3Xs/pYrP2iglSVvJhgBg1irTNchS8x1O674NlSSRMFVdz8YX3RikNrKvNLs5A9mj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a25:dc7:0:b0:671:82dc:2ed0 with SMTP id
 190-20020a250dc7000000b0067182dc2ed0mr619835ybn.220.1659047324914; Thu, 28
 Jul 2022 15:28:44 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:21 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-3-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 02/16] perf jevents: Add JEVENTS_ARCH make option
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

