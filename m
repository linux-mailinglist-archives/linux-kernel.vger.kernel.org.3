Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DCE4DA95D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbiCPEhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCPEhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:37:32 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C03410C3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:36:16 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220316043611epoutp04b04540bc846ebe8fd2970a319b7ba292~cwnT-cp0Y0541405414epoutp04a
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:36:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220316043611epoutp04b04540bc846ebe8fd2970a319b7ba292~cwnT-cp0Y0541405414epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647405371;
        bh=/gm4AA8CLxszdt7ziOnnHN8fkkwV9dp3skuI6cB3n9Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ax4WCof0CihgblJvkZPSXXKY6cbKi5f5NW8AK4niWAi9Jqpi/UeKxjU3lN0Yz7EMM
         Nd1ot5H/cni1keDICuqbLDuUM4YfZDURsfrBusy2NUZ9ylkcZZ7vlBMZEHLLGXko1L
         mWqtgeCQr2e6ILE1byqSLeWcB6cYYbWfwDbr0/ZI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220316043610epcas5p12eb332b22acaf98109514b899950a42c~cwnTSeYZZ0546505465epcas5p1U;
        Wed, 16 Mar 2022 04:36:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.3F.12523.A3961326; Wed, 16 Mar 2022 13:36:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933~cwnCY9t7v1251512515epcas5p2l;
        Wed, 16 Mar 2022 04:35:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220316043552epsmtrp289c7c86cadc8901dbb073a477b0638f7~cwnCW3vpT2071020710epsmtrp2T;
        Wed, 16 Mar 2022 04:35:52 +0000 (GMT)
X-AuditID: b6c32a4a-5a1ff700000030eb-bb-6231693ac7d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.EC.03370.82961326; Wed, 16 Mar 2022 13:35:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220316043549epsmtip205604eb6be39089cbf46f41a7a185dcf~cwm-GpVcy1218912189epsmtip2g;
        Wed, 16 Mar 2022 04:35:48 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com
Cc:     v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, keescook@chromium.org,
        ndesaulniers@google.com, rdunlap@infradead.org, void@manifault.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1 module-next] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Date:   Wed, 16 Mar 2022 10:05:40 +0530
