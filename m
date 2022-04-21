Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27575095BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384075AbiDUET1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbiDUETU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:19:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE3FD31
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:16:30 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220421041625epoutp0265ac2fe0356acafea1d51617251ee5d9~nzkVnVuI52774427744epoutp02g
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:16:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220421041625epoutp0265ac2fe0356acafea1d51617251ee5d9~nzkVnVuI52774427744epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650514585;
        bh=Uhme5diI4XEjVU+7qvpXN7OUOzEchtuyK8DtVF5hywQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eh5i3snb77lslK1o0WNTQWRPtGAmu7h/CTU8gqhD9X9xB3iLXKFb+2Xrj45gi9xVf
         hvWV23zYYR8jPDxZLytumm5QAJpVov5vPO0J+2hUDCo4Yu1Exulz4/dx8xLrmSsO64
         qHSpDySKBbjLsf1QlmkPK1WwI5IPkzIhq4H0UPpY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220421041625epcas5p43f353e67d9e0e6a151c485ed6d5b054e~nzkVGuOQj0766607666epcas5p4l;
        Thu, 21 Apr 2022 04:16:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.C2.09952.99AD0626; Thu, 21 Apr 2022 13:16:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680~nzkB_kF2F0066000660epcas5p48;
        Thu, 21 Apr 2022 04:16:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220421041604epsmtrp279afb081ee7b7024bdd255f635e8562c~nzkB9GmeS0572705727epsmtrp28;
        Thu, 21 Apr 2022 04:16:04 +0000 (GMT)
X-AuditID: b6c32a4b-4b5ff700000226e0-eb-6260da99e803
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.C3.03370.48AD0626; Thu, 21 Apr 2022 13:16:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220421041601epsmtip12ab9193fefba212f272bbabd8c0cd14e~nzj-FNF4X0994209942epsmtip1H;
        Thu, 21 Apr 2022 04:16:01 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com
