Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015D54506B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbiFIPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbiFIPPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:15:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6122E699;
        Thu,  9 Jun 2022 08:15:41 -0700 (PDT)
Date:   Thu, 09 Jun 2022 15:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654787740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogrOq9vhDIU1vnWkh0rFG1oDA7rFMvFTyJJAyFrFzFA=;
        b=yQUwVsdjUfwDj1yuqopMlMBQkvxxWk3tndNXPl5xbNGyFJRJmoz53VqHVNOK9rxUKwwpeE
        293l5KKTBdaQMK2XQwX5qr+rTxq6P404yQQPCWOb/z1inM05jVjYQts8RkyMUzqmM/ZOD9
        CrodVY1eE0ysWz75IHiHm92B8dqXP3lkgUSZ/KNBZ7yS37ghykpa+jIgF0O35Rrb91X3R2
        dX4RMC5n3XPhKCosnsuA6TUniMqE2sqCOKdPe18OIldyOhh2wnsyqnjTBHlrQa9524tZfO
        V5pFI4WE516NKueQv+f4EXFFByMOuHBXEUTSEQpB1PkB/EwjI8t14oG7ogNXtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654787740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogrOq9vhDIU1vnWkh0rFG1oDA7rFMvFTyJJAyFrFzFA=;
        b=M/FBsbpEucML2WYDiZuwuXO/coazzuQdR/gZnw3uH1P321Nc6Ii9beK8NWOKNo0wYf4fqD
        eWLdMPo8XUaXNaAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix obsolete reference to CONFIG_X86_SMAP
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <44c57668768c1ba1b4ba1ff541ec54781636e07c.1654101721.git.jpoimboe@kernel.org>
References: <44c57668768c1ba1b4ba1ff541ec54781636e07c.1654101721.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165478773912.4207.17052247168855339682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c2f75a43f5ae48b9babeb5b82c9f23fe18d3d144
Gitweb:        https://git.kernel.org/tip/c2f75a43f5ae48b9babeb5b82c9f23fe18d3d144
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 01 Jun 2022 09:42:12 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Jun 2022 11:49:55 -07:00

objtool: Fix obsolete reference to CONFIG_X86_SMAP

CONFIG_X86_SMAP no longer exists.  For objtool's purposes it has been
replaced with CONFIG_HAVE_UACCESS_VALIDATION.

Fixes: 03f16cd020eb ("objtool: Add CONFIG_OBJTOOL")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/44c57668768c1ba1b4ba1ff541ec54781636e07c.1654101721.git.jpoimboe@kernel.org
---
 lib/Kconfig.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index c4fe15d..a9f7eb0 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -94,7 +94,7 @@ config UBSAN_UNREACHABLE
 	bool "Perform checking for unreachable code"
 	# objtool already handles unreachable checking and gets angry about
 	# seeing UBSan instrumentation located in unreachable places.
-	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || X86_SMAP))
+	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || HAVE_UACCESS_VALIDATION))
 	depends on $(cc-option,-fsanitize=unreachable)
 	help
 	  This option enables -fsanitize=unreachable which checks for control
