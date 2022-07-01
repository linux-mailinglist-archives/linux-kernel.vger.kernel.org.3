Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20027563B7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiGAUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiGAUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:55:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155068A26;
        Fri,  1 Jul 2022 13:55:02 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s27so3411322pga.13;
        Fri, 01 Jul 2022 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQ6KsO2zFBmcfmgLJrQL61MdtKOyPUgT/0irzsdCMHU=;
        b=TVfZtmud/h5X321ny0Mc7f5dsivitUSp0rMZEnD2UuzzDznneUjwY2YxNiWjaRyhPh
         CtOXxJRHZdnjafJHbG9bbocXSi736L4ageMgyp9PTAgetvXnUyJUCvYcG0ipcDv79Z8O
         0syRmqxHPmghkGyVHBNTM+qkcl5rDEiBYZk8HWkg6wkxE6BnVnJY149/K8QyUtlqyTJf
         y8jl1psX95tR60TmMz5cJSmTMqFJwsT+qTAxe1zwIAf55cHzV/9Qe5oapWeci7qXF0Nt
         UoGu7AWbavo5JNtRTltA8wCz2d0nYcwZ80kbjmZQhJ7ne8Gf681UNKr+hnZcO3zsULgz
         jx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uQ6KsO2zFBmcfmgLJrQL61MdtKOyPUgT/0irzsdCMHU=;
        b=OafJ78ckZOHccguyJ9kB2RPaKtQyEtcJbrmlGoEIflclwJ5uzCGtbbqWIKzKo+rG2B
         1cVWJd+5Et3O9S/SBl7NevRBgD+jqEMXyqVq/Y2oMC5DIwwPB3lyx8U0oetbzqswPbuW
         DtW/dJNAAdhDhAYM1TQy6/VaNClKju+gndS3jdv7BWZ9sB5bc6Kv9gTvcy5c5hL0eyU5
         LRmHmdr3wXTZEZrfG9RJmRucT26x5MpwFCBhL3tsNqVsqoURg3G+9rOTt+6fq27pKWco
         kfzm5PoNU+Vei7ufOvyubrbvwV0Fs5wePlZzPuHJkKU437nSBvfCbTn/mPsqRYuBAS4t
         L9bg==
X-Gm-Message-State: AJIora9xkjffDn5uA9w+N11kUq91qheUNd3BIV3kexGAvPgVHuqtzOgg
        MJxf3KHSq/fqZkjJJtB0LBA=
X-Google-Smtp-Source: AGRyM1v4qTPXxg09V3OPjyQyTmcdBdj+IKuWT95mNa+vh4IIJr7Uc5rQLlq6Mm2BrOHZgsZep70zrA==
X-Received: by 2002:a63:2254:0:b0:40d:d291:7710 with SMTP id t20-20020a632254000000b0040dd2917710mr13678752pgm.269.1656708901768;
        Fri, 01 Jul 2022 13:55:01 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:d774:23c8:6d02:a99d])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm16057176pls.100.2022.07.01.13.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:55:01 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf tools: Ignore dead threads during event synthesis
Date:   Fri,  1 Jul 2022 13:54:58 -0700
Message-Id: <20220701205458.985106-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220701205458.985106-1-namhyung@kernel.org>
References: <20220701205458.985106-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it synthesize various task events, it scans the list of task
first and then accesses later.  There's a window threads can die
between the two and proc entries may not be available.

Instead of bailing out, we can ignore that thread and move on.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a068f42833c3..84d17bd4efae 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -767,11 +767,12 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		if (*end)
 			continue;
 
-		rc = -1;
+		/* some threads may exit just after scan, ignore it */
 		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
 					     &tgid, &ppid, &kernel_thread) != 0)
-			break;
+			continue;
 
+		rc = -1;
 		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
 						ppid, process, machine) < 0)
 			break;
-- 
2.37.0.rc0.161.g10f37bed90-goog

