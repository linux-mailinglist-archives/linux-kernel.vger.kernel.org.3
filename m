Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FE5734DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiGMLDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiGMLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:02:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A96FFE2D;
        Wed, 13 Jul 2022 04:02:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LjZQn4ygVzhYwN;
        Wed, 13 Jul 2022 19:00:17 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:02:52 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:02:51 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <broonie@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 4/5] ARM: stacktrace: Make stack walk callback consistent with generic code
Date:   Wed, 13 Jul 2022 19:00:19 +0800
Message-ID: <20220713110020.85511-5-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713110020.85511-1-lihuafei1@huawei.com>
References: <20220713110020.85511-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with the generic arch_stack_walk() code the ARM stack walk code takes
a callback that is called per stack frame. Currently the ARM code always
passes a struct stackframe to the callback and the generic code just
passes the pc, however none of the users ever reference anything in the
struct other than the pc value. The ARM code also uses a return type of
int while the generic code uses a return type of bool though in both
cases the return value is a boolean value and the sense is inverted
between the two.

In order to reduce code duplication when ARM is converted to use
arch_stack_walk() change the signature and return sense of the ARM
specific callback to match that of the generic code.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/include/asm/stacktrace.h |  2 +-
 arch/arm/kernel/perf_callchain.c  |  9 ++++-----
 arch/arm/kernel/return_address.c  |  8 ++++----
 arch/arm/kernel/stacktrace.c      | 13 ++++++-------
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 25282ff645fb..ce85d3ad5d05 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -44,7 +44,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 
 extern int unwind_frame(struct stackframe *frame);
 extern void walk_stackframe(struct stackframe *frame,
-			    int (*fn)(struct stackframe *, void *), void *data);
+			    bool (*fn)(void *, unsigned long), void *data);
 extern void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		     unsigned long top);
 
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index bc6b246ab55e..7147edbe56c6 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -81,13 +81,12 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
  * whist unwinding the stackframe and is like a subroutine return so we use
  * the PC.
  */
-static int
-callchain_trace(struct stackframe *fr,
-		void *data)
+static bool
+callchain_trace(void *data, unsigned long pc)
 {
 	struct perf_callchain_entry_ctx *entry = data;
-	perf_callchain_store(entry, fr->pc);
-	return 0;
+	perf_callchain_store(entry, pc);
+	return true;
 }
 
 void
diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 38f1ea9c724d..ac15db66df4c 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -16,17 +16,17 @@ struct return_address_data {
 	void *addr;
 };
 
-static int save_return_addr(struct stackframe *frame, void *d)
+static bool save_return_addr(void *d, unsigned long pc)
 {
 	struct return_address_data *data = d;
 
 	if (!data->level) {
-		data->addr = (void *)frame->pc;
+		data->addr = (void *)pc;
 
-		return 1;
+		return false;
 	} else {
 		--data->level;
-		return 0;
+		return true;
 	}
 }
 
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 836420c00938..ec0ca3192775 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -121,12 +121,12 @@ int notrace unwind_frame(struct stackframe *frame)
 #endif
 
 void notrace walk_stackframe(struct stackframe *frame,
-		     int (*fn)(struct stackframe *, void *), void *data)
+		     bool (*fn)(void *, unsigned long), void *data)
 {
 	while (1) {
 		int ret;
 
-		if (fn(frame, data))
+		if (!fn(data, frame->pc))
 			break;
 		ret = unwind_frame(frame);
 		if (ret < 0)
@@ -142,21 +142,20 @@ struct stack_trace_data {
 	unsigned int skip;
 };
 
-static int save_trace(struct stackframe *frame, void *d)
+static bool save_trace(void *d, unsigned long addr)
 {
 	struct stack_trace_data *data = d;
 	struct stack_trace *trace = data->trace;
-	unsigned long addr = frame->pc;
 
 	if (data->no_sched_functions && in_sched_functions(addr))
-		return 0;
+		return true;
 	if (data->skip) {
 		data->skip--;
-		return 0;
+		return true;
 	}
 
 	trace->entries[trace->nr_entries++] = addr;
-	return trace->nr_entries >= trace->max_entries;
+	return trace->nr_entries < trace->max_entries;
 }
 
 /* This must be noinline to so that our skip calculation works correctly */
-- 
2.17.1

