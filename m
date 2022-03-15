Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5E4D9837
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbiCOJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCOJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:57:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A46EAF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:56:07 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220315095602epoutp02c8d7fd2bf49fc678f63c64c05e31e6ec~chVSkFwIH1028610286epoutp02s
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220315095602epoutp02c8d7fd2bf49fc678f63c64c05e31e6ec~chVSkFwIH1028610286epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647338162;
        bh=D7eXl0APQA03J6V/PI5OU1HJMSAbDS/nRlIBAmGGijI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Mb/U00HbJPj6wXOI6QaenxV2jBeMcBU5tzMczAZ8wD6xHllivso4L0PQwWhOfBaT8
         wGWMdYNQYurmCGvGVVcZH8uby3NKWXYj6lLVVoD5eianED9L/Z//prkJR+4mfmmf+b
         iGV4M7dGL0AjOPV4pJcdJGvM8CE3znBuN2lkNiPw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220315095601epcas5p38641ddfc080b4bd2e481d767cf6612dd~chVR7M3Ru3205032050epcas5p3P;
        Tue, 15 Mar 2022 09:56:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.14.05590.1B260326; Tue, 15 Mar 2022 18:56:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc~chRU2gCA30985309853epcas5p2O;
        Tue, 15 Mar 2022 09:51:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220315095129epsmtrp1ef8bfabda16605dd0b4bf28c2125d786~chRU1nckh0754907549epsmtrp1g;
        Tue, 15 Mar 2022 09:51:29 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-c8-623062b1bd63
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.2D.03370.1A160326; Tue, 15 Mar 2022 18:51:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220315095126epsmtip13d1a36e1cf00a4e8c27711ff0ba44c8c~chRSH3aU92135621356epsmtip1e;
        Tue, 15 Mar 2022 09:51:26 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com
Cc:     v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v2] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Date:   Tue, 15 Mar 2022 15:21:12 +0530
Message-Id: <20220315095112.439580-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmhu7GJIMkg0t7FSzmrF/DZtHbNJ3J
        4sj8NawWDw5eZ7e4vGsOm0XD7O+sFo9nzWOzODy/jcXixoSnjBYr5y9ntPj/+Curxb6OB0wW
        uzcuYrM4fucpk8Whk3MZLRo/32d0EPCY3XCRxWPnrLvsHi37bgGJI29ZPTat6mTzODHjN4vH
        vJOBHhe6sj3e77vK5tG3ZRWjx/otV1k8Pm+SC+CJ4rJJSc3JLEst0rdL4Mo48PA1Y8EPz4qD
        n3+wNTDes+li5OSQEDCR2LvsPFsXIxeHkMBuRonFHzcxQTifGCXOHvrIDOF8ZpRYv/kIO0zL
        v/OLmUFsIYFdjBIrV0RAFH1hlLgwqRWsiE1AT2LVrj0sIAkRgQuMEldu7QHrYBa4wijxaBoX
        iC0sECyxbuYKVhCbRUBVYtK91WA2r4CtRGPjeiaIbfISMy99Z4eIC0qcnPmEBWKOvETz1tnM
        EDV7OCTuLc2GsF0k7l7cB9UrLPHq+Baoq6UkXva3sYMcJCHQzSixofsYC4Qzg1Hi88GrjBBV
        9hJPLi4EuoIDaIOmxPpd+hBhWYmpp9YxQSzmk+j9/QRqAa/EjnkwtqpEy80NrBC2tMTnjx9Z
        IGwPiWkb+qDBFSux6vgqpgmM8rOQ/DMLyT+zEDYvYGRexSiZWlCcm55abFpgnJdarlecmFtc
        mpeul5yfu4kRnPi0vHcwPnrwQe8QIxMH4yFGCQ5mJRHeMy/0k4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInznkrfkCgkkJ5YkpqdmlqQWgSTZeLglGpg2u99Ys6VUy9OVMt80jls15f4xYE9i8v0
        nP/yu3EHlrE/39/WohH7o/6Zt5ad3YeKRXPnWPrwKjYv2Cs++53Spk1NSvpnnpZ0quUo2Xm+
        WLPzhg/zAtVE1ZLFPkXu/q93F5kZ2iqqX05cfv7l5tL8zTO77k6IO8u91GXxt/Lq1sIFPb/e
        x26pePci7mzwTv2VPkF3fq+4s1s0pZ67gX377K07NaLEpMO49NIiTQ32nghgkpjyS75l623/
        jw9eyE4UnD/Farnddn7bWbdzaq50G8XMUDi0+yNbhWTyykijFKNY2UNMHUpJPIsPvK/sTE2V
        Sr+xXrH+ntv+f2U/char3m1d2P86lPVq6u2d8t/5lFiKMxINtZiLihMBiTR8vesDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO7CRIMkg02TdSzmrF/DZtHbNJ3J
        4sj8NawWDw5eZ7e4vGsOm0XD7O+sFo9nzWOzODy/jcXixoSnjBYr5y9ntPj/+Curxb6OB0wW
        uzcuYrM4fucpk8Whk3MZLRo/32d0EPCY3XCRxWPnrLvsHi37bgGJI29ZPTat6mTzODHjN4vH
        vJOBHhe6sj3e77vK5tG3ZRWjx/otV1k8Pm+SC+CJ4rJJSc3JLEst0rdL4Mo48PA1Y8EPz4qD
        n3+wNTDes+li5OSQEDCR+Hd+MTOILSSwg1GiZ00wRFxa4ue/9ywQtrDEyn/P2SFqPjFKfDyj
        CWKzCehJrNq1B6iGi0NE4AajxOKFncwgDrPAHUaJb5+PgnUICwRKnJv0EGwDi4CqxKR7q1lB
        bF4BW4nGxvVMEBvkJWZe+s4OEReUODnzCdhmZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4hrS0djDuWfVB7xAjEwfjIUYJDmYlEd4zL/SThHhT
        EiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamAq3P9os7nf1PCS
        3/Lp/cK1K7O8Tj2M++i4v+Z67cXXWj7R1ldc2c2kOJ6ZXg4+VNt7huFWVPuqRH63A8fm/lmu
        ZWt2SeBIwJn3inffK70qf1xVHJg++ZvZuSOLtzK4z3K26vKddfTbPF6VYFPxlc/Z5CYsFHYr
        2afxb0Uhr2m/vWJ9meelpLtf5G45bWr+dUjczzQorlNY5LN7NauDCjdDcsLhduZ7Ie9ve2yr
        thU/1F7nbqoS9T5eTEnSeOcZdxum+LDEQ1eKuT2z+xpjTp5i0eboz211OupvrsCXNomTuz8r
        KEfnxOvfUqpPmc7OOrPUfuXj+G4LqS/xAeKee5isbruLPU97v8+Ye3OQEktxRqKhFnNRcSIA
        2+WnQBADAAA=
