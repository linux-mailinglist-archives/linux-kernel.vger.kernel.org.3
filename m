Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2049E1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiA0L4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiA0L4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D38C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:56:39 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BB591EC059D;
        Thu, 27 Jan 2022 12:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643284598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNSth3tzSv/2p+hB53qPBBPKc721uGg6LNa/frseOlQ=;
        b=lR1lU9UGT+hOXfhknlQI8ldfT8yTPEnTltd58/cfnCDvfuiax/3B2tP93+CTLbzSXhwkaG
        RVQQltENVSRQJ/uUlwSeti4NSrXu9plxPlpGIXtacz7mhqhW6RC8DGZeV864UmGC1zYoBN
        ezXuZDDc2FQJtDGOgL600MOzdUHcg58=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v2 4/6] x86/cpu: Remove "nosmep"
Date:   Thu, 27 Jan 2022 12:56:24 +0100
Message-Id: <20220127115626.14179-5-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220127115626.14179-1-bp@alien8.de>
References: <20220127115626.14179-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There should be no need to disable SMEP anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/x86/cpuinfo.rst                   | 4 ++--
 arch/x86/kernel/cpu/common.c                    | 7 -------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04b155a4298f..e3894159c22b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3398,7 +3398,7 @@
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-	nosmep		[X86,PPC64s]
+	nosmep		[PPC64s]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
 
diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
index 12fbe2b1e98a..08246e8ac835 100644
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
index 7e5d695279bc..3d0a5340a678 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -291,13 +291,6 @@ static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
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
-- 
2.29.2

