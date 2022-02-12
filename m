Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDE4B3473
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiBLLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:18:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBLLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:18:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15C12613F;
        Sat, 12 Feb 2022 03:18:02 -0800 (PST)
Date:   Sat, 12 Feb 2022 11:17:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644664679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0R2QHDQmiYduE/sh3uq1H1h87TD/Q/RH6gPXiG/2yhY=;
        b=JS9hbHDPIhjtC7yCWnUO3MwqyywzfwRT0RgR3V7lMJ5Yonc/Q/kwdPWpboYBLcmcbskZ67
        Q9howqPDCy56gFXJe9Npj54p1Ua2/JyvqCMVBYZNTu4l46DFMcOoKvCbWyP+f1hLnwq1wc
        8TugfJiqBQW51DKYdO9mW3vG9w3/PQTXItwafCr79nFjROWw7GEfzGl5xXROBW8JuiJWR0
        f+apu2bq371C2PfeNaQ7K1amldvatPBwqaiKdX3JGuBhAItt0urwNJaexK5vVYow0yur8C
        S2sGtltLKgQwPXVbMq15xnHmgVKrq6V01PLZGgyBVstmGJ7SGJbSfqXXFSkTZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644664679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0R2QHDQmiYduE/sh3uq1H1h87TD/Q/RH6gPXiG/2yhY=;
        b=swAAlZtu3uga2c4zSC2X1Xnvlvpm65f/V1IsqEQF35v5veFo3E7Qq/WMIJj/alWkx2ctS9
        qlyx6mUz7fDaJwAQ==
From:   "tip-bot2 for Marco Bonelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/head64: Add missing __head annotation to
 sme_postprocess_startup()
Cc:     Marco Bonelli <marco@mebeim.net>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220211162350.11780-1-marco@mebeim.net>
References: <20220211162350.11780-1-marco@mebeim.net>
MIME-Version: 1.0
Message-ID: <164466467861.16921.14773525480598389536.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     5f117033243488a0080f837540c27999aa31870e
Gitweb:        https://git.kernel.org/tip/5f117033243488a0080f837540c27999aa31870e
Author:        Marco Bonelli <marco@mebeim.net>
AuthorDate:    Fri, 11 Feb 2022 17:23:50 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 12 Feb 2022 11:37:09 +01:00

x86/head64: Add missing __head annotation to sme_postprocess_startup()

This function was previously part of __startup_64() which is marked
__head, and is currently only called from there. Mark it __head too.

Signed-off-by: Marco Bonelli <marco@mebeim.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220211162350.11780-1-marco@mebeim.net
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de563db..4f5ecbb 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -126,7 +126,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
-static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
 	int i;
