Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF7516B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358607AbiEBHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbiEBHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:37:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117F114D;
        Mon,  2 May 2022 00:33:58 -0700 (PDT)
Date:   Mon, 02 May 2022 07:33:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651476837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Hl93BaP+6Fz4+/p8Q6tSarrF/dIp3vDcExxf3BnwgQ=;
        b=YCPOc6+wufYjQF7S9TThe94SeQhsZ3wvWdNDDKfrkg75fbDytxgw+kBJeUFtJGK8hPMDE3
        ITtTsMMFkA3BKSIytvbA1eACQCAotjDpR3QxkA5+9aw9jUBdBk2tY9BctO3/iaqbSm+eIU
        Z1AT6Z2CxXRDSfJIpl6BcBTDR1qpPCTiBPI+yPNH3x5V7bZKRJ/j7cM5aW2AEZxe8sHDS3
        uHtKUImduaY78T1trfyDVNbsObkAdznycru2MGj6IVxSs6IFYFC13IbEx6JzXCpX0PyNLq
        XMYVM1DPR8ZhkIbJJ6ABeq2Aa7wN4wrJKtshRKnc/C3yf1gWrv/jrByBu9loHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651476837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Hl93BaP+6Fz4+/p8Q6tSarrF/dIp3vDcExxf3BnwgQ=;
        b=114+oRhU/Vz7aPBZa6iQlyCq0XTduTRToXwpNv0fdTQqypkGHRsyrX3WN+L1F5zFNjS+Tu
        2XGkobkVWdBjv+Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Cleanup variable shadowing
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202204262032.jFYKit5j-lkp@intel.com>
References: <202204262032.jFYKit5j-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <165147683595.4207.10467691801544326592.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b91c0922bf1ed15b67a6faa404bc64e3ed532ec2
Gitweb:        https://git.kernel.org/tip/b91c0922bf1ed15b67a6faa404bc64e3ed532ec2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 May 2022 09:20:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 09:28:31 +02:00

x86/fpu: Cleanup variable shadowing

Addresses: warning: Local variable 'mask' shadows outer variable

Remove extra variable declaration and switch the bit mask assignment to use
BIT_ULL() while at it.

Fixes: 522e92743b35 ("x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/202204262032.jFYKit5j-lkp@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 31c12f4..81fcd04 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1233,7 +1233,7 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 	}
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
-		u64 mask = ((u64)1 << i);
+		mask = BIT_ULL(i);
 
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(xsave, i);
