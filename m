Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4035A468B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH2Jzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiH2Jzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:55:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3A5E2E6AE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:55:33 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+ATjQxjh88LAA--.52227S2;
        Mon, 29 Aug 2022 17:55:32 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix warning: #warning syscall fstat not implemented
Date:   Mon, 29 Aug 2022 17:55:31 +0800
Message-Id: <1661766931-7277-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxT+ATjQxjh88LAA--.52227S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4rAw1xWw4xCF1fAF1rXrb_yoW3Wwb_Aa
        47Kw47Ww1kJr4xA39IvF93Jw10ga18WFn09r1fZr47uan8KwsxGw48X3srZF1qkr4vvr4F
        vay8tF1Y9w15tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0cTm3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define __ARCH_WANT_NEW_STAT to fix the following build warning:

  CALL    scripts/checksyscalls.sh
<stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index fcb6689..b344b1f 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 
-- 
2.1.0

