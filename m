Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22AF46D1D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhLHLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhLHLRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E406C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:13:51 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C617E1EC04EC;
        Wed,  8 Dec 2021 12:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6DeNY6NraKICDhBYcBMTtNl1trS2fkoTwQ7CfXs3HE=;
        b=JA9UmlLq1oTvRvi/LdTNu35NaQb31y8LlOwMpBdwb8oGXBq6l/EKGxJHOjjZNOELRh7HP3
        EdDTEC8tWGFqD7ylCR7nAG68ez7XO7TVFASoZ7HzYy8wijReicZL8C8jusYrdu6nzoOF7B
        dNNbeem6YgISoNVvT48CDeANzYoIUKs=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 07/12] x86/mce: Mark mce_panic() noinstr
Date:   Wed,  8 Dec 2021 12:13:38 +0100
Message-Id: <20211208111343.8130-8-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

And allow instrumentation inside it because it does calls to other
facilities which will not be tagged noinstr.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xc73: call to mce_panic() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d7fa444d6282..d81266885de3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -266,11 +266,17 @@ static void wait_for_panic(void)
 	panic("Panicing machine check CPU died");
 }
 
-static void mce_panic(const char *msg, struct mce *final, char *exp)
+static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 {
-	int apei_err = 0;
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
+	int apei_err = 0;
+
+	/*
+	 * Allow instrumentation around external facilities usage. Not that it
+	 * matters a whole lot since the machine is going to panic anyway.
+	 */
+	instrumentation_begin();
 
 	if (!fake_panic) {
 		/*
@@ -285,7 +291,7 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 	} else {
 		/* Don't log too much for fake panic */
 		if (atomic_inc_return(&mce_fake_panicked) > 1)
-			return;
+			goto out;
 	}
 	pending = mce_gen_pool_prepare_records();
 	/* First print corrected ones that are still unlogged */
@@ -321,6 +327,9 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
+
+out:
+	instrumentation_end();
 }
 
 /* Support code for software error injection */
-- 
2.29.2

