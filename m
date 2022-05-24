Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC435320F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiEXC2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiEXC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:27:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5B2C694B5;
        Mon, 23 May 2022 19:27:52 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvyqmQoxix8cgAA--.5133S4;
        Tue, 24 May 2022 10:27:51 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] MIPS: Use memblock_add_node() in early_parse_mem() under CONFIG_NUMA
Date:   Tue, 24 May 2022 10:27:50 +0800
Message-Id: <1653359270-27056-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1653359270-27056-1-git-send-email-yangtiezhu@loongson.cn>
References: <1653359270-27056-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvyqmQoxix8cgAA--.5133S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyDGw4DGw1kAw1kKw4kWFg_yoWDGwbEyw
        1S9r4kG34ayF1jvr47X3s3Wa4jy3yUXFyxuFna9r42y3s8JryUG393Ar1DZrs8ur1DArn5
        Zr9xCrWUCan7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbhxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4UMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb5fHUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memblock_add_node to add new memblock region within a NUMA node
in early_parse_mem() under CONFIG_NUMA, otherwise the mem parameter
can not work well.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/setup.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1c7f916..2ca156a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -37,6 +37,7 @@
 #include <asm/cdmm.h>
 #include <asm/cpu.h>
 #include <asm/debug.h>
+#include <asm/mmzone.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
@@ -364,7 +365,10 @@ static int __init early_parse_mem(char *p)
 	if (*p == '@')
 		start = memparse(p + 1, &p);
 
-	memblock_add(start, size);
+	if (IS_ENABLED(CONFIG_NUMA))
+		memblock_add_node(start, size, pa_to_nid(start), MEMBLOCK_NONE);
+	else
+		memblock_add(start, size);
 
 	return 0;
 }
-- 
2.1.0

