Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432F951FBAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiEILwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiEILwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:52:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2C2016C0;
        Mon,  9 May 2022 04:48:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i1so13580873plg.7;
        Mon, 09 May 2022 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbhOp8dGqoE6FheK4Bgv/VADx1fQjAbINXwn9/xDrX4=;
        b=HNl2MMO940Mvxmd3JtBec1wdqgZ0Hy2/DVmP/4OuxQEjFH80b45VJtUP537flgMoxb
         VXZsMXImQJ4Z3WiqicOn9aInjO/6NxrOl6EfQwkBvsI1jLLAnYM5SPF42tELcxR3Lzo7
         tgxEFzBBMJfiu/KSVHrLE5I3eB/hJRXiCiDu04VbYHAlflzMqyYqwZuaoHzEpfph6zmC
         B/NI60GqIiildOzvUpRfPqmRg/tc9kteazHMAcgRp75e28NUGRVG0o3m1Z0RTkmMkH5L
         OSP6ZX2WBNnO9OJ4JKe3H9Idfa2/BOlRdPUuehx9ZWGp1G9z7dFevxMGEOaah19+Wv44
         KgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbhOp8dGqoE6FheK4Bgv/VADx1fQjAbINXwn9/xDrX4=;
        b=heA0bc8Eii7BpuQ/nN30GG0reXEmEjmc9A7qhvetptXsAe7ExIpBpSdiVjVa8DHGt2
         uE/EaioIsM0+Y/NMfgXRX9Uy41lKCyuS6TJrITTFDGAV+grMLnLqGO567d/MsvrEhbn1
         KBB5Fp7MwrHyhwLA7aeF6AUS44Wb5JXxzlBrkLeECT2u8YylQ2HBBUxlNx/LgkHEJlu0
         iwuoTwA06c4wqLnuH9I3naF2XHGmkylYRzk4vv4I09gZa0DQUXMm5UV4PmMcWA7k64mN
         DU4LQLdX4HnZ4gql4tsYDra8vRmyNzCU7mYhJiUU5Y6Er9ziLwTKjlBt/MzNqS42Ur4M
         qH+A==
X-Gm-Message-State: AOAM531PUVLvmvDdLEQmaaDZXPkud6nLlt5Tvtofy/o6TeggE5jvp0M1
        xRSUKnZgpgoVs5+ttI4g8Nw=
X-Google-Smtp-Source: ABdhPJw8pBrCaPpH3J79rhq7/D9WGZG4Chg7AmEGIsNvCni3DpBJKsWw/klsWigIV9pN2oePsxOrhA==
X-Received: by 2002:a17:902:edc7:b0:15b:4196:1957 with SMTP id q7-20020a170902edc700b0015b41961957mr15494055plk.161.1652096890867;
        Mon, 09 May 2022 04:48:10 -0700 (PDT)
Received: from CHENGDONGLI-MB0.localdomain ([203.205.141.80])
        by smtp.gmail.com with ESMTPSA id ip13-20020a17090b314d00b001cd4c118b07sm8762233pjb.16.2022.05.09.04.48.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 May 2022 04:48:09 -0700 (PDT)
From:   Chengdong Li <brytonlee01@gmail.com>
X-Google-Original-From: Chengdong Li <chengdongli@tencent.com>
Received: by CHENGDONGLI-MB0.localdomain (Postfix, from userid 501)
        id B750A7C8F8AE; Mon,  9 May 2022 19:48:00 +0800 (CST)
To:     alexey.v.bayduraev@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, rickyman7@gmail.com, adrian.hunter@intel.com,
        irogers@google.com, german.gomez@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: [PATCH] perf tools: fix callstack entries and nr print message
Date:   Mon,  9 May 2022 19:47:43 +0800
Message-Id: <20220509114743.22668-1-chengdongli@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengdong Li <chengdongli@tencent.com>

when generating callstack information from branch_stack(Intel LBR),
the actual number of callstack entry should be bigger than the number
of branch_stack, for example:

	branch_stack records:
		B() -> C()
		A() -> B()
	converted callstack records should be:
		C()
		B()
		A()
though, the number of callstack equals
to the number of branch stack plus 1.

This patch fix above issue in branch_stack__printf(). For example,

	# echo 'scale=2000; 4*a(1)' > cmd
	# perf record --call-graph lbr bc -l < cmd

