Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB65ABB84
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiICACQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiICACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:02:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C1FC00F9;
        Fri,  2 Sep 2022 17:02:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso6911679pjh.5;
        Fri, 02 Sep 2022 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=XorKwMQUb7K+kigdhgsfq6FPDdCfAHrNSX7HqJ58NXI=;
        b=j1nWZwRJhwlI8JwKYHmo6F1VXpip1//WhpRZo2Z+IR6SdKNBiqJiKPeEymfD5MVUam
         JVJ1vl5GgmIlLEsKsGnHRlWGU6Jacl0tNB7w0B/qMuiJ7UFGSclB8KVA7bGprfvm8gbb
         7gcNQLCtmKasik6SXKkAq8gH4wxiI8VH6jleo5X1wVtdjwU9C4fSP6AgRVGCRJFALBmY
         2a/nUJyj8n5e+khA2gHm7OlnAPz7UXn65rGch38bQM5SqyEJU2a3htOFmsl7HCzgaXsP
         qsFDUZwgW4oVoefazuyjnVBw+81V9TGmd5PuMHhz4lqu4n1Il3e9AHJtMo2G5iHiWlwk
         Ja6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=XorKwMQUb7K+kigdhgsfq6FPDdCfAHrNSX7HqJ58NXI=;
        b=rr59b+v6PJm6ENRxqQCVuoTG9hcYn7ATY9rK1qSUs4tu1RP1puL2adZh7oDKgf8o26
         f+O4PVisXCejrnnoFAdDly8GBrYgyBLNo2Pu8aPlvSjZBJCXqhQxRsJ6NbkgoZl9SIjl
         glUZ3CRG+DXFQ494knZjQsoeeb80OYptyqsI6Nco8Q6/SJesnXBcq5MHn9cKmoojE2E0
         KVsk3q5nfCePS07nYjnRV8JYJPiiuzqE6XWGSzsYJyHoCxHt8+a/65x4PuDogZaRCYgI
         R79k+OLOIDJiBvDbZI/mBiOQKQSfV4JqFBxKtkh6gSpg4gIWl6bpU8gZHENWq54SLZ99
         coOQ==
X-Gm-Message-State: ACgBeo2ZXPTNyKPGYarXi1Xu3WhaE8Yaixq+g+U6KHXIYfvnYoxq/AYN
        XfoweoC+37/7txh/D8x2vVw=
X-Google-Smtp-Source: AA6agR5FEGcvGRW6flcnqPAR+kdwIVsfk4sIhq6pMs/2o9yJDcgKq7lmVJ/rv8TdNI4w8rV+ZlUqJg==
X-Received: by 2002:a17:903:244c:b0:16e:fa53:a54c with SMTP id l12-20020a170903244c00b0016efa53a54cmr37059049pls.46.1662163332680;
        Fri, 02 Sep 2022 17:02:12 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:5512:f0c2:97f5:28f4])
        by smtp.gmail.com with ESMTPSA id a25-20020a62d419000000b005366696b735sm2391302pfh.77.2022.09.02.17.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:02:11 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Marco Elver <elver@google.com>
Subject: [PATCH] perf test: Skip sigtrap test on old kernels
Date:   Fri,  2 Sep 2022 17:02:10 -0700
Message-Id: <20220903000210.1112014-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

If it runs on an old kernel, perf_event_open would fail because of the
new fields sigtrap and sig_data.  Just skip the test if it failed.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/sigtrap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index e32ece90e164..7057566e6ae4 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
 	if (fd < 0) {
 		pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
+		ret = TEST_SKIP;
 		goto out_restore_sigaction;
 	}
 
-- 
2.37.2.789.g6183377224-goog

