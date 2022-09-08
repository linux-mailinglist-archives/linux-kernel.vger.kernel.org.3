Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB565B17AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiIHIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIHIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:50:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70221357D6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:49:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B74D1F6E6;
        Thu,  8 Sep 2022 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662626998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vyv3zMH0pPEDEqZnbB8cB4qvjHdxz6bU2S4iMof2iU=;
        b=SEYuyVYAiGYA9+UltCd0MYfXzFBYTsvw9Bi5LUrNSO2FubjQW9gviWFEZqUpGUzGRpU4+R
        7WD268pd50zpFeZdEAHIjbwHnPHawqapCJpOg1++jiCAIVqSt2qpJsGlb1W+zDDpzxeKr9
        pHOjHz1csrLZhBP7zwgR6hjoyQmA6cA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E54EB1322C;
        Thu,  8 Sep 2022 08:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LLrONrWsGWOsNgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 08 Sep 2022 08:49:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 07/10] x86/mtrr: simplify mtrr_bp_init()
Date:   Thu,  8 Sep 2022 10:49:11 +0200
Message-Id: <20220908084914.21703-8-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908084914.21703-1-jgross@suse.com>
References: <20220908084914.21703-1-jgross@suse.com>
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

In case of the generic cache interface being used (Intel CPUs or a
64-bit system), the initialization sequence of the boot CPU is more
complicated as necessary:

- check if MTRR enabled, if yes, call mtrr_bp_pat_init() which will
  disable caching, set the PAT MSR, and reenable caching

- call mtrr_cleanup(), in case that changed anything, call
  cache_cpu_init() doing the same caching disable/enable dance as
  above, but this time with setting the (modified) MTRR state (even
  if MTRR was disabled) AND setting the PAT MSR (again even with
  disabled MTRR)

The sequence can be simplified a lot while removing potential
inconsistencies:

- check if MTRR enabled, if yes, call mtrr_cleanup() and then
  cache_cpu_init()

This ensures to:

- no longer disable/enable caching more than once

- avoid to set MTRRs and/or the PAT MSR on the boot processor in case
  of MTRR cleanups even if MTRRs meant to be disabled

With that mtrr_bp_pat_init() can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/cpu/mtrr/generic.c | 14 --------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  7 ++-----
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  1 -
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 5f83ee865def..b15634e5ad44 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -442,20 +442,6 @@ static void __init print_mtrr_state(void)
 		pr_debug("TOM2: %016llx aka %lldM\n", mtrr_tom2, mtrr_tom2>>20);
 }
 
-/* PAT setup for BP. We need to go through sync steps here */
-void __init mtrr_bp_pat_init(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cache_disable();
-
-	pat_init();
-
-	cache_enable();
-	local_irq_restore(flags);
-}
-
 /* Grab all of the MTRR state for this CPU into *state */
 bool __init get_mtrr_state(void)
 {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 9609a0d235f8..956838bb4481 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -761,13 +761,10 @@ void __init mtrr_bp_init(void)
 			mtrr_enabled = get_mtrr_state();
 
 			if (mtrr_enabled) {
-				mtrr_bp_pat_init();
 				cache_generic |= CACHE_GENERIC_MTRR |
 						 CACHE_GENERIC_PAT;
-			}
-
-			if (mtrr_cleanup(phys_addr)) {
-				changed_by_mtrr_cleanup = 1;
+				changed_by_mtrr_cleanup =
+					mtrr_cleanup(phys_addr);
 				cache_cpu_init();
 			}
 		}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 3b1883185185..c98928ceee6a 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -50,7 +50,6 @@ void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
-void mtrr_bp_pat_init(void);
 
 extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
 
-- 
2.35.3

