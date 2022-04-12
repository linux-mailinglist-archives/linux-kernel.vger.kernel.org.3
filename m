Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C684FE51C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357352AbiDLPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357284AbiDLPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:50:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB75FF33
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec12272fb2so56698087b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E5czj/bC3S4sZ4UgMamyfD/R4emkovjRTfasylw11c8=;
        b=cIEupEYkE1f7xIXa2QLCg5rVnIl2Lz0s+h2BNFFK/IKWT1xdZBnxzlPGbY8NrHbiBi
         CifyeqIG97Q9JLG7HFVEpxLnuis4pgAYYgt4vPNiPOw3oyQi5pvnKR4WF0N1+RapQc7C
         1YgfVLcYqVJ2AFOViG/nTZw7hnRjbTuOTUJVQbHVSge2h4ToRaeVA80vB+ZACxvwKMaP
         FseJzDRxTY3fiFCjtS6yoIbqqAiXEXcs7g75idPELZEccNDk+CupnS1DbWr4YoPYt4NN
         JmM3Tymk5OwMMP9D8/iq2DHuxg0Tx7htHYTcWdvD+6+Hdfz2G7iKua1LlXp60K97B/YT
         oT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E5czj/bC3S4sZ4UgMamyfD/R4emkovjRTfasylw11c8=;
        b=77tWtpFk64oIEc12HKEob6OxT3YhqRusvn5QmgD7ZHLpKkIwiHIKFYIQy9l+ZM8MNB
         KZnkcdD2oUhMgd06teGOagF8c0iCGsFtvIuDOyxONeYnlvsWuOBLv9VbEkFx6ZkeF8oV
         FPvqQjitZ0KzxhdP4Qw9jg7Ix3kZpWDRu/hmDtBkekwAwEzXv307fbrprRBlDupIVJt8
         kZ+Pg77aWOfmq/T6IoX2xz0dUOA7NUvlr7uPT+Vr/xQK8uooNOVYud0a1191NUFOU9em
         OomiCN0t/WLpC+tT3RNflvvzT424Lsx5WxuFvxC402pYA63FzTWJxalNAKvlYukMQwvv
         jo/Q==
X-Gm-Message-State: AOAM532Hzp16EJkfAt7QU40IBHBgNlnQf7gK4su9jFDSEyUt3XefOvhc
        ti6Vby1HKLaEHg9amXW1MOY2kcrBPaUx
X-Google-Smtp-Source: ABdhPJxebRmsFHLeMUzDv29itwFXatOp3qc2ILe77MVoqCifZVtWoVoLfD2g59Q8gGAkSynYd6HQJ7+oTyhB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a25:688d:0:b0:641:2721:798 with SMTP id
 d135-20020a25688d000000b0064127210798mr11414226ybc.35.1649778509700; Tue, 12
 Apr 2022 08:48:29 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:48:16 -0700
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
Message-Id: <20220412154817.2728324-4-irogers@google.com>
Mime-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 3/4] perf symbol: By default only fix zero length symbols
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

For architectures without a specific end fixup (ie not arm64, powerpc,
s390) only fix up the end of zero length symbols. This reverts the
behavior introduced by:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
where non-zero length symbols were expanded to the start of the current
symbol.
---
 tools/perf/util/symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cc4c46563802..62163b45cf3f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -104,7 +104,8 @@ static int prefix_underscores_count(const char *str)
 void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
 				     bool is_kernel __maybe_unused)
 {
-	if (p->end == p->start || p->end != c->start)
+	/* If the previous symbol is zero length, make its end the start of the current symbol. */
+	if (p->end == p->start)
 		p->end = c->start;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog

