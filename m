Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7E58C7B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiHHLkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiHHLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:40:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCAA5F5F;
        Mon,  8 Aug 2022 04:40:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.46.64.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F42F6601C28;
        Mon,  8 Aug 2022 12:40:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659958826;
        bh=Mz0RDPA7p3Dfvp3I4U1fgB3B0KKGWXSWNIX3BZgcrBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzWwD1wcxrwuIt0Octlu4Ol2iu4SmNmMWwgoYoRkmqZF9DCWk0SljRkPp4fvTD/e5
         4DaopepsJDHllgckmzAn8MVF8Ep2BL/vI0ssgZD0ho41Pu906GWA2ceZvvFdDRMBM4
         NGaksFFVLjyBZgcHDmA8NFkzlgv0fXoznA7IN5aQMHlxp/cSVVZJoBRM1+yUXOQXBg
         t1zQ21gD5f0Q9p+nAif9g8EgKGhbOO2L+URXd7jo16LH8CXFn4KzZoYMrdcah9Pi1A
         sGsBKCZ6GL/h7Kcn4PXAnxgswwvTVefHu0IzVltTS/9JfVF6eHqFgMb+GLo9LYGaWz
         jhSZksmzqyDxw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     Steven Noonan <steven@uplinklabs.net>, usama.anjum@collabora.com,
        kernel@collabora.com
Subject: [PATCH 3/3] x86/tsc: don't check for random warps if using direct sync
Date:   Mon,  8 Aug 2022 16:39:54 +0500
Message-Id: <20220808113954.345579-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808113954.345579-1-usama.anjum@collabora.com>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Noonan <steven@uplinklabs.net>

There's some overhead in writing and reading MSR_IA32_TSC. We try to
account for it. But sometimes overhead gets under or over estimated.
When we retry syncing, it sees the clock "go backwards". Hence,
ignore random wrap if using direct sync.

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 arch/x86/kernel/tsc_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 2a855991f982..1fc751212a0e 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -405,7 +405,7 @@ void check_tsc_sync_source(int cpu)
 		pr_debug("TSC synchronization [CPU#%d -> CPU#%d]: passed\n",
 			smp_processor_id(), cpu);
 
-	} else if (atomic_dec_and_test(&test_runs) || random_warps) {
+	} else if (atomic_dec_and_test(&test_runs) || (random_warps && !tsc_allow_direct_sync)) {
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
 
-- 
2.30.2

