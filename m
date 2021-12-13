Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFC473313
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbhLMRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36202 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbhLMRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:06 -0500
Date:   Mon, 13 Dec 2021 17:35:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zica81/nXicOVPAxqLr7WW1zJoGKCeZnZ3bLtoWPa6Y=;
        b=oRjIAw7KZS+1W3FRUzHBcL2W7SA26z9warGgqPqe7+Qm/A+nACuoJDa4XqI7ZaOSkgc6ru
        DJuVdL/pk/MaqsLHKx3mSmyNpXgxzFil6WIOttjKobGBp7NhYZ8Mx7uZf/+8uxaHvVYvWZ
        /kq4NPzcQy4i9LpBbK3HWytQB5tk3nvDlM7j3kRAVtS1rnxxvcW77SZUoOOV0t3AUpugOy
        fuGgcvwy14a3VJvUeFT9lS4YeAtOEXUBFlu9EYuOJ/poMqJxETtMIiitz8tkY0z5OOI/3q
        5WpkNoH4L+UoNSfy8tFabIq/FznpHcUelxPkybxq9KUx3T8ocaCfDg609r8leQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zica81/nXicOVPAxqLr7WW1zJoGKCeZnZ3bLtoWPa6Y=;
        b=t34Xjavz16/EO9NK1pInhe0ymyiGXQg/3wf8Puznf1S0AykNm0x3aSqoHt173l32jflvQk
        AGu14IQ79QZdQXDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark mce_read_aux() noinstr
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-10-bp@alien8.de>
References: <20211208111343.8130-10-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690356.23020.5183179449240242570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     db6c996d6ce45dfb44891f0824a65ecec216f47a
Gitweb:        https://git.kernel.org/tip/db6c996d6ce45dfb44891f0824a65ecec216f47a
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 02 Nov 2021 11:14:48 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:13:23 +01:00

x86/mce: Mark mce_read_aux() noinstr

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x681: call to mce_read_aux() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-10-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4bdcca8..53b4cfc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -648,7 +648,7 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static void mce_read_aux(struct mce *m, int i)
+static noinstr void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
