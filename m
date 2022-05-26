Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E1534EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiEZMLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEZMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:11:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C196B041E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:11:22 -0700 (PDT)
Received: from zn.tnic (p200300ea97465770329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5770:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55C0E1EC0674;
        Thu, 26 May 2022 14:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653567076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DGvaOf7ZWqer9H9Hno7O0dvqYa1/DdSJY3Hb3UVv22g=;
        b=OE5HW6xw+ZKAwByyyXDCJNdaLZBMtVXt0ZC9cxsbAiB7ChhQrTifBH5CQ0n7itXcBr2/Gs
        HBdc4gsMRt3J+EDZrKu3rKhOUZTuiUaAx5xKHJjZBAWhurdx1tTgtX6yDiVW0CiO23ypr6
        sZ9C3WMkmetxjGmhRc/opLYP+RQ/SJU=
Date:   Thu, 26 May 2022 14:11:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Taint addresses
Message-ID: <Yo9uYL9eL9KBuzam@zn.tnic>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic>
 <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
 <Yo5LAenZIsYmM9Ie@zn.tnic>
 <c40151ec88db4b7aa7dcadf6428b019e@intel.com>
 <Yo5SupgZjT/a1p5m@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo5SupgZjT/a1p5m@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess something like this:

...
[    2.591532] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.592678] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S       C        5.18.0+ #7
[    2.593079] Last taint addresses:
[    2.593079]  S:start_kernel+0x614/0x634
[    2.593079]  C:kernel_init+0x70/0x140
[    2.593079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    2.593079] Call Trace:
[    2.593079]  <TASK>
[    2.593079]  dump_stack_lvl+0x38/0x49
[    2.593079]  ? rest_init+0xd0/0xd0
[    2.593079]  kernel_init+0x75/0x140
[    2.593079]  ret_from_fork+0x22/0x30
[    2.593079]  </TASK>
---

I probably should put the taint addresses after the stack trace but
other than that, it gives you where the taint was added last.

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..7e3aeddece5f 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -94,5 +94,6 @@ extern const char *print_tainted(void);
 extern void add_taint(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
+void print_tainted_addresses(const char *log_lvl);
 
 #endif	/* _LINUX_PANIC_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index eb4dfb932c85..78b541c8da99 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -49,6 +49,7 @@ unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+static unsigned long taint_addrs[TAINT_FLAGS_COUNT];
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -437,6 +438,23 @@ const char *print_tainted(void)
 	return buf;
 }
 
+void print_tainted_addresses(const char *log_lvl)
+{
+	int i;
+
+	if (!tainted_mask)
+		return;
+
+	printk("%sLast taint addresses:\n", log_lvl);
+
+	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
+		const struct taint_flag *t = &taint_flags[i];
+
+			if (test_bit(i, &tainted_mask))
+				printk("%s %c:%pS\n", log_lvl, t->c_true, (void *)taint_addrs[i]);
+	}
+}
+
 int test_taint(unsigned flag)
 {
 	return test_bit(flag, &tainted_mask);
@@ -461,7 +479,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 	if (lockdep_ok == LOCKDEP_NOW_UNRELIABLE && __debug_locks_off())
 		pr_warn("Disabling lock debugging due to kernel taint\n");
 
+	if (WARN_ON_ONCE(flag >= TAINT_FLAGS_COUNT))
+		return;
+
 	set_bit(flag, &tainted_mask);
+	taint_addrs[flag] = _RET_IP_;
 
 	if (tainted_mask & panic_on_taint) {
 		panic_on_taint = 0;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6b7f1bf6715d..595fa8757916 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -62,6 +62,8 @@ void dump_stack_print_info(const char *log_lvl)
 	       (int)strcspn(init_utsname()->version, " "),
 	       init_utsname()->version, BUILD_ID_VAL);
 
+	print_tainted_addresses(log_lvl);
+
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
 		       log_lvl, dump_stack_arch_desc_str);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
