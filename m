Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949B463F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbhK3VCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbhK3U7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:51 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960BC061757
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:06 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 193so28349024qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHLPpkfYBgSNE1K2ypQoqoyeedAVoDq43ShmrIHl78c=;
        b=QyMONnPK/zmSxQXcsCVX5SMdnrOIdLw+Dnf3uku5i43OEOlLv24iuCYGhPfaykRPnd
         s2jM7AiO/R2/H26/DzeBzbfRhFRdupGL3WUwPKSdioLjfK1Xz/MTdGRp/9ybdbhI94gi
         GYTNiWTXH9BAJhUiABCWy6a+uhT3iEhS0dNaask0/M5Vvn8uRcqf0IgnY4yHTv/jli3M
         W3VRorNgS1fXDZLgqNjiGCDUynFHkzA8Ybcu9XqsRvZEWwVdmwrJDiPi43/cESKZIb/i
         8uDBYWzywvhydbhi0J+svr7FYdcWfv/Y6ePT5nBE2jIMWXcib9H/3AfkYMdeiRSAXB9X
         3f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHLPpkfYBgSNE1K2ypQoqoyeedAVoDq43ShmrIHl78c=;
        b=LGH3Rg16tySz4QVhdDCX+lJyU5fho/AmLRGYoOO+j0y+dvNnNyV8aH70pY/yDnwzgn
         UGq9WGmJRrxR9wHOa8LfIUMqFlK3ugLwNokLExUZ69CLdEwj4YzwmwilGIaG/S5m0OjJ
         hz2aDhtMXSdVSK4A3ggAAtZ/ZRL7WHwiD5LxBeAgGiWSvGN0fp6DyYqc0o0ETXXM9nfQ
         d7znNDYPV183/8Er/ZKBaMTD03tRt2BjNN0omCEeakLlMQXeeW0yoDDm3zcUQ+FXVSz7
         vu19QWB5CAEyzYvPBzUc/nLIVuMt5cBwAufTrqdlUAh6ByNJquphFlFHfDXpDph8HlOD
         yL6Q==
X-Gm-Message-State: AOAM530YGDg3U2xs51/XzL5WY6xKXALSFjQWHccYjOWog0DspS4cZJZr
        TYkz3ddHpWIOuzvvCpCkrwRfwHt9kg==
X-Google-Smtp-Source: ABdhPJwKoGU1febEBDIX+KvxH/mNm3brld3j/5R/0reFN5w1pGNBbRplxqzVKI2P17b2ddswIDmeng==
X-Received: by 2002:a37:a811:: with SMTP id r17mr1931565qke.305.1638305765174;
        Tue, 30 Nov 2021 12:56:05 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:04 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 5/6] kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
Date:   Tue, 30 Nov 2021 15:55:48 -0500
Message-Id: <20211130205549.116673-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130205549.116673-1-brgerst@gmail.com>
References: <20211130205549.116673-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 init/Kconfig            | 10 +-----
 kernel/kallsyms.c       | 12 ++------
 scripts/kallsyms.c      | 68 ++++++-----------------------------------
 scripts/link-vmlinux.sh |  4 ---
 4 files changed, 12 insertions(+), 82 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 943552dc9c19..981621f658a9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1711,10 +1711,6 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols.
 
-config KALLSYMS_ABSOLUTE_PERCPU
-	bool
-	depends on KALLSYMS
-
 config KALLSYMS_BASE_RELATIVE
 	bool
 	depends on KALLSYMS
@@ -1722,11 +1718,7 @@ config KALLSYMS_BASE_RELATIVE
 	help
 	  Instead of emitting them as absolute values in the native word size,
 	  emit the symbol references in the kallsyms table as 32-bit entries,
-	  each containing a relative value in the range [base, base + U32_MAX]
-	  or, when KALLSYMS_ABSOLUTE_PERCPU is in effect, each containing either
-	  an absolute value in the range [0, S32_MAX] or a relative value in the
-	  range [base, base + S32_MAX], where base is the lowest relative symbol
-	  address encountered in the image.
+	  each containing a relative value in the range [base, base + U32_MAX].
 
 	  On 64-bit builds, this reduces the size of the address table by 50%,
 	  but more importantly, it results in entries whose values are build
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3011bc33a5ba..bea1cfc5cacd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -152,16 +152,8 @@ static unsigned long kallsyms_sym_address(int idx)
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
 		return kallsyms_addresses[idx];
 
-	/* values are unsigned offsets if --absolute-percpu is not in effect */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
-		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
-
-	/* ...otherwise, positive offsets are absolute values */
-	if (kallsyms_offsets[idx] >= 0)
-		return kallsyms_offsets[idx];
-
-	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
-	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+	/* values are unsigned offsets */
+	return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
 }
 
 static bool cleanup_symbol_name(char *s)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 54ad86d13784..f6419efc2c54 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -33,7 +33,6 @@ struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
 	unsigned int start_pos;
