Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272E52B16D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiEREVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiEREUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36450220D1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so10319057b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ulc7jVR4esIc7uAea3k2kp75KCKMXlF4y2JGNUw/UGw=;
        b=bxid9/puL5bhxOXx2DTa8x8S1jgQCq5ay8qtP8LgiP6EyAB9Jn/k76q9uY+42eXvyT
         7ZP0zMdq/j1OnIk//ijsmuz6SH1sN4KDPXScFDLgtlLjwqHonUI8XOUEn1HfFSbhdfJr
         BjWr6JBk+5YusFdxIF/xgJuhHNA8LdL+WFERkJbck2kMhpFWX3H93AAVl1RDqGxoEpIO
         cxU53lF8O8g4Rl+CbZ1W9tMvTGBkhD426abmXzh7kl24a+/5D1A2EYPmhd0wvIrSAgyL
         MITt5pQLPyDvsOgutXaR4QDTMIpr8URZnJ1svgVo/dYHBbohIpIzEv6wr8cZiRWiZy73
         2fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ulc7jVR4esIc7uAea3k2kp75KCKMXlF4y2JGNUw/UGw=;
        b=ew1zT+iCs95UhrgN4Rzc4dQKauWoaZ6taQIobtFKJt0rA7TaHSistW0iEp0l4Vw+TN
         FdFFB+yLRg+W4/wgCZ0kvDkA4ILQEJksWsLwP5h5GHC2SzdHhF+Ou+7Ew6owghYDyoSz
         MbU491zTeOevtz/S3SYtS4IYDpGn9/jkWTQUpfgA8VNPRuvqyW8hOFN93vQCtgiivxIV
         PbCMqN9Yv+ujGMfd/ujsmViy60F4wzLyEyEn3UJc1WCpt+FUzjx4DH/Bn07yO5EJ8XQw
         HlAIRezzUro2N+AFL2VMMz1Ipezh9xzfv54YYfbUaf4v1Adwyce8ULZUK/GNICXZOu/9
         8y+w==
X-Gm-Message-State: AOAM533t6fqWWOn7nKmQmg/OiHVlQNQERZ4bF6z08GPnqdasM1S83dh4
        +rncbEiqULhB199C1NsbW0aTSs93x4kD
X-Google-Smtp-Source: ABdhPJyi/kenzf5f6IvXdgmpjEuRxks7EA7p2I2jEiPI1ZIU8yY0XO2JOXI4l5qnLfdLCvciyP4mtpcve1ex
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:230f:0:b0:64d:76e2:6aa5 with SMTP id
 j15-20020a25230f000000b0064d76e26aa5mr16689099ybj.116.1652847651210; Tue, 17
 May 2022 21:20:51 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:27 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-9-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 8/8] perf test: Use skip in PERF_RECORD_*
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
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

Check if the error code is EACCES and make the test a skip with
a "permissions" skip reason if so.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-record.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6354465067b8..6a001fcfed68 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -330,7 +330,21 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
-	return (err < 0 || errs > 0) ? -1 : 0;
+	if (err == -EACCES)
+		return TEST_SKIP;
+	if (err < 0)
+		return TEST_FAIL;
+	return TEST_OK;
 }
 
-DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD);
+static struct test_case tests__PERF_RECORD[] = {
+	TEST_CASE_REASON("PERF_RECORD_* events & perf_sample fields",
+			 PERF_RECORD,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__PERF_RECORD = {
+	.desc = "PERF_RECORD_* events & perf_sample fields",
+	.test_cases = tests__PERF_RECORD,
+};
-- 
2.36.0.550.gb090851708-goog

