Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BEC533E19
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiEYNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiEYNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970746D1AB;
        Wed, 25 May 2022 06:43:25 -0700 (PDT)
Date:   Wed, 25 May 2022 13:43:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653486200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0T/htAa6Mcy4LUNx5ZyokxP7Whrk84psRqgVebcxrM=;
        b=JFb2cjdFGxAI+MMyQ9c27wlUHHBDbGdo0VwX/aquxcxFnRYyzwR5z3mbk3sP2tZtO1giQu
        jDSji4NSFdjt/RwGQjHS5w/AvSlvAUs/D4/cDQDQOdEhvg8VEVQaxF/QcnIkHqBvyJjhLg
        lQ4jVHt8M381Yg25j0mHij/eXnXnXuB+iYNjq5ZmqZMyeDWiQbTHZcqSfcsN8Mpegx2OpN
        Qp7krJxojr4LX+qRR13IxQUGC52n3GF06BfB2k6QdiNNn1p10BR9LRrTuZ1/ATuQGdy6I7
        YEFxCJLT3Tr4PS3DXtZ5vTrkoVUnpy/iegmszw3TQ6m6IAFuJ34iwly5FbJXNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653486200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0T/htAa6Mcy4LUNx5ZyokxP7Whrk84psRqgVebcxrM=;
        b=relEWGN/Hzot3AHhyhxyvluKUk/YE5rvvMItM/CxSlFF6yqjf3Q7ia2pETKkIwInzVawwM
        hYoEgrNlDQialqCA==
From:   "tip-bot2 for XueBing Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Use strscpy() to replace deprecated strlcpy()
Cc:     XueBing Chen <chenxuebing@jari.cn>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <730f0fef.a33.180fa69880f.Coremail.chenxuebing@jari.cn>
References: <730f0fef.a33.180fa69880f.Coremail.chenxuebing@jari.cn>
MIME-Version: 1.0
Message-ID: <165348619853.4207.3379558582363552426.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     8a33d96bd178d5f49cc5c1898e4cda08e221d2db
Gitweb:        https://git.kernel.org/tip/8a33d96bd178d5f49cc5c1898e4cda08e221d2db
Author:        XueBing Chen <chenxuebing@jari.cn>
AuthorDate:    Wed, 25 May 2022 16:51:01 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 May 2022 15:34:38 +02:00

x86/setup: Use strscpy() to replace deprecated strlcpy()

strlcpy() is marked deprecated and should not be used, because
it doesn't limit the source length.

The preferred interface for when strlcpy()'s return value is not
checked (truncation) is strscpy().

[ mingo: Tweaked the changelog ]

Signed-off-by: XueBing Chen <chenxuebing@jari.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/730f0fef.a33.180fa69880f.Coremail.chenxuebing@jari.cn
---
 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 249981b..3ebb853 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -903,18 +903,18 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
 		/* append boot loader cmdline to builtin */
 		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
 		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
 #endif
 
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	/*
