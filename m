Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B42594166
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348962AbiHOViS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348979AbiHOVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:36:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07035DD759;
        Mon, 15 Aug 2022 12:25:38 -0700 (PDT)
Date:   Mon, 15 Aug 2022 19:25:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660591537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clUiGzR8GvCtQEzAy+OAVvp4S6yCdwI7DHULOBY0mTA=;
        b=ZZhvTcbpI6rACMFccV0ixKxcr0908+lm8avBaJZLeAMoFwaowC7SFIUGxdA+O8HSgBowWJ
        0+I7RaZjLQDGxh+YuJbutmOViNQefyOhzqscIPmJ6GSRdCb6KK39EA7wn19rcr/qstL8zG
        SJM+dgn/alybFWK+ygRH276vARlxWKQcre8och/Cp5a5hvdLw+4yUHpIncMJoLrIkUMRMh
        r0Pg6cogOpub+3IJVBK7nkbp6RKZcCX/HpSjIsmKYPIBjTKBvUYsCvEtZ6qRDdoJ5hxkwf
        iRcmZkzr2allEyWPzYML2lHSUYdYy5krwYAn3RhbAREt4LS1NbCw+2Y6AFk4/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660591537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clUiGzR8GvCtQEzAy+OAVvp4S6yCdwI7DHULOBY0mTA=;
        b=kFuvy+ZKSiw2dLLzj3ike2bSCLsGam1MOEG/PUhWSx7uxmAEKZ/iK8YOObbuIMK+xbDUqA
        TaX2cM+a+R4PpUCw==
From:   "tip-bot2 for Li kunyu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Remove superfluous type casting from
 arch/x86/boot/bitops.h
Cc:     Li kunyu <kunyu@nfschina.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220725042358.3377-1-kunyu@nfschina.com>
References: <20220725042358.3377-1-kunyu@nfschina.com>
MIME-Version: 1.0
Message-ID: <166059153613.401.18360871834009022723.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     039f0e054a29d06970892240d70143150d2aaec2
Gitweb:        https://git.kernel.org/tip/039f0e054a29d06970892240d70143150d2aaec2
Author:        Li kunyu <kunyu@nfschina.com>
AuthorDate:    Mon, 25 Jul 2022 12:23:58 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Aug 2022 19:17:43 +02:00

x86/boot: Remove superfluous type casting from arch/x86/boot/bitops.h

'const void *' will auto-type-convert to just about any other const
pointer type, no need to force it.

  [ mingo: Rewrote the changelog. ]

Signed-off-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220725042358.3377-1-kunyu@nfschina.com
---
 arch/x86/boot/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 02e1dea..8518ae2 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -19,13 +19,13 @@
 
 static inline bool constant_test_bit(int nr, const void *addr)
 {
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 	return ((1UL << (nr & 31)) & (p[nr >> 5])) != 0;
 }
 static inline bool variable_test_bit(int nr, const void *addr)
 {
 	bool v;
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 
 	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
 	return v;
