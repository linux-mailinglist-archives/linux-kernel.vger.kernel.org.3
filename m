Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F384C5E85
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiB0UPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiB0UPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:15:11 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4046B29
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5CxN1xUBMlFImqgSv+us7R4+dJ9oDkUUXsIOfadkE+0=; b=eEixWE+16EJiQsTKsfCvWXs22J
        CvLcnDhIf4ORddm6vyM7SGNCwl7Q+QXYcyp70dxCTtmuBhqLN3623WC0P71wv1RYq+3L+WG1tCrc4
        jDMRVEcJ4+BqemKYnd1MxTDsUbJdMtMl1PpPR9zjBXNE1RlIEwgvpYGP+Z88FFLDvxh8AQCPOpWdp
        bufbWknGp+7mCyjro3sUpxwFFONJ2nF++zMt+k5+TbwupKTscFYUgeUo5U5X56cYVR7MkAg1O3MhM
        ygSsIw94EUUCvpU9zR5oKaZQyHAmsLoP+09RAXftAInVEPHKtUDPiapzI61vI6gzArUG6rc3J6hzm
        W1fiRYrg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1nOPvq-0007GG-Bg; Sun, 27 Feb 2022 20:14:13 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        jeremy.fitzhardinge@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] x86/mm: Use strtobool for noexec parsing
Date:   Sun, 27 Feb 2022 20:13:56 +0000
Message-Id: <20220227201356.241452-1-linux@treblig.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strtobool to parse the 'noexec' parameter rather than open coding
it.
'disable_nx' is changed to a bool and flipped to 'enable_nx'
so it's meaning follows the command line option.

There's no change in behaviour for noexec=on/off.
noexec=junk will now warn
strtobool allows 0/1 and y/n (etc) as well as the on/off.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/mm/setup_nx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/setup_nx.c b/arch/x86/mm/setup_nx.c
index ed5667f5169ff..77450b5889a0d 100644
--- a/arch/x86/mm/setup_nx.c
+++ b/arch/x86/mm/setup_nx.c
@@ -7,7 +7,7 @@
 #include <asm/proto.h>
 #include <asm/cpufeature.h>
 
-static int disable_nx;
+static bool enable_nx = true;
 
 /*
  * noexec = on|off
@@ -19,21 +19,15 @@ static int disable_nx;
  */
 static int __init noexec_setup(char *str)
 {
-	if (!str)
-		return -EINVAL;
-	if (!strncmp(str, "on", 2)) {
-		disable_nx = 0;
-	} else if (!strncmp(str, "off", 3)) {
-		disable_nx = 1;
-	}
+	int ret = strtobool(str, &enable_nx);
 	x86_configure_nx();
-	return 0;
+	return ret;
 }
 early_param("noexec", noexec_setup);
 
 void x86_configure_nx(void)
 {
-	if (boot_cpu_has(X86_FEATURE_NX) && !disable_nx)
+	if (boot_cpu_has(X86_FEATURE_NX) && enable_nx)
 		__supported_pte_mask |= _PAGE_NX;
 	else
 		__supported_pte_mask &= ~_PAGE_NX;
@@ -46,7 +40,7 @@ void __init x86_report_nx(void)
 		       "missing in CPU!\n");
 	} else {
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-		if (disable_nx) {
+		if (!enable_nx) {
 			printk(KERN_INFO "NX (Execute Disable) protection: "
 			       "disabled by kernel command line option\n");
 		} else {
-- 
2.35.1