Message-Id: <20220316043540.677128-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxTPfX3v9dENebYsXku2ShfMhEAVx3bjwJFI9EUlGWqyyLJItS+1
        A1rSFreR/VGBfVDCACMDCoJsRkplK5ZKsTAm1Y0xyIQpHSpKEYiuClgKuA4XRvsw87/fxznn
        d87NpXjCACGmVGo9q1XLc6SkAO+4uuWN+B2qbUe3+uekqN7aSqKywmoMXWtsJZCn908+GizN
        RTec9SQy1D0l0KSpgURXG7/A0WjFNEBPKlYw1NLYDNDK5CKBZsaqcdTzlQdDXRe/JVHf2DSG
        XP1nAHI0W0l00j8OUiOZOsMwzlw23eUzxT23+cxZWz5TfG2GYNrNsYzNUkIyv9Ys40xDfwYz
        eKEDY4aM2cxczwjJfG23AMZqH8EZv+219yIyBckKNkd1gtXKdmYJjrdUnSLyJvd+Um6Y5RnA
        vRQjoChIvwnND8RGIKCEdBeAznI3wZF5AGu9bh5H/ABW36lcJWGhjmeOdjyIhbQTwMXhrVzR
        AoD/zpzHggZJJ0CLsxsPGpH0EIA3b3eHRvHoixisfXg6NEpEZ8GJR8shjNMxcMJzjgjicDoF
        ftPdRHBxElj7x1M+p6+H/bVToWjeql50qS40FNILFCwZtK3tlwbP9XINkBZBb599DYuhf/ZH
        kmsoBbCt9BecIzUA+ntHAFf1LpwaDkZTqxFboNUp4+RXYdVvP2Bc8jpYtjyFcXo47Gx4jmNg
        8a22ta2joN/nwznMwOkHAyT3YB/C0sUlvAJITC8cZHrhINP/yWcBzwI2snm6XCWrS8pLVLMf
        J+jkubp8tTLhmCbXBkK/M3ZvJ5jwPElwAYwCLgApnjQyfPCh7KgwXCH/tIDVao5o83NYnQtE
        Ubh0Q/iAsk0upJVyPZvNsnms9rmLUWFiAyY5UW7x/v3lqHGToiAqTXWvaFTzTuAvt9vX49h5
        5Wd7UaV4l3N3R6Gwpu2l5LfSUk/FxAciduiN+gOHXOn7UzPx3zfGyaMGrg8WDp9+VDb3/keX
        RhevyAq6z69LSnk2e+TyiEZR0YwtlW3veL3+TrvoYN3hfe3mppLN2+3R68ej543mqgO7MrId
        xyZfvm45WODd4x3y+eb11ROC1u8GAnzVZx+M/eNVuj3Jcca7b+/vI/wRu2O7REsnO+Pu7zEn
        7pOkJ7ZUp9/KlH0ON5XrN+se+25Ym/oV8a9EBxwrNiQ6LN6QkSSTam4+5qsXZla6wyoz++7r
        kyTRnvGsBuvCTxHfd0px3XH5tlieVif/D5XbfWwMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvK5GpmGSwdNpkhZz1q9hs+htms5k
        cWT+GlaLBwevs1uc6c61uLxrDptFw+zvrBaPZ81jszg8v43F4saEp4wWHyb8Z7JYOX85o8X/
        x19ZLd7emc5isa/jAZPF7o2L2CyO33nKZHHo5FxGi+3L17NZNH6+z+gg4jG74SKLx85Zd9k9
        WvbdYvdYsKnUo+XIW1aPzSu0PDat6mTzODHjN4vHvJOBHmdWb2PyuNCV7fF+31U2j74tqxg9
        1m+5yuLxeZNcAH8Ul01Kak5mWWqRvl0CV8bKqZNYCx57VfQ3vGNuYLxn28XIySEhYCLxZ/tm
        FhBbSGAHo8SGP6IQcWmJn//es0DYwhIr/z1n72LkAqr5xCjxZtovRpAEm4CexKpde1hAEiIC
        NxglFi/sZAZxmAX2M0l823cDrF1YIE6i6cZDJhCbRUBV4uGDJawgNq+ArcS0PQtZIVbIS8y8
        9J0dIi4ocXLmE7BeZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
        L10vOT93EyM4CrW0djDuWfVB7xAjEwfjIUYJDmYlEd4zL/SThHhTEiurUovy44tKc1KLDzFK
        c7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCSvlYypcjtm7rN+ara0jWhAQWHa5Qnr2x1
        C82ev+7o2xrTnYdFLvz/q+z0wky0V2XO7FXHrhnN4zufd0jd2fTzCV3mKjXW8uW/TNxWby5O
        XKwYpr/s0H5b20/F5tbXk2Ws3eUWHNgstOGh61+L78HTsjwWBR6Zduf0vmf3JwckvX4Suvz3
        ojuOBw/M9us262ASf1egsJ3NdsKMHXt2tvTuN0o+6L52Q260SePCgy+9ZZPau9pfPFe955U8
        W0nzc9nMravu7JN/y1eo4LFjVaBV8FLhcx+/TLV3FlTmvL5E4W7U3Lcbg7nZTwae5b6hVhL2
        fbv6LLaDDQstMmoP3ZkcdvXGIpEjhnmvn/bmT3tnrsRSnJFoqMVcVJwIAHmzu8QxAwAA
X-CMS-MailID: 20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933
References: <CGME20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print module information when KALLSYMS is disabled.

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
---
 include/linux/kallsyms.h |  2 +
 include/linux/module.h   | 20 ++++++++++
 kernel/kallsyms.c        | 27 +++++++------
 kernel/module.c          |  4 +-
 lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
 5 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 4176c7eca7b5..1813ba9854f9 100644
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
index 1e135fd5c076..b154fa822f77 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -678,6 +678,20 @@ static inline bool is_livepatch_module(struct module *mod)
 bool is_module_sig_enforced(void);
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
index 951c93216fc4..bd014504771d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -461,19 +461,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
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
@@ -568,6 +557,18 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
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
diff --git a/kernel/module.c b/kernel/module.c
index 46a5c2ed1928..ccccb135c7fe 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1465,12 +1465,10 @@ resolve_symbol_wait(struct module *mod,
 	return ksym;
 }
 
-#ifdef CONFIG_KALLSYMS
 static inline bool sect_empty(const Elf_Shdr *sect)
 {
 	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
 }
-#endif
 
 /*
  * /sys/module/foo/sections stuff
@@ -2799,7 +2797,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 }
 #endif /* CONFIG_KALLSYMS */
 
-#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 static void init_build_id(struct module *mod, const struct load_info *info)
 {
 	const Elf_Shdr *sechdr;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..6f661f5a6814 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -979,33 +979,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
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

