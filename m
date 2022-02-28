Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4740D4C62B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiB1GBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiB1GBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:01:11 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557BB52B05
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:00:31 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220228060025epoutp020b2ba2175b633c33cd61a74159b1a648~X3cSTNm1m2542725427epoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220228060025epoutp020b2ba2175b633c33cd61a74159b1a648~X3cSTNm1m2542725427epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646028025;
        bh=8pZN1tElVEXDJhstfxtn6+EA198G1rh7eUyLBdYGKU8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ELe+8fkZdmsMF+ZXQxDrV49UatMIIuThGgH9xFd514WFGuutFaSJNl9FwfDYDWApa
         mJ4woWYSkvkEZUyK2m3qyolYOQl3FXWTemvGMzNQCG09Y51HBDyTjNkJXkYFtvuZGb
         LUIkjmeoRFAh34WnGCG8+Xry0iLUpy5qk7K5evh4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220228060024epcas5p41dc883a6934509f392ce5f1d34e283a2~X3cRx7bEZ1434714347epcas5p4D;
        Mon, 28 Feb 2022 06:00:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.91.05590.8F46C126; Mon, 28 Feb 2022 15:00:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73~X3GDR45st0083200832epcas5p1R;
        Mon, 28 Feb 2022 05:34:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220228053457epsmtrp22185cfbe4fec5003ae4218c7c1ac7c8c~X3GDQ84SN1643616436epsmtrp2W;
        Mon, 28 Feb 2022 05:34:57 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-4c-621c64f8b62b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.70.29871.10F5C126; Mon, 28 Feb 2022 14:34:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220228053454epsmtip12cc27be966540d88e232d2f26568e758~X3GAq_pd12193521935epsmtip1X;
        Mon, 28 Feb 2022 05:34:54 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com
Cc:     v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.or,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Date:   Mon, 28 Feb 2022 11:04:47 +0530
Message-Id: <20220228053447.1584704-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzNfd/gnj6qi1dwoBWW1GnropC3RJk6Zp4YMowly4yLVPtsDVC7
        tujEP6z4MangmixEaLEoYQmpSKEpDvmosSi0SiJVCBNhVikjI5ENiiuhi0r7MPOfm3POPb97
        cn65FCr6A0+kjmoMvE6jKBQT8ditbolk45xy9aFNYVcKW+NoJNiK0isIe6+2EWcDd4dI9kl7
        DcEarWGcHbPYCLa79gLG/m4eB2z17ILl7dhrnHVfDCBsR0sdwfaOjCOsx3cVsGdCz8F2hrMa
        /Rh32zJKcufcwwvHvVc4Nzv0CHBOexnBeasiGGfz7eX6TQXc3+5BgrvssgPO4RrEuJAzOZfe
        H79VyRcePc7rZJn58erR8g6gvSX78b/R54gRhD81AYqCzBY4Yc4wgXhKxHQAaHXdxwQyA6Cv
        dAYxgbgF8i+AEf+GKI4OWC7WL5q6AOztNBECmQWwrsmMR10EI4X29s6YawXTD+DAcCcaJSjz
        BEBz6DIWdS1n5HDGGkajGGPSYPlv3himmUz4S6kTE/JSYPXjMCnoCdBXHYzp6IJ+ttUaexQy
        XgoagyFCGMiCFT/bcQEvh5O9LlLAiTA01UUIA5cAbL7UgwmkCsDQ3UEguL6EQf91PLoblJFA
        R7tMkD+BlQ+aECF5KayIBBFBp2Gb7T1Og+eeNi8GJ8HQ9PRiAw52h92YsMnv4WTNDDCDFMsH
        hSwfFLL8n3wNoHawitfqi1S8Pl27WcOfkOoVRfpijUp6+FiRE8S+4Po9beBl4B+pByAU8ABI
        oeIVNImvOiSilYqTJbzu2EFdcSGv94AkChOvpB+omhUiRqUw8AU8r+V1728RKi7RiGTU5m/p
        oR/3EQ2ajJ/y/xzR7m4om/JIDblewynRd2+Wvm65Zrh+M+w40/omjXSqJgOvhqcfzjvCNL3P
        K/uBIPt8OQcOP+tzx5WoctzKmy1LCONu7Av/+DNttXtdV17ZGH9CvVKXdUeZLhncyu6YsGW+
        nKgaOI3mRNoSNhwZkqbJReuykvttCdmN88fl+z56cXLnmtMbybm/8koK1qIZBFP/1a7GCcU3
        T1c7fq2UJwUkmtsXbuyov+//9gq2rEdaxznuePOSW+eLU09Z5Z3ShvRd6pGDheenvo40MaFg
        +WfZXbx4cpuarGw3zA1kZ21+JNvkTLIGUj+m5AkeHN8pxvRqxefrUZ1e8Q71C7zh8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTpcxXibJYOJFDos569ewWfQ2TWey
        ODJ/DavFg4PX2S0u75rDZtEw+zurxeNZ89gsDs9vY7G4MeEpo8XML0Al/x9/ZbXY1/GAyWL3
        xkVsFsfvPGWyOHRyLqNF4+f7jA4CHrMbLrJ47Jx1l92jZd8tIHHkLavHl+vnGT02repk8zgx
        4zeLx7yTgR4XurI93u+7yubRt2UVo8f6LVdZPD5vkgvgjeKySUnNySxLLdK3S+DKuNuzm7Fg
        m37Fn7v3mRoYv6t1MXJySAiYSMzqWMLSxcjFISSwm1Fi3ad3TBAJaYmf/96zQNjCEiv/PWeH
        KPrEKHFt4W92kASbgJ7Eql17wLpFBG4wSixe2MkM4jAL3GaU+H1mN1iVsECQxPfjdxlBbBYB
        VYme7SeYQWxeATuJyU2boFbIS8y89J0dIi4ocXLmE7A4M1C8eets5gmMfLOQpGYhSS1gZFrF
        KJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcUVqaOxi3r/qgd4iRiYPxEKMEB7OSCC87
        q2SSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxXn23X
        SFNrCT0W++malkJE3MVrM5wu77rU69fabft7Q72op/MO6W03nzWu+af8IeNsgq34VQdui+MG
        61jKBeetnrL6xbJi7XUvYv58FawqkKoWXcH4wenen0csW1fqHHtS9FKjMdpiNvsmSfc959KP
        /u0t+GTF0K+42aGwXKi35Dwjm8wb+6YbKp8vPRDlrK5v85zfer35kPi6I69q7UQ7+3Us229/
        i13WMf1t35NbtXu//ot1OJ0Uu3Tyztr70s3y5WG9eqvesCnN36rO6+sndjs2JXmb3URuHbdO
        i4ss1wXnfH727PbRB4nvpgikJaQvELPYdfrfpX0bLNef6BJfoKnQfPfp0pR3gdvP6QcqsRRn
        JBpqMRcVJwIANEzBmRcDAAA=
