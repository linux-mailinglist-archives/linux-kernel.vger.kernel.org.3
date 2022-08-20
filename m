Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA059ACE8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiHTJ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbiHTJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:25:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FEF5C343
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 02:25:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 69FA11FDBD;
        Sat, 20 Aug 2022 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660987538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9u1SaUR5yI9p8R8N8ofvxILRs1M2hzJI4h2vyFfrA8=;
        b=gGTAo9BwxgqV8mrviLJWJvW+8Y9yx32TtlD70JNrIT2jvHqRZDQDlM+aSwXvJbTerU0s+A
        LRBiVpAJbg3pfdvDw8VDueKkXg1R/+nOtwtHgx4IQL1C1EqOfYPPw601t5zpbD+YWObL9i
        +Jkc4nRJLm6Vrokm/eX/eVMvL59nknw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2816A13440;
        Sat, 20 Aug 2022 09:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MAGKCJKoAGPJMAAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 20 Aug 2022 09:25:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 05/10] x86/mtrr: split generic_set_all()
Date:   Sat, 20 Aug 2022 11:25:28 +0200
Message-Id: <20220820092533.29420-6-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220820092533.29420-1-jgross@suse.com>
References: <20220820092533.29420-1-jgross@suse.com>
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

Split generic_set_all() into multiple parts, while moving the main
function body into cacheinfo.c.

This prepares the support of PAT without needing MTRR support by
moving the main function body of generic_set_all() into cacheinfo.c
while renaming it to cache_cpu_init(). The MTRR specific parts are
moved into a dedicated small function called by cache_cpu_init().
The PAT and MTRR specific functions are called conditionally based
on the cache_generic bit settings.

The setting of smp_changes_mask is merged into the (new) function
mtrr_generic_set_state() used to call set_mtrr_state(). It was
probably split in ancient times, as atomic operations while running
uncached might be quite expensive, but OTOH only systems with a
broken BIOS should ever require to set any bit in smp_changes_mask,
so just hurting those devices with a penalty of a few microseconds
during boot shouldn't be a real issue.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/cacheinfo.h   |  1 +
 arch/x86/include/asm/mtrr.h        |  2 ++
 arch/x86/kernel/cpu/cacheinfo.c    | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/mtrr/generic.c | 15 ++-------------
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 313a6920d0f9..563d9cb5fcf5 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -12,5 +12,6 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 void cache_disable(void);
 void cache_enable(void);
+void cache_cpu_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 12a16caed395..986249a2b9b6 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -50,6 +50,7 @@ extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 void mtrr_disable(void);
 void mtrr_enable(void);
+void mtrr_generic_set_state(void);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -91,6 +92,7 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
+#define mtrr_generic_set_state() do {} while (0)
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 47e2c72fa8a4..36378604ec61 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1120,3 +1120,22 @@ void cache_enable(void) __releases(cache_disable_lock)
 
 	raw_spin_unlock(&cache_disable_lock);
 }
+
+void cache_cpu_init(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cache_disable();
+
+	/* Set MTRR state. */
+	if (cache_generic & CACHE_GENERIC_MTRR)
+		mtrr_generic_set_state();
+
+	/* Set PAT. */
+	if (cache_generic & CACHE_GENERIC_PAT)
+		pat_init();
+
+	cache_enable();
+	local_irq_restore(flags);
+}
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index a9ac159b1566..0be6d43ec1fe 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -736,30 +736,19 @@ void mtrr_enable(void)
 	mtrr_wrmsr(MSR_MTRRdefType, *lo, *hi);
 }
 
-static void generic_set_all(void)
+void mtrr_generic_set_state(void)
 {
 	unsigned long mask, count;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cache_disable();
 
 	/* Actually set the state */
 	mask = set_mtrr_state();
 
-	/* also set PAT */
-	pat_init();
-
-	cache_enable();
-	local_irq_restore(flags);
-
 	/* Use the atomic bitops to update the global mask */
 	for (count = 0; count < sizeof(mask) * 8; ++count) {
 		if (mask & 0x01)
 			set_bit(count, &smp_changes_mask);
 		mask >>= 1;
 	}
-
 }
 
 /**
@@ -859,7 +848,7 @@ int positive_have_wrcomb(void)
  * Generic structure...
  */
 const struct mtrr_ops generic_mtrr_ops = {
-	.set_all		= generic_set_all,
+	.set_all		= cache_cpu_init,
 	.get			= generic_get_mtrr,
 	.get_free_region	= generic_get_free_region,
 	.set			= generic_set_mtrr,
-- 
2.35.3

