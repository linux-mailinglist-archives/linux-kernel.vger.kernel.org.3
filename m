Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B435330B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiEXSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiEXSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:53:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B42D5798A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:53:33 -0700 (PDT)
Received: from zn.tnic (p200300ea974657c6329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57c6:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F3A81EC0575;
        Tue, 24 May 2022 20:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653418411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+TdOuNjF7WGNyon6haxmg5aXIog4wU2LGWC4mw0n8U=;
        b=gOdg2FDcA1ocYGErgKcsb+hsuHS2UtGzvtyGVK9Kp5GhfbTFRStKRzfxxnffjz6/bhkfyp
        ThxCwOVpeSLO/bbpKclVZz7TDHGFNYK23DKprRFHT4PsrElbE64/naSN6hL298l6IXx8m6
        Xq74X3wm+b6Wgltz+8Z+U1MTwe8JrAM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/3] x86/microcode: Rip out the OLD_INTERFACE
Date:   Tue, 24 May 2022 20:53:22 +0200
Message-Id: <20220524185324.28395-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524185324.28395-1-bp@alien8.de>
References: <20220524185324.28395-1-bp@alien8.de>
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

Everything should be using the early initrd loading by now.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig                     |  12 ----
 arch/x86/kernel/cpu/microcode/core.c | 100 ---------------------------
 2 files changed, 112 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e8f6fd28e59..1c0da2dbfb26 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1345,18 +1345,6 @@ config MICROCODE_AMD
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
 
-config MICROCODE_OLD_INTERFACE
-	bool "Ancient loading interface (DEPRECATED)"
-	default n
-	depends on MICROCODE
-	help
-	  DO NOT USE THIS! This is the ancient /dev/cpu/microcode interface
-	  which was used by userspace tools like iucode_tool and microcode.ctl.
-	  It is inadequate because it runs too late to be able to properly
-	  load microcode on a machine and it needs special tools. Instead, you
-	  should've switched to the early loading method with the initrd or
-	  builtin microcode by now: Documentation/x86/microcode.rst
-
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 239ff5fcec6a..b72c4134f289 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -373,98 +373,6 @@ static int apply_microcode_on_target(int cpu)
 	return ret;
 }
 
-#ifdef CONFIG_MICROCODE_OLD_INTERFACE
-static int do_microcode_update(const void __user *buf, size_t size)
-{
-	int error = 0;
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-		enum ucode_state ustate;
-
-		if (!uci->valid)
-			continue;
-
-		ustate = microcode_ops->request_microcode_user(cpu, buf, size);
-		if (ustate == UCODE_ERROR) {
-			error = -1;
-			break;
-		} else if (ustate == UCODE_NEW) {
-			apply_microcode_on_target(cpu);
-		}
-	}
-
-	return error;
-}
-
-static int microcode_open(struct inode *inode, struct file *file)
-{
-	return capable(CAP_SYS_RAWIO) ? stream_open(inode, file) : -EPERM;
-}
-
-static ssize_t microcode_write(struct file *file, const char __user *buf,
-			       size_t len, loff_t *ppos)
-{
-	ssize_t ret = -EINVAL;
-	unsigned long nr_pages = totalram_pages();
-
-	if ((len >> PAGE_SHIFT) > nr_pages) {
-		pr_err("too much data (max %ld pages)\n", nr_pages);
-		return ret;
-	}
-
-	cpus_read_lock();
-	mutex_lock(&microcode_mutex);
-
-	if (do_microcode_update(buf, len) == 0)
-		ret = (ssize_t)len;
-
-	if (ret > 0)
-		perf_check_microcode();
-
-	mutex_unlock(&microcode_mutex);
-	cpus_read_unlock();
-
-	return ret;
-}
-
-static const struct file_operations microcode_fops = {
-	.owner			= THIS_MODULE,
-	.write			= microcode_write,
-	.open			= microcode_open,
-	.llseek		= no_llseek,
-};
-
-static struct miscdevice microcode_dev = {
-	.minor			= MICROCODE_MINOR,
-	.name			= "microcode",
-	.nodename		= "cpu/microcode",
-	.fops			= &microcode_fops,
-};
-
-static int __init microcode_dev_init(void)
-{
-	int error;
-
-	error = misc_register(&microcode_dev);
-	if (error) {
-		pr_err("can't misc_register on minor=%d\n", MICROCODE_MINOR);
-		return error;
-	}
-
-	return 0;
-}
-
-static void __exit microcode_dev_exit(void)
-{
-	misc_deregister(&microcode_dev);
-}
-#else
-#define microcode_dev_init()	0
-#define microcode_dev_exit()	do { } while (0)
-#endif
-
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
@@ -856,10 +764,6 @@ static int __init microcode_init(void)
 		goto out_driver;
 	}
 
-	error = microcode_dev_init();
-	if (error)
-		goto out_ucode_group;
-
 	register_syscore_ops(&mc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
 				  mc_cpu_starting, NULL);
@@ -870,10 +774,6 @@ static int __init microcode_init(void)
 
 	return 0;
 
- out_ucode_group:
-	sysfs_remove_group(&cpu_subsys.dev_root->kobj,
-			   &cpu_root_microcode_group);
-
  out_driver:
 	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
-- 
2.35.1