X-CMS-MailID: 20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc
References: <CGME20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

(C) With patched kernel without KALLSYMS:
[7.870286] ps 0xffff800000f2008c [crash]        // similar to original 
[7.870716] pS 0x(____ptrval____)+0x8c [crash]   // base address hashed and offset is without hash
[7.871025] pSb 0x(____ptrval____)+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
[7.871321] pB 0x(____ptrval____)+0x8c [crash]
[7.871512] pBb 0x(____ptrval____)+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
[7.872191] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

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
v1->v2: hash base address of module, change *fmt to fmt[0] and removed
        copy paste.

 include/linux/kallsyms.h |  2 +
 include/linux/module.h   | 22 +++++++++++
 kernel/kallsyms.c        | 26 ++++++-------
 kernel/module.c          |  4 +-
 lib/vsprintf.c           | 84 +++++++++++++++++++++++++++++++++-------
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
index 1e135fd5c076..26a49e663351 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -678,6 +678,22 @@ static inline bool is_livepatch_module(struct module *mod)
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
+	len += sprintf(buffer + len, "]");
+
+	return len;
+}
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -818,6 +834,12 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
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
index 57213e1d2349..cdbcaf86252a 100644
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
@@ -586,6 +575,17 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
 	return __sprint_symbol(buffer, address, -1, 1, 1);
 }
 
+int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
+			    int backtrace, int symbol)
+{
+	if (backtrace)
+		return __sprint_symbol(buffer, address, -1, 1, build_id);
+	else if (symbol)
+		return __sprint_symbol(buffer, address, 0, 1, build_id);
+	else
+		return __sprint_symbol(buffer, address, 0, 0, 0);
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
index 7adb8fd4d804..064b0cc45a37 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1000,33 +1000,91 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 }
 #endif
 
+#if !defined(CONFIG_KALLSYMS) && defined(CONFIG_MODULES)
+static int sprint_module_info(char *buf, char *end, unsigned long value,
+			     const char *fmt, int modbuildid, int backtrace, int symbol)
+{
+	struct module *mod;
+	unsigned long offset = 0;
+	unsigned long base;
+	char *modname;
+	int len;
+	const unsigned char *buildid = NULL;
+
+	if (is_ksym_addr(value))
+		return 0;
+
+	if (backtrace || symbol)
+		offset = 1;
+
+	preempt_disable();
+	mod = __module_address(value);
+	if (mod) {
+		modname = mod->name;
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+		if (modbuildid)
+			buildid = mod->build_id;
+#endif
+		if (offset) {
+			base = (unsigned long)mod->core_layout.base;
+			offset = value - base;
+		}
+	}
+
+	preempt_enable();
+	if (!mod)
+		return 0;
+
+	/* address belongs to module */
+	if (offset)
+		len = sprintf(buf, "0x%p+0x%lx", (void *)base, offset);
+	else
+		len = sprintf(buf, "0x%lx", (void *)value);
+
+	len += fill_name_build_id(buf, modname, modbuildid, buildid, len);
+	return len;
+}
+#else
+static inline int sprint_module_info(char *buf, char *end, unsigned long value,
+			     const char *fmt)
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
+	if (sprint_module_info(sym, end, value, fmt, build_id, backtrace, symbol))
+		return string_nocheck(buf, end, sym, spec);
+
 	return special_hex_number(buf, end, value, sizeof(void *));
 #endif
 }
-- 
2.17.1

