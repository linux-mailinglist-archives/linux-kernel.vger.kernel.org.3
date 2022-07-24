Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9F57F2AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiGXC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXC3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:29:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3F16582
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:29:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u12so4982244edd.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQteeziS+VdRmbuMhvls5Rgisd3m+xGC6DUocVp6jm0=;
        b=VedBFNLV1BozLcFDvetxqfxTAoNAdHN3Jds9vacWDLE2C2paTLDqYjFMKbjOp5i+0t
         Ih3YfVN3NYpYoCdQqUU7H1zx0iifUjxHT1n+LsbhCOhvDekmwCqRE/4HBWNMMPEESGO5
         kAtN1/z05QWlSOSoiuNogrnafpHAi7NbhbFHgcuhKvGzKkNOYD6yUNUE3JQfkOcFaRgc
         5ZNw47T385vdCmfIw1WxcUXzoz2uMH2bYO6IfHho/XEAYfzngLri7UAVkBb3ksueM+wk
         kfRKC3M/pOju1eJ8eDHAQZCYHLiBYuRapb3g6st6dWBKZ9WDphuvmbXL+YFqHobzU6yd
         yJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQteeziS+VdRmbuMhvls5Rgisd3m+xGC6DUocVp6jm0=;
        b=NX3oVVvn9V4peH11ZI8J47Kn/h9Snxr7r8Dd0VVKgeyYbr0L8jj0ZdslJ8UMKZmBdY
         l/Vwn/gsXG/xkduq3RwNRk37Ptq+/VmF4Uak3whZWexSilTDt+JBOvRqHhZzAxHrcvfQ
         8brJEpIHID2b5XPW8HM7IX/DnM+Up9G2wKL2nDkyIE63A1lw9BhONf2u7uIN07Fou/Tw
         zgl5h112WnyFizZjbhHsQcz5DoT91PVoNmGzwVKZ/h7Y/NPd04xyb67PB+TUlqrS47Ti
         S7RYvrNAHvvLJ759754U6iJ2XUo5n1sKQb4FiJgAc1rwCxMHy9kzADSL6IWYe2aWMG/F
         IOGg==
X-Gm-Message-State: AJIora8v/Uk2rElX7RvvmLpduVFF2JeMmJifN9nrVwwOBLc/aEbsQ6IZ
        dzD2AQGDQK/vOLXjJMe22VcJdQ==
X-Google-Smtp-Source: AGRyM1v2Ol+IepD6aPUJry3WKmX90GXVJPT19rJl32mjJAl3UTTkJg+jtcnkukFVsgqS4A9lk3oJ1A==
X-Received: by 2002:a05:6402:3685:b0:43b:dfd3:9487 with SMTP id ej5-20020a056402368500b0043bdfd39487mr4831399edb.32.1658629756164;
        Sat, 23 Jul 2022 19:29:16 -0700 (PDT)
