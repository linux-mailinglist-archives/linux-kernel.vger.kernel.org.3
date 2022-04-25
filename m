Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3250E4E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbiDYP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243122AbiDYP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:59:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73711483C;
        Mon, 25 Apr 2022 08:56:22 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:56:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650902180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvEo3pIPmkeqJjZJjnqzOY4nYV5eWsz50+K81wzXkOk=;
        b=dWROzVM6FwtJUAsAsqTW+fKPmDnOPiiD4XLt6KZL3S4ztjXar4ZLTDQHoEYcvB93gPBeDc
        Wl4tYszU2gN2JWjNLg2H6se6K/N/vyLoI2mRe0ONQxRY52y4iUBlIYnrAWSlIWDJyj7tbo
        6HPJht0uggQayfHZ70gxdkucsUhbq8wxpz28IVycNktl7zaIQEFAk2Zs3IAQS55qgA7qJD
        d8VlZPGKeSy8IUE7ZmWt+GNgg9ADltg/g+GjM6JR95TxzidialT+Ftd/lop7lWcIhiYZ89
        U02lti50OtH72iMMGpAJ5rbtLqnaZ4wjuA/i8oBTxVqBfSJAJLGZ3qF5I5FgnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650902180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvEo3pIPmkeqJjZJjnqzOY4nYV5eWsz50+K81wzXkOk=;
        b=4cEnn3tZowq7JmYeLoPtla68lcpBgWx51yQAkaUYc01pnfplTl+UunM8sAyT4lmAmksBUv
        fQftZ9AJJVyncWDA==
From:   "tip-bot2 for Carlos Bilbao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add messages for panic errors in AMD's MCE grading
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405183212.354606-3-carlos.bilbao@amd.com>
References: <20220405183212.354606-3-carlos.bilbao@amd.com>
MIME-Version: 1.0
Message-ID: <165090217952.4207.18288395575874990441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     fa619f5156cf1ee3773edc6d756be262c9ef35de
Gitweb:        https://git.kernel.org/tip/fa619f5156cf1ee3773edc6d756be262c9ef35de
Author:        Carlos Bilbao <carlos.bilbao@amd.com>
AuthorDate:    Tue, 05 Apr 2022 13:32:14 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Apr 2022 12:40:48 +02:00

x86/mce: Add messages for panic errors in AMD's MCE grading

When a machine error is graded as PANIC by the AMD grading logic, the
MCE handler calls mce_panic(). The notification chain does not come
into effect so the AMD EDAC driver does not decode the errors. In these
cases, the messages displayed to the user are more cryptic and miss
information that might be relevant, like the context in which the error
took place.

Add messages to the grading logic for machine errors so that it is clear
what error it was.

  [ bp: Massage commit message. ]

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20220405183212.354606-3-carlos.bilbao@amd.com
---
 arch/x86/kernel/cpu/mce/severity.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index d842148..00483d1 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -304,6 +304,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 /* See AMD PPR(s) section Machine Check Error Handling. */
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
+	char *panic_msg = NULL;
 	int ret;
 
 	/*
@@ -314,6 +315,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC) {
+		panic_msg = "Processor Context Corrupt";
 		ret = MCE_PANIC_SEVERITY;
 		goto out;
 	}
@@ -337,19 +339,26 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 	 * system will not be able to recover, panic.
 	 */
 	if ((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov) {
+		panic_msg = "Overflowed uncorrected error without MCA Overflow Recovery";
 		ret = MCE_PANIC_SEVERITY;
 		goto out;
 	}
 
 	if (!mce_flags.succor) {
+		panic_msg = "Uncorrected error without MCA Recovery";
 		ret = MCE_PANIC_SEVERITY;
 		goto out;
 	}
 
-	if (error_context(m, regs) == IN_KERNEL)
+	if (error_context(m, regs) == IN_KERNEL) {
+		panic_msg = "Uncorrected unrecoverable error in kernel context";
 		ret = MCE_PANIC_SEVERITY;
+	}
 
 out:
+	if (msg && panic_msg)
+		*msg = panic_msg;
+
 	return ret;
 }
 
