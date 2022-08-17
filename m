Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8500D5968BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiHQFkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiHQFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964D5A83A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-335420c7bfeso8487937b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=qHxxMbzf5P1kENTIcu/skD1A7VW/ZSQMIDyzork9iPw=;
        b=gqVyKJEKg7FHYfUlvFZRQ4gywaDxqgOla/wYNSrRrpQPIOeQgd8otSDUR81rYz06Pz
         86FwoEQRXDngYehTse62DCp3ULAG3zl2VVSHPUTcSch9dCd1GVJmHLNIuS9Ice2KYHSE
         /Ph6X2GyUQLtHLZp3hUMsFENjq6wAqo+qn5EpWgzZcCvi33yqo5FpUFubMhztDoufgY/
         s/YaI0T2hL8w14sHHW7W+c6Mmk2yfQ/ibvJzRLrLjAkzecGwLWICJuoLQBTNOna3XZbI
         VnFy770xGVxdjDk9dXHvkb/ZqSHfM1yhNZARL1EQll7tFtso8gJjlI04p5hAKF0gFFP7
         BTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=qHxxMbzf5P1kENTIcu/skD1A7VW/ZSQMIDyzork9iPw=;
        b=7TFLs6iY/uI9o/TCyOChTfAhPdtTfAo+3EK3E9ZjV7SkRKdHpfGu2biQtuZ4P1O0cS
         Zeohcg8v5ydTV2ves0Edl2pF+EX9tTVxyekPKxTf2dqC6MPmPUIlI8rZ0mLgxoNsbN5T
         RkSp7MOe2U8cPALjrwGKhvNpXDc1mkLTPezja85kumtklMEmc6vqn+oDvnvzfmmxrhVh
         KW2AsuGf7H7FhCyGP5tu0lIX7RwSW8gnRVwct2B7QLdb4TAmqIifSPh3pE7yJajx2d4J
         WI0jtT0x7TAfb3/p+owdecpp47d5TyM0H4ZZGnK2XYzCpWH0hIPguJQqkDZ9TOPhyfyb
         fbsQ==
X-Gm-Message-State: ACgBeo2k5e+tEYez1bqU2MGmm3hUrqV2lPopU8LGFvRSC4Q3QHo3w+HB
        EaYwXyAEKQHawpp3NUXe/UfxnPuzQn+a
X-Google-Smtp-Source: AA6agR6oqIM30UMn/90m2gApF2R7Le2AepInoK1oGfNY9eAWaYg7N++h7MaUpqoBJDhq2iKEZ3Oi69J7zqh3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a25:ce92:0:b0:680:c480:4a8 with SMTP id
 x140-20020a25ce92000000b00680c48004a8mr19112893ybe.299.1660714791094; Tue, 16
 Aug 2022 22:39:51 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:30 -0700
In-Reply-To: <20220817053930.769840-1-irogers@google.com>
Message-Id: <20220817053930.769840-7-irogers@google.com>
Mime-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 6/6] perf build: Enable -Wthread-safety with clang
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

If building with clang then enable -Wthread-safety warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0661a1cf9855..0ef6f572485d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,6 +19,11 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
+# Enabled Wthread-safety analysis for clang builds.
+ifeq ($(CC_NO_CLANG), 0)
+  CFLAGS += -Wthread-safety
+endif
+
 include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
-- 
2.37.1.595.g718a3a8f04-goog

