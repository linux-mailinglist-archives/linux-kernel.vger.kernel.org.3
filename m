Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD84DDC62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiCRPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiCRPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:06:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F0FF41330;
        Fri, 18 Mar 2022 08:05:33 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxqsywnzRicaQLAA--.9144S4;
        Fri, 18 Mar 2022 23:05:21 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MIPS: Return -EINVAL if mem parameter is invalid in early_parse_mem()
Date:   Fri, 18 Mar 2022 23:05:19 +0800
Message-Id: <1647615920-23103-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
References: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxqsywnzRicaQLAA--.9144S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrXryfZrW5AF48Gr1ftFb_yoW8CF18pr
        40y343tr4UWr97Za4Syr95W34fJ3Z5trW3XayxGr1rJ3WUXr1UJw48XFyayryjgrW8ta4j
        9rsYva4UGwsrCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryrMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUzpBDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, the users usually need to make sure the value
of mem parameter is correct, but it is better to do some check to
avoid potential boot hangs.

This commit checks whether the first mem parameter is invalid, if
yes, return -EINVAL before call memblock_remove() and memblock_add().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/setup.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 14aa8bd..c8c8f60 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -343,12 +343,19 @@ static int usermem __initdata;
 static int __init early_parse_mem(char *p)
 {
 	phys_addr_t start, size;
+	phys_addr_t pa_start, pa_end;
+	u64 idx;
 
 	if (!p) {
 		pr_err("mem parameter is empty, do nothing\n");
 		return -EINVAL;
 	}
 
+	start = 0;
+	size = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
+
 	/*
 	 * If a user specifies memory size, we
 	 * blow away any automatically generated
@@ -356,13 +363,20 @@ static int __init early_parse_mem(char *p)
 	 */
 	if (usermem == 0) {
 		usermem = 1;
+		for_each_mem_range(idx, &pa_start, &pa_end) {
+			if (start >= pa_start && size <= pa_end - pa_start)
+				break;
+
+			if (idx < memblock.memory.cnt)
+				continue;
+
+			usermem = -1;
+			pr_err("mem parameter is invalid, do nothing\n");
+			return -EINVAL;
+		}
 		memblock_remove(memblock_start_of_DRAM(),
 			memblock_end_of_DRAM() - memblock_start_of_DRAM());
 	}
-	start = 0;
-	size = memparse(p, &p);
-	if (*p == '@')
-		start = memparse(p + 1, &p);
 
 	memblock_add(start, size);
 
@@ -638,7 +652,7 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	parse_early_param();
 
-	if (usermem)
+	if (usermem == 1)
 		pr_info("User-defined physical RAM map overwrite\n");
 
 	check_kernel_sections_mem();
-- 
2.1.0

