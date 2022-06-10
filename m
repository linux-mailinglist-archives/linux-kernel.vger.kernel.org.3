Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B6546C19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbiFJSC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiFJSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:02:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC626D0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:02:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so23202312ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8g7Zznczp6I1sznUOMtSobsOu1cIZ/e72E9w80VeXUA=;
        b=mWg0NGJHeZ7Yf11l850PcdthCWlBwlDIQrQTER03M5lVTm1ahubqqCNCTMEkDx/T2x
         vdVCrEIHvZ/PsfuKzrZToRDTRznJlarZxdcP37hlFYseIMIy9Gsf6dMUmzIDV+5wfY0d
         dke9s4uU/U0qsVEuhuVSuugQkySSDWLlZa+83G1qp4VrTkSxMCs/KT6fK3rC6X8m3Aay
         dhOXjzG3iq+IEE1z166y9N6d3e3Udzas6TA0lT9yOo1VzRwloEoE+QgbvAG2AeoOV8WY
         Z08D7fRBdKDj9ITQHA5tHo3yH/qNbw+hxrYpHu4dHoqz9vWclmJZWdCbz+lZ7HR/VqSY
         uwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8g7Zznczp6I1sznUOMtSobsOu1cIZ/e72E9w80VeXUA=;
        b=WKf6ggybcJ/quR1cX/mkmeG94HTSWeTLF/7mXuQpftvd8APZ3ZNRMm3XiMIcyXvaco
         gx+h5p571PkdnMzhdiyzxPiD47CgpY2B3MjBrCb2Vcyk51qHOCcJINQckhY7UnacbMLK
         o/HM9pcfnBup9OkR3uwl+3Fpk7b5ZE/g6+yXLhJ4lDLD0TP65SlCvyjdXyfaU7l+v4jE
         E5fL1ZrEFfHI/OFrdU3drLGjtracp+pZN/4/6Xd8ROzctJM/h8aQRL5qNx7fIi1hUEQP
         dDjJb15v1KX1yxp0xpphzdjlRbjdgYHQQXkF3kM6k/wFLaC7KATD305498SV2OOyb179
         RBNg==
X-Gm-Message-State: AOAM530iP3OW+wnKGb89Ctf2dUz2EPtOR9Nh13Q53zbaFWNhebL05byE
        i/tE030iDCHsSqiMY9kElsiAWtZvl7MK
X-Google-Smtp-Source: ABdhPJyYij0RTjOXOmw32oNm8P6w72IfCLTo4nLil7GAoKLwPKaB6kFOTzsggKRIA78rKr8Csn6Kr0qkGjeE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:70ff:220d:425a:78ab])
 (user=irogers job=sendgmr) by 2002:a25:cec6:0:b0:65c:98f5:a06a with SMTP id
 x189-20020a25cec6000000b0065c98f5a06amr45393202ybe.355.1654884171558; Fri, 10
 Jun 2022 11:02:51 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:02:47 -0700
Message-Id: <20220610180247.444798-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] perf test: Fix undefined behavior in bp_account
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Fix:
tests/bp_account.c:154:9: runtime error: variable length array bound evaluates to non-positive value 0
by switching from a variable length to an allocated array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bp_account.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index d1ebb5561e5b..6f921db33cf9 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -151,11 +151,21 @@ static int detect_ioctl(void)
 static int detect_share(int wp_cnt, int bp_cnt)
 {
 	struct perf_event_attr attr;
-	int i, fd[wp_cnt + bp_cnt], ret;
+	int i, *fd = NULL, ret = -1;
+
+	if (wp_cnt + bp_cnt == 0)
+		return 0;
+
+	fd = malloc(sizeof(int) * (wp_cnt + bp_cnt));
+	if (!fd)
+		return -1;
 
 	for (i = 0; i < wp_cnt; i++) {
 		fd[i] = wp_event((void *)&the_var, &attr);
-		TEST_ASSERT_VAL("failed to create wp\n", fd[i] != -1);
+		if (fd[i] == -1) {
+			pr_err("failed to create wp\n");
+			goto out;
+		}
 	}
 
 	for (; i < (bp_cnt + wp_cnt); i++) {
@@ -166,9 +176,11 @@ static int detect_share(int wp_cnt, int bp_cnt)
 
 	ret = i != (bp_cnt + wp_cnt);
 
+out:
 	while (i--)
 		close(fd[i]);
 
+	free(fd);
 	return ret;
 }
 
-- 
2.36.1.476.g0c4daa206d-goog

