Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD14F917F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiDHJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiDHJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C587100764;
        Fri,  8 Apr 2022 02:08:45 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCo7CpYdO08GaahQt+H4dK5eLkrrUSaNyjBnuvdVLI8=;
        b=ugfoz7M3p4i+IBuQCrhqlG9UWFU5GWxkxGsZ8lpl9emULRKqeu0IVS6+WtFtTcN3nQe8ze
        pD7A6YqeJmC4TxXH0+UzX6rwynzt57tsf0tRbRG8y/eLR1Jj7mcK/MAqn8JNc9I8s9zW1M
        e5QIOylZsE+XAo/v8+z3m61IV5VcXeYr5pVaurtXSvNtcTsCI3rsCYxZRuAMshpOeYFN9W
        mKAUCuqsZD/o8hBB8YezqFt3IeD1rugxJ0oUj5JnTchNxvvdM0jk6Qrx/jOO9uO+iUXr0W
        wCTroqVe3dAjKd44Uk7BbEFoIQ/LrFL6Gd1mCdoPcWQKHsfv3rC72rg7s1pxZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCo7CpYdO08GaahQt+H4dK5eLkrrUSaNyjBnuvdVLI8=;
        b=55x8jqQDOD69YycxMW+UFpRWej8elnrtv+UJ6GiYRc6/fmLcRxaaSUPwCW7L4jidF2P4nq
        eYUHar+70JDG7pCg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add a sev= cmdline option
Cc:     Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-41-brijesh.singh@amd.com>
References: <20220307213356.2797205-41-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892265.389.9709721824909968252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ba37a1438aeb540cc48722d629f4b2e7e4398466
Gitweb:        https://git.kernel.org/tip/ba37a1438aeb540cc48722d629f4b2e7e4398466
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Mon, 07 Mar 2022 15:33:50 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:12 +02:00

x86/sev: Add a sev= cmdline option

For debugging purposes it is very useful to have a way to see the full
contents of the SNP CPUID table provided to a guest. Add an sev=debug
kernel command-line option to do so.

Also introduce some infrastructure so that additional options can be
specified via sev=option1[,option2] over time in a consistent manner.

  [ bp: Massage, simplify string parsing. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-41-brijesh.singh@amd.com
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 Documentation/x86/x86_64/boot-options.rst       | 14 +++++-
 arch/x86/kernel/sev.c                           | 44 ++++++++++++++++-
 3 files changed, 60 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e..48ad2ec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5308,6 +5308,8 @@
 
 	serialnumber	[BUGS=X86-32]
 
+	sev=option[,option...] [X86-64] See Documentation/x86/x86_64/boot-options.rst
+
 	shapers=	[NET]
 			Maximal number of shapers.
 
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 07aa000..4efb1fa 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -310,3 +310,17 @@ Miscellaneous
     Do not use GB pages for kernel direct mappings.
   gbpages
     Use GB pages for kernel direct mappings.
+
+
+AMD SEV (Secure Encrypted Virtualization)
+=========================================
+Options relating to AMD SEV, specified via the following format:
+
+::
+
+   sev=option1[,option2]
+
+The available options are:
+
+   debug
+     Enable debug messages.
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c873372..70ecc6e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -112,6 +112,13 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
+struct sev_config {
+	__u64 debug		: 1,
+	      __reserved	: 63;
+};
+
+static struct sev_config sev_cfg __read_mostly;
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -2042,6 +2049,23 @@ void __init snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+static void dump_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i = 0;
+
+	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
+		cpuid_table->count, cpuid_table->__reserved1, cpuid_table->__reserved2);
+
+	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		pr_info("index=%3d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
+			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
+			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
+	}
+}
+
 /*
  * It is useful from an auditing/testing perspective to provide an easy way
  * for the guest owner to know that the CPUID table has been initialized as
@@ -2059,6 +2083,26 @@ static int __init report_cpuid_table(void)
 	pr_info("Using SNP CPUID table, %d entries present.\n",
 		cpuid_table->count);
 
+	if (sev_cfg.debug)
+		dump_cpuid_table();
+
 	return 0;
 }
 arch_initcall(report_cpuid_table);
+
+static int __init init_sev_config(char *str)
+{
+	char *s;
+
+	while ((s = strsep(&str, ","))) {
+		if (!strcmp(s, "debug")) {
+			sev_cfg.debug = true;
+			continue;
+		}
+
+		pr_info("SEV command-line option '%s' was not recognized\n", s);
+	}
+
+	return 1;
+}
+__setup("sev=", init_sev_config);
