Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F23584CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiG2HoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiG2HoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A465809
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13-20020a5b09cd000000b0067114eb5b50so3287354ybq.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gJpUpfYLbWgWjOwgXjGO+9lnopmpvExo4+EzC9HEZTY=;
        b=dGCDlxqp0N92i8FI8IxZI0RMts2CVs6exeUrA29GDqYZd2sk37RGoacdGjeaGAaPEl
         veyYOZBOQmOc24vq5FT0+v67NmYoZPupwBcSbyu/TNItgl51jakqAeFTk7FmNHcuwF5s
         pyIEjbOqMtfjIMC0SNfrA/UQR/Pr/nXMZCMoS2MA3Tz7jvRTZwt4bIihGAMsFxtssia9
         seAGqe9IhHByUB8BHUkgIW6PmueRB80GtUkYVRFSbRtaBOL1aiIn8a/sQ1FGp59m7yT7
         JqR4pii4eZKYpIEeR1WUkTYi/kra01qzW5F6bRMrxFc4RW5XMmwU+T37ESVmuzmhsVCX
         WIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gJpUpfYLbWgWjOwgXjGO+9lnopmpvExo4+EzC9HEZTY=;
        b=VZK6sTwo1VbeYywkK/KbxdC2GnidrKvhx2biUFKS9TLp7oxsci93UOAnSvjbOJ/CwS
         zvuo6t/PIOKoFyzgtrR46rOgRqFA76RPiyb8gxEqsKwBWLNNVgwAC1O2xp1jtJZBhXiM
         +SPlUURLW8PQS5TIFOUGTeo1U2MH3tcNpTmtqp26zmBEkqjnANozi1BrGx3B5aGtClGa
         lAy1+UNfei4tHWDqDFBDsbe+U/cicue1qE0t9oBIe7fFDNldS+B+yVq9Ziy33eChWsB+
         wMdgQZCWL0AQWJvlmmciL+6PFm3Stcc+KW7kMY6SceTLtrpKPXzFKtTmvR3v5R+KVs5e
         Fg+w==
X-Gm-Message-State: ACgBeo3G45o1Fq13sC1lB3+vCU/+PQ3OEC7n9YK1h601pdYp9VX+4XAt
        hsEqoaotmzq1UFaHtHaHp5SHEre4ti4w
X-Google-Smtp-Source: AA6agR4xDcMfnB3k6eIsa+YSBZau3gw42uQA+UFZp9uzUXHPo8lYPYIQ1NrBgvJdmk8BPuBm/TWyurtIPhKV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a05:6902:70c:b0:670:bb85:766e with SMTP id
 k12-20020a056902070c00b00670bb85766emr1640653ybt.428.1659080644298; Fri, 29
 Jul 2022 00:44:04 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:35 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-2-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 01/17] perf jevents: Clean up pytype warnings
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

Improve type hints to clean up pytype warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 83e0dcbeac9a..5b72048d50da 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -6,8 +6,7 @@ import csv
 import json
 import os
 import sys
-from typing import Callable
-from typing import Sequence
+from typing import (Callable, Optional, Sequence)
 
 # Global command line arguments.
 _args = None
@@ -57,7 +56,7 @@ class JsonEvent:
                                        '. '), '.').replace('\n', '\\n').replace(
                                            '\"', '\\"').replace('\r', '\\r')
 
-    def convert_aggr_mode(aggr_mode: str) -> str:
+    def convert_aggr_mode(aggr_mode: str) -> Optional[str]:
       """Returns the aggr_mode_class enum value associated with the JSON string."""
       if not aggr_mode:
         return None
@@ -67,7 +66,7 @@ class JsonEvent:
       }
       return aggr_mode_to_enum[aggr_mode]
 
-    def lookup_msr(num: str) -> str:
+    def lookup_msr(num: str) -> Optional[str]:
       """Converts the msr number, or first in a list to the appropriate event field."""
       if not num:
         return None
@@ -79,7 +78,7 @@ class JsonEvent:
       }
       return msrmap[int(num.split(',', 1)[0], 0)]
 
-    def real_event(name: str, event: str) -> str:
+    def real_event(name: str, event: str) -> Optional[str]:
       """Convert well known event names to an event string otherwise use the event argument."""
       fixed = {
           'inst_retired.any': 'event=0xc0,period=2000003',
@@ -95,7 +94,7 @@ class JsonEvent:
         return fixed[name.lower()]
       return event
 
-    def unit_to_pmu(unit: str) -> str:
+    def unit_to_pmu(unit: str) -> Optional[str]:
       """Convert a JSON Unit to Linux PMU name."""
       if not unit:
         return None
@@ -154,7 +153,7 @@ class JsonEvent:
     if self.metric_expr:
       self.metric_expr = self.metric_expr.replace('\\', '\\\\')
     arch_std = jd.get('ArchStdEvent')
-    if precise and self.desc and not '(Precise Event)' in self.desc:
+    if precise and self.desc and '(Precise Event)' not in self.desc:
       extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
                                                                  'event)')
     event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
-- 
2.37.1.455.g008518b4e5-goog

