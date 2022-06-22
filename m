Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6304554DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358606AbiFVOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357373AbiFVOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D37A23BFBD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655909342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hYutT6A0gBfkQr0X8J4zcR1vTCradKixIqqKEZ5f2E=;
        b=eXH410oNN3Q6SkW/lct7Ov3WSxDQU5o4IRYaIUflUrmUi7olPSDv9u/5yWqaVN+DVms/W7
        tDfbZjaHoEyKOgR0DhdYy1WmmTV2hNB8ZXM9Q9KI66/cvz6rjujyz9c6yYxhsIrBBCvoj3
        zYbjJ8eba7yZj+8mLVTvizRjshoeoCk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-iwwwGXe1MYCm2IvYuoTHzg-1; Wed, 22 Jun 2022 10:48:58 -0400
X-MC-Unique: iwwwGXe1MYCm2IvYuoTHzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B87E328049E5;
        Wed, 22 Jun 2022 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99A0E40C1421;
        Wed, 22 Jun 2022 14:48:45 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Jane Malalane <jane.malalane@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/4] x86/cpuid: check for dependencies violations in CPUID and attempt to fix them
Date:   Wed, 22 Jun 2022 17:48:20 +0300
Message-Id: <20220622144820.751402-5-mlevitsk@redhat.com>
In-Reply-To: <20220622144820.751402-1-mlevitsk@redhat.com>
References: <20220622144820.751402-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to configuration bugs, sometimes a CPU feature is disabled in CPUID,
but not features that depend on it.

While the above is not supported, the kernel should try to not crash,
and clearing the dependent cpu caps is the best way to do it.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kernel/cpu/common.c     |  4 ++--
 arch/x86/kernel/cpu/cpuid-deps.c | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4cc79971d2d847..c83a8f447d6aed 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1469,7 +1469,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 			this_cpu->c_early_init(c);
 
 		c->cpu_index = 0;
-		filter_cpuid_features(c, false);
+		filter_cpuid_features(c, true);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1757,7 +1757,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	 */
 
 	/* Filter out anything that depends on CPUID levels we don't have */
-	filter_cpuid_features(c, true);
+	filter_cpuid_features(c, false);
 
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index bcb091d02a754b..6d9c0e39851805 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -94,6 +94,11 @@ static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
 		set_bit(feature, (unsigned long *)cpu_caps_cleared);
 }
 
+static inline bool test_feature(struct cpuinfo_x86 *c, unsigned int feature)
+{
+	return test_bit(feature, (unsigned long *)c->x86_capability);
+}
+
 /* Take the capabilities and the BUG bits into account */
 #define MAX_FEATURE_BITS ((NCAPINTS + NBUGINTS) * sizeof(u32) * 8)
 
@@ -127,6 +132,7 @@ void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 	} while (changed);
 }
 
+
 void setup_clear_cpu_cap(unsigned int feature)
 {
 	clear_cpu_cap(&boot_cpu_data, feature);
@@ -137,6 +143,10 @@ void setup_clear_cpu_cap(unsigned int feature)
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
  * software.  Add those features to this table to auto-disable them.
+ *
+ * Also due to configuration bugs, some CPUID features might be present
+ * while CPUID features that they depend on are not present,
+ * e.g a AVX2 present but AVX is not present.
  */
 struct cpuid_dependent_feature {
 	u32 feature;
@@ -151,9 +161,10 @@ cpuid_dependent_features[] = {
 	{ 0, 0 }
 };
 
-void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
+void filter_cpuid_features(struct cpuinfo_x86 *c, bool early)
 {
 	const struct cpuid_dependent_feature *df;
+	const struct cpuid_dep *d;
 
 	for (df = cpuid_dependent_features; df->feature; df++) {
 
@@ -172,10 +183,22 @@ void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
 			continue;
 
 		clear_cpu_cap(c, df->feature);
-		if (!warn)
+		if (early)
 			continue;
 
 		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
 			x86_cap_flag(df->feature), df->level);
 	}
+
+	for (d = cpuid_deps; d->feature; d++) {
+
+		if (!test_feature(c, d->feature) || test_feature(c, d->depends))
+			continue;
+
+		clear_feature(c, d->feature);
+
+		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, because it depends on "
+			X86_CAP_FMT " which is not supported in CPUID\n",
+			x86_cap_flag(d->feature), x86_cap_flag(d->depends));
+	}
 }
-- 
2.26.3

