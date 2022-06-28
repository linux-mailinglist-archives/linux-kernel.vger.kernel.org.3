Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7F55CB97
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiF1J7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344617AbiF1J7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDD2ED6A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3177608c4a5so99088547b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ar0tQaDtQRVxSK1L64O5LGBBBeYgKP9H/0S8vYb7eY0=;
        b=QDaFAZbFppsXaGKVqzfkonMpccyr1cbOroDVbmeHjzV5Y5PKhzNM4NZ4HtvM2w6F5X
         qS3uJLF/cnyo+Y9dbZmY4O4l/xiGaBWPD8yy9soRQ0MVn8obJY7/4CupDFChWXOS0d4M
         g9Z7akfK1xChH19AZzJG+bP+GG6rojDxrnmRwxICTwa939HvKZYiSQWXLQK58qOGEFJ6
         07lg8mVua/7rqrL/A4yl+GSFL7zEk/c1UsOEDsSQgQ5QaXVHZByNl65yUJvgGyM8f5uI
         D49G3Zf6ZhA+eiMN2aMH510qgfvOXQCX3lEL9qzEBWpg1nt8B7Xc+oXqvgghD5d51qlK
         3LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ar0tQaDtQRVxSK1L64O5LGBBBeYgKP9H/0S8vYb7eY0=;
        b=kF1Y/ynhqcFawBbnwlepqumargIsXzWYbLeWeEo+xaRgQQJZe2ZnDFXMERb/WuTev1
         8AMnW2+EYUzHq1If789lJoD+00j1jUsFItxBDCbLAH9Z/QSO3ofTe+hmI+RZtGNteuB5
         vLrD1CEWZRrVYKIlHC9pv6zsNdP/wnRfFmkAhAACYFZsriM52A9dbZN0AeSByuYOZQpH
         wZZKZZqCWN4K4D3Tz5P6a8hkiOs9Zq2bsm78nZGkvVRLRfwkZOxbCKd5NIH0y7GEVNdr
         MzvSy5l7ImOLleT118KnHZTo9NAbcnXPTx6kcJh1W95PuQG35VgPrVxdp9CM2xDFWTpc
         E05w==
X-Gm-Message-State: AJIora8oEeRkR+Dr/AJXXBHlt5UBuRiGn49J5wahJQhgTT9lO2xOEtLn
        r4vzW7AjWHhXC+XXY7OXiy9g1I+DBw==
X-Google-Smtp-Source: AGRyM1tI+zmY9bXD9lPsRaWsu6mvsAtKuZuIuC7/08NiJKMQvXlU/prcjNa4TCejWigh16YxBHUIR7IxOg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a81:6603:0:b0:317:8d2f:e255 with SMTP id
 a3-20020a816603000000b003178d2fe255mr20169767ywc.166.1656410355202; Tue, 28
 Jun 2022 02:59:15 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:26 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-7-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 06/13] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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
---
 include/linux/hw_breakpoint.h | 1 -
 kernel/events/hw_breakpoint.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 78dd7035d1e5..9fa3547acd87 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
 extern int reserve_bp_slot(struct perf_event *bp);
 extern void release_bp_slot(struct perf_event *bp);
-int hw_breakpoint_weight(struct perf_event *bp);
 int arch_reserve_bp_slot(struct perf_event *bp);
 void arch_release_bp_slot(struct perf_event *bp);
 void arch_unregister_hw_breakpoint(struct perf_event *bp);
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index a089302ddf59..a124786e3ade 100644
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
2.37.0.rc0.161.g10f37bed90-goog

