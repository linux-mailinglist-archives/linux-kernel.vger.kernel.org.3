Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5705C4E57CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbiCWRvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiCWRv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:51:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2D7084D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:49:54 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220323174948epoutp04215c7e8ac26c3ea6bc60039b444c68b0~fE9O6MKpq1835518355epoutp04g
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:49:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220323174948epoutp04215c7e8ac26c3ea6bc60039b444c68b0~fE9O6MKpq1835518355epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648057788;
        bh=o8IC/d01fPVATVulaoxk5nJ1bb6bnWd0zPHn3EAudgk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=i+WUooXrLTfCB72knK6X/MSDOVSUAAQ4gTh/OBCEuSNGHPwF+iIRPW9KvcZlp7hOe
         t5j1y1fELCMPLVZbE2MOVZor7zpaKDU/7UzSSUpG2/W6YxvEpcx/fcwXluMEcUSHh+
         SxNMTm7S7qmgwqmwOvl7KD2LX0HLAbHrolWZvw3I=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220323174947epcas5p2486e6348f0300aa9013f088b8a5707a5~fE9NyUAwR3023730237epcas5p2-;
        Wed, 23 Mar 2022 17:49:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.9A.12523.BBD5B326; Thu, 24 Mar 2022 02:49:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220323164758epcas5p2d98f696230aaa5e2d6a8820bc2f13f0c~fEHPwTcqm2157421574epcas5p2j;
        Wed, 23 Mar 2022 16:47:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220323164758epsmtrp1c5ff58aca4cfd7821e0428c8a8cb8be7~fEHPvCgKu0787707877epsmtrp1o;
        Wed, 23 Mar 2022 16:47:58 +0000 (GMT)
