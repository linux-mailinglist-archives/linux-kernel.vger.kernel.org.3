Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C04728E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhLMKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:16:13 -0500
Received: from mail.loongson.cn ([114.242.206.163]:59324 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232134AbhLMJ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:58:07 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxXN0lGbdhlAIAAA--.85S3;
        Mon, 13 Dec 2021 17:57:58 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] MIPS: SGI-IP22: Remove unnecessary check of GCC option
Date:   Mon, 13 Dec 2021 17:57:56 +0800
Message-Id: <1639389477-17586-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxXN0lGbdhlAIAAA--.85S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJry5ZrW8tFW5ZF4kCF4rXwb_yoW8Wr15p3
        yUA39rGryFgr1jva4rCa48uF4rZr95JFWxZw1Utry8uFnYgF15Jr1xKr4fJFnxZr15Ca4S
        qa1S93ZIka15Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLFxUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the document "Minimal requirements to compile the Kernel [1],
the minimal version of GCC is 5.1, -mr10k-cache-barrier=store is supported
with GCC 5.1 [2], so just remove the unnecessary check to fix the build
error [3]:

  arch/mips/sgi-ip22/Platform:28: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.

[1] https://www.kernel.org/doc/html/latest/process/changes.html
[2] https://gcc.gnu.org/onlinedocs/gcc-5.1.0/gcc/MIPS-Options.html
[3] https://github.com/ClangBuiltLinux/linux/issues/1543

Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/sgi-ip22/Platform | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
index 62fa30b..a4c46e3 100644
--- a/arch/mips/sgi-ip22/Platform
+++ b/arch/mips/sgi-ip22/Platform
@@ -23,10 +23,5 @@ endif
 # be 16kb aligned or the handling of the current variable will break.
 # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
 #
-ifdef CONFIG_SGI_IP28
-  ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
-      $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
-  endif
-endif
 cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
 load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
-- 
2.1.0

