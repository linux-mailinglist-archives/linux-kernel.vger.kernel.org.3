Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65D5ADDC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiIFDGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiIFDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:06:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E4D27DDE;
        Mon,  5 Sep 2022 20:06:25 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72spuRZj310SAA--.6686S5;
        Tue, 06 Sep 2022 11:06:19 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf bench syscall: Add execve syscall benchmark
Date:   Tue,  6 Sep 2022 11:06:17 +0800
Message-Id: <1662433577-23266-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
References: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Cx72spuRZj310SAA--.6686S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13tw4xuw1rGr4DAryUAwb_yoWrCr4UpF
        s7C3W5Jw4rJryayr43Jr1q9Fy3Awn7Xr1Yyr1ayanxZrsrW34YqF42qa4F9F17Ww47K3y3
        ur4kZFW8Wa1rAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4miiDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the execve syscall benchmark, more syscall
benchmarks can be added in the future.

Here are the test results:

  [loongson@linux perf]$ ./perf bench syscall

          # List of available benchmarks for collection 'syscall':

           basic: Benchmark for basic getppid(2) calls
           close: Benchmark for close(2) calls
          execve: Benchmark for execve(2) calls
             all: Run all syscall benchmarks

  [loongson@linux perf]$ ./perf bench syscall execve
  # Running 'syscall/execve' benchmark:
  # Executed 10000 execve() calls
       Total time: 4.827 [sec]

       482.761800 usecs/op
             2071 ops/sec
  [loongson@linux perf]$ ./perf bench syscall all
  # Running syscall/basic benchmark...
  # Executed 10000000 getppid() calls
       Total time: 1.956 [sec]

         0.195692 usecs/op
          5110065 ops/sec

  # Running syscall/close benchmark...
  # Executed 10000000 close() calls
       Total time: 6.306 [sec]

         0.630692 usecs/op
          1585558 ops/sec

  # Running syscall/execve benchmark...
  # Executed 10000 execve() calls
       Total time: 4.842 [sec]

       484.299500 usecs/op
             2064 ops/sec

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/bench/bench.h   |  1 +
 tools/perf/bench/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c |  1 +
 3 files changed, 38 insertions(+)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 916cd47..6ca3327 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -35,6 +35,7 @@ int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_close(int argc, const char **argv);
+int bench_syscall_execve(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 058394b..c8f8bee 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -14,6 +14,7 @@
 #include <sys/time.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <unistd.h>
 #include <stdlib.h>
 
@@ -30,6 +31,27 @@ static const char * const bench_syscall_usage[] = {
 	NULL
 };
 
+static void test_execve(void)
+{
+	const char *pathname = "/bin/true";
+	char *const argv[] = { (char *)pathname, NULL };
+	pid_t pid = fork();
+
+	if (pid < 0) {
+		fprintf(stderr, "fork failed\n");
+		exit(1);
+	} else if (pid == 0) {
+		execve(pathname, argv, NULL);
+		fprintf(stderr, "execve /bin/true failed\n");
+		exit(1);
+	} else {
+		if (waitpid(pid, NULL, 0) < 0) {
+			fprintf(stderr, "waitpid failed\n");
+			exit(1);
+		}
+	}
+}
+
 static int bench_syscall_common(int argc, const char **argv, int syscall)
 {
 	struct timeval start, stop, diff;
@@ -49,6 +71,12 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 		case __NR_close:
 			close(dup(0));
 			break;
+		case __NR_execve:
+			test_execve();
+			/* Only loop 10000 times to save time */
+			if (i == 10000)
+				loops = 10000;
+			break;
 		default:
 			break;
 		}
@@ -64,6 +92,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	case __NR_close:
 		name = "close()";
 		break;
+	case __NR_execve:
+		name = "execve()";
+		break;
 	default:
 		break;
 	}
@@ -111,3 +142,8 @@ int bench_syscall_close(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_close);
 }
+
+int bench_syscall_execve(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_execve);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index b63c711..6f9ff75 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -53,6 +53,7 @@ static struct bench sched_benchmarks[] = {
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
 	{ "close",	"Benchmark for close(2) calls",			bench_syscall_close	},
+	{ "execve",	"Benchmark for execve(2) calls",		bench_syscall_execve	},
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
 };
-- 
2.1.0