Cc:     v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.or,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, onkarnath.1@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Date:   Thu, 21 Apr 2022 09:45:42 +0530
Message-Id: <20220421041542.9195-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmpu7MWwlJBlt/81nMWb+GzaK3aTqT
        xZH5a1gtHhy8zm5xedccNouG2d9ZLR7PmsdmcXh+G4vFjQlPGS1mfgEqWdHzgdXi/+OvrBb7
        Oh4wWezeuIjN4vidp0wWh07OZbRo/Hyf0UHQY3bDRRaPnbPusnu07LsFJI68ZfX4cv08o8em
        VZ1sHidm/GbxmHcy0ONCV7bH+31X2Tz6tqxi9Fi/5SqLx+dNcgG8UVw2Kak5mWWpRfp2CVwZ
        NzfMYS1oTai42L6YvYFxt38XIyeHhICJRP+fuWxdjFwcQgK7GSWu/nvHDOF8YpQ4uO8jE4Tz
        mVGi6+IBdpiWC73/2CESuxglJs08DdX/hVFiwvGzrCBVbAJ6Eqt27WEBSYgIXGCUuHJrD9hg
        ZoE3jBJ3PzaCVQkLJEp8mf+YDcRmEVCVeL7nKAuIzStgLTFrYj8LxD55iZmXvrNDxAUlTs58
        AhZnBoo3b53NDFFzgkNi/28rCNtFonP2HSYIW1ji1fEtUHdLSXx+txdoFweQXS6xdUI9yD0S
        Ai2MEvvnTGGDqLGXeHJxIStIDbOApsT6XfoQYVmJqafWMUGs5ZPo/f0EajyvxI55MLaqRMvN
        DawQtrTE548foc73kGj68wisRkggVuLglPOMExjlZyH5ZhaSb2YhbF7AyLyKUTK1oDg3PbXY
        tMA4L7Vcrzgxt7g0L10vOT93EyM4GWp572B89OCD3iFGJg7GQ4wSHMxKIryhM+OThHhTEiur
        Uovy44tKc1KLDzFKc7AoifOeSt+QKCSQnliSmp2aWpBaBJNl4uCUamBS2LCx3miVmIfsIVbJ
        jX8uJe5frvaszyDSZLG9eaqk+PWVsZ5b7sqX3XFyWzHh75Ubm8N5vc31b82+ZODlHbBSi/vh
        JM4T5l8vpN8XvXst37Xji+atFV6KQtoXdC+sys85m69pmfIx4XPF9uOM/0I6e6+42a+oXMZ8
        1LXA3MtX4X2uJuuXBRFRPJKTFgs7+y1Y3uXBqamsvOphmfS5jEKLZEkpNQ7Znc1rny9/ffrf
        uuV7nm9Y8dKrqLcv2mFPhnQDe9BZcfV5G6Ue1IQvm5Ixy9/j9gL7R0lhx/L6WXYe6he0S50a
        967i85RJ0rXPlf4IfJD33H7p/bpJbO5H9KYdn2hbtvzp4+wLK0UdpxoosRRnJBpqMRcVJwIA
        V0CqjvUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTrflVkKSQfN6XYs569ewWfQ2TWey
        ODJ/DavFg4PX2S0u75rDZtEw+zurxeNZ89gsDs9vY7G4MeEpo8XML0AlK3o+sFr8f/yV1WJf
        xwMmi90bF7FZHL/zlMni0Mm5jBaNn+8zOgh6zG64yOKxc9Zddo+WfbeAxJG3rB5frp9n9Ni0
        qpPN48SM3ywe804GelzoyvZ4v+8qm0ffllWMHuu3XGXx+LxJLoA3issmJTUnsyy1SN8ugSvj
        5oY5rAWtCRUX2xezNzDu9u9i5OSQEDCRuND7jx3EFhLYwSjx+2gSRFxa4ue/9ywQtrDEyn/P
        gWq4gGo+MUrc7ZsJ1sAmoCexatceFpCEiMANRonFCzuZQRLMAt8YJfa054PYwgLxEvc+dYI1
        sAioSjzfcxRsKq+AtcSsif1QG+QlZl76zg4RF5Q4OfMJC8QceYnmrbOZJzDyzUKSmoUktYCR
        aRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnBcaWntYNyz6oPeIUYmDsZDjBIczEoi
        vKEz45OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYDoe
        tT/mtp61KWfGn38LFvfsap2nvJ1TsNzsuVuFg1z74uZTz5zur1jEvvNUa09f7RSvU9v4dxXt
        WPl106ujfiFv7Blj1udwHZk9Z9n+51VsB9RO579m9Nti+YZf5+9eodzHjOK+Bvb5nsnCj+UY
        Z0m3R6wXZjinX/JdLsP79JfWVW3flXOLvlb2dwXy3Not5/7kfF/QhoiIZIObwSt+nrh445Pv
        hvt1h6zZmSZxSsspV4TU+U38Jf7iy6aW2KN2DdOWOkas9DHvmNHhlR7avJjv4fcSw7mu9gsX
        BDaV79qxZuKS+6cyHN/4rHX9ZttUdnghm7//7CWNgVvbrNgUteZznBK4pX3IL7hpz4YWCSWW
        4oxEQy3mouJEAPi2BUIaAwAA
X-CMS-MailID: 20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680
References: <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print module information when KALLSYMS is disabled.

init_build_id() function is moved to module/main.c as it can be
independent of kallsyms.

No change for %pB, as it needs to know symbol name to adjust address
value which can't be done without KALLSYMS.

(A) original output with KALLSYMS:
[8.842129] ps function_1 [crash]
[8.842735] pS function_1+0x4/0x2c [crash]
[8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
[8.843175] pB function_1+0x4/0x2c [crash]
[8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]

(B) original output without KALLSYMS:
[12.487424] ps 0xffff800000eb008c
[12.487598] pS 0xffff800000eb008c
[12.487723] pSb 0xffff800000eb008c
[12.487850] pB 0xffff800000eb008c
[12.487967] pBb 0xffff800000eb008c

(C) With patched kernel
with KALLYSMS:
[41.974576] ps function_1 [crash]
[41.975173] pS function_1+0x4/0x2c [crash]
[41.975386] pSb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
[41.975879] pB function_1+0x4/0x2c [crash]
[41.976076] pBb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]

without KALLSYMS:
[9.624152] ps 0xffff800001bd008c [crash]	// similar to original, no changes
[9.624548] pS 0x(____ptrval____)+0x8c [crash]   // base address hashed and offset is without hash
[9.624847] pSb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
[9.625388] pB 0x(____ptrval____)+0x8c [crash]
[9.625594] pBb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]