-	unsigned int percpu_absolute;
 	unsigned char sym[];
 };
 
@@ -51,14 +50,9 @@ static struct addr_range text_ranges[] = {
 #define text_range_text     (&text_ranges[0])
 #define text_range_inittext (&text_ranges[1])
 
-static struct addr_range percpu_range = {
-	"__per_cpu_start", "__per_cpu_end", -1ULL, 0
-};
-
 static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
-static int absolute_percpu;
 static int base_relative;
 
 static int token_profit[0x10000];
@@ -224,7 +218,6 @@ static struct sym_entry *read_symbol(FILE *in)
 		return NULL;
 
 	check_symbol_range(name, addr, text_ranges, ARRAY_SIZE(text_ranges));
-	check_symbol_range(name, addr, &percpu_range, 1);
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
@@ -241,7 +234,6 @@ static struct sym_entry *read_symbol(FILE *in)
 	sym->len = len;
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
-	sym->percpu_absolute = 0;
 
 	return sym;
 }
@@ -379,11 +371,6 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 	return total;
 }
 
-static int symbol_absolute(const struct sym_entry *s)
-{
-	return s->percpu_absolute;
-}
-
 static void write_src(void)
 {
 	unsigned int i, k, off;
@@ -419,28 +406,17 @@ static void write_src(void)
 			long long offset;
 			int overflow;
 
-			if (!absolute_percpu) {
-				offset = table[i]->addr - relative_base;
-				overflow = (offset < 0 || offset > UINT_MAX);
-			} else if (symbol_absolute(table[i])) {
-				offset = table[i]->addr;
-				overflow = (offset < 0 || offset > INT_MAX);
-			} else {
-				offset = relative_base - table[i]->addr - 1;
-				overflow = (offset < INT_MIN || offset >= 0);
-			}
+			offset = table[i]->addr - relative_base;
+			overflow = (offset < 0 || offset > UINT_MAX);
 			if (overflow) {
 				fprintf(stderr, "kallsyms failure: "
-					"%s symbol value %#llx out of range in relative mode\n",
-					symbol_absolute(table[i]) ? "absolute" : "relative",
+					"symbol value %#llx out of range in relative mode\n",
 					table[i]->addr);
 				exit(EXIT_FAILURE);
 			}
 			printf("\t.long\t%#x\n", (int)offset);
-		} else if (!symbol_absolute(table[i])) {
-			output_address(table[i]->addr);
 		} else {
-			printf("\tPTR\t%#llx\n", table[i]->addr);
+			output_address(table[i]->addr);
 		}
 	}
 	printf("\n");
@@ -730,36 +706,14 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
-static void make_percpus_absolute(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
-			/*
-			 * Keep the 'A' override for percpu symbols to
-			 * ensure consistent behavior compared to older
-			 * versions of this tool.
-			 */
-			table[i]->sym[0] = 'A';
-			table[i]->percpu_absolute = 1;
-		}
-}
-
 /* find the minimum non-absolute symbol address */
 static void record_relative_base(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (!symbol_absolute(table[i])) {
-			/*
-			 * The table is sorted by address.
-			 * Take the first non-absolute symbol value.
-			 */
-			relative_base = table[i]->addr;
-			return;
-		}
+	/*
+	 * The table is sorted by address.
+	 * Take the first symbol value.
+	 */
+	relative_base = table[0]->addr;
 }
 
 int main(int argc, char **argv)
@@ -769,8 +723,6 @@ int main(int argc, char **argv)
 		for (i = 1; i < argc; i++) {
 			if(strcmp(argv[i], "--all-symbols") == 0)
 				all_symbols = 1;
-			else if (strcmp(argv[i], "--absolute-percpu") == 0)
-				absolute_percpu = 1;
 			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
 			else
@@ -781,8 +733,6 @@ int main(int argc, char **argv)
 
 	read_map(stdin);
 	shrink_table();
-	if (absolute_percpu)
-		make_percpus_absolute();
 	sort_symbols();
 	if (base_relative)
 		record_relative_base();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5cdd9bc5c385..797b177cc181 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -243,10 +243,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if [ -n "${CONFIG_KALLSYMS_ABSOLUTE_PERCPU}" ]; then
-		kallsymopt="${kallsymopt} --absolute-percpu"
-	fi
-
 	if [ -n "${CONFIG_KALLSYMS_BASE_RELATIVE}" ]; then
 		kallsymopt="${kallsymopt} --base-relative"
 	fi
-- 
2.31.1

