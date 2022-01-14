Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8F48E461
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiANGs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiANGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:48:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BAFC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:48:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e18-20020a255012000000b00611b9fa7078so9448560ybb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HMm6lw8fmCzwK/qAm0rnyqsh44zJLqbdDkWenpmSRLk=;
        b=AGp8bk4dNYz2YbKjz9F6ldM9V3L5xbYpFX1f0d3EF53J+qNT62etz0c8sX1TGsKpE4
         qG00hl7piKfpBWc4BCmhN1suswNqET6HwzK7lVQZcsTAhW/VaqmJunyk/JS5z++hTrYv
         h4Lg/3oWROm1BxNDxodMmPdPbgs4V1KvKzW+/gRJz/8h/KV8Jc+K3fCAHp9cYurcHDpD
         43JqK/bqieDuu9eBrTfG6CCiHIegCRxtZ2khankhOKtueslTns8LvHRKsmi0T3Z7VPdM
         q19KRFfX/FGRi4Tp+i2kdfrirlbGiFyVZE8E+CeVSgqcvBN6fMLQwMmbH9dPRh0pSEoJ
         Pj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HMm6lw8fmCzwK/qAm0rnyqsh44zJLqbdDkWenpmSRLk=;
        b=n94Ldi8z4ecXFHoxJCl4M61lqYIgm2fQfi3DAyodPW7GKKdkxgHWpGqQ7oL19t0x5+
         QiSj4fs9bHWU8MzmxSWySJnuj+Uklgl9LoQ7Ai4hsUCCNKRmBRLATlyouAWyeZAaisMH
         t4Hh/CcUWKSDs33uWmvz0O0YtNkDACPo/Givs9pebnjvCQZbx4mSGSjIsaDmqXh5gp+u
         uDaAsTjUgAEteP3EbtE1Jv/f6pXDyS0aJD4Wi2Ua/jx6aG9mw4ME/pzTrZWcv35fSv4X
         8eAS8H3ofRJzDzlL/PYt6v+QANA7B+2SSzm3mSrpvxpGr+KJOcIS8JU09i5t3rYJf2Kk
         kq4g==
X-Gm-Message-State: AOAM532ABGRy3UQWsitZPh22axsEocu534Omex9gCARL5qimW8xjxIhm
        cE4JBNI7YP9+kgALStzbZOCb8OaGcHQ1
X-Google-Smtp-Source: ABdhPJwhxSzCg2gZ8CBq5yz4UF4rfjyY6GWEipaxURLLLH8fw6VkrsGuN1NI99Vv8zva8uUfdQyNniXroQFK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de36:7cc:6c7a:b7cd])
 (user=irogers job=sendgmr) by 2002:a25:d648:: with SMTP id
 n69mr4603717ybg.371.1642142906649; Thu, 13 Jan 2022 22:48:26 -0800 (PST)
Date:   Thu, 13 Jan 2022 22:48:22 -0800
Message-Id: <20220114064822.1806019-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] perf arm: Fix off-by-one directory path.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relative path include works in the regular build due to -I paths but may
fail in other situations.

Fixes: 83869019c74c ("perf arch: Support register names from all archs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm64-frame-pointer-unwind-support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
index 4f5ecf51ed38..2242a885fbd7 100644
--- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
+++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
@@ -6,7 +6,7 @@
 #include "unwind.h"
 
 #define perf_event_arm_regs perf_event_arm64_regs
-#include "../arch/arm64/include/uapi/asm/perf_regs.h"
+#include "../../arch/arm64/include/uapi/asm/perf_regs.h"
 #undef perf_event_arm_regs
 
 struct entries {
-- 
2.34.1.703.g22d0c6ccf7-goog

