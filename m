Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1342C529706
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiEQB5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiEQB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:57:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FFC27B38;
        Mon, 16 May 2022 18:57:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so16101009plh.1;
        Mon, 16 May 2022 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3a9HyiIRBM4wCH9QPbga5zq5KSGL3bFe4oIwKIdI5E4=;
        b=GYr55paZ8TIT7tq6qQkePhatMRmdh7D+PtqLx6vy02JCPGjQAUiwkQIRJwwfdm9Uye
         jSnG4k791tnDD2QEDT+k4Iql0Oy4c9wwvVTfaVFUSrSIeDIsDMt5AOrEUARxg7LF/qmW
         EtXnCmCD5a5LH69Wc2+osbJrPVZ9kxuD92c4m+yA8cwBZC478wEWTeqpqlKJgzD3IAxy
         4VegSWsTfFuhUgCtMdpFJKg6WNwk0QaX/HO4zdpO34GdhCE2ONBLbv9jAbi1FqLzRObi
         P7cxJJs7r6lUvmunhrgU4abcu09L5ONJeGByGM/IbxYKH4lzH3FrwATnMCQocpvVpr+e
         lzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3a9HyiIRBM4wCH9QPbga5zq5KSGL3bFe4oIwKIdI5E4=;
        b=v3a0tge5410n52I1aYjujzzpk/SifbArQQ1CkfjpErx2H1yNZQzR5S4M2YP90V0OQh
         8+yMdSH1yLeCrdx1mzXvZ09NVojRI8En0AOo2oCXMq2N54yb4vjEe5Qjd0lItexDOlIW
         4LVgYM4sH6m5i6z+QAbxEZiLKMje+3J5ZPLf+A79sS2yISZ5QYXyuL2v4tGVfTQwtxQz
         19RtZO+m3xQBIsnjG+pk4C1QWLWW23OZQlx6Juqhj9TMuKCPypvbzHzhQU5Lh9IEBIJr
         Kf7L5gvSQPEw0H1fwnUJjd88po2A18fUvXlWcKAW8xUvJKwaSe1ptGfnUbm3RkIoSQ/w
         5XgQ==
X-Gm-Message-State: AOAM533LJM1tkxe0yyxrWQGM4ajLlUUg1PiCrjAfbABe+GP4UuAGbgJX
        oYOL0gLyb0QB5pUzK3ROkjM=
X-Google-Smtp-Source: ABdhPJxrfeTqop3Yx7uhR0Fu1ohY0L6VmDw1Hx3oiYpsTV3TEZ991DxjRyJA8qoHF1OFrjr7/QvOyw==
X-Received: by 2002:a17:903:496:b0:161:6377:8024 with SMTP id jj22-20020a170903049600b0016163778024mr10803104plb.90.1652752662587;
        Mon, 16 May 2022 18:57:42 -0700 (PDT)
Received: from CHENGDONGLI-MB0.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id z4-20020a62d104000000b0050dc7628184sm7708267pfg.94.2022.05.16.18.57.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 May 2022 18:57:41 -0700 (PDT)
From:   Chengdong Li <brytonlee01@gmail.com>
X-Google-Original-From: Chengdong Li <chengdongli@tencent.com>
Received: by CHENGDONGLI-MB0.localdomain (Postfix, from userid 501)
        id 8C14F808B887; Tue, 17 May 2022 09:57:34 +0800 (CST)
To:     alexey.v.bayduraev@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, rickyman7@gmail.com, adrian.hunter@intel.com,
        irogers@google.com, german.gomez@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: [RESEND PATCH v2] perf tools: fix callstack entries and nr print message
Date:   Tue, 17 May 2022 09:57:26 +0800
Message-Id: <20220517015726.96131-1-chengdongli@tencent.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Ynka4u+jCvFefgwJ@krava>
References: <Ynka4u+jCvFefgwJ@krava>
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

This patch fixes above issue in branch_stack__printf(). For example,

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

Change from v1:
	- refined code style according to Jiri's review comments.

Signed-off-by: Chengdong Li <chengdongli@tencent.com>
---
 tools/perf/util/session.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f9a320694b85..a7f93f5a1ac8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1151,9 +1151,20 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	uint64_t i;
 
-	printf("%s: nr:%" PRIu64 "\n",
-		!callstack ? "... branch stack" : "... branch callstack",
-		sample->branch_stack->nr);
+	if (!callstack) {
+		printf("%s: nr:%" PRIu64 "\n", "... branch stack", sample->branch_stack->nr);
+	} else {
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
+	}
 
 	for (i = 0; i < sample->branch_stack->nr; i++) {
 		struct branch_entry *e = &entries[i];
@@ -1169,8 +1180,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 				(unsigned)e->flags.reserved,
 				e->flags.type ? branch_type_name(e->flags.type) : "");
 		} else {
-			printf("..... %2"PRIu64": %016" PRIx64 "\n",
-				i, i > 0 ? e->from : e->to);
+			if (i == 0) {
+				printf("..... %2"PRIu64": %016" PRIx64 "\n"
+				       "..... %2"PRIu64": %016" PRIx64 "\n",
+						i, e->to, i+1, e->from);
+			} else {
+				printf("..... %2"PRIu64": %016" PRIx64 "\n", i+1, e->from);
+			}
 		}
 	}
 }
-- 
2.27.0