X-CMS-MailID: 20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73
References: <CGME20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with commit '82b37e632513 ("kallsyms: print module name in %ps/S
case when KALLSYMS is disabled"), module name printing was enhanced.

As per suggestion from Petr Mladek <pmladek@suse.com>, covering
other flavours also to print build id also.

for %pB no change as it needs to know symbol name to adjust address
value which can't be done without KALLSYMS.

original output with KALLSYMS:
[8.842129] ps function_1 [crash]
[8.842735] pS function_1+0x4/0x2c [crash]
[8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
[8.843175] pB function_1+0x4/0x2c [crash]
[8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]

original output without KALLSYMS:
[12.487424] ps 0xffff800000eb008c
[12.487598] pS 0xffff800000eb008c
[12.487723] pSb 0xffff800000eb008c
[12.487850] pB 0xffff800000eb008c
[12.487967] pBb 0xffff800000eb008c

With patched kernel without KALLSYMS:
[9.205207] ps 0xffff800000eb008c [crash]
[9.205564] pS 0xffff800000eb0000+0x8c [crash]
[9.205757] pSb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
[9.206066] pB 0xffff800000eb0000+0x8c [crash]
[9.206257] pBb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]

Suggested-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
earlier discussion: https://lkml.org/lkml/2022/2/10/185

 include/linux/kallsyms.h | 27 --------------
 kernel/module.c          |  4 +--
 lib/vsprintf.c           | 76 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index ebfeb6099c28..5fb17dd4b6fa 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -163,33 +163,6 @@ static inline bool kallsyms_show_value(const struct cred *cred)
 	return false;
 }
 
-#ifdef CONFIG_MODULES
-static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
-{
-	struct module *mod;
-	unsigned long offset;
-	int ret = 0;
-
-	preempt_disable();
-	mod = __module_address(value);
-	if (mod) {
-		offset = value - (unsigned long)mod->core_layout.base;
-		snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
-				(unsigned long)mod->core_layout.base, offset, mod->name);
-
-		sym[size - 1] = '\0';
-		ret = 1;
-	}
-
-	preempt_enable();
-	return ret;
-}
-#else
-static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
-{
-	return 0;
-}
-#endif /*CONFIG_MODULES*/
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
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
index cb7345ff57f3..d4a24fd29494 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -980,6 +980,80 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 }
 #endif
 
+#if !defined(CONFIG_KALLSYMS) && defined(CONFIG_MODULES)
+static int sprint_module_info(char *buf, char *end, unsigned long value,
+			     const char *fmt)
+{
+	struct module *mod;
+	unsigned long offset = 1;
+	unsigned long base;
+	int ret = 0;
+	const char *modname;
+	int modbuildid = 0;
+	int len;
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+	const unsigned char *buildid = NULL;
+#endif
+
+	if (is_ksym_addr(value))
+		return 0;
+
+	if (*fmt == 'B' && fmt[1] == 'b')
+		modbuildid = 1;
+	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
+		modbuildid = 1;
+	else if (*fmt != 's') {
+		/*
+		 * do nothing.
+		 */
+	} else
+		offset = 0;
+
+	preempt_disable();
+	mod = __module_address(value);
+	if (mod) {
+		ret = 1;
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
+	if (!ret)
+		return 0;
+
+	/* address belongs to module */
+	if (offset)
+		len = sprintf(buf, "0x%lx+0x%lx", base, offset);
+	else
+		len = sprintf(buf, "0x%lx", value);
+
+	len += sprintf(buf + len, " [%s", modname);
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+	if (modbuildid && buildid) {
+		/* build ID should match length of sprintf */
+		static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
+		len += sprintf(buf + len, " %20phN", buildid);
+	}
+#endif
+	len += sprintf(buf + len, "]");
+
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
@@ -1005,7 +1079,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
 
 	return string_nocheck(buf, end, sym, spec);
 #else
-	if (fill_minimal_module_info(sym, KSYM_SYMBOL_LEN, value))
+	if (sprint_module_info(sym, end, value, fmt))
 		return string_nocheck(buf, end, sym, spec);
 
 	return special_hex_number(buf, end, value, sizeof(void *));
-- 
2.17.1

