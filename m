Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C474587BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiHBL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388A4505F;
        Tue,  2 Aug 2022 04:57:39 -0700 (PDT)
Date:   Tue, 02 Aug 2022 11:57:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659441457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCu9c6Oi0J6bIMX6Dxg5upP4pi0J0EeFZvvwPRwJEdE=;
        b=juW5jCk6V0hHxIT8LfaS2RTUioa3N8Ohbp/xhGMdkGb9hUqTcjcfNwbotEYs67pVfduY2u
        a7a4A2ul4QlYzvCbN6EH9vBgvB6RJHDEdqE0QhubZR/Vmi7C0X+3vhWqtfEDdRCEkygcWc
        oidl6Ns7I15PMHQx1QoxKpZeV+SYEPI1JV1LahHnaI2IDXVMJhwR0jS2MfmuApgZ5yk2JR
        XES/sMXUbiObK2JuPisc3niDDRmNQQWYw2pp3tm8Ij9ftaqC9Eqkz6OawFdrO98CIhOJ9P
        Rjl/wN9h1nMcSIlYWxlGeAfMCaRJ3oTsDXZh+BZnJ1d8yCAm1VF1MinCD2G2ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659441457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCu9c6Oi0J6bIMX6Dxg5upP4pi0J0EeFZvvwPRwJEdE=;
        b=IycYctxPUhmpgfBoSUKrQSIPuRSv+lfkXv09niZCFQV56lnKGEWQoYfJt/nZ0k/bX+m0lp
        H8tvMMO9iUvOxsAQ==
From:   "tip-bot2 for Chenyi Qiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220802033206.21333-1-chenyi.qiang@intel.com>
References: <20220802033206.21333-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Message-ID: <165944145642.15455.3291714201522580365.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ffa6482e461ff550325356ae705b79e256702ea9
Gitweb:        https://git.kernel.org/tip/ffa6482e461ff550325356ae705b79e256702ea9
Author:        Chenyi Qiang <chenyi.qiang@intel.com>
AuthorDate:    Tue, 02 Aug 2022 11:32:06 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 13:42:00 +02:00

x86/bus_lock: Don't assume the init value of DEBUGCTLMSR.BUS_LOCK_DETECT to be zero

It's possible that this kernel has been kexec'd from a kernel that
enabled bus lock detection, or (hypothetically) BIOS/firmware has set
DEBUGCTLMSR_BUS_LOCK_DETECT.

Disable bus lock detection explicitly if not wanted.

Fixes: ebb1064e7c2e ("x86/traps: Handle #DB for bus lock")
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20220802033206.21333-1-chenyi.qiang@intel.com
---
 arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 663f6e6..2d7ea54 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1216,22 +1216,23 @@ static void bus_lock_init(void)
 {
 	u64 val;
 
-	/*
-	 * Warn and fatal are handled by #AC for split lock if #AC for
-	 * split lock is supported.
-	 */
-	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
-	    (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
-	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
-	    sld_state == sld_off)
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
 
-	/*
-	 * Enable #DB for bus lock. All bus locks are handled in #DB except
-	 * split locks are handled in #AC in the fatal case.
-	 */
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
-	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
+	    sld_state == sld_off) {
+		/*
+		 * Warn and fatal are handled by #AC for split lock if #AC for
+		 * split lock is supported.
+		 */
+		val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	} else {
+		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	}
+
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
 }
 
