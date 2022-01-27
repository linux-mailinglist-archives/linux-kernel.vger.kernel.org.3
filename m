Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA6A49E1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiA0L4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiA0L4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CFCC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:56:41 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF4FE1EC0354;
        Thu, 27 Jan 2022 12:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643284600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1w1nfaXg2CU2hE5rhGblxO2NDdTodudQ/nnschEZiwc=;
        b=p9vYLfjxowz4qeJ0lFL7kap64GJh8eeUakTC/utiBSz33qtHNc3pvZAOvtEcaKDvMy9DM9
        KaRAb6LG/q3U8FFWTrGM7Jg3UM1LmLkMFyS0FWRlS2RwaMH36ij/CZrBttRQXAiuVkOsc2
        FOTGYPBTyoY3xh2Km7tZcxwoeYwbovo=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] x86/cpu: Remove "noclflush"
Date:   Thu, 27 Jan 2022 12:56:26 +0100
Message-Id: <20220127115626.14179-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220127115626.14179-1-bp@alien8.de>
References: <20220127115626.14179-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Not really needed anymore and there's clearcpuid=.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/x86/kernel/cpu/common.c                    | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dd398f83b335..9882c0cc9722 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3377,8 +3377,6 @@
 
 	nocache		[ARM]
 
-	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
-
 	delayacct	[KNL] Enable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3d0a5340a678..c090cc69c615 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1727,14 +1727,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	update_srbds_msr();
 }
 
-static __init int setup_noclflush(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_CLFLUSH);
-	setup_clear_cpu_cap(X86_FEATURE_CLFLUSHOPT);
-	return 1;
-}
-__setup("noclflush", setup_noclflush);
-
 void print_cpu_info(struct cpuinfo_x86 *c)
 {
 	const char *vendor = NULL;
-- 
2.29.2