X-AuditID: b6c32a4a-5a1ff700000030eb-bc-623b5dbbe343
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.F2.29871.E3F4B326; Thu, 24 Mar 2022 01:47:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220323164755epsmtip23011593fa51b22897a3032bdb3e0835b~fEHMW4Br-0713307133epsmtip2S;
        Wed, 23 Mar 2022 16:47:54 +0000 (GMT)
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
Subject: [PATCH 1/1 module-testing] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Date:   Wed, 23 Mar 2022 22:17:42 +0530
Message-Id: <20220323164742.2984281-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmhu7uWOskg93zJC3mrF/DZtHbNJ3J
        4sj8NawWDw5eZ7c4051rcXnXHDaLhtnfWS0ez5rHZnF4fhuLxY0JTxktPkz4z2Sxcv5yRov/
        j7+yWry9M53FYl/HAyaL3RsXsVkcv/OUyeLQybmMFtuXr2ezaPx8n9FBxGN2w0UWj52z7rJ7
        tOy7xe6xYFOpR8uRt6wem1doeWxa1cnmcWLGbxaPeScDPc6s3sbkcaEr2+P9vqtsHn1bVjF6
        rN9ylcXj8ya5AP4oLpuU1JzMstQifbsErozGw1wFi5Mqth3+z9LAuDqwi5GTQ0LARGLDpses
        ILaQwG5GibOdwRD2J0aJR92GXYxcQPY3Ronpf4+ywDTsO3CGHSKxl1Fi/sXJzBDOF0aJtuUr
        2EGq2AT0JFbt2sMCkhARuMAoceXWHrAqZoGNTBIzX0xhBqkSFkiW+HBqDhOIzSKgKnHsaCOY
        zStgJ7GvewkbxD55iZmXvrNDxAUlTs58AnYHM1C8eetssKESAh84JBr2zGeFaHCR2Ll9MTOE
        LSzx6vgWdghbSuJlfxs7REM3o8SG7mMsEM4MRonPB68yQlTZSzy5uBBoEgfQCk2J9bv0IcKy
        ElNPrWOC2Mwn0fv7CRNEnFdixzwYW1Wi5eYGqCOkJT5//AgNMQ+JLxdms0OCNVZi07MlLBMY
        5WcheWgWkodmIWxewMi8ilEytaA4Nz212LTAKC+1XK84Mbe4NC9dLzk/dxMjOHFqee1gfPjg
        g94hRiYOxkOMEhzMSiK8iz+YJwnxpiRWVqUW5ccXleakFh9ilOZgURLnPZ2+IVFIID2xJDU7
        NbUgtQgmy8TBKdXAlPltoZ93ekvpp2ORJ2Old6nME1rWbbaz4+DdN29OpKtkWtqrRYmxyW7R
        OnqveYuI15yHP4MDp77TM7h6vP+SW0fT+2kr57T4rz2fzLtsllfc+oPbv6h/ESsTkEzZ9eXA
        7vLDITuvBZzkM/kpofxI4oKcir/nH9s5Tfadio0ldc7x7lyVmbaGch4qsgLJTGv/CrlbqyZ3
        rvd+EHDGiUM1vCP5sUtXW+HLlfszP0vFvHPkfmX007FbOir89ruvcw+1es53s7g53/Dv5Enp
        86Y43V2iPfvTnnTuc9+rXO/MjzO0mn12yt0N13hmiV4U37Dzr93lZzl3e3OaFI9ss99/+ejh
        ECE7XrGi8giR/LwbSizFGYmGWsxFxYkADcE7FwsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvK6dv3WSwZ3vyhZz1q9hs+htms5k
        cWT+GlaLBwevs1uc6c61uLxrDptFw+zvrBaPZ81jszg8v43F4saEp4wWHyb8Z7JYOX85o8X/
        x19ZLd7emc5isa/jAZPF7o2L2CyO33nKZHHo5FxGi+3L17NZNH6+z+gg4jG74SKLx85Zd9k9
        WvbdYvdYsKnUo+XIW1aPzSu0PDat6mTzODHjN4vHvJOBHmdWb2PyuNCV7fF+31U2j74tqxg9
        1m+5yuLxeZNcAH8Ul01Kak5mWWqRvl0CV0bjYa6CxUkV2w7/Z2lgXB3YxcjJISFgIrHvwBn2
        LkYuDiGB3YwSxx83skMkpCV+/nvPAmELS6z89xyq6BOjxMGn85lAEmwCehKrdu1hAUmICNxg
        lFi8sJMZxGEW2M8k8W3fDbB2YYFEifv7j7GB2CwCqhLHjjaCdfMK2Ens617CBrFCXmLmpe/s
        EHFBiZMzn4D1MgPFm7fOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6
        yfm5mxjBUailuYNx+6oPeocYmTgYDzFKcDArifAu/mCeJMSbklhZlVqUH19UmpNafIhRmoNF
        SZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMTu8zTMjvZDdMb2YJCK14cepQ/O/GRvfvLFy0P
        PXTfWTZfnlz2y71S4fHrQOdzBw8GbVCTfxHWctL7m+hdFtVZynvMdqlnvdqkFfH+SPARhpwz
        EvfNC14Wlnu3btpyNJvva37oZaX+XQLnSy8nxKRPvWH98L35q6aJB2+w3Hd89zZDuemde4j8
        RKdS5+i9v5buCligUlJpnp1y9PhjAZbQX/+MXhaeDfiw0Ckz8MzVbSu91OavnnOM5UKQcvXJ
        OzEnPlrxfKncZFt76Q3bPtO79m/OtvCV3vZ6ss64w2XxorCCz8zn9WSy/xn9mXrSb9mpneJf
        ShI7Xsp2WW+T/raGKSi+137Nm4kRnu/8cpbUKLEUZyQaajEXFScCABaMw2IxAwAA
X-CMS-MailID: 20220323164758epcas5p2d98f696230aaa5e2d6a8820bc2f13f0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220323164758epcas5p2d98f696230aaa5e2d6a8820bc2f13f0c
References: <CGME20220323164758epcas5p2d98f696230aaa5e2d6a8820bc2f13f0c@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
module-next -> module-testing: Petr's review and test tag is picked from previous version,
current version has slight changes (module.c -> module/main.c). No functional change in patch,
only init_build_id() function is moved to module/main.c as it can be independent of
kallsyms.

 include/linux/kallsyms.h |  2 +
 include/linux/module.h   | 20 ++++++++++
 kernel/kallsyms.c        | 27 +++++++------
 kernel/module/internal.h | 11 +++---
 kernel/module/kallsyms.c | 20 ----------
 kernel/module/main.c     | 20 ++++++++++
 lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
 7 files changed, 133 insertions(+), 52 deletions(-)

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
index ce0ef17662c9..196521691ffe 100644
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
index 36574a806a81..20060eb8c6d5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -981,33 +981,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
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

