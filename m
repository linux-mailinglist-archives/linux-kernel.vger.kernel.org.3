Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C5513CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351831AbiD1Uci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351821AbiD1Ucf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:32:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F1DC0D30
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:29:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c322f770so56700107b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=bO37AFCpe1/E1wIgqlJlZti6Su6aZgapKCGNNQ0qvyY=;
        b=YtNmFiAHUlm9kDuzzsMam1KjATnxi4mjsWWlVSXCASDjopMVUgmqOXfxYU3WqjrWuo
         HJPp2c0g0UkuQK5RLYoBxkQhZWbFc1d0/8YPiQb7/JVzTCwUjqUXlMHcp7G36RNx/XUg
         7epg9i5/xrzLJCoOGOd8srdk68bGJoAZIsVB8mJiIhGM4WXjS7xwM3WkXbklqhq6hyla
         HcFyqNhMhTeuzinC0xn3CEgbCESJ54nDVn2SMzdYNtDzwzEnRe7g6y0yiC9WHbHpmUw+
         Tr9uas6Fas17VppW9VSX9V/A6rDkc11sSFYzHpkuxw6wY1le+WXZzjg+JMjdA2QTcI8y
         rqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=bO37AFCpe1/E1wIgqlJlZti6Su6aZgapKCGNNQ0qvyY=;
        b=dyesyJVsRfrI5n1Sk4zuB22l9KedYFDJPMdP9TkBbCTPHnRsm0sBvr0d2lV/JUqhPw
         OClMkDY979r/ZZpqi4QmkriHkfbUsFNbVP7oz/smZVcnSNg9WRj26kbg/oTPQnEY6pT7
         KWUkhWTOn3aQxI3wBXWef50kMMbP6LBW4qRz2MGQYU6hjSL0Qj9Twn4Xribjk6BTKOBy
         JfrM21/aD17tp0bBWExMEzMAdmZkTMNVZQavbWdX4S8gfUuJ46+keB7LjyxQ7N/CkG87
         tH579W79hN/dnCyjgqD9t0OQ7dDlu0D09pcbXKxmat51dS3P9yUaXO2ktVJjWYsdhlrk
         oMXw==
X-Gm-Message-State: AOAM530n1QfdWTtKFfuk6w9H//fqo7qBrUlBuBUzqd7a9id/FvbYkFdg
        AtYyMCKAw82Hz1p9nVEWvQ7hngAb3lPH
X-Google-Smtp-Source: ABdhPJyGVJ7PjGpPvXxm9zgkSvmK9qcOgX2lV9sz3ErQQnYDkU2b+aDsJqp6yFxFeq1vIJNtLvcm0BK8o9gQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3c33:ed69:1770:973e])
 (user=irogers job=sendgmr) by 2002:a5b:cd:0:b0:63d:ab85:a6f7 with SMTP id
 d13-20020a5b00cd000000b0063dab85a6f7mr31688296ybp.290.1651177759300; Thu, 28
 Apr 2022 13:29:19 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:29:12 -0700
In-Reply-To: <20220428202912.1056444-1-irogers@google.com>
Message-Id: <20220428202912.1056444-2-irogers@google.com>
Mime-Version: 1.0
References: <20220428202912.1056444-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 2/2] perf vendor events intel: Add cpuid for sapphirerapids
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes compile time warnings:

pmu-events/pmu-events.c:27238:31: error: =E2=80=98pme_sapphirerapids=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
27238 | static const struct pmu_event pme_sapphirerapids[] =3D {
      |                               ^~~~~~~~~~~~~~~~~~

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 963a76fec277..4b47ac1b806d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -41,6 +41,7 @@ GenuineIntel-6-A7,v1,icelake,core
 GenuineIntel-6-6A,v1,icelakex,core
 GenuineIntel-6-6C,v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
+GenuineIntel-6-8F,v1,sapphirerapids,core
 GenuineIntel-6-96,v1,elkhartlake,core
 GenuineIntel-6-97,v1,alderlake,core
 GenuineIntel-6-9A,v1,alderlake,core
--=20
2.36.0.464.gb9c8b46e94-goog

