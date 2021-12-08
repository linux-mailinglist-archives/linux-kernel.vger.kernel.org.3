Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE446D189
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhLHLHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:07:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59530 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhLHLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:07:17 -0500
Date:   Wed, 08 Dec 2021 11:03:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638961425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikhtMKkQySo8HFeDndy6XVlqsBUutI5KUYrNEghzSuI=;
        b=v5IV/zFT5do6rLQu02I3VI3ozR1mgtl/93gU75cEXt9SIuWrL6xNNz9sf/WDyUDaUM/7qR
        2PVg1vtRQsqjGD6F1hq866qNrLSdJ8NfWVczIGLNTEqNln4nUpkSocltcJbzD0siA62j73
        fFzcMY5A4UqJFvrgOIfVcaNXQpZu+ygLbVwrHlc22O082o1MwbAHd/E4p6jFBDQ4od0UAj
        yZdgxezwpBEHswWW0Ct7K+jLM7sDoR++tROIwEUIqC+h5wlKa3JQcLgiJwQWAsTAdPFaIE
        KpPWCzRn45YIo3ihamSmMMd21iV12L1V/0bZ98lKHfnkUUEgN+g3njnCvEpE+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638961425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikhtMKkQySo8HFeDndy6XVlqsBUutI5KUYrNEghzSuI=;
        b=+/4PSoXtCUiCVRid09LopLkt2gnl4JHnASiQvTKK0+J3+MbPt6R71QYuHY1qmWlHPB2/Hc
        a/brN3qgYV60/iAw==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Check if a bank is populated before injecting
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <163896142414.11128.1972175927654865503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e48d008bd13eaa9068ff59c65275d17516179f7b
Gitweb:        https://git.kernel.org/tip/e48d008bd13eaa9068ff59c65275d17516179f7b
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Thu, 04 Nov 2021 16:58:41 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 12:00:56 +01:00

x86/mce/inject: Check if a bank is populated before injecting

The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
(SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
will read as zero and writes to it will be ignored.

On a hw-type error injection (injection which writes the actual MCA
registers in an attempt to cause a real MCE) check the value of this
register before trying to inject the error.

Do not impose any limitations on a sw injection and allow the user to
test out all the decoding paths without relying on the available hardware,
as its purpose is to just test the code.

 [ bp: Heavily massage. ]

Link: https://lkml.kernel.org/r/20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211104215846.254012-2-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c | 42 ++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0bfc140..725e8e4 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -74,7 +74,6 @@ MCE_INJECT_SET(status);
 MCE_INJECT_SET(misc);
 MCE_INJECT_SET(addr);
 MCE_INJECT_SET(synd);
-MCE_INJECT_SET(ipid);
 
 #define MCE_INJECT_GET(reg)						\
 static int inj_##reg##_get(void *data, u64 *val)			\
@@ -95,6 +94,20 @@ DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
+
+/* Use the user provided IPID value on a sw injection. */
+static int inj_ipid_set(void *data, u64 val)
+{
+	struct mce *m = (struct mce *)data;
+
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		if (inj_type == SW_INJ)
+			m->ipid = val;
+	}
+
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
 static void setup_inj_struct(struct mce *m)
@@ -577,6 +590,33 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 	m->bank = val;
+
+	/*
+	 * sw-only injection allows to write arbitrary values into the MCA
+	 * registers because it tests only the decoding paths.
+	 */
+	if (inj_type == SW_INJ)
+		goto inject;
+
+	/*
+	 * Read IPID value to determine if a bank is populated on the target
+	 * CPU.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		u64 ipid;
+
+		if (rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
+			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
+			return -EINVAL;
+		}
+
+		if (!ipid) {
+			pr_err("Cannot inject into unpopulated bank %llu\n", val);
+			return -ENODEV;
+		}
+	}
+
+inject:
 	do_inject();
 
 	/* Reset injection struct */
