Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44954CEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356313AbiFOQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349676AbiFOQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1EE6C;
        Wed, 15 Jun 2022 09:32:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 184so11818326pga.12;
        Wed, 15 Jun 2022 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duoHmKxuIzFJAlNO4QfNqtELx9hfbWCYoYDT4+R52Yw=;
        b=abTGZjIAm0tK/MttgJerHY1vYC4yNou74dFkyopcGMNJF9gmAyyNVIIkLq7cMtPQdO
         GDzPxCYJAYL9KttjKg8OG1JiuCD3UCGHiGKF0z7AHNQZ5slQjl2CJaPyXZgVA6uitZEu
         4XD/lSuPicFJ3XeZ7l+fc5O4iPTE84aSmWIDuDVymnMSifuYBXUMuMSiAg1R5hBFcsOL
         50P5I2HGmqTtvWWPabCc5OcYiWYIjTPmsKUwxB3t5k0A7S8w1SDlcsXhgCcf1TC8Cm+y
         IMDP8YvZ+qDDxpSWdRfJH+RbB5ziDaWIv+vf61HumclZWyqdrbKTKqlj83xjyypM+ZMX
         voxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=duoHmKxuIzFJAlNO4QfNqtELx9hfbWCYoYDT4+R52Yw=;
        b=ZqBbegQPdDRWOGcqpjGZTk35UTce574d5OtRtt0nawqb3LNCcSiGk8Evt2ZpmFx4UJ
         892/Zuyd8g7S9CfXPYSjXT3VP5bgk+rSH3OUCNTNyOfSLxIinPigiQQtSaQ5iFO9Y/lQ
         6sr4VH5xONryHqA3rNXCA0mUFAhaUTqTK6e37MeCrSq0bAlS7V6TeMSjVWJ8FTvfGBgB
         ZhL9cL5cAZ3hDEAZaohzpeSfIPuAEbuzCqb3/xwye0N1obK2nY3mYytzE7kjkCzT8Ffl
         HWnS6bYziFcdGoJqv7eQEpaAmNxEmncB3vECtIrgFHxztuRJpIhl1PE/4PmM6K6xGs7r
         KRSQ==
X-Gm-Message-State: AJIora9aR53y+wkNeyCZd2c+745C+ypKeSlU5mOPkDYsMBFlQ94DSPDK
        dHv1Tl9wJIK0WeFEefuFP6M=
X-Google-Smtp-Source: AGRyM1txCojo1d2022iToq/duTxSlUjTwLS6oZh6A4Zw9W50qHzeQPwyBjUq09+ewyhjDpgGX6zh1A==
X-Received: by 2002:a05:6a00:b8b:b0:51b:eefc:7fd2 with SMTP id g11-20020a056a000b8b00b0051beefc7fd2mr437043pfj.74.1655310749924;
        Wed, 15 Jun 2022 09:32:29 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/7] perf lock: Skip print_bad_events() if nothing bad
Date:   Wed, 15 Jun 2022 09:32:18 -0700
Message-Id: <20220615163222.1275500-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
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

The debug output is meaningful when there are bad lock sequences.
Skip it unless there's one or -v option is given.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 118a036a81fb..2337b09dd2cd 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -858,9 +858,16 @@ static void print_bad_events(int bad, int total)
 {
 	/* Output for debug, this have to be removed */
 	int i;
+	int broken = 0;
 	const char *name[4] =
 		{ "acquire", "acquired", "contended", "release" };
 
+	for (i = 0; i < BROKEN_MAX; i++)
+		broken += bad_hist[i];
+
+	if (broken == 0 && !verbose)
+		return;
+
 	pr_info("\n=== output for debug===\n\n");
 	pr_info("bad: %d, total: %d\n", bad, total);
 	pr_info("bad rate: %.2f %%\n", (double)bad / (double)total * 100);
-- 
2.36.1.476.g0c4daa206d-goog

