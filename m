Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9704B7E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344019AbiBPDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:05:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbiBPDFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:05:55 -0500
Received: from qq.com (smtpbg458.qq.com [59.36.132.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB4FDFA7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:05:42 -0800 (PST)
X-QQ-mid: bizesmtp90t1644980678tkckuw3h
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Feb 2022 11:04:27 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: xoS364mEyr1yw2RUzBdRqiWRxqiQzTQwtwPSWDCxpOZsgPRJXULOaLK+heC5o
        lu2prAox1PgQNJyJly3Z5jeOJ0dA8IXWpCoJZbwJeETdxf93tF0MZy4h3btVuOFM6wP/GPb
        FsRC03JOg7+3z+7yCBc7rHl4dhhcascxVXLYXrpT1ya69jpaD/0dLZt3hKSe74FbWyPI/aS
        XYeaM/fe5nZp/HXmlQoMrbXt2b6fN0In85A/v4HK5rLcJauqa7Z7AgS+pk/2atJ7F//d0QZ
        zW8WvqaGnqrSDQNyjlQHMA7naipoMbCMlafB00Qz4c5gbfpPOyzeGK2Sqp8AU7fjRo1PS6k
        bArr0RmHMGZVWJ35/JyhxGWBHo9zA==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 1/2] perf tools: Remove redundant ret variable
Date:   Wed, 16 Feb 2022 11:04:24 +0800
Message-Id: <20220216030425.27779-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value from hist_entry_iter__add() directly instead
of taking this in another redundant variable.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 tools/perf/builtin-annotate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 490bb9b8cf17..e347b8ef088f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -190,7 +190,6 @@ static int process_branch_callback(struct evsel *evsel,
 	};
 
 	struct addr_location a;
-	int ret;
 
 	if (machine__resolve(machine, &a, sample) < 0)
 		return -1;
@@ -203,8 +202,7 @@ static int process_branch_callback(struct evsel *evsel,
 
 	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
 
-	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
-	return ret;
+	return hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 }
 
 static bool has_annotation(struct perf_annotate *ann)
-- 
2.20.1



