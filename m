Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A8F4F1E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380298AbiDDVsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379936AbiDDSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:24:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450F22B20;
        Mon,  4 Apr 2022 11:22:20 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:22:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3w/yAJpOjhAW4Wz4L7tzqhvuIJL/yoS7z64bdUfVlo=;
        b=fM2IqwhWVs5WEO4dPP2InNrIDr6iPi8W3+eXYVQ/jDFTNoJBvDMHNsT5cgktCBAcnLgHVj
        I/dt7TpFrlI6+euW2C2LSJr5YtWee3O1ngtjoSTgKX4lIysF5A9TX220wxoIBhrOPyGihq
        KOgkD5+ye9PemR1+jzzFn78KVgw9Jvqs7xuFyZhvKUojzW29lhLF3VFhil+mDJwViyGxBK
        5jzZEgWQvynFDPzrcy5M8Nr/PQ4RNIME99pF6gVbBSwLBGwc2ApHL+fBUiS8ZUQUMM5o5H
        BkyHHHRX1d/28fClqGYjPwH3Z86HKdjL6qS4KEAAw4xf42/bog4EkCiwfftigg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3w/yAJpOjhAW4Wz4L7tzqhvuIJL/yoS7z64bdUfVlo=;
        b=edx0y1BQwJYFEZA/+QGVlmu5NUBQYqfIOvgtAaaIiW8bFMJnzTHsczLp30WbEdR3pMZpXS
        onjZTfSuS9lJ5OBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove "nosmep"
Cc:     Borislav Petkov <bp@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220127115626.14179-5-bp@alien8.de>
References: <20220127115626.14179-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909653849.389.15352587748803921438.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     385d2ae0a1b5efacb30e13a0f0e521490441d9bb
Gitweb:        https://git.kernel.org/tip/385d2ae0a1b5efacb30e13a0f0e521490441d9bb
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 27 Jan 2022 12:56:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:17:00 +02:00

x86/cpu: Remove "nosmep"

There should be no need to disable SMEP anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-5-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/x86/cpuinfo.rst                   | 4 ++--
 arch/x86/kernel/cpu/common.c                    | 7 -------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e0bb710..39ac2c1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3465,7 +3465,7 @@
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-	nosmep		[X86,PPC64s]
+	nosmep		[PPC64s]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
 
diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
index 12fbe2b..08246e8 100644
--- a/Documentation/x86/cpuinfo.rst
+++ b/Documentation/x86/cpuinfo.rst
@@ -140,8 +140,8 @@ from #define X86_FEATURE_UMIP (16*32 + 2).
 
 In addition, there exists a variety of custom command-line parameters that
 disable specific features. The list of parameters includes, but is not limited
-to, nofsgsbase, and nosmep. 5-level paging can also be disabled using
-"no5lvl". SMEP is disabled with the aforementioned parameter.
+to, nofsgsbase, nosgx, noxsave, etc. 5-level paging can also be disabled using
+"no5lvl".
 
 e: The feature was known to be non-functional.
 ----------------------------------------------
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 747df07..5791f69 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -369,13 +369,6 @@ static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 }
 #endif
 
-static __init int setup_disable_smep(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SMEP);
-	return 1;
-}
-__setup("nosmep", setup_disable_smep);
-
 static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_SMEP))
