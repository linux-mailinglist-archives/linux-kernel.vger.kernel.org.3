Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1C475B85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbhLOPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:12:13 -0500
Received: from foss.arm.com ([217.140.110.172]:54588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243797AbhLOPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1931435;
        Wed, 15 Dec 2021 07:12:12 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 106AE3F774;
        Wed, 15 Dec 2021 07:12:09 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/6] perf tools: Refactor script__setup_sample_type()
Date:   Wed, 15 Dec 2021 15:11:35 +0000
Message-Id: <20211215151139.40854-4-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215151139.40854-1-german.gomez@arm.com>
References: <20211215151139.40854-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Truong <alexandre.truong@arm.com>

Refactoring script__setup_sample_type() by using
callchain_param_setup() to replace the duplicate code
for callchain parameter setting up.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/builtin-script.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index da2175d70ac9..ab7d575f97f2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3468,16 +3468,7 @@ static void script__setup_sample_type(struct perf_script *script)
 	struct perf_session *session = script->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 
-	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
-		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER)) {
-			callchain_param.record_mode = CALLCHAIN_DWARF;
-			dwarf_callchain_users = true;
-		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
-			callchain_param.record_mode = CALLCHAIN_LBR;
-		else
-			callchain_param.record_mode = CALLCHAIN_FP;
-	}
+	callchain_param_setup(sample_type);
 
 	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
-- 
2.25.1

