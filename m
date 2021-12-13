Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401947331A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhLMRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbhLMRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:08 -0500
Date:   Mon, 13 Dec 2021 17:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6fCpPfoeXt+ki421lxodb/shE5lzyflYG3Q7+mCQ9E=;
        b=RV4D6ddvJbkX8PBkFZpT6Ukl14DnaM0gCRkWbCotKcwvkxLagaQLxbJA4XySwU8ZfgePB0
        eplxU8P4FZwWvTb41iBS0519NBe9jjjPSwb4E8mAopIJ4WoglqtKbSOfynSjk9BXiUYIXF
        C+/vFXMCSivqQQMhLMmToTpfeBslu2L5yacFSIU6ERupE1EYfBorODWFOckql7haq57DWm
        4VUtXQzHVevGsWZVlZ90caW2NYPWY2glVJfplDdZ8443AovStahaxOJiPVZx44FBC2WYZG
        R0X99I1VUsD0Lff28hROGgYAoTII3+hIUpClACA5T8X01s11X7xIvdZM/iAxrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6fCpPfoeXt+ki421lxodb/shE5lzyflYG3Q7+mCQ9E=;
        b=YQO5339/pTCyTVDQIf2pk/I2WnjG4TOalg8vUHhpowjrE8jwji2dyaE4/f0s8XqZnPTTpK
        k+3RNvtY1p5of3BQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Allow instrumentation during task work queueing
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-6-bp@alien8.de>
References: <20211208111343.8130-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690650.23020.4840742138694293786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4fbce464db81a42f9a57ee242d6150ec7f996415
Gitweb:        https://git.kernel.org/tip/4fbce464db81a42f9a57ee242d6150ec7f996415
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 13 Oct 2021 09:07:19 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:12:35 +01:00

x86/mce: Allow instrumentation during task work queueing

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xdb1: call to queue_task_work() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-6-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c11fc8d..d788ccc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1459,6 +1459,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if (worst != MCE_AR_SEVERITY && !kill_current_task)
 		goto out;
 
+	/*
+	 * Enable instrumentation around the external facilities like
+	 * task_work_add() (via queue_task_work()), fixup_exception() etc.
+	 * For now, that is. Fixing this properly would need a lot more involved
+	 * reorganization.
+	 */
+	instrumentation_begin();
+
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
@@ -1487,6 +1495,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
 			queue_task_work(&m, msg, kill_me_never);
 	}
+
+	instrumentation_end();
+
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
