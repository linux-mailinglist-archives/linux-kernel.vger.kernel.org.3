Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47388473B47
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbhLNDJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:09:14 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48950 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232616AbhLNDJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:09:12 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxXN3PCrhhHngAAA--.2717S3;
        Tue, 14 Dec 2021 11:09:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] MIPS: SGI-IP22: Remove unnecessary check of GCC option
Date:   Tue, 14 Dec 2021 11:09:01 +0800
Message-Id: <1639451342-7029-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639451342-7029-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639451342-7029-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxXN3PCrhhHngAAA--.2717S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyrWFyDXFWUuFW7Ww17ZFb_yoW8Wr4fpa
        yUAa9rGryrXr1UZas5Ga48uF4rZwn8JFWxZ3WUt348uFsYgF13Jr1xKr1Fg3ZxZr15Ca4S
        qF4I9w1jka15Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jcOz3UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/process/changes.rst, the minimal version of GCC
is 5.1, and -mr10k-cache-barrier=store is supported with GCC 5.1 [1], just
remove the unnecessary check to fix the build error [2]:

  arch/mips/sgi-ip22/Platform:28: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.

[1] https://gcc.gnu.org/onlinedocs/gcc-5.1.0/gcc/MIPS-Options.html
[2] https://github.com/ClangBuiltLinux/linux/issues/1543

Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
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

