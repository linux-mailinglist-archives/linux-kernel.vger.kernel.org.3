Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B951F486
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiEIGbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiEIGVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:21:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F7D1778A0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:17:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KxWCb0xg9z1JBt4;
        Mon,  9 May 2022 14:16:43 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 14:17:52 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <catalin.marinas@arm.com>, <cuigaosheng1@huawei.com>,
        <will@kernel.org>, <broonie@kernel.org>, <pcc@google.com>,
        <mark.rutland@arm.com>, <keescook@chromium.org>,
        <daniel.kiss@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>,
        <gongruiqi1@huawei.com>
Subject: [PATCH -next] arm64: add missing header dependencies
Date:   Mon, 9 May 2022 14:17:51 +0800
Message-ID: <20220509061751.3434059-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get one error when building module with processor.h:

./arch/arm64/include/asm/processor.h:263:36: error: implicit declaration of function ‘task_stack_page’;
  ((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
./arch/arm64/include/asm/processor.h:266:42: note: in expansion of macro ‘task_pt_regs’
 #define KSTK_ESP(tsk) user_stack_pointer(task_pt_regs(tsk))

task_stack_page is declared in linux/sched/task_stack.h, so this patch
add the missing header dependencies.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/arm64/include/asm/processor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 73e38d9a540c..1c239841c4d6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -28,6 +28,7 @@
 #include <linux/build_bug.h>
 #include <linux/cache.h>
 #include <linux/init.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/thread_info.h>
-- 
2.25.1

