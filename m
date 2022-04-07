Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0B4F8B06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiDGXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiDGXHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE65BCB57
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:05:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h16-20020a056902009000b00628a70584b2so5293390ybs.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tors/41JgQKyqvse+O7pu0FFz6GUUhE6Y3Idh3XFdO4=;
        b=VtpRPUeczstXHdV+zd2nTPGF6b/Tshh2qvyDNkCw3zgF3eb0ZPJZGb1X5aCh9Zaj51
         ICqxxGu+bkOPrCcWpGJJTTOKpvrPE2Jy5xFSl3otZMHsLZfHoFMa5UwNMjaY1DfWaaP1
         n7NAb651jlHirzvPUNVopB+Tan6HzXfzjcDbDT8I0TCJ4DExvHVXfxU8+BVu+3TNBncP
         nnWg44VKdxqLINhxqbuhPBbPl6F/KpHCxEo4BhaCalVZGHo15rfrzSlHzazPfsnHACaR
         Y925KpqG5uQcq+P/3MpWcU6CcgRGzSEKfNUeGTBW802evTkhoAcw1Q1Z2843XMItpK1A
         6RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tors/41JgQKyqvse+O7pu0FFz6GUUhE6Y3Idh3XFdO4=;
        b=QBvrx7GTnSK6aWMnRHFqADLBq44nAGwxEGMBvJkY62TxmifwGk5njQyhRHyI3N77v0
         ioyAOKmYg3Y2t/M/cKWZrz4eNrOYupFGz9DNoNXx2juW9OEsPVBfRVyB+fcvcd5vn9wE
         ebLqmnSwg+uz5vfwq385XQVxrKFQkJnQgfM8t70KmKz7k0zRtds0Zn21b9CWUBRXCGz0
         J9k4cz9Y2OmgKMgGJ5sDtJlzcFofaFFF+1NlNMm9j5WRFKQmbkbwd2iUIeiQkyb/aGqj
         SdwZ+DMN9UgdvqU/g36yyGRr7GqQHkgo1PiIKq8RKnokzZ/oj+R/n5wr+hKV6fzOSWVT
         +1Iw==
X-Gm-Message-State: AOAM532eNGADNkZuMjKfM6cOI4+Q9VBeAKDQmzIj/zkoEYKEP3ZoQc6N
        KysBltaWPYywBr99tlTXPMFeSuq7bLno
X-Google-Smtp-Source: ABdhPJyH022FsTnDX21QaHconZXhJnn/KzbIMrLAOb8OT7uonKFUv72/UXwSrles6plotzyo7qhEGeurC/8L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a25:e70c:0:b0:63e:e00b:ecd5 with SMTP id
 e12-20020a25e70c000000b0063ee00becd5mr1602174ybh.547.1649372714390; Thu, 07
 Apr 2022 16:05:14 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:04:59 -0700
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
Message-Id: <20220407230503.1265036-2-irogers@google.com>
Mime-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 1/5] perf annotate: Drop objdump stderr
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

If objdump writes to stderr it can block waiting for it to be read. As
perf doesn't read stderr then progress stops with perf waiting for
stdout output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4c641b240df..82cc396ef516 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2047,6 +2047,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	objdump_process.argv = objdump_argv;
 	objdump_process.out = -1;
 	objdump_process.err = -1;
+	objdump_process.no_stderr = 1;
 	if (start_command(&objdump_process)) {
 		pr_err("Failure starting to run %s\n", command);
 		err = -1;
-- 
2.35.1.1178.g4f1659d476-goog

