Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4031650B548
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350519AbiDVKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446677AbiDVKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD877DB0;
        Fri, 22 Apr 2022 03:34:59 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WFcaJ5qlrSo2qvNAjn7cVA2XbTWm0qebl64tNPAGd4=;
        b=3XcpRXP3GztScaTGMMih8F97bc7JFxVrN4yl6BZkfKj30Fk2pm567okK61YyPYxnAwbZL3
        yJHaMo0Apu61zYHj1t2PVkw+ne3awTSdVIQBx7qfyAOeQW1Y9EVIy5uZJKe4bEF69AAWuV
        qNwokSo6P61yUsJ3Hxbo4I6CNl5i2L0sFJvLOeoUJSiFoxx2JRPMmH4PRynuraYFUDG/Tj
        /1SqBwdaN17lcfQXpdjfrqYaasKSvWSfGK4Ffi6psQxheCawSyTIpq3SAFhtvJ9oCbQdJM
        ApQDaQD8kJDEvzlqC6CgB52URneOLhFWH9gJYCiFIVKH54TYFJgD3vXUdVvssg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WFcaJ5qlrSo2qvNAjn7cVA2XbTWm0qebl64tNPAGd4=;
        b=sSeTs6Rbieg0BXOvWemAmcVnqDTRf3sEqWEygLmuQSxrtzdVoq9A0lDhyQW3XL9D9kLz2n
        2xkkHKBsi8zcZFBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add HAVE_NOINSTR_VALIDATION
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <488e94f69db4df154499bc098573d90e5db1c826.1650300597.git.jpoimboe@redhat.com>
References: <488e94f69db4df154499bc098573d90e5db1c826.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062369721.4207.17877598871081772031.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     489e355b42255c5536a0ea3083a66b54a5e235c3
Gitweb:        https://git.kernel.org/tip/489e355b42255c5536a0ea3083a66b54a5e235c3
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:05 +02:00

objtool: Add HAVE_NOINSTR_VALIDATION

Remove CONFIG_NOINSTR_VALIDATION's dependency on HAVE_OBJTOOL, since
other arches might want to implement objtool without it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/488e94f69db4df154499bc098573d90e5db1c826.1650300597.git.jpoimboe@redhat.com
---
 arch/Kconfig      | 3 +++
 arch/x86/Kconfig  | 1 +
 lib/Kconfig.debug | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6ba6e34..1e19da7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1038,6 +1038,9 @@ config HAVE_JUMP_LABEL_HACK
 config HAVE_NOINSTR_HACK
 	bool
 
+config HAVE_NOINSTR_VALIDATION
+	bool
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 06e7cdd..1847d6e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -233,6 +233,7 @@ config X86
 	select HAVE_MOVE_PUD
 	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
 	select HAVE_NMI
+	select HAVE_NOINSTR_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
 	select HAVE_PCSPKR_PLATFORM
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 73359d6..55b9acb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -502,7 +502,7 @@ config STACK_VALIDATION
 
 config NOINSTR_VALIDATION
 	bool
-	depends on HAVE_OBJTOOL && DEBUG_ENTRY
+	depends on HAVE_NOINSTR_VALIDATION && DEBUG_ENTRY
 	select OBJTOOL
 	default y
 
