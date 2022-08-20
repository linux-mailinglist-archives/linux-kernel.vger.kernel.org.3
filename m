Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8694559ACEC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbiHTJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiHTJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:25:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A215B040
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 02:25:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4EEFC1FF2C;
        Sat, 20 Aug 2022 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660987539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+9qSe12eN9aldkpJUagir7LS9P8+Ie9bYA0m7OCmgU=;
        b=jwQV9DUHU1m/w4KwDZAHaiEgHp1+vBu8JBDI1SuKu/yWHL8/ABmTvpPvgpWrYOuArNxHcA
        6u/QFmufL8ScBAHFisN+w6l5yU12CyLZAMh/A+rxn6+kt31lLZHX1UQhA3ImTT+cIu95tf
        VJgKfXxWw3RWqW6W5SSwEXsd1mu8Ztg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B50113440;
        Sat, 20 Aug 2022 09:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mJiRAZOoAGPJMAAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 20 Aug 2022 09:25:39 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 08/10] x86/mtrr: let cache_aps_delayed_init replace mtrr_aps_delayed_init
Date:   Sat, 20 Aug 2022 11:25:31 +0200
Message-Id: <20220820092533.29420-9-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220820092533.29420-1-jgross@suse.com>
References: <20220820092533.29420-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare decoupling MTRR and PAT replace the MTRR specific
mtrr_aps_delayed_init flag with a more generic cache_aps_delayed_init
one.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/cacheinfo.h |  2 ++
 arch/x86/include/asm/mtrr.h      |  2 --
 arch/x86/kernel/cpu/cacheinfo.c  |  2 ++
 arch/x86/kernel/cpu/mtrr/mtrr.c  | 17 ++++-------------
 arch/x86/kernel/smpboot.c        |  5 +++--
 5 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 563d9cb5fcf5..e80ed3c523c8 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -7,6 +7,8 @@ extern unsigned int cache_generic;
 #define CACHE_GENERIC_MTRR 0x01
 #define CACHE_GENERIC_PAT  0x02
 
+extern bool cache_aps_delayed_init;
+
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 986249a2b9b6..5d31219c8529 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -43,7 +43,6 @@ extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_ap_init(void);
-extern void set_mtrr_aps_delayed_init(void);
 extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
@@ -87,7 +86,6 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
 #define mtrr_ap_init() do {} while (0)
-#define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 36378604ec61..c6e7c93e45e8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1139,3 +1139,5 @@ void cache_cpu_init(void)
 	cache_enable();
 	local_irq_restore(flags);
 }
+
+bool cache_aps_delayed_init;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index ca348dcc5bf8..b68ec43e33a2 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -65,7 +65,6 @@ unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
 u64 size_or_mask, size_and_mask;
-static bool mtrr_aps_delayed_init;
 
 static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
@@ -172,7 +171,7 @@ static int mtrr_rendezvous_handler(void *info)
 	if (data->smp_reg != ~0U) {
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
-	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
+	} else if (cache_aps_delayed_init || !cpu_online(smp_processor_id())) {
 		cache_cpu_init();
 	}
 	return 0;
@@ -784,7 +783,7 @@ void __init mtrr_bp_init(void)
 
 void mtrr_ap_init(void)
 {
-	if (!cache_generic || mtrr_aps_delayed_init)
+	if (!cache_generic || cache_aps_delayed_init)
 		return;
 
 	/*
@@ -818,14 +817,6 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-void set_mtrr_aps_delayed_init(void)
-{
-	if (!cache_generic)
-		return;
-
-	mtrr_aps_delayed_init = true;
-}
-
 /*
  * Delayed MTRR initialization for all AP's
  */
@@ -839,11 +830,11 @@ void mtrr_aps_init(void)
 	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
 	 * then we are done.
 	 */
-	if (!mtrr_aps_delayed_init)
+	if (!cache_aps_delayed_init)
 		return;
 
 	set_mtrr(~0U, 0, 0, 0);
-	mtrr_aps_delayed_init = false;
+	cache_aps_delayed_init = false;
 }
 
 void mtrr_bp_restore(void)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f24227bc3220..ef7bce21cbe8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -58,6 +58,7 @@
 #include <linux/overflow.h>
 
 #include <asm/acpi.h>
+#include <asm/cacheinfo.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
@@ -1428,7 +1429,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_mtrr_aps_delayed_init();
+	cache_aps_delayed_init = true;
 
 	smp_quirk_init_udelay();
 
@@ -1439,7 +1440,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_thaw_secondary_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
+	cache_aps_delayed_init = true;
 }
 
 void arch_thaw_secondary_cpus_end(void)
-- 
2.35.3

