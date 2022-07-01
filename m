Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5A563B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiGAUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiGAUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:55:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF468A11;
        Fri,  1 Jul 2022 13:55:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x138so3506812pfc.3;
        Fri, 01 Jul 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0tzuXJ4fkDFDXNosYJbNw2/XivHjlXN2Le9Og9w1Vg=;
        b=M9tf3Y44xGmhLMIrSU+f0NqKp5sL7jXJmEeHbOhB1LEuWawhJtXhuaHPPGApTsV27w
         HAKoLm/eVLKpVWmL2uNg/YyxRDzSM8WYJKOjXu6YxbsrhJSIxc1xdBXbj5iB1vZ5dEdf
         GQreTg74l2K+2Y0zpn0WyaFb2rVG67qf/+mS4qRNzW6yV/cdXfqHGWByEBJPabL6fYFj
         Rb18dyWRfvbmAPAHppoTo4BgGWQJJapDZeNl3tOTrDjZL3lPaOY2Iq9MiwoEIx4BAgk7
         A0P9W+SAsfX9Td80dvmKDpZr+K+pfTROdDikA6vzOdV/kAra3uTkPXyKwWkVaqd3+s4p
         +Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=r0tzuXJ4fkDFDXNosYJbNw2/XivHjlXN2Le9Og9w1Vg=;
        b=FAp7n8kE68SbuSV9Jw18JPWdO63apVptMGXg4zjmtrqQbGsbVp9PXE+6KK/fG4C1WN
         GWfex4kS217dvf3EdHmcYORNdD5FLEeU+1UpipxQPybfeGqYaN3cBvzVWnCB0pBmXOjN
         69DyxfBVgayf/uxQJoCeOeN0ML4jZDBvVfwQ8Ub0wSjqsnBkG8PVEmyA0+ZxGVRZD6Ij
         SNOgAWroYUULYsbmw6aR71JUKwbyH1eUzrUYEwb2Sz5w2pB1fRxiHLdnE3AKVV92DQmz
         ar4XBqvikT9qTajhV01z8OGDXKNeGfWNTrxefD7ehiv4nHDpJK9+bmTFEGZKCvpSq67D
         e5og==
X-Gm-Message-State: AJIora9FcDv0GwFWyd4C9/owi2yja6gbkkp52MNpko4u7EsJ1RU62hhg
        uxz3AFseJuB7n6ywC7+7w+o=
X-Google-Smtp-Source: AGRyM1tKTPk/lGBk4MHeQR0UtAfurvaaef/ixvVvIr01raf/MRwgsXWvhPJgm4YRjOUhS9ZtUJq15w==
X-Received: by 2002:a63:90c1:0:b0:40d:3be3:5609 with SMTP id a184-20020a6390c1000000b0040d3be35609mr13565938pge.421.1656708900689;
        Fri, 01 Jul 2022 13:55:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:d774:23c8:6d02:a99d])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm16057176pls.100.2022.07.01.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:54:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf tools: Don't sort the task scan result from /proc
Date:   Fri,  1 Jul 2022 13:54:57 -0700
Message-Id: <20220701205458.985106-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
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

It should not sort the result as procfs already returns a proper
ordering of tasks.  Actually sorting the order caused problems that it
doesn't guararantee to process the main thread first.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 27acdc5e5723..a068f42833c3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -754,7 +754,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	n = scandir(filename, &dirent, filter_task, alphasort);
+	n = scandir(filename, &dirent, filter_task, NULL);
 	if (n < 0)
 		return n;
 
@@ -987,7 +987,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		return 0;
 
 	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	n = scandir(proc_path, &dirent, filter_task, alphasort);
+	n = scandir(proc_path, &dirent, filter_task, NULL);
 	if (n < 0)
 		return err;
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

