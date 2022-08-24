Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4259FEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiHXPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiHXPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:41:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A790999259
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33931a5c133so211753347b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=GrPou0VZKgNlblC435aJ0/uQRkx4htFwsCEj3e4SObU=;
        b=N1o6OUXGC/iH2ijb+lNFnDPHgqw3EE+YVt/w/YNG5LZUfFDtYUy7DPSHSoCRfmQwJS
         GEW628oNDtiSEG+TR9DYt4rWnaj3cDMsOXnilUJ370jMbMm2KfNgR9m9Ztnive72kTrg
         OaXWIVL0131N9ESH7zWki2HFxKiH1rI35QiprRkAJ13BoDEnL+LlSMy/HEWT438XtiMf
         WGYAyjrFhnpcRX1qI2eaj3Tz+LyLgSHEugk/D/oOKrB0J9WujNMqEsCeVjZOH7UIoT9C
         YQYpw/2SUA7LK6rmLDDGa50cJB04mKuYyUDqd0YphGCt9YPiv0IJMleBR3DizoZje5+w
         Sv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=GrPou0VZKgNlblC435aJ0/uQRkx4htFwsCEj3e4SObU=;
        b=aY46QS0VsVKNHaV8BhXKVpv9wm5yblmQUMQyUbbJ5zdhUYNTwG4rCtUvL9zeJBWA2t
         9BenNiQ0EfYQ0JP/miAJROwnr69C7JtKE9PEDmocAuXOE0f7FUKlGjvt7YDXNJpHpNee
         NmIy/I4E6JM0d2Crnt3ZNA400VS2T6DeVMHZNAA5t1is75Fv0hsD2AJBzWsLeADZozKI
         2Q47ywji6QN5SZXGfG2Lpj3T9d3RKllIp9iOVQ1awMH91ft1eLDTRqB0KzffmvoAf8XP
         xpOFhBKp/f++dNMuhp9OH6ues+1OZmsQGVZlO4OLYa4Xam8LCfugpHZxX+M3+DjCcELr
         nMAg==
X-Gm-Message-State: ACgBeo0P+a1Aih4Z+/8f4CJZ0rb6v7pijYQNSbFPSxwWFZ3NtFyzEK0v
        YkNXSSRvzVrVRm09j+Nty8cuPDWhuFM5
X-Google-Smtp-Source: AA6agR50UpqAJXTKM7Aszo8uGw/kXlrIkRrRMT0M2mPuVHtgbj+KdyX05ZLo/uA1kRbmgsROvLG/mEAHf0b2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:b3c4:0:b0:68d:d900:837e with SMTP id
 x4-20020a25b3c4000000b0068dd900837emr28057015ybf.501.1661355681725; Wed, 24
 Aug 2022 08:41:21 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:39:01 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-19-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 18/18] perf build: Enable -Wthread-safety with clang
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
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index c41a090c0652..72dadafdbad9 100644
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
2.37.2.609.g9ff673ca1a-goog

