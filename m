Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D05ADDBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiIFDGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiIFDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:06:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E28682656B;
        Mon,  5 Sep 2022 20:06:25 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72spuRZj310SAA--.6686S4;
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
Subject: [PATCH 2/3] perf bench syscall: Add close syscall benchmark
Date:   Tue,  6 Sep 2022 11:06:16 +0800
Message-Id: <1662433577-23266-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
References: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Cx72spuRZj310SAA--.6686S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13tw4xuFW5Zr15uFW5Awb_yoW5ury5pF
        sFkw1rJr4rtFWYyw47JF1qgFy3AwnrXr15KwnYyan8Z39rX34Yqw42ga4F9F17Ww42k3y5
        ur4kZFW0gF4rCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUslApDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a simple close syscall benchmark, more syscall
benchmarks can be added in the future.

Here are the test results:

  [loongson@linux perf]$ ./perf bench syscall

          # List of available benchmarks for collection 'syscall':

           basic: Benchmark for basic getppid(2) calls
           close: Benchmark for close(2) calls
             all: Run all syscall benchmarks

  [loongson@linux perf]$ ./perf bench syscall basic
  # Running 'syscall/basic' benchmark:
  # Executed 10000000 getppid() calls
       Total time: 1.956 [sec]

         0.195687 usecs/op
          5110201 ops/sec
  [loongson@linux perf]$ ./perf bench syscall close
  # Running 'syscall/close' benchmark:
  # Executed 10000000 close() calls
       Total time: 6.302 [sec]

         0.630297 usecs/op
          1586553 ops/sec
  [loongson@linux perf]$ ./perf bench syscall all
  # Running syscall/basic benchmark...
  # Executed 10000000 getppid() calls
       Total time: 1.956 [sec]

         0.195686 usecs/op
          5110232 ops/sec

  # Running syscall/close benchmark...
  # Executed 10000000 close() calls
       Total time: 6.302 [sec]

         0.630271 usecs/op
          1586619 ops/sec

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/bench/bench.h   |  1 +
 tools/perf/bench/syscall.c | 11 +++++++++++
 tools/perf/builtin-bench.c |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6cefb43..916cd47 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -34,6 +34,7 @@ int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
+int bench_syscall_close(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 746fd71..058394b 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 		case __NR_getppid:
 			getppid();
 			break;
+		case __NR_close:
+			close(dup(0));
+			break;
 		default:
 			break;
 		}
@@ -58,6 +61,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	case __NR_getppid:
 		name = "getppid()";
 		break;
+	case __NR_close:
+		name = "close()";
+		break;
 	default:
 		break;
 	}
@@ -100,3 +106,8 @@ int bench_syscall_basic(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_getppid);
 }
+
+int bench_syscall_close(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_close);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334ab89..b63c711 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -52,6 +52,7 @@ static struct bench sched_benchmarks[] = {
 
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
+	{ "close",	"Benchmark for close(2) calls",			bench_syscall_close	},
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
 };
-- 
2.1.0

