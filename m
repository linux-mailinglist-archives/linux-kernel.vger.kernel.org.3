Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC34258563A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbiG2Umf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiG2Umc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:42:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E097AB2E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:42:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3230031a80fso42152997b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JAvx/aPZFM84K2VRXkCj96/gkqr/BAMXs6GSNp+VJYo=;
        b=V53PMEE0lrxOpWpkbZ7I3MSGsA160CxKl8siF2oiGa7PW5vM5/pqsAHTNN2Gt+Rpte
         qY+T1os5lqgqtSd902UfCKyx0wTLCHruevYXFkvQMd5aC86+i8Q1mxBLZqO+LH/CV9pQ
         aGGeeOgmVwoSHwEfINbUeDfc/86o17CTZtiLaAY5Al64/bO6jm6kISdaay2uziNqrmTC
         xoYLllCO0Z6xMytEW7DjIKGBN3Nz8QGTxuVGUa0J0gDUs3TZLbXAu6vOJAoqLv11qRYT
         5NzczsptV05uCOrtvHC3kmGRh8KxaAk5WTxNd+240bSl9kCdf1y7KWL9LwkpkeSXTrcQ
         /6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JAvx/aPZFM84K2VRXkCj96/gkqr/BAMXs6GSNp+VJYo=;
        b=vDRmI3xTmDctZMmmL5ZvBxMmwWr5cur02MvVv7SZC7ou04V+uVKuQo/4W19eG8V3Jb
         j6lpeuPVk2HqfeS1NdsDybnvi0aCUXLRc4pjBSVt5POd/tVkAJscDFVo9saDwMaYWBaN
         Fx5wbGYknmgTXZC6Ok1B0r7wYKZbZ7r4dh5gKjNyg232ZdxdeCoZdtXPrFpvIYY2ROCz
         Mct5m2q9C49X3m9G6MN+6Im3GOOqTSvre/kfQjulcVlyYVzda4DzVnMfUZTA9K54pvxM
         Spm1GmDUnJjaZOFW3LDuf/ER8M6vDVu3lT3pm2sX7Vjy/iD1u9H0SjqnJpwFoQWBElTB
         iM4g==
X-Gm-Message-State: ACgBeo0/JJcwuOh7f+iME9CTdO/3Pc9l1HIOETD7lYUIUeWtYg5Ftkkn
        pCmcugGPBaAUYHk8ueThcHJcPt52Vr+0
X-Google-Smtp-Source: AA6agR7goZ0xK7lT1FUtE0B0l2MHYOZtcNWCfBwg0hQxOMoZ1IyhHxvrev0p66aRtZea+/26eX0/Puq2GP37
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:8c03:0:b0:66f:8a7:5a07 with SMTP id
 k3-20020a258c03000000b0066f08a75a07mr3864093ybl.272.1659127350832; Fri, 29
 Jul 2022 13:42:30 -0700 (PDT)
Date:   Fri, 29 Jul 2022 13:42:16 -0700
In-Reply-To: <20220729204217.250166-1-irogers@google.com>
Message-Id: <20220729204217.250166-2-irogers@google.com>
Mime-Version: 1.0
References: <20220729204217.250166-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 1/2] perf parse-events: Don't #define YY_EXTRA_TYPE
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Adding a #define to side-effect a local include isn't clean, for
example, it inhibits header precompilation. YY_EXTRA_TYPE is
defined to be void* by default, so just remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7ed235740431..8012db830814 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -24,7 +24,6 @@
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
 #include "parse-events-bison.h"
-#define YY_EXTRA_TYPE void*
 #include "parse-events-flex.h"
 #include "pmu.h"
 #include "thread_map.h"
-- 
2.37.1.455.g008518b4e5-goog

