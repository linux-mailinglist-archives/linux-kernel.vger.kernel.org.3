Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D463C50E975
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244935AbiDYT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbiDYT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:28:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899B93B02D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:25:49 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AA601EC01D2;
        Mon, 25 Apr 2022 21:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650914743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QPEuQqkgCOC/ZfNzoTcbxZdTZ9VhVIYzFHCDezKueJo=;
        b=jkxiCEJ4TrV9QfUsCetq4k1NKiyAaw+IOlhYDuA6Fuk7ygnBCageHrC4tHZHuVL/KQobYi
        H7fJLo8Pjn0/j4KrGRREmk28ptix2XCtHq9+8AD5WuJL4tjFZ7U0qCzHt/zo8WlyR6pRqG
        EfP9B6EouiGqiChzVEfPwuiE1sZuMLY=
Date:   Mon, 25 Apr 2022 21:25:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Message-ID: <Ymb1tBJsch/TB2ph@zn.tnic>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
 <Yl6PueNCZZeobMWr@zn.tnic>
 <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:58:47PM -0500, Eric DeVolder wrote:
> So in taking this concept and looking at, in particular, patch 4/8
> "crash: add generic infrastructure for crash hotplug support", I'm not
> exactly sure how to apply this technique.

So I took your patch 4 and maimed into what I think it should look like,
see below.

Now there's a single ifdef there and the registration routines are
wrapped in IS_ENABLED() so that you register a callback only when the
respective stuff - HOTPLUG_CPU or MEMORY_HOTPLUG - is enabled. Otherwise
the couple of functions are unused but that's not that big of a deal.

I've also fixed up some other issues I've encountered along the way.

Holler if there are questions.

HTH.

---
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..b3c32e04d3f0 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU	0
+#define KEXEC_CRASH_HP_ADD_CPU		1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
+#define KEXEC_CRASH_HP_ADD_MEMORY	3
+
+struct kimage;
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
+				     unsigned int cpu);
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 02daff1f47dd..d907a1f0d3da 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -307,13 +307,11 @@ struct kimage {
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
 
-#ifdef CONFIG_CRASH_HOTPLUG
 	bool hotplug_event;
 	unsigned int offlinecpu;
 	bool elfcorehdr_index_valid;
 	int elfcorehdr_index;
 #endif
-#endif
 
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
@@ -329,15 +327,6 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
-#ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_hotplug_handler(struct kimage *image,
-	unsigned int hp_action, unsigned int cpu);
-#define KEXEC_CRASH_HP_REMOVE_CPU   0
-#define KEXEC_CRASH_HP_ADD_CPU      1
-#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
-#define KEXEC_CRASH_HP_ADD_MEMORY   3
-#endif /* CONFIG_CRASH_HOTPLUG */
-
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ecf746243ab2..a6c4ee1d5c86 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -497,57 +497,50 @@ static int __init crash_save_vmcoreinfo_init(void)
 
 subsys_initcall(crash_save_vmcoreinfo_init);
 
-#ifdef CONFIG_CRASH_HOTPLUG
-void __weak arch_crash_hotplug_handler(struct kimage *image,
-	unsigned int hp_action, unsigned int cpu)
+void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
+					    unsigned int cpu)
 {
-	pr_warn("crash hp: %s not implemented", __func__);
+	WARN(1, "crash hotplug handler not implemented");
 }
 
-static void crash_hotplug_handler(unsigned int hp_action,
-	unsigned int cpu)
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
-	/* Obtain lock while changing crash information */
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_crash_image)
 		return;
 
-	/* Check kdump is loaded */
-	if (kexec_crash_image) {
-		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
+	mutex_lock(&kexec_mutex);
 
-		/* Needed in order for the segments to be updated */
-		arch_kexec_unprotect_crashkres();
+	pr_debug("crash hotplug: hp_action %u, cpu %u", hp_action, cpu);
 
-		/* Flag to differentiate between normal load and hotplug */
-		kexec_crash_image->hotplug_event = true;
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
 
-		/* Now invoke arch-specific update handler */
-		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
+	/* Flag to differentiate between normal load and hotplug */
+	kexec_crash_image->hotplug_event = true;
 
-		/* No longer handling a hotplug event */
-		kexec_crash_image->hotplug_event = false;
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
 
-		/* Change back to read-only */
-		arch_kexec_protect_crashkres();
-	}
+	/* No longer handling a hotplug event */
+	kexec_crash_image->hotplug_event = false;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
 
 	/* Release lock now that update complete */
 	mutex_unlock(&kexec_mutex);
 }
 
-#if defined(CONFIG_MEMORY_HOTPLUG)
-static int crash_memhp_notifier(struct notifier_block *nb,
-	unsigned long val, void *v)
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
 {
-	struct memory_notify *mhp = v;
-
 	switch (val) {
 	case MEM_ONLINE:
-		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
 		break;
 
 	case MEM_OFFLINE:
-		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY, -1U);
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, -1U);
 		break;
 	}
 	return NOTIFY_OK;
@@ -557,38 +550,33 @@ static struct notifier_block crash_memhp_nb = {
 	.notifier_call = crash_memhp_notifier,
 	.priority = 0
 };
-#endif
 
-#if defined(CONFIG_HOTPLUG_CPU)
 static int crash_cpuhp_online(unsigned int cpu)
 {
-	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
 	return 0;
 }
 
 static int crash_cpuhp_offline(unsigned int cpu)
 {
-	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
 	return 0;
 }
-#endif
 
 static int __init crash_hotplug_init(void)
 {
 	int result = 0;
 
-#if defined(CONFIG_MEMORY_HOTPLUG)
-	register_memory_notifier(&crash_memhp_nb);
-#endif
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
 
-#if defined(CONFIG_HOTPLUG_CPU)
-	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-				"crash/cpuhp",
-				crash_cpuhp_online, crash_cpuhp_offline);
-#endif
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						   "crash/cpuhp",
+						   crash_cpuhp_online,
+						   crash_cpuhp_offline);
 
 	return result;
 }
-
 subsys_initcall(crash_hotplug_init);
-#endif /* CONFIG_CRASH_HOTPLUG */
+#endif

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
