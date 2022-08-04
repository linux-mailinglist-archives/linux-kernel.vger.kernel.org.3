Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3B58A329
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiHDWTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbiHDWSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52071BDA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:18:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13-20020a5b09cd000000b0067114eb5b50so581491ybq.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jj3QL2VB7yeMKctZCaHc1b4ABIGklkTL3vOmKj4cY9M=;
        b=naXkqYvmoVUVtTztzNIGjOQUWNikWsYOV4jgsyFyUFZsEVsaKf8MXMW+zQer81F4XC
         MiE02JVtmba5DXcB7DEo0SVOrShXwyh+1RvYubTHhKuCLHRZiY6lUCccPNhELDCPm8Vd
         /CTEf/hWXLcMlwY6vw/Ptfm2HOcv2cyC5i6A976rZx1jUi5s7RqHjsAUN0YER66k0dpn
         bbYxMXZWYUuTpnJD4Ln1S98YScsV3aZMxMAQWEG/Ssze9SKPp/I7o6xvEjlHYC6mSkaY
         vCYf59JQoZkWBuNWZqVb1OSW3LguO3UGRLk1uXRHG3QhiBsTITXT21K+IBjFNE/9nAqX
         sdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jj3QL2VB7yeMKctZCaHc1b4ABIGklkTL3vOmKj4cY9M=;
        b=Co3dTBSc4w63NxiQSOaRuJHC2pFEzL15C0fDF3LtRtBRVPijoz9zVU4jBB0SwaG5cF
         di9O9xBnXdLgKKiMR1QQ+wnNcCpB+QJFZHC3rVkRU84qpj2d2IOtCws52LjW/OXXUpW/
         S9cz7lKLR+Gmv50edxGBIat1La5mXtlWWsju4v8MFhPbkYFq6aHOwXp7lkjlkh5Z4RvL
         r0tm7gz10jFv7uNl0LHSDOZkqJLtxlOkvJnsTRkfAsaAoTDmXcU4uaQXp4BI9ow78MKY
         jQnsT6AVrwkG9bZBlVkixXDQVvv6Q5/LO6QzBQ9m3mrtLSO+voVPUqe9l28MCaq7q0xA
         gvOQ==
X-Gm-Message-State: ACgBeo1+hAK2zBui/uFekDtHPKzz8eCVqUNZJUTLn+qJYptJXwBtZ4tQ
        n79Et2Rj4IwuS+4dP7eUVUV927ysiqfc
X-Google-Smtp-Source: AA6agR6rZdiG6AKqT8iby13icVKn/mvs7v0tmX3sdWha8vwGpee+4AOmvaAMXvvm9MSdbSfLPmP8mirEpP+p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:604:0:b0:676:c237:ddf0 with SMTP id
 4-20020a250604000000b00676c237ddf0mr3204397ybg.71.1659651519224; Thu, 04 Aug
 2022 15:18:39 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:05 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-7-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 06/17] perf jevents: Provide path to json file on error
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

If a JSONDecoderError or similar is raised then it is useful to know the
path. Print this and then raise the exception agan.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 98d18d5c3830..12d2daf3570c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -224,7 +224,12 @@ class JsonEvent:
 
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
2.37.1.559.g78731f0fdb-goog

