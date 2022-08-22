Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8E59BCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiHVJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:29:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B8F1CB36;
        Mon, 22 Aug 2022 02:29:22 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MB6Rj0qsBzlWWC;
        Mon, 22 Aug 2022 17:26:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 17:29:06 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 17:29:05 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <bp@suse.de>, <ndesaulniers@google.com>, <nathan@kernel.org>,
        <alexandre.belloni@bootlin.com>, <mingo@kernel.org>,
        <acme@kernel.org>, <namhyung@kernel.org>, <jolsa@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf tools: Fix compile error for x86
Date:   Mon, 22 Aug 2022 17:25:57 +0800
Message-ID: <20220822092557.210209-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO") eradicates
CC_HAS_ASM_GOTO, perf on x86 call asm_volatile_goto when compiling __GEN_RMWcc.
However, asm_volatile_goto is not declared, which causes compilation error:

In file included from /home/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:7,
                 from /home/linux/tools/include/asm/atomic.h:6,
                 from /home/linux/tools/include/linux/atomic.h:5,
                 from /home/linux/tools/include/linux/refcount.h:41,
                 from /home/linux/tools/lib/perf/include/internal/cpumap.h:5,
                 from /home/linux/tools/perf/util/cpumap.h:7,
                 from /home/linux/tools/perf/util/env.h:7,
                 from /home/linux/tools/perf/util/header.h:12,
                 from pmu-events/pmu-events.c:9:
/home/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h: In function ‘atomic_dec_and_test’:
/home/linux/tools/include/asm/../../arch/x86/include/asm/rmwcc.h:7:2: error: implicit declaration of function ‘asm_volatile_goto’ [-Werror=implicit-function-declaration]
  asm_volatile_goto (fullop "; j" cc " %l[cc_label]"  \
  ^~~~~~~~~~~~~~~~~

Solution:
Define asm_volatile_goto in compiler_types.h if not declared.

Currently, only x86 architecture uses asm_volatile_goto.
Theoretically, this patch affects only the x86 architecture.

Fixes: a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/include/linux/compiler_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index 24ae3054f304..1bdd834bdd57 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -36,4 +36,8 @@
 #include <linux/compiler-gcc.h>
 #endif
 
+#ifndef asm_volatile_goto
+#define asm_volatile_goto(x...) asm goto(x)
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.30.GIT

