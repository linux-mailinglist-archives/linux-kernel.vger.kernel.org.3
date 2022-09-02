Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35875AA7E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiIBGQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiIBGQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:16:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A888E0CE;
        Thu,  1 Sep 2022 23:16:20 -0700 (PDT)
Date:   Fri, 02 Sep 2022 06:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662099378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yh5nbofxKXDkqZCw/xR+TdYjF6z3LSisPjX1xlymmF0=;
        b=yr/ratrtsf8EDswM9qS0PGolYp4Atn2sNTcTcpCobWNqtBUE74pQ4skmoBvjD/YYCrlARL
        ej7QSgq6waWLrStYBCxpSH4nXSbZj1phr0tXItN+uu5uCMCk6sXLRgUA+iP120WiFa4Nzp
        XF++HVx74UI5wQ5NUdruzJBxcd8Nv1/ayNoAejxPaVpZsZgj/fAT9Sd+WPThU5xoLX/yRp
        Se4HEy0nokcjVFgucCGcMmgrpSExZcDlD+ZEBGUl+U3Ej9kfv9mx4XAzb8VRe7mDMlhcHb
        IyqeZ6oUnZNVgTPhMNO0YwCDaoz1MdXT1aujOpB9CY7w18vgDrM1GCKbYjgNjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662099378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yh5nbofxKXDkqZCw/xR+TdYjF6z3LSisPjX1xlymmF0=;
        b=hi5+w0JHOCaR643UN4rj1mc44DFnesXEUZ1Ugwl1ibW45EHcEcpkkfZVO1ZrRyTROdW/Ey
        ePKUBfqdg0PDbRCw==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Print previous version of
 microcode after reload
Cc:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829181030.722891-1-ashok.raj@intel.com>
References: <20220829181030.722891-1-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <166209937647.401.14402365682473849794.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7fce8d6eccbc31a561d07c79f359ad09f0424347
Gitweb:        https://git.kernel.org/tip/7fce8d6eccbc31a561d07c79f359ad09f0424347
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 29 Aug 2022 18:10:30 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 02 Sep 2022 08:01:58 +02:00

x86/microcode: Print previous version of microcode after reload

Print both old and new versions of microcode after a reload is complete
because knowing the previous microcode version is sometimes important
from a debugging perspective.

  [ bp: Massage commit message. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20220829181030.722891-1-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/microcode/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ad57e0e..6a41cee 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -491,7 +491,7 @@ wait_for_siblings:
  */
 static int microcode_reload_late(void)
 {
-	int ret;
+	int old = boot_cpu_data.microcode, ret;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -503,7 +503,8 @@ static int microcode_reload_late(void)
 	if (ret == 0)
 		microcode_check();
 
-	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
+	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+		old, boot_cpu_data.microcode);
 
 	return ret;
 }