Received: from leo-build-box.lan (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b0072b31307a79sm3741524ejy.60.2022.07.23.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 19:29:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Chang Rui <changruinj@gmail.com>
Subject: [PATCH v2 1/2] perf symbol: Correct address for bss symbols
Date:   Sun, 24 Jul 2022 10:28:56 +0800
Message-Id: <20220724022857.2621520-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220724022857.2621520-1-leo.yan@linaro.org>
References: <20220724022857.2621520-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using 'perf mem' and 'perf c2c', an issue is observed that tool
reports the wrong offset for global data symbols.  This is a common
issue on both x86 and Arm64 platforms.

Let's see an example, for a test program, below is the disassembly for
its .bss section which is dumped with objdump:

  ...

  Disassembly of section .bss:

  0000000000004040 <completed.0>:
  	...

  0000000000004080 <buf1>:
  	...

  00000000000040c0 <buf2>:
  	...

  0000000000004100 <thread>:
  	...

First we used 'perf mem record' to run the test program and then used
'perf --debug verbose=4 mem report' to observe what's the symbol info
for 'buf1' and 'buf2' structures.

  # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.exe 8
  # ./perf --debug verbose=4 mem report
    ...
    dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 sh_addr: 0x4040 sh_offset: 0x3028
    symbol__new: buf2 0x30a8-0x30e8
    ...
    dso__load_sym_internal: adjusting symbol: st_value: 0x4080 sh_addr: 0x4040 sh_offset: 0x3028
    symbol__new: buf1 0x3068-0x30a8
    ...

Perf tool relies on libelf to parse symbols, in executable and shared
object files, 'st_value' holds a virtual address; 'sh_addr' is the
address at which section's first byte should reside in memory, and
'sh_offset' is the byte offset from the beginning of the file to the
first byte in the section.  Perf tool uses below formula to convert
symbol's memory address to file address:

  file_address = st_value - sh_addr + sh_offset
                    ^
                    ` Memory address

We can see the final adjusted address ranges for buf1 and buf2 are
[0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this is
incorrect, in the code, the structure for 'buf1' and 'buf2' specifies
compiler attribute with 64-byte alignment.

The problem happens for 'sh_offset', libelf returns it as 0x3028 which
is not 64-byte aligned, combining with disassembly, it's likely libelf
doesn't respect the alignment for .bss section, therefore, it doesn't
return the aligned value for 'sh_offset'.

Suggested by Fangrui Song, elf file contains program header which
contains PT_LOAD segments, the fields p_vaddr and p_offset in PT_LOAD
segments contain the execution info.  A better choice for converting
memory address to file address is using the formula:

  file_address = st_value - p_vaddr + p_offset

This patch introduces function elf_read_program_header() which returns
out the program header based on the passed 'st_value', then it uses
above formula to calculate the symbol file address; and the debugging
log is updated respectively.

After applying the change:

  # ./perf --debug verbose=4 mem report
    ...
    dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 p_vaddr: 0x3d28 p_offset: 0x2d28
    symbol__new: buf2 0x30c0-0x3100
    ...
    dso__load_sym_internal: adjusting symbol: st_value: 0x4080 p_vaddr: 0x3d28 p_offset: 0x2d28
    symbol__new: buf1 0x3080-0x30c0
    ...

Fixes: f17e04afaff8 ("perf report: Fix ELF symbol parsing")
Reported-by: Chang Rui <changruinj@gmail.com>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/symbol-elf.c | 45 ++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ecd377938eea..ef6ced5c5746 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -233,6 +233,33 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	return NULL;
 }
 
+static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
+{
+	size_t i, phdrnum;
+	u64 sz;
+
+	if (elf_getphdrnum(elf, &phdrnum))
+		return -1;
+
+	for (i = 0; i < phdrnum; i++) {
+		if (gelf_getphdr(elf, i, phdr) == NULL)
+			return -1;
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		sz = max(phdr->p_memsz, phdr->p_filesz);
+		if (!sz)
+			continue;
+
+		if (vaddr >= phdr->p_vaddr && (vaddr < phdr->p_vaddr + sz))
+			return 0;
+	}
+
+	/* Not found any valid program header */
+	return -1;
+}
+
 static bool want_demangle(bool is_kernel_sym)
 {
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
@@ -1209,6 +1236,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 					sym.st_value);
 			used_opd = true;
 		}
+
 		/*
 		 * When loading symbols in a data mapping, ABS symbols (which
 		 * has a value of SHN_ABS in its st_shndx) failed at
@@ -1262,11 +1290,20 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
+			GElf_Phdr phdr;
+
+			if (elf_read_program_header(syms_ss->elf,
+						    (u64)sym.st_value, &phdr)) {
+				pr_warning("%s: failed to find program header for "
+					   "symbol: %s st_value: %#" PRIx64 "\n",
+					   __func__, elf_name, (u64)sym.st_value);
+				continue;
+			}
 			pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
-				  "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n", __func__,
-				  (u64)sym.st_value, (u64)shdr.sh_addr,
-				  (u64)shdr.sh_offset);
-			sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+				  "p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
+				  __func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
+				  (u64)phdr.p_offset);
+			sym.st_value -= phdr.p_vaddr - phdr.p_offset;
 		}
 
 		demangled = demangle_sym(dso, kmodule, elf_name);
-- 
2.25.1

