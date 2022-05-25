Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2B534125
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbiEYQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiEYQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:12:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42361B41EE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:12:43 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB1491EC059D;
        Wed, 25 May 2022 18:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653495161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMu/m7XioOOCsVwbHfYOStEmXft/WwJngRwU6UZOBwU=;
        b=H/ZEiygX0m7TsVBLCZ2GVbEfTr/26p2yRmNnsobds2wtmDE60QLj1irBOtceCsqJefCb8u
        4i/q8RhkKR1iQXsvbaZgZhbme6bGjS1z9CZq1hmLqfBGvOs/V3Wto4lXZwnvrpe1dQrZo0
        ssZ7JFJZ6Y8GlVYQvnAzFdJQ9Hc0CuA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/4] x86/microcode: Default-disable late loading
Date:   Wed, 25 May 2022 18:12:30 +0200
Message-Id: <20220525161232.14924-3-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525161232.14924-1-bp@alien8.de>
References: <20220525161232.14924-1-bp@alien8.de>
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

From: Borislav Petkov <bp@suse.de>

It is dangerous and it should not be used anyway - there's a nice early
loading already.

Requested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig                     | 11 +++++++++++
 arch/x86/kernel/cpu/common.c         |  2 ++
 arch/x86/kernel/cpu/microcode/core.c |  7 ++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1c0da2dbfb26..33891b82fb65 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1345,6 +1345,17 @@ config MICROCODE_AMD
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
 
+config MICROCODE_LATE_LOADING
+	bool "Late microcode loading (DANGEROUS)"
+	default n
+	depends on MICROCODE
+	help
+	  Loading microcode late, when the system is up and executing instructions
+	  is a tricky business and should be avoided if possible. Just the sequence
+	  of synchronizing all cores and SMT threads is one fragile dance which does
+	  not guarantee that cores might not softlock after the loading. Therefore,
+	  use this at your own risk. Late loading taints the kernel too.
+
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e9142797c99..c296cb1c0113 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2222,6 +2222,7 @@ void cpu_init_secondary(void)
 }
 #endif
 
+#ifdef CONFIG_MICROCODE_LATE_LOADING
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
@@ -2251,6 +2252,7 @@ void microcode_check(void)
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
+#endif
 
 /*
  * Invoked from core CPU hotplug code after hotplug operations
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b72c4134f289..c717db6b6856 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -376,6 +376,7 @@ static int apply_microcode_on_target(int cpu)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
+#ifdef CONFIG_MICROCODE_LATE_LOADING
 /*
  * Late loading dance. Why the heavy-handed stomp_machine effort?
  *
@@ -543,6 +544,9 @@ static ssize_t reload_store(struct device *dev,
 	return ret;
 }
 
+static DEVICE_ATTR_WO(reload);
+#endif
+
 static ssize_t version_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -559,7 +563,6 @@ static ssize_t pf_show(struct device *dev,
 	return sprintf(buf, "0x%x\n", uci->cpu_sig.pf);
 }
 
-static DEVICE_ATTR_WO(reload);
 static DEVICE_ATTR(version, 0444, version_show, NULL);
 static DEVICE_ATTR(processor_flags, 0444, pf_show, NULL);
 
@@ -712,7 +715,9 @@ static int mc_cpu_down_prep(unsigned int cpu)
 }
 
 static struct attribute *cpu_root_microcode_attrs[] = {
+#ifdef CONFIG_MICROCODE_LATE_LOADING
 	&dev_attr_reload.attr,
+#endif
 	NULL
 };
 
-- 
2.35.1

