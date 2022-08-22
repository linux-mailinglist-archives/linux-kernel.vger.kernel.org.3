Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F959C53F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiHVRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiHVRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:42:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BC40BDB;
        Mon, 22 Aug 2022 10:42:00 -0700 (PDT)
Date:   Mon, 22 Aug 2022 17:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661190119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5czPSK8TXuuC7meTY+Sd48/UazXXlbKZgmO+4Z5mCdo=;
        b=gZ74cHhfdZ3RRf0Jty7fhCTModYdm/TeZ2+jMWyDuFVgy7PYChD5otKs6auTX+NvyGLcNi
        /mCN1V1qW3zRS1GwUE9Zkupn/8P/rErJp/Cf8MrxccjE+SFu4Esqvez60HAxSSzeFL0GK8
        Mg8OdchG7GrPOb9soIz/N+mJN8MfKn32Ig71mNWYIIPrETKnsy7P4o783HDN7DqxCpLZMY
        z+rOvoK9gNOEWwMXB3P2uTMZ0zl2Bz++p+c9SsYDcSxy84XEiWouxoFaHr3W1Jf0d/sSnr
        HyADHPuYNbLiMoS8DzT2BOSQorN6y35aOQtoSbmi1F10Y9e4OBLRGTgzduVdcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661190119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5czPSK8TXuuC7meTY+Sd48/UazXXlbKZgmO+4Z5mCdo=;
        b=WSNU0t5wcCjBt65bxt+IhSLe+D3xSebkjOHxkYoJLhtYdlQgyj8dP+kyJntfPeRwl7bwLc
        sutIWdyc841A8aCw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] RAS/CEC: Reduce offline page threshold for Intel systems
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220607212015.175591-1-tony.luck@intel.com>
References: <20220607212015.175591-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <166119011743.401.9614017197181916604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d25c6948a6aad787d9fd64de6b5362c3f23cc8d0
Gitweb:        https://git.kernel.org/tip/d25c6948a6aad787d9fd64de6b5362c3f23cc8d0
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 02 Aug 2022 09:18:47 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 22 Aug 2022 19:30:02 +02:00

RAS/CEC: Reduce offline page threshold for Intel systems

A large scale study of memory errors on Intel systems in data centers
showed that aggressively taking pages with corrected errors offline is
the best strategy of using corrected errors as a predictor of future
uncorrected errors.

Set the threshold to "2" on Intel systems. AMD guidance is that this is
not necessary for their systems.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20220607212015.175591-1-tony.luck@intel.com
Link: https://lore.kernel.org/r/YulOZ/Eso0bwUcC4@agluck-desk3.sc.intel.com
---
 drivers/ras/cec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 42f2fc0..321af49 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -556,6 +556,14 @@ static int __init cec_init(void)
 	if (ce_arr.disabled)
 		return -ENODEV;
 
+	/*
+	 * Intel systems may avoid uncorrectable errors
+	 * if pages with corrected errors are aggressively
+	 * taken offline.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		action_threshold = 2;
+
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
