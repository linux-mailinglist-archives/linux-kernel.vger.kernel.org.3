Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16A47E89D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350201AbhLWUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:07:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:36629 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhLWUHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640290024; x=1671826024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H3CipibIqZbEhIQv9vI3VoBQ6zDUfMhw2PDAz9s+NSw=;
  b=Q4bLr0hm34iwWxVYoMV1HmEXjaB22YF0sqmZurTeSQhSvdpXiSlmdRQJ
   CO9JZpEmu2SUMWuV7KnNj0+yfCX4fik+dombSZ5eNA0GLWCMFdOm7p5Aa
   TQU1t5jM50Xzr1a6USksaIi8JNfjqhbSYo5wHuevudaSKwwG9yk4NkQLJ
   6CWggMqvQIhZtNEyBARnBuDkhOLmB8kkKj7Qx+pLnenevozPzdKPXBfK4
   ZNjxJ+5UGXitBTRF/bVBvBHrkUIGg8M0xkCZ0eJjprLAvGIdw+WsdQ8eE
   au88Qu6JkO3kt/DAB3LbhoihXld8doYk/baV0YivlBdGuLCSXebIvNKHB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="239653516"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="239653516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 12:07:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="522205778"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 12:07:03 -0800
Date:   Thu, 23 Dec 2021 12:07:01 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Youquan Song <youquan.song@intel.com>
Subject: [PATCH v2] x86/mce: Reduce number of machine checks taken during
 recovery
Message-ID: <YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com>
References: <20211215222016.1390235-1-tony.luck@intel.com>
 <20211218005322.GM16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218005322.GM16608@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Youquan Song <youquan.song@intel.com>

When any of the copy functions in arch/x86/lib/copy_user_64.S take a
fault, the fixup code copies the remaining byte count from %ecx to %edx
and unconditionally jumps to .Lcopy_user_handle_tail to continue the
copy in case any more bytes can be copied.

If the fault was #PF this may copy more bytes (because the page fault
handler might have fixed the fault). But when the fault is a machine
check the original copy code will have copied all the way to the poisoned
cache line. So .Lcopy_user_handle_tail will just take another machine
check for no good reason.

Every code path to .Lcopy_user_handle_tail comes from an exception fixup
path, so add a check there to check the trap type (in %eax) and simply
return the count of remaining bytes if the trap was a machine check.

Doing this reduces the number of machine checks taken during synthetic
tests from four to three.

As well as reducing the number of machine checks, this also allows
Skylake generation Xeons to recover some cases that currently fail. The
is because "rep movsb" is only recoverable when source and destination
are well aligned and the byte count is large. That useless call to
.Lcopy_user_handle_tail may violate one or more of these conditions and
generate a fatal machine check.

[Tony: Added more details to commit message]

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/lib/copy_user_64.S | 9 +++++++++
 1 file changed, 9 insertions(+)

V2: Update based on comments from PeterZ
	- Rebase to tip x86/core branch
	- Add comment documenting eax is now part of calling convention
	  for .Lcopy_user_handle_tail
	- Trim commit comment to make it easier to see that I did
	  audit all the call sequences for .Lcopy_user_handle_tail

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index e6ac38587b40..26781cbe7e37 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -212,6 +212,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Don't try to copy the tail if machine check happened
  *
  * Input:
+ * eax x86 trap number - set by fixup_excpetion()
  * rdi destination
  * rsi source
  * rdx count
@@ -220,12 +221,20 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * eax uncopied bytes or 0 if successful.
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
+	cmp $X86_TRAP_MC,%eax
+	je 3f
+
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	RET
 
+3:
+	movl %edx,%eax
+	ASM_CLAC
+	RET
+
 	_ASM_EXTABLE_CPY(1b, 2b)
 
 .Lcopy_user_handle_align:

base-commit: 82a8954acd93ae95d6252fb93a3d210c8f71b093
-- 
2.31.1

