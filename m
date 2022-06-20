Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D875521F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbiFTQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242047AbiFTQL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEE205FA;
        Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:11:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655741513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrpcf1ppm+YNN5xe/s4XK/CIQPND1kqdvgAI2MfreU8=;
        b=rMUQPYpvihQLaNiBDYnBnV/Bis/I+zUCNQegqtMgMeu3wwZWjGZ4xVUyGnyKqbaVo5WQUM
        mZe9qUrGBLN4Dkb7meJhbPCtgthMpMnXdGnOJf+MY0DhCZcGDSDWiQ1r0s4w43bY2vffHL
        HUoqUVgcUDVkt8kDrbwbotAswyMGHc5l7Llei7Vts+jSUC2CFy0D6EWKSfb5hOZy/o/R9P
        EHi/zBo6O9/kk2QmckLwtPUAyRrK6oRzFpqJKg/1F70TD7PuYUtWaOTJOfuFEkm6TqBwTh
        NlCdN6Zsal89AbEpIlQ31YSsKMopvDBQjD5qRdN13ZUAhD5UYXwMUS6NSjJQOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655741513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrpcf1ppm+YNN5xe/s4XK/CIQPND1kqdvgAI2MfreU8=;
        b=pZ0EBiOGBFrUSLUbIG2/HFpL0sCEcZ9PSSVczkDL+ORKVB8a0L057OwlRxWugKd4RBTeux
        1CKYhXy9oz9qKoBA==
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/pmem: Fix platform-device leak in error path
Cc:     Johan Hovold <johan@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220620140723.9810-1-johan@kernel.org>
References: <20220620140723.9810-1-johan@kernel.org>
MIME-Version: 1.0
Message-ID: <165574151164.4207.15439194073733618682.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     229e73d46994f15314f58b2d39bf952111d89193
Gitweb:        https://git.kernel.org/tip/229e73d46994f15314f58b2d39bf952111d89193
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 20 Jun 2022 16:07:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Jun 2022 18:01:16 +02:00

x86/pmem: Fix platform-device leak in error path

Make sure to free the platform device in the unlikely event that
registration fails.

Fixes: 7a67832c7e44 ("libnvdimm, e820: make CONFIG_X86_PMEM_LEGACY a tristate option")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220620140723.9810-1-johan@kernel.org
---
 arch/x86/kernel/pmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pmem.c b/arch/x86/kernel/pmem.c
index 6b07faa..23154d2 100644
--- a/arch/x86/kernel/pmem.c
+++ b/arch/x86/kernel/pmem.c
@@ -27,6 +27,11 @@ static __init int register_e820_pmem(void)
 	 * simply here to trigger the module to load on demand.
 	 */
 	pdev = platform_device_alloc("e820_pmem", -1);
-	return platform_device_add(pdev);
+
+	rc = platform_device_add(pdev);
+	if (rc)
+		platform_device_put(pdev);
+
+	return rc;
 }
 device_initcall(register_e820_pmem);
