Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC0584CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiG2Hoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiG2HoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6781B2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so3287694ybp.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mqNHYsVWGj0fcO4+XKl+I9RLjcmp/sKEanarsLP2wxg=;
        b=RJcVJE+hnyZrLqpNeLhiP9SbUZi5PF1h2Xz8hG5gfDrto2ZQvRbIcC6+pAXjRuhbXS
         hxf5W34jXcMzU2CSQeY4iX89QrtXGzGakLrL+jut524o4UiZznud+g/U7dnxxAqrqlQT
         pzXDXlpBwMSb0l3uxn+/I7DzOr+PXPhV5f2aefc12bYS8AsaCHGNI7SYJli4tevGjywb
         sjAke3+r/1BZzyPlQMjKvu4ZlUqYoJZIcGX2HFRv2ByMovs9934a832sOvC4E/EY360c
         Z9KwuNdsFQwBBf5wGlduUlXAcoWQRtqSha80ussn7tI3v6pjtpcTMvkdeP2C/mBzt5DT
         vnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mqNHYsVWGj0fcO4+XKl+I9RLjcmp/sKEanarsLP2wxg=;
        b=EVuL8Q1+cUP3X/SJ3gSPA/f+DubrJSsygUiHBR6OgpBjXUBxCpnqm2tNtE/r9eRq0U
         oaoNrPTsHvNVYMpjzp5gHPuTO1tYEbfuUxoJKpaagE6AdxOkv2GswfGbEDaRZSogJuat
         CJ2ExNQpZ2fIQAKfOcFGvGwOx0bkv1J7EmljvL/MQY8THOMtbYPuZmkmIyxkKTdybOsF
         fxY+0tE0cpinM9dM6w6ZWGASs8Un6IcdKmOf1XWl39zqO/PrvJNQug7Sod80BJod/9ji
         DIgnEaP8Agoqikk2pAJqR80BGOJRD3V305c5Io9IkSAEeDv56oXnrK/+fOMk9b9Gj9bS
         3n5A==
X-Gm-Message-State: ACgBeo3yi7Ocm5sTdEzbKBKDkpYw3MEZ/QQ+yITnhbOxRLbU6Ivglpd7
        XufqCzYHJzcg//5MThipbzIsANJHD6Gx
X-Google-Smtp-Source: AA6agR5bkDJ5EE78BgJwxPU+WAXWDt1bh9VDrLedHC8RwnOPxWMaMu2tKQ6y1risxyc6dYbK0QDT6tXW0iKG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a0d:c602:0:b0:31c:822a:c168 with SMTP id
 i2-20020a0dc602000000b0031c822ac168mr2198798ywd.134.1659080657058; Fri, 29
 Jul 2022 00:44:17 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:40 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-7-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 06/17] perf jevents: Provide path to json file on error
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
2.37.1.455.g008518b4e5-goog

