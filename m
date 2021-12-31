Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D348256B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhLaReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:34:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLaReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:34:06 -0500
Date:   Fri, 31 Dec 2021 17:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640972045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szEq3NaEi/bcFMPMMLyxFsQDZatqO722Hc7D631C6fg=;
        b=1zVP177epJyEoMs+jGEsw+m6TESYswwtfKIilfcf71R0n738+5hZDkqfOJxKqTym8e9fEx
        dU477OxjYIJGgESx4qMFtlqcxQ/vDh2iHvN9ZpaPZV7LDIObBv9K/0BiRkW4AgP06YhyHc
        iv7V6m+5K4fzWINjifvVvZQs3ZBiX2PZ6WxbnGmf0FrcEuuMBaoe4f1XDjnczbh8njwBLg
        vwoj49fSXxPdZkURE6JGffDo+xEaJbvyKo47keSztLIrM5Re5eb71zGMSZdNrJQ91G3Rme
        ry9tztiCDxJqbjK6UreN6Y5BsuNpGv1pTacHUnJQs6dgJQytnrf+fDEp+ElS1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640972045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szEq3NaEi/bcFMPMMLyxFsQDZatqO722Hc7D631C6fg=;
        b=n4ep0a+32miksJcKSUiYZBFhU8TSdMIeW6XVpyalztBQRQ5tIAsYBSvJxNJacP+lAVtUFg
        H5qKN+KchSL6ZzDQ==
From:   "tip-bot2 for Youquan Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Reduce number of machine checks taken during
 recovery
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com>
References: <YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <164097204390.16921.8552003820708688632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3376136300a00df9a864b88fa969177d6c3be8e5
Gitweb:        https://git.kernel.org/tip/3376136300a00df9a864b88fa969177d6c3be8e5
Author:        Youquan Song <youquan.song@intel.com>
AuthorDate:    Thu, 23 Dec 2021 12:07:01 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 31 Dec 2021 18:22:32 +01:00

x86/mce: Reduce number of machine checks taken during recovery

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
is because REP; MOVSB is only recoverable when source and destination
are well aligned and the byte count is large. That useless call to
.Lcopy_user_handle_tail may violate one or more of these conditions and
generate a fatal machine check.

  [ Tony: Add more details to commit message. ]
  [ bp: Fixup comment.
    Also, another tip patchset which is adding straight-line speculation
    mitigation changes the "ret" instruction to an all-caps macro "RET".
    But, since gas is case-insensitive, use "RET" in the newly added asm block
    already in order to simplify tip branch merging on its way upstream.
  ]

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com
---
 arch/x86/lib/copy_user_64.S |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e63..e73b76e 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -225,6 +225,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Don't try to copy the tail if machine check happened
  *
  * Input:
+ * eax trap number written by ex_handler_copy()
  * rdi destination
  * rsi source
  * rdx count
@@ -233,12 +234,20 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
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
 	ret
 
+3:
+	movl %edx,%eax
+	ASM_CLAC
+	RET
+
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