Before applying this patch, `perf script -D` output:

	1220022677386876 0x2a40 [0xd8]: PERF_RECORD_SAMPLE(IP, 0x4002): 17990/17990: 0x40a6d6 period: 894172 addr: 0
	... LBR call chain: nr:8
	.....  0: fffffffffffffe00
	.....  1: 000000000040a410
	.....  2: 000000000040573c
	.....  3: 0000000000408650
	.....  4: 00000000004022f2
	.....  5: 00000000004015f5
	.....  6: 00007f5ed6dcb553
	.....  7: 0000000000401698
	... FP chain: nr:2
	.....  0: fffffffffffffe00
	.....  1: 000000000040a6d8
	... branch callstack: nr:6    # which is not consistent with LBR records.
	.....  0: 000000000040a410
	.....  1: 0000000000408650    # ditto
	.....  2: 00000000004022f2
	.....  3: 00000000004015f5
	.....  4: 00007f5ed6dcb553
	.....  5: 0000000000401698
	 ... thread: bc:17990
	 ...... dso: /usr/bin/bc
	bc 17990 1220022.677386:     894172 cycles:
			  40a410 [unknown] (/usr/bin/bc)
			  40573c [unknown] (/usr/bin/bc)
			  408650 [unknown] (/usr/bin/bc)
			  4022f2 [unknown] (/usr/bin/bc)
			  4015f5 [unknown] (/usr/bin/bc)
		    7f5ed6dcb553 __libc_start_main+0xf3 (/usr/lib64/libc-2.17.so)
			  401698 [unknown] (/usr/bin/bc)

After applied:

	1220022677386876 0x2a40 [0xd8]: PERF_RECORD_SAMPLE(IP, 0x4002): 17990/17990: 0x40a6d6 period: 894172 addr: 0
	... LBR call chain: nr:8
	.....  0: fffffffffffffe00
	.....  1: 000000000040a410
	.....  2: 000000000040573c
	.....  3: 0000000000408650
	.....  4: 00000000004022f2
	.....  5: 00000000004015f5
	.....  6: 00007f5ed6dcb553
	.....  7: 0000000000401698
	... FP chain: nr:2
	.....  0: fffffffffffffe00
	.....  1: 000000000040a6d8
	... branch callstack: nr:7
	.....  0: 000000000040a410
	.....  1: 000000000040573c
	.....  2: 0000000000408650
	.....  3: 00000000004022f2
	.....  4: 00000000004015f5
	.....  5: 00007f5ed6dcb553
	.....  6: 0000000000401698
	 ... thread: bc:17990
	 ...... dso: /usr/bin/bc
	bc 17990 1220022.677386:     894172 cycles:
			  40a410 [unknown] (/usr/bin/bc)
			  40573c [unknown] (/usr/bin/bc)
			  408650 [unknown] (/usr/bin/bc)
			  4022f2 [unknown] (/usr/bin/bc)
			  4015f5 [unknown] (/usr/bin/bc)
		    7f5ed6dcb553 __libc_start_main+0xf3 (/usr/lib64/libc-2.17.so)
			  401698 [unknown] (/usr/bin/bc)

Signed-off-by: Chengdong Li <chengdongli@tencent.com>
---
 tools/perf/util/session.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f9a320694b85..568a1db98686 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1151,9 +1151,19 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	uint64_t i;
 
-	printf("%s: nr:%" PRIu64 "\n",
-		!callstack ? "... branch stack" : "... branch callstack",
-		sample->branch_stack->nr);
+	if (!callstack)
+		printf("%s: nr:%" PRIu64 "\n", "... branch stack", sample->branch_stack->nr);
+	else
+		/* the reason of adding 1 to nr is because after expanding
+		 * branch stack it generates nr + 1 callstack records. e.g.,
+		 *         B()->C()
+		 *         A()->B()
+		 * the final callstack should be:
+		 *         C()
+		 *         B()
+		 *         A()
+		 */
+		printf("%s: nr:%" PRIu64 "\n", "... branch callstack", sample->branch_stack->nr+1);
 
 	for (i = 0; i < sample->branch_stack->nr; i++) {
 		struct branch_entry *e = &entries[i];
@@ -1169,8 +1179,12 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 				(unsigned)e->flags.reserved,
 				e->flags.type ? branch_type_name(e->flags.type) : "");
 		} else {
-			printf("..... %2"PRIu64": %016" PRIx64 "\n",
-				i, i > 0 ? e->from : e->to);
+			if (i == 0)
+				printf("..... %2"PRIu64": %016" PRIx64 "\n"
+				       "..... %2"PRIu64": %016" PRIx64 "\n",
+						i, e->to, i+1, e->from);
+			else
+				printf("..... %2"PRIu64": %016" PRIx64 "\n", i+1, e->from);
 		}
 	}
 }
-- 
2.27.0