with disable hashing:
[8.563916] ps 0xffff800000f2008c [crash]
[8.564574] pS 0xffff800000f20000+0x8c [crash]
[8.564749] pSb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
[8.565008] pB 0xffff800000f20000+0x8c [crash]
[8.565154] pBb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]

Suggested-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/kallsyms.h |  2 +
 include/linux/module.h   | 20 ++++++++++
 kernel/kallsyms.c        | 27 +++++++------
 kernel/module/internal.h | 11 +++---
 kernel/module/kallsyms.c | 20 ----------
 kernel/module/main.c     | 20 ++++++++++
 lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
 7 files changed, 133 insertions(+), 52 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index ce1bd2fbf23e..72bd24e80545 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -89,6 +89,8 @@ extern int sprint_symbol_build_id(char *buffer, unsigned long address);
 extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
 extern int sprint_backtrace(char *buffer, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
+extern int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
+			    int backtrace, int symbol);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
diff --git a/include/linux/module.h b/include/linux/module.h
index 46d4d5f2516e..66f4491249c5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -682,6 +682,20 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
+static inline int fill_name_build_id(char *buffer, char *modname,
+			    int add_buildid, const unsigned char *buildid,
+			    int len)
+{
+	len += sprintf(buffer + len, " [%s", modname);
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+	if (add_buildid && buildid) {
+		/* build ID should match length of sprintf */
+		static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
+		len += sprintf(buffer + len, " %20phN", buildid);
+	}
+#endif
+	return len + sprintf(buffer + len, "]");
+}
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -818,6 +832,12 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 	return ptr;
 }
 
+static inline int fill_name_build_id(char *buffer, char *modname,
+			    int add_buildid, const unsigned char *buildid,
+			    int len)
+{
+	return 0;
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 79f2eb617a62..e6e96b2e0257 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -465,19 +465,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	if (add_offset)
 		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
 
-	if (modname) {
-		len += sprintf(buffer + len, " [%s", modname);
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
-		if (add_buildid && buildid) {
-			/* build ID should match length of sprintf */
-#if IS_ENABLED(CONFIG_MODULES)
-			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
-#endif
-			len += sprintf(buffer + len, " %20phN", buildid);
-		}
-#endif
-		len += sprintf(buffer + len, "]");
-	}
+	if (modname)
+		len += fill_name_build_id(buffer, modname, add_buildid, buildid, len);
 
 	return len;
 }
@@ -572,6 +561,18 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
 	return __sprint_symbol(buffer, address, -1, 1, 1);
 }
 
