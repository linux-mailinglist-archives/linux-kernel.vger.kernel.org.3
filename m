Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6147658F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhLOWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:20:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:28122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhLOWUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639606824; x=1671142824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RXnU8uG8TOnL2XfCZ0t4rH5GoVPCRXYY4j+vFp7lvHY=;
  b=iV+3+Z/3sGMZXK9sXObkEHYsNoBnOfrJ4VFKPws8TpVP0qGz1jbAI9bs
   BAc3I/CXegGUmaGcZL7+PBf/2DTKUByRzvspN75IG7b0rSJpwxwCkii0h
   TVpLHK/MxH3SYXgRhyNsJ3X+QJUC+ZTpHpk2WezOyxbEE5qyrskQeddA3
   5wMFFApyW1ntZ/9jgvOPHOClDwERoqUHfexLMqbTzErZQAZTkRsFU0G7C
   eNgNFKqDHDnY7mxZ9g78NdcIlH2ezjJG2rE/toerio5jBa0Y++Pk8+Zb3
   a3NaBERoYVesFPI9NQurWIYZrcDA2a3G1+Jv7MGtX31UtbkyRsJGP8Wsx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238088866"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="238088866"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 14:20:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="506022826"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 14:20:23 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/mce: Reduce number of machine checks taken during recovery
Date:   Wed, 15 Dec 2021 14:20:16 -0800
Message-Id: <20211215222016.1390235-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

A machine check recovery test case injects poison into memory and then
tries a write(2) system call with a buffer that begins 64 bytes before
the poison and includes the first poison byte:

$ sudo ./einj_mem_uc -f -m 64:65:0 copyin
0: copyin   vaddr = 0x7f13639cc400 paddr = 834fa0d400
./einj_mem_uc: short (64 bytes) write to temp file
page not present
Big surprise ... still running. Thought that would be fatal
Unusual number of MCEs seen: 4
Test passed

While it executes correctly (just the 64 non-poison bytes are written)
and recovers, four machine checks seems like a lot.

When any of the copy functions in arch/x86/lib/copy_user_64.S consume
poison and take a fault the fixup code copies the remaining byte count
from %ecx to %edx and unconditionally jumps to .Lcopy_user_handle_tail
to continue the copy in case any more bytes can be copied.

If the fault was #PF this may copy more bytes (because the page fault
handler might have fixed the fault). But when the fault is a machine
check the original copy code will have copied all the way to the poisoned
cache line. So .Lcopy_user_handle_tail will just take another machine
check for no good reason.

There are five distinct blocks of fixup code that branch to
.Lcopy_user_handle_tail, so add a check there to check the trap type
(in %eax) and simply return the count of remaining bytes.

As well as reducing the number of machine checks, this also allows
Skylake generation Xeons to recover some cases that currently fail. The
is because "rep movsb" is only recoverable when source and destination
are well aligned and the byte count is large. That useless call to
.Lcopy_user_handle_tail may violate one or more of these conditions and
generate a fatal machine check.

With this change applied the count of machine checks to recover is
reduced from four to three:

$ sudo ./einj_mem_uc -f -m 64:65:0 copyin
0: copyin   vaddr = 0x7f1e44845400 paddr = 55930b400
./einj_mem_uc: short (64 bytes) write to temp file
page not present
Big surprise ... still running. Thought that would be fatal
Unusual number of MCEs seen: 3
Test passed

[Tony: Added more details to commit message]

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/lib/copy_user_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e630b9b1..8c53be99faa0 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -233,12 +233,19 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * eax uncopied bytes or 0 if successful.
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
+	cmp $X86_TRAP_MC,%eax
+	je 3f
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
+3:
+	movl %edx,%eax
+	ASM_CLAC
+	ret
+
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
-- 
2.31.1

