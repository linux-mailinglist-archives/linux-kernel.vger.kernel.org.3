Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A26473315
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbhLMRfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbhLMRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:06 -0500
Date:   Mon, 13 Dec 2021 17:35:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxKiSD10LbkLA3s+vO8y6HEiou9qqjarLUf6yOCfwkE=;
        b=1ADgJ+CP1SVyzESKc5KvJabK3rqxcfZTfK1sjvj5SBqQEDChz0+xpMO1F+y+8mxqtJXvhQ
        xyr8pZKBQLezg2EAWH+lBHPjK/M/3IWaPQpl8w0POmiRJsin2/YOPTqRquheKB0F7wFmXy
        I56n+2E2Vl3s4e/k3Bp47SawfSHP0rn1KI0HB1tsDB7uwATQk43qt4ypoEud7R6+vuZZ9Z
        qIPaMLQ6C6m0ECLNjRgdwU6upKhrriVm9ly8ExBfCoTNutaYaeGT0YAb15r924nfrmZNeC
        Jx7kkiwms50eti/sEAOlUfcNLJQ/ZkcSPOJrx9uqEE9i5lZm9NqxeoJB3VavWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxKiSD10LbkLA3s+vO8y6HEiou9qqjarLUf6yOCfwkE=;
        b=4QQlNgmhGF8CAdTSgNWNBVTGSaIX00Q8tRvt05tyzw6JGOqHYrCr/UT7V904WiHgZMSg/s
        NM88f/fX0dxIfeDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark mce_end() noinstr
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-9-bp@alien8.de>
References: <20211208111343.8130-9-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690431.23020.14608772125685991584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     b4813539d37fa31fed62cdfab7bd2dd8929c5b2e
Gitweb:        https://git.kernel.org/tip/b4813539d37fa31fed62cdfab7bd2dd8929c5b2e
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 01 Nov 2021 16:43:33 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:13:12 +01:00

x86/mce: Mark mce_end() noinstr

It is called by the #MC handler which is noinstr.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xbd6: call to memset() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-9-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ec0f7bb..4bdcca8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1064,10 +1064,13 @@ static int mce_start(int *no_way_out)
  * Synchronize between CPUs after main scanning loop.
  * This invokes the bulk of the Monarch processing.
  */
-static int mce_end(int order)
+static noinstr int mce_end(int order)
 {
-	int ret = -1;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+	int ret = -1;
+
+	/* Allow instrumentation around external facilities. */
+	instrumentation_begin();
 
 	if (!timeout)
 		goto reset;
@@ -1108,7 +1111,8 @@ static int mce_end(int order)
 		/*
 		 * Don't reset anything. That's done by the Monarch.
 		 */
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/*
@@ -1124,6 +1128,10 @@ reset:
 	 * Let others run again.
 	 */
 	atomic_set(&mce_executing, 0);
+
+out:
+	instrumentation_end();
+
 	return ret;
 }
 
