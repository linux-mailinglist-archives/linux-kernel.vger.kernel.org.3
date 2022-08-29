Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91F5A4CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiH2M52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiH2M4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:31 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162CF5588
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:19 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id f18-20020a056402355200b00446c8d2ed50so5361908edd.18
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=T2C4sxYRs2lEzCnHUaLRTNKBKI12YQqfPe+dPUrodjM=;
        b=Oei65SiBeyseuj2GkCMZu6UkQDXfMukCs8q/ts7docSju1x50Wnuyo56PNgsA6HyKh
         QIN3iALVpE4KtqSJCJw7xhEOCvdF6Nj4aaQRdldUGReSHeSUPlQtPNrfZMshM9WmIh7D
         F66kQer8IfUfc0aZZBJKqF2p8mQNUtHZduPcpyzmcjmfTP8IAtSfvKheWIe8pbsuF80V
         n6JT0dTHHJGAeqPEaae41JTQVmfHG3xrkJcxGeiFu5iSEmPx+AxR8pfqXZMWkWBblTqj
         qwkITtO1N1SMp71IBMV7uOhDi/g7bC6iP/ZkN9sylaZYO6ap321AAv0sJxlYpg70So+Z
         I9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=T2C4sxYRs2lEzCnHUaLRTNKBKI12YQqfPe+dPUrodjM=;
        b=xJBaTIeHPJK8dBNCPZqcKWOlxOonyNjOjRdyGtRXdKaBm8waeVAQOcLr+2DfHqp88D
         LsjU9lvt+BsmjZ2hCCyRlpvoa7W3foGlVt+dPWN2ssypYlW73/D+zfSgJDJWZW2PZtB6
         16Va9FqQYegCJjJ4/TQXlkvmRRBbXZVyOa2YJE9v1i0NaMa5aVMp0G3P3WzbZ4OEfOes
         movMXRyiPf6fKGBsphrWaW4Vx6bK1lwv4GqlJBPkCe/+srCJJDykQEJV/zQZ4cHsBvIx
         ObBSZ79pMAvF56IyBnkr5gp+bpN6Xk6bBqaov2VKKYQOUNRKiE/S64BWpY9y0NORASm8
         OQNg==
X-Gm-Message-State: ACgBeo2D2CAnMgotiN/CkkkSYKPgegIj0RPxH4IknrYaeBbk3BCUhhbB
        aV9e6lT7/J98lipV2tWSPz50L5/3cw==
X-Google-Smtp-Source: AA6agR7pPBxBn4gZSDR06aP3DtZ7Ndp+4q6FXFUDOBECLllaiRHkqTE+4IlfvAW4YcpDEfo5TzfTEk2i4g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a17:907:3f97:b0:741:84b4:8356 with SMTP id
 hr23-20020a1709073f9700b0074184b48356mr3916826ejc.148.1661777297695; Mon, 29
 Aug 2022 05:48:17 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:12 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-8-elver@google.com>
Subject: [PATCH v4 07/14] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
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

Due to being a __weak function, hw_breakpoint_weight() will cause the
compiler to always emit a call to it. This generates unnecessarily bad
code (register spills etc.) for no good reason; in fact it appears in
profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:

    ...
    0.70%  [kernel]       [k] hw_breakpoint_weight
    ...

While a small percentage, no architecture defines its own
hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
which makes the fact it is currently __weak a poor choice.

Change hw_breakpoint_weight()'s definition to follow a similar protocol
to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
hw_breakpoint_weight(), we'll use it instead.

The result is that it is inlined and no longer shows up in profiles.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 include/linux/hw_breakpoint.h | 1 -
 kernel/events/hw_breakpoint.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index a3fb846705eb..f319bd26b030 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -80,7 +80,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
 extern int reserve_bp_slot(struct perf_event *bp);
 extern void release_bp_slot(struct perf_event *bp);
-int hw_breakpoint_weight(struct perf_event *bp);
 int arch_reserve_bp_slot(struct perf_event *bp);
 void arch_release_bp_slot(struct perf_event *bp);
 void arch_unregister_hw_breakpoint(struct perf_event *bp);
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 9fb66d358d81..9c9bf17666a5 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -124,10 +124,12 @@ static __init int init_breakpoint_slots(void)
 }
 #endif
 
-__weak int hw_breakpoint_weight(struct perf_event *bp)
+#ifndef hw_breakpoint_weight
+static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
 	return 1;
 }
+#endif
 
 static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 {
-- 
2.37.2.672.g94769d06f0-goog

