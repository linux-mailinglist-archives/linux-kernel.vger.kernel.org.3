Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B25734DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiGMLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiGMLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:02:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E95FFE05;
        Wed, 13 Jul 2022 04:02:53 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LjZQn1Yy1z1L8Ts;
        Wed, 13 Jul 2022 19:00:17 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:02:51 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:02:50 +0800
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
Subject: [PATCH v2 3/5] ARM: stacktrace: Allow stack trace saving for non-current tasks
Date:   Wed, 13 Jul 2022 19:00:18 +0800
Message-ID: <20220713110020.85511-4-lihuafei1@huawei.com>
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

The current ARM implementation of save_stack_trace_tsk() does not allow
saving stack trace for non-current tasks, which may limit the scenarios
in which stack_trace_save_tsk() can be used. Like other architectures,
or like ARM's unwind_backtrace(), we can leave it up to the caller to
ensure that the task that needs to be unwound is not running.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/arm/kernel/stacktrace.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 3acf51ee46bb..836420c00938 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -171,19 +171,11 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	data.no_sched_functions = nosched;
 
 	if (tsk != current) {
-#ifdef CONFIG_SMP
-		/*
-		 * What guarantees do we have here that 'tsk' is not
-		 * running on another CPU?  For now, ignore it as we
-		 * can't guarantee we won't explode.
-		 */
-		return;
-#else
+		/* task blocked in __switch_to */
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
 		frame.lr = 0;		/* recovered from the stack */
 		frame.pc = thread_saved_pc(tsk);
-#endif
 	} else {
 		/* We don't want this function nor the caller */
 		data.skip += 2;
-- 
2.17.1

