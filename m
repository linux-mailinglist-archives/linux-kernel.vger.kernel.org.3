Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A65A4D9F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiCOQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiCOQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:03:17 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8255BEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:02:01 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220315160156epoutp0306397b1fe62969079dba86208142f969~cmUxIVPxu0430004300epoutp03v
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:01:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220315160156epoutp0306397b1fe62969079dba86208142f969~cmUxIVPxu0430004300epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647360116;
        bh=PA9gm9soUlRKwOjsrTc63+uLbx027kDaCPKtnZR66sM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=p6OsK84cK7co90lXSNYiTw5ZDSKfIqQGseR3TBN7wlYJ/FiqVPJVxZLluzDS4kW5Q
         tGcQupO9Ocu4YgfFpcaBMwo+f5vY6dINja0haO0YOGkKBqCnk4FiIUjTz8uK2EHfPh
         Mm+Xa5zuZC74hV47ZrD8NYe4FFOTrElYbj5A+NrA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220315160156epcas5p4b54e9153e68e021d5bc65868fc8283da~cmUwjsPWr3195531955epcas5p4S;
        Tue, 15 Mar 2022 16:01:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.E0.06423.378B0326; Wed, 16 Mar 2022 01:01:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c~cmLWnF77J2873428734epcas5p2C;
        Tue, 15 Mar 2022 15:51:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220315155109epsmtrp279914e7704bc86c596cbea4128b02aa6~cmLWmLw2C2587025870epsmtrp2H;
        Tue, 15 Mar 2022 15:51:09 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-d1-6230b8735a49
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.6D.03370.DE5B0326; Wed, 16 Mar 2022 00:51:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220315155106epsmtip144c34c4afab83ffe4f486849b69a3df9~cmLT7Dtvh2340623406epsmtip1a;
        Tue, 15 Mar 2022 15:51:06 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com