+int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
+			    int backtrace, int symbol)
+{
+	if (backtrace)
+		return __sprint_symbol(buffer, address, -1, 1, build_id);
+
+	if (symbol)
+		return __sprint_symbol(buffer, address, 0, 1, build_id);
+
+	return __sprint_symbol(buffer, address, 0, 0, 0);
+}
+
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
 	loff_t pos;
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 3e23bef5884d..cfff130f7c5f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -206,21 +206,20 @@ static inline void kmemleak_load_module(const struct module *mod,
 #endif /* CONFIG_DEBUG_KMEMLEAK */
 
 #ifdef CONFIG_KALLSYMS
-void init_build_id(struct module *mod, const struct load_info *info);
 void layout_symtab(struct module *mod, struct load_info *info);
 void add_kallsyms(struct module *mod, const struct load_info *info);
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
 
-static inline bool sect_empty(const Elf_Shdr *sect)
-{
-	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
-}
 #else /* !CONFIG_KALLSYMS */
-static inline void init_build_id(struct module *mod, const struct load_info *info) { }
 static inline void layout_symtab(struct module *mod, struct load_info *info) { }
 static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
 #endif /* CONFIG_KALLSYMS */
 
+static inline bool sect_empty(const Elf_Shdr *sect)
+{
+	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
+}
+
 #ifdef CONFIG_SYSFS
 int mod_sysfs_setup(struct module *mod, const struct load_info *info,
 		    struct kernel_param *kparam, unsigned int num_params);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..576a597615a7 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -209,26 +209,6 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
-void init_build_id(struct module *mod, const struct load_info *info)
-{
-	const Elf_Shdr *sechdr;
-	unsigned int i;
-
-	for (i = 0; i < info->hdr->e_shnum; i++) {
-		sechdr = &info->sechdrs[i];
-		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
-		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
-					sechdr->sh_size))
-			break;
-	}
-}
-#else
-void init_build_id(struct module *mod, const struct load_info *info)
-{
-}
-#endif
-
 /*
  * This ignores the intensely annoying "mapping symbols" found
  * in ARM ELF files: $a, $t and $d.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 05a42d8fcd7a..d511a9c62b53 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2657,6 +2657,26 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 
 static void cfi_init(struct module *mod);
 
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+static void init_build_id(struct module *mod, const struct load_info *info)
+{
+	const Elf_Shdr *sechdr;
+	unsigned int i;
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		sechdr = &info->sechdrs[i];
+		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
+		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
+					sechdr->sh_size))
+			break;
+	}
+}
+#else
+static inline void init_build_id(struct module *mod, const struct load_info *info)
+{
+}
+#endif
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40d26a07a133..e0aba2c80b8e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -999,33 +999,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 }
 #endif
 
+#if !defined(CONFIG_KALLSYMS) && defined(CONFIG_MODULES)
+static int sprint_module_info(char *buf, unsigned long value,
+			     int modbuildid, int backtrace, int symbol)
+{
+	struct module *mod;
+	unsigned long offset;
+	void *base;
+	char *modname;
+	int len;
+	const unsigned char *buildid = NULL;
+	bool add_offset;
+
+	if (is_ksym_addr(value))
+		return 0;
+
+	if (backtrace || symbol)
+		add_offset = true;
+	else
+		add_offset = false;
+
+	preempt_disable();
+	mod = __module_address(value);
+	if (mod) {
+		modname = mod->name;
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+		if (modbuildid)
+			buildid = mod->build_id;
+#endif
+		if (add_offset) {
+			base = mod->core_layout.base;
+			offset = value - (unsigned long)base;
+		}
+	}
+	preempt_enable();
+	if (!mod)
+		return 0;
+
+	/* address belongs to module */
+	if (add_offset)
+		len = sprintf(buf, "0x%p+0x%lx", base, offset);
+	else
+		len = sprintf(buf, "0x%lx", value);
+
+	return len + fill_name_build_id(buf, modname, modbuildid, buildid, len);
+}
+#else
+static inline int sprint_module_info(char *buf, unsigned long value,
+			     int modbuildid, int backtrace, int symbol)
+{
+	return 0;
+}
+#endif
+
 static noinline_for_stack
 char *symbol_string(char *buf, char *end, void *ptr,
 		    struct printf_spec spec, const char *fmt)
 {
 	unsigned long value;
-#ifdef CONFIG_KALLSYMS
 	char sym[KSYM_SYMBOL_LEN];
-#endif
+	int backtrace = 0, symbol = 0, build_id = 0;
 
 	if (fmt[1] == 'R')
 		ptr = __builtin_extract_return_addr(ptr);
 	value = (unsigned long)ptr;
 
-#ifdef CONFIG_KALLSYMS
-	if (*fmt == 'B' && fmt[1] == 'b')
-		sprint_backtrace_build_id(sym, value);
-	else if (*fmt == 'B')
-		sprint_backtrace(sym, value);
-	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
-		sprint_symbol_build_id(sym, value);
-	else if (*fmt != 's')
-		sprint_symbol(sym, value);
-	else
-		sprint_symbol_no_offset(sym, value);
+	if (fmt[0] == 'B' && fmt[1] == 'b') {
+		backtrace = 1;
+		build_id = 1;
+	} else if (fmt[0] == 'B')
+		backtrace = 1;
+	else if (fmt[0] == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b'))) {
+		symbol = 1;
+		build_id = 1;
+	} else if (fmt[0] != 's')
+		symbol = 1;
+	else {
+		/* Do Nothing, no offset */
+	}
 
+#ifdef CONFIG_KALLSYMS
+	sprint_kallsym_common(sym, value, build_id, backtrace, symbol);
 	return string_nocheck(buf, end, sym, spec);
 #else
+	if (sprint_module_info(sym, value, build_id, backtrace, symbol))
+		return string_nocheck(buf, end, sym, spec);
+
 	return special_hex_number(buf, end, value, sizeof(void *));
 #endif
 }
-- 
2.17.1

