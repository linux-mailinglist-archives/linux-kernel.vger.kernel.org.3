Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766E449B2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355546AbiAYLfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:35:05 -0500
Received: from foss.arm.com ([217.140.110.172]:36796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345725AbiAYLcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:32:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C57B7101E;
        Tue, 25 Jan 2022 03:32:11 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C93CF3F7D8;
        Tue, 25 Jan 2022 03:32:09 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v2 1/7] arm: lib: remove leading whitespace in bitop macro
Date:   Tue, 25 Jan 2022 11:31:54 +0000
Message-Id: <20220125113200.3829108-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125113200.3829108-1-mark.rutland@arm.com>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `bitop` macro is used to create assembly functions for bit
operations, handling all the boilderplate such as ENTRY(), ENDPROC(),
etc.

Within the `bitop` macro, the argument to ENTRY() has leading whitespace
for alignment, but there is no leading whitespace for the argument to
ENDPROC().

The leading whitespace in the argument to ENTRY() prevents the value
from safely being token-pasted to form a longer symbol name, as
subsequent patches will need to do, where the value will be passed into
a new SYM_ENTRY_AT() macro:

  ENTRY(name)
  -> SYM_FUNC_START(name)
  -> SYM_START(name, [...])
  -> SYM_START_AT(name, [...])
  -> SYM_ENTRY_AT(name, [...])

... where SYM_ENTRY_AT() will token-paste name to form a local label
used by later macros:

| .set .L____sym_entry__##name, location ASM_NL

... but as this happens before assembler macros are evaluated, and
`name` will expand to `\name`, the token-pasting will retain the leading
space:

| .L____sym_entry__ \name

... and when evaluated within an assembler macro this will result in
build errors:

| [mark@lakrids:~/src/linux]% git clean -qfdx
| [mark@lakrids:~/src/linux]% usekorg 10.3.0 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -s multi_v7_defconfig
| [mark@lakrids:~/src/linux]% usekorg 10.3.0 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -s arch/arm/lib
| arch/arm/lib/changebit.S: Assembler messages:
| arch/arm/lib/changebit.S:12: Error: expected comma after ".L____sym_entry__"
| make[1]: *** [scripts/Makefile.build:388: arch/arm/lib/changebit.o] Error 1
| make: *** [Makefile:1846: arch/arm/lib] Error 2

This patch removes the leading space such that the name can be
token-pasted.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/lib/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 95bd359912889..36195edeb0b9f 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -4,7 +4,7 @@
 
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, name, instr
-ENTRY(	\name		)
+ENTRY(\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strbne	r1, [ip]		@ assert word-aligned
@@ -29,7 +29,7 @@ ENDPROC(\name		)
 	.endm
 
 	.macro	testop, name, instr, store
-ENTRY(	\name		)
+ENTRY(\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strbne	r1, [ip]		@ assert word-aligned
@@ -59,7 +59,7 @@ ENDPROC(\name		)
 	.endm
 #else
 	.macro	bitop, name, instr
-ENTRY(	\name		)
+ENTRY(\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strbne	r1, [ip]		@ assert word-aligned
@@ -86,7 +86,7 @@ ENDPROC(\name		)
  * to avoid dirtying the data cache.
  */
 	.macro	testop, name, instr, store
-ENTRY(	\name		)
+ENTRY(\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strbne	r1, [ip]		@ assert word-aligned
-- 
2.30.2

