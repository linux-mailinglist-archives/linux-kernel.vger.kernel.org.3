Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83104641D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbhK3XAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbhK3XAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:00:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE9C061748;
        Tue, 30 Nov 2021 14:56:39 -0800 (PST)
Date:   Tue, 30 Nov 2021 22:56:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638312998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnqnyIPZkUAgwlA/RcC3vXJqFQl4gWJOjAnzRqj6Ubw=;
        b=2q3tjkCzunbWpc8AWgIMrv5XpzFYYcd6ET33OqeLF/t5treQPCL63Y2Dj7p02QWeMcqeSd
        YdHBfTLKKVxMgYrVaggDG9LTE0LaC2skP+isPj+hlegArtWPfd+bvLCKmWDsOhXHcoXhXK
        3SbjDh3tpDr5xLNa/SwFcJZ2DSoqRD/Jk643GGSL3Hpnr3Bx8I6MvmM39hG42qzOk19ZMi
        IfPUPzGBgdyd72yoxw17rf0XgwBg606VEQAdd7vOLaNBm5ViYIdwxgRunpSC5SqfVr+lNo
        retjpwcjgEtr/5Fsdv6soxYiSDcjMLYREyzk3kAwW6JS7h2ZmMNMECy+791Hfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638312998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnqnyIPZkUAgwlA/RcC3vXJqFQl4gWJOjAnzRqj6Ubw=;
        b=Wxrg9tjA9xAWhaAzgQFd2/kXabUOobd1vffuyNGCvQyb69t3OXiLmsRC1MCK0qjM1xcLGK
        b5RHjJGOkONnwzBQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn-eval: Handle insn_get_opcode() failure
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211130184933.31005-2-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163831299708.11128.7866012474234259026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     23ef731e4365196bfc186358eb4f6265d60ab352
Gitweb:        https://git.kernel.org/tip/23ef731e4365196bfc186358eb4f6265d60ab352
Author:        Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate:    Tue, 30 Nov 2021 21:49:30 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 14:52:26 -08:00

x86/insn-eval: Handle insn_get_opcode() failure

is_string_insn() calls insn_get_opcode() that can fail, but does not
handle the failure.

is_string_insn() interface does not allow to communicate an error to the
caller.

Push insn_get_opcode() to the only non-static user of is_string_insn()
and fail it early if insn_get_opcode() fails.

[ dhansen: fix tabs-versus-spaces breakage ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20211130184933.31005-2-kirill.shutemov@linux.intel.com
---
 arch/x86/lib/insn-eval.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index eb3ccff..1c51e8a 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -37,8 +37,6 @@ enum reg_type {
  */
 static bool is_string_insn(struct insn *insn)
 {
-	insn_get_opcode(insn);
-
 	/* All string instructions have a 1-byte opcode. */
 	if (insn->opcode.nbytes != 1)
 		return false;
@@ -1405,6 +1403,9 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	if (!insn || !regs)
 		return (void __user *)-1L;
 
+	if (insn_get_opcode(insn))
+		return (void __user *)-1L;
+
 	switch (insn->addr_bytes) {
 	case 2:
 		return get_addr_ref_16(insn, regs);
