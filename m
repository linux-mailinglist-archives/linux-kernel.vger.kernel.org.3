Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144915ADDBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiIFDGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiIFDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:06:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBEA27DD4;
        Mon,  5 Sep 2022 20:06:27 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72spuRZj310SAA--.6686S3;
        Tue, 06 Sep 2022 11:06:18 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf bench syscall: Introduce bench_syscall_common()
Date:   Tue,  6 Sep 2022 11:06:15 +0800
Message-Id: <1662433577-23266-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
References: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Cx72spuRZj310SAA--.6686S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWfuF4fKFyfGrW5ZFy3twb_yoW8AFWUpr
        47Cw4rJw4rCaySva1fXw4v9FyrJr93JF1YkrsFkws5Ar47X345tw42ga4FvF17urWxKFW5
        uanYvFyrWF4UZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUx38nDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, there is only a basic syscall benchmark via getppid,
this is not enough. Introduce bench_syscall_common() so that we can add
more syscalls to benchmark. This is preparation for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/bench/syscall.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 9b75101..746fd71 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -30,25 +30,41 @@ static const char * const bench_syscall_usage[] = {
 	NULL
 };
 
-int bench_syscall_basic(int argc, const char **argv)
+static int bench_syscall_common(int argc, const char **argv, int syscall)
 {
 	struct timeval start, stop, diff;
 	unsigned long long result_usec = 0;
+	const char *name = NULL;
 	int i;
 
 	argc = parse_options(argc, argv, options, bench_syscall_usage, 0);
 
 	gettimeofday(&start, NULL);
 
-	for (i = 0; i < loops; i++)
-		getppid();
+	for (i = 0; i < loops; i++) {
+		switch (syscall) {
+		case __NR_getppid:
+			getppid();
+			break;
+		default:
+			break;
+		}
+	}
 
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	switch (syscall) {
+	case __NR_getppid:
+		name = "getppid()";
+		break;
+	default:
+		break;
+	}
+
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# Executed %'d getppid() calls\n", loops);
+		printf("# Executed %'d %s calls\n", loops, name);
 
 		result_usec = diff.tv_sec * 1000000;
 		result_usec += diff.tv_usec;
@@ -79,3 +95,8 @@ int bench_syscall_basic(int argc, const char **argv)
 
 	return 0;
 }
+
+int bench_syscall_basic(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_getppid);
+}
-- 
2.1.0