Cc:     v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Date:   Tue, 15 Mar 2022 21:21:00 +0530
Message-Id: <20220315155100.516107-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmlm7xDoMkg2XzLCzmrF/DZtHbNJ3J
        4sj8NawWDw5eZ7e4vGsOm0XD7O+sFo9nzWOzODy/jcXixoSnjBYr5y9ntPj/+Curxb6OB0wW
        uzcuYrM4fucpk8Whk3MZLRo/32d0EPCY3XCRxWPnrLvsHi37bgGJI29ZPTat6mTzODHjN4vH
        vJOBHhe6sj3e77vK5tG3ZRWjx/otV1k8Pm+SC+CJ4rJJSc3JLEst0rdL4Mr4/m49U8Fxv4pj
        n5IbGJ86dDFyckgImEhc713A1MXIxSEksJtR4tfyNkYI5xOjxMZHHewQzmdGiZ3/lrDCtEyZ
        tRmqZRejxPTLZ6BavjBK3Fl0EKyKTUBPYtWuPSwgCRGBC4wSV27tYQZJMAtcYZR4NI0LxBYW
        CJa4PusYWJxFQFXi4tJONhCbV8BW4seTGYwQ6+QlZl76zg4RF5Q4OfMJC8QceYnmrbOZQRZI
        CBzhkFj9FKbBRWL6nyXsELawxKvjW6BsKYnP7/ayQTR0M0ps6D7GAuHMYJT4fPAqVLe9xJOL
        C4F+4ABaoSmxfpc+RFhWYuqpdUwQm/kken8/YYKI80rsmAdjq0q03NwADSRpic8fP7JA2B4S
        zZcegcWFBGIlHt9uZ5nAKD8LyUOzkDw0C2HzAkbmVYySqQXFuempxaYFhnmp5XrFibnFpXnp
        esn5uZsYwalPy3MH490HH/QOMTJxMB5ilOBgVhLhPfNCP0mINyWxsiq1KD++qDQntfgQozQH
        i5I47+n0DYlCAumJJanZqakFqUUwWSYOTqkGJsnsWeeVpp719pyxaE1mU9Cfp+seyZUG/k+0
        /vr69v6I6sB/1Vs2XRXezL9L4OChTTWLpe63L+NqsNwh0PxPg1N2grbx9B8/5ofNU7NZI6G2
        2bK08uq69ze2vWJeXF7J9Ps3n4a0yptNvisk7F0uTxPvNs7Xlp59IL5hTbDDtisvQ/g2F9j0
        q052fuOj9qk8TlaZ5YBpoBZ31Lk6yZC7H3/5dPW4nG9rDOWo3zHVUyPh7c1WqUnmEyMCN10R
        ie6M2a8lsS8xd9WXPU4nNqRUHrTWcPC7a1j06f0nplnzNSrlX7xvuyB96L1SVgHTrIOK/L/W
        vj3692Fvy7KqNx7BPyeGz3JR77r3o//1dblQISWW4oxEQy3mouJEAGM6BFTsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO7brQZJBg1TFC3mrF/DZtHbNJ3J
        4sj8NawWDw5eZ7e4vGsOm0XD7O+sFo9nzWOzODy/jcXixoSnjBYr5y9ntPj/+Curxb6OB0wW
        uzcuYrM4fucpk8Whk3MZLRo/32d0EPCY3XCRxWPnrLvsHi37bgGJI29ZPTat6mTzODHjN4vH
        vJOBHhe6sj3e77vK5tG3ZRWjx/otV1k8Pm+SC+CJ4rJJSc3JLEst0rdL4Mr4/m49U8Fxv4pj
        n5IbGJ86dDFyckgImEhMmbWZqYuRi0NIYAejxP6dX9khEtISP/+9Z4GwhSVW/nvODlH0iVHi
        xKONYAk2AT2JVbv2sIAkRARuMEosXtjJDOIwC9xhlPj2+SjYKGGBQIlnp9ezgdgsAqoSF5d2
        gtm8ArYSP57MYIRYIS8x89J3doi4oMTJmU/ANjADxZu3zmaewMg3C0lqFpLUAkamVYySqQXF
        uem5xYYFRnmp5XrFibnFpXnpesn5uZsYwVGkpbWDcc+qD3qHGJk4GA8xSnAwK4nwnnmhnyTE
        m5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD00rGaYyz6h+H
        Lq8pXfS0THRT18mwksebjzdHmbPfkAjYMD/lTb+Wg7bam9MXhI1vLZ2m1cxx8lrwomu8uydr
        cswRdn5x/1v/5uNnp/j7usY8Z+MPtbnmUt1geDjRPXLm6wiFlRMTF67zn6Y7Z2VmM1uQzOE9
        Ck0qZz5IH1HPv7r50WOJ5jb/oCj2eUsre9YwtHwW4eadOiNOTDe4bsrnOW5GxTJ2koJCL98p
        Rdxgd7Z9lytjY+0Yv35NwJ6NPJeOrlm7gNf11V62A7abGE9M+Ds7sXDmCSf1xd9PBRzbfNfz
        e7BXl/z3a013jev+a7ufe7Dr6sPJ1n+Zb09USZ8dc+HXnA3z/2edDdrl+9nxwDslluKMREMt
        5qLiRABE4QNkEQMAAA==
X-CMS-MailID: 20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
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
commit id 'kallsyms: print module name in %ps/S case when KALLSYMS is disabled'
	needs to be removed from mm(linux-next) tree, current change is
	with ignorance of this commit. I was not sure how to send patch, with 2 patches
	consisting reversal commit also, or current approach is correct.

v1->v2: hash base address of module, change *fmt to fmt[0] and removed
        copy paste.
v2->v3: fixed review comments from Andy Shevchenko <andriy.shevchenko@linux.intel.com>

 include/linux/kallsyms.h |  2 +
 include/linux/module.h   | 20 ++++++++++
 kernel/kallsyms.c        | 27 +++++++------
 kernel/module.c          |  4 +-
 lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
 5 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index e5ad6e31697d..c24fa627ab6e 100644
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
index 57213e1d2349..7762efadf166 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -479,19 +479,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
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
@@ -586,6 +575,18 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
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
index 6cea788fd965..5756d31a024b 100644
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
index 7adb8fd4d804..86f7d24af73c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1000,33 +1000,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
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

