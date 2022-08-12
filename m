Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EAA591786
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiHLXKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiHLXKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CA9C20E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f46b4759bso18622377b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=kPWsuFqycsY/yXV7nCgwsjWW6XxROqmLrLkaSuTFd4g=;
        b=rxjmjQpKDzS7G0C+9MAaUX4sdS40WxnORu9wsxkeSrzBbIrDyTkkvDdpH9Q4fDq8rv
         1FOwsDUFhyxtnNTlFm6bk8FTSLFgIBQ165feaBrjBbixMZJwjPDgJ0CJj5Voqz+MkcQS
         OFgBH5grTkKZLqcw2VK454e2fsMWDO0JnCawPq2l1SUWr6xLR5EgVvfwE8fckI/afazp
         eqxmT0m8FcGQhtrYM4PiGWk3w7id6oFmXcUnSOtSY9RELqp668za8mOdYexpauzIhvId
         N/VBFb8oVV+dICkKxaQSjifY+Noxt1g+iTpl/iNknx39MS5junx0m4Esj/91UL3vvegX
         T50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=kPWsuFqycsY/yXV7nCgwsjWW6XxROqmLrLkaSuTFd4g=;
        b=YfyQGBEEjQzvpgzGd/tNKqqyAzExJ3Pw67NRvFwXVr3DyqLiilAk9qMpRSY0O/w9us
         ByYCNySX62gpds4u/irsD3HKdOYQG68t/qTZfkuRM+vlmEGYMFYd4EkUw7Ym2VFWeYwo
         l3TvyGEyWM8bA553O77m49UoUmY3IdHGrQg2MZXGFF5GcbdATb1wDwFeaB40Nolu0r3r
         6QGttLNzwILUJaUauDjSZ4KSd2NeD80aOPyx+unR3cZxwsnHtPeTLrMxmKDvTRUYZepx
         PYbyaTCmyaiYWtOIEKW4j3n+bq+owbFUs4GQoDiTM9GpmUZQjUt75GE8lfrxAIWCGbd7
         5j/A==
X-Gm-Message-State: ACgBeo36kWRS+BUSweo3OgEjDtRaMQ5Irp22bnmBnzwbKP3CA1dQB8g7
        S5vkDDJrGH/iqEgYuQDRvSZn61ffxgF4
X-Google-Smtp-Source: AA6agR4VKEloBEmRShMw7+2nW0kl6o1FN+BGq8FKr+/u4UHKzqmgJpZpOlb1g2Fk8WRnCpI/DvA74SydZdIy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a81:1016:0:b0:31e:63f8:483d with SMTP id
 22-20020a811016000000b0031e63f8483dmr5606640ywq.199.1660345802166; Fri, 12
 Aug 2022 16:10:02 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:38 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-4-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 03/14] perf jevents: Provide path to json file on error
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a JSONDecoderError or similar is raised then it is useful to know the
path. Print this and then raise the exception agan.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8e8462cb359b..31936eafa9ff 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -225,7 +225,12 @@ class JsonEvent:
 
 def read_json_events(path: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
-  return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+
+  try:
+    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+  except BaseException as err:
+    print(f"Exception processing {path}")
+    raise
 
 
 def preprocess_arch_std_files(archpath: str) -> None:
-- 
2.37.1.595.g718a3a8f04-goog

