Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56246C141
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhLGRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:05:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39294 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhLGRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:05:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5461CCE1C68;
        Tue,  7 Dec 2021 17:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23EBC341C1;
        Tue,  7 Dec 2021 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638896538;
        bh=PTyVD4AriAGKQA+5iIODko/4ioAXDlqcrMXsIBsg+C0=;
        h=From:To:Cc:Subject:Date:From;
        b=MVZYNEW3USXJKFwgQiIDe+jvocKBEUS8l5jg+VKL6ONZ/9FONPY7FSww5lWcwC+8i
         Znp39ltDQgDx2BtJEz67HGxY4fv0VswTs/J8vHYM1RgioiKl2yqjDbPk6JvhEzoRVP
         fYG40Sd6DBzoBJZ+H/O6yQrapvB9eUjazfsxRUzmUFDXByfWfmqbyx3OKfpqgcq8rU
         Kz8HIeQt5XO0s+bSB7JOzcUCGy7s55yW8v8AkbgCog+LyycpCFnebQEbsWpLXjlam0
         SpMhtHVQCFgGd8rhTvmdXRJ5awzTJBo85x9PqUG1hO/qlQ5x7NxJvI9RFcdaBCw3cZ
         obKiVk2i/BTGA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Subject: [PATCH] MIPS: Loongson64: Use three arguments for slti
Date:   Tue,  7 Dec 2021 10:01:29 -0700
Message-Id: <20211207170129.578089-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM's integrated assembler does not support 'stli <reg>, <imm>':

<instantiation>:16:12: error: invalid operand for instruction
 slti $12, (0x6300 | 0x0008)
           ^
arch/mips/kernel/head.S:86:2: note: while in macro instantiation
 kernel_entry_setup # cpu specific setup
 ^
<instantiation>:16:12: error: invalid operand for instruction
 slti $12, (0x6300 | 0x0008)
           ^
arch/mips/kernel/head.S:150:2: note: while in macro instantiation
 smp_slave_setup
 ^

To increase compatibility with LLVM's integrated assembler, use the full
form of 'stli <reg>, <reg>, <imm>', which matches the rest of
arch/mips/. This does not result in any change for GNU as.

Link: https://github.com/ClangBuiltLinux/linux/issues/1526
Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/mips/include/asm/mach-loongson64/kernel-entry-init.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 13373c5144f8..efb41b351974 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -32,7 +32,7 @@
 	nop
 	/* Loongson-3A R2/R3 */
 	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
-	slti	t0, (PRID_IMP_LOONGSON_64C | PRID_REV_LOONGSON3A_R2_0)
+	slti	t0, t0, (PRID_IMP_LOONGSON_64C | PRID_REV_LOONGSON3A_R2_0)
 	bnez	t0, 2f
 	nop
 1:
@@ -63,7 +63,7 @@
 	nop
 	/* Loongson-3A R2/R3 */
 	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
-	slti	t0, (PRID_IMP_LOONGSON_64C | PRID_REV_LOONGSON3A_R2_0)
+	slti	t0, t0, (PRID_IMP_LOONGSON_64C | PRID_REV_LOONGSON3A_R2_0)
 	bnez	t0, 2f
 	nop
 1:

base-commit: 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
-- 
2.34.1

