Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46C5A4CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiH2M5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiH2M4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:25 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444AF760E0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:08 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso5420173ede.15
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=Xnrbr4NWXpH3ILMfaL+Hqy6Mh/173nAe6Rh4Ql+SwwA=;
        b=aoWdQSkdpteyXmYAo1c6eiVE2udp1iPCkTbGD3cqc5tyTEc5w9TDE5eQ2pH/aC5ONx
         wvITjNHuqGva9IIaS4Jy/kRGfM87daq+ZT24dKaI5knatHyVNPce7SKxJrvTIxK+jpRV
         T+oUK6JwmqGiqfWOw+qZfCjfKSncTUyCL/rTKrD/R/uwr1cZQDo2BiYCLIVtBSK8KpsZ
         CLE54Tvl9hptOey0GrB4CQxeXWFE0oHlZwm2u/7tiypSnfTXu/PJqf5/FBc4ceMvlGJj
         bS8z75PhngVBIBAZf6h+e4wkxi/WQq7RrV8yo3ue7h3N/zwN5y8SZVpJk5+wDM79X8yf
         2pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Xnrbr4NWXpH3ILMfaL+Hqy6Mh/173nAe6Rh4Ql+SwwA=;
        b=zA3Fgb5Pwa8bH81tX4xNdrC9cmtnVLA1EpsBG11ya8iZ3QwBelGgLX7Svc5feu2zb0
         Ol+8f8nrw47tQKCniU8zYoc4muqpA2bjAUzp5JDyUzdo+6tdn1Fa8noahGwDYSFXiFdt
         kEEcfEMCTI9qD0yfr2C6dZ0bVb/veAZpWsFEpgxzTQdrDEKzzfIMAI/qKgKjDTYcqcBH
         PEp/iP1Uu/VHUup6RUujdgOsLQIpJXtp+t3iaAME4EADwsloORzSzla0WBc4rkbGgZVd
         bkcnc7oSkmEOX17XKEg/XZtME2/qib8zXenOr+xe91imLKkdh0fSs9IQ0d9mFuZkTkIb
         JpWg==
X-Gm-Message-State: ACgBeo3JvJx1wWh19LGS6KYyCd8yBCXMjPTM99E6vw4lCnqNjjw3003d
        y+avQWT2kvCQidLjXT+gqwQgSGsNNw==
X-Google-Smtp-Source: AA6agR42dMVaiS+cJuLOtzyugHi3iaDb9VrUvxxRA/60qGgLveidvAmI7LaoSF8LrpwtVNgvbP26lurGuA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:aa7:c946:0:b0:43d:3038:1381 with SMTP id
 h6-20020aa7c946000000b0043d30381381mr16380942edt.354.1661777286713; Mon, 29
 Aug 2022 05:48:06 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:08 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-4-elver@google.com>
Subject: [PATCH v4 03/14] perf/hw_breakpoint: Clean up headers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
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

Clean up headers:

 - Remove unused <linux/kallsyms.h>

 - Remove unused <linux/kprobes.h>

 - Remove unused <linux/module.h>

 - Remove unused <linux/smp.h>

 - Add <linux/export.h> for EXPORT_SYMBOL_GPL().

 - Add <linux/mutex.h> for mutex.

 - Sort alphabetically.

 - Move <linux/hw_breakpoint.h> to top to test it compiles on its own.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v2:
* Move to start of series.
---
 kernel/events/hw_breakpoint.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fd5cd1f9e7fc..6076c6346291 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -17,23 +17,22 @@
  * This file contains the arch-independent routines.
  */
 
+#include <linux/hw_breakpoint.h>
+
+#include <linux/bug.h>
+#include <linux/cpu.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/irqflags.h>
-#include <linux/kallsyms.h>
-#include <linux/notifier.h>
-#include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
-#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/bug.h>
 
-#include <linux/hw_breakpoint.h>
 /*
  * Constraints data
  */
-- 
2.37.2.672.g94769d06f0-goog

