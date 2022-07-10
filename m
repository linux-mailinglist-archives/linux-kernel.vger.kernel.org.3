Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683F56CC28
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGJBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:22:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61FEE23
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 18:22:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 70so2097973pfx.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYoGrbu/lavwm2Al6qo83Dqjha+dsixArTpwHQ6cIJc=;
        b=OcDjMK2mQbjjBkah53yxyxRIKDOmKb8CFZ7uUmcvlCGp8708Cuyys1scVN2LfeGTGB
         QlInZDJqFPsTP8YhJDz5c+mvvHq+nKvU2pHFf57bDOYTDyP7BLuc9R273pdjVSYV5HIt
         avTkL32WmBqOGXtjmJp7jYOsbu7OFbgrB2pTPWHXBELX/nDidObQswwZV8dm0Goqsp55
         WJb7il+Xit8XnT4EVHmzIS8jpxkqiyHVKUDPa/D3E7qqyOYjaDSr9WajZvtklARFKySi
         ReSFBTHnpLt8lvvH7moLmK44Yq4DWAJAI87YndRZfi1VAnhtxhK8PT1l5Zzsp6LDBeLe
         1KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYoGrbu/lavwm2Al6qo83Dqjha+dsixArTpwHQ6cIJc=;
        b=m2pFUzrxRlivBz0PX3wX50rnlNbHCntmkLzfO62aJD374xxb4TsIsOmQsA5ZRUmpt0
         hmjn2c5p+nax6R6ErMvM3jcFScK3ZWYYbjFKuvyUp5UetiVodyTRHXct1CdM2UKBLp2d
         C3g0w9SuQoWkFoSIGj6ZwAADpNvsMxqpBoIqBQnwWz+mfhgOn8qraPqr3s6WQiUa62wa
         RuUD96XmaTOT8LDmyDHl5zYYLV51VDbdM3e8SnGgUBxK0Ug3+QPwpJdVcDeaPpwmlFWg
         4UC9rh4vo2+KOu88xokIVWJd8nt7Q+GUHfJqpHxygelH8CZYnnWggzHdno97kdSGFY07
         PRlA==
X-Gm-Message-State: AJIora+/o+47irgRViOdKjNUa958I2SbjU5+2UhjsUechJS92lRy+NFP
        KHVkQ6HS81m2UBXwQU0cwZ2XrA==
X-Google-Smtp-Source: AGRyM1ssa+hPKWNqIf5w5Dg+O3CPj7Diw4dUApBmB4+7U10MguqEtl5yWIStKxSKa8nhwDL4z/y0Iw==
X-Received: by 2002:a63:69c9:0:b0:411:994d:1e12 with SMTP id e192-20020a6369c9000000b00411994d1e12mr9547746pgc.383.1657416132566;
        Sat, 09 Jul 2022 18:22:12 -0700 (PDT)
Received: from leo-build-box.lan (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id b73-20020a621b4c000000b0052ab7985e18sm2078331pfb.61.2022.07.09.18.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:22:12 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Chang Rui <changruinj@gmail.com>
Subject: [RFC PATCH v1] perf symbol: Correct address for bss symbols
Date:   Sun, 10 Jul 2022 09:22:04 +0800
Message-Id: <20220710012204.2390293-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

  Disassembly of section .data:

  0000000000004000 <__data_start>:
  	...

  0000000000004008 <__dso_handle>:
      4008:	08 40 00             	or     %al,0x0(%rax)
      400b:	00 00                	add    %al,(%rax)
      400d:	00 00                	add    %al,(%rax)
  	...

  0000000000004010 <wait_to_begin>:
      4010:	01 00                	add    %eax,(%rax)
      4012:	00 00                	add    %al,(%rax)
      4014:	00 00                	add    %al,(%rax)
  	...

  0000000000004018 <lock_thd_name>:
      4018:	08 20                	or     %ah,(%rax)
      401a:	00 00                	add    %al,(%rax)
      401c:	00 00                	add    %al,(%rax)
  	...

  0000000000004020 <reader_thd_name>:
      4020:	10 20                	adc    %ah,(%rax)
      4022:	00 00                	add    %al,(%rax)
      4024:	00 00                	add    %al,(%rax)
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

Perf tool relies on libelf to parse symbols, here 'st_value' is the
address from executable file, 'sh_addr' is the belonged section's linked
start address, and 'sh_offset' is the dynamic loaded address for this
section, then perf tool uses below formula to adjust symbol address:

  adjusted_address = st_value - sh_addr + sh_offset

So we can see the final adjusted address ranges for buf1 and buf2 are
[0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this is
incorrect, in the code, the structure for 'buf1' and 'buf2' specifies
compiler attribute with 64-byte alignment.

The problem happens for 'sh_offset', libelf returns it as 0x3028 which
is not 64-byte aligned, on the other hand, we can see both 'st_value'
and 'sh_addr' are 64-byte aligned.  Combining with disassembly, it's
likely libelf uses the .data section end address as .bss section
start address, therefore, it doesn't respect the alignment attribute for
structures in .bss section.

Since .data and .bss sections are in the continuous virtual address
space, and .data section info returned by libelf is reliable, to fix
this issue, if detects it's a bss symbol, it rolls back to use .data
section info to adjust symbol's virtual address.

Essentially, we need to fix libelf to return correct offsets for
sections, on the other hand, we live commonly with existed versions of
libelf.  So we also need this change in perf tool.

Fixes: f17e04afaff8 ("perf report: Fix ELF symbol parsing")
Reported-by: Chang Rui <changruinj@gmail.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/dso.h        |  1 +
 tools/perf/util/symbol-elf.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3a9fd4d389b5..00f57f4ac6bc 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -180,6 +180,7 @@ struct dso {
 	u8		 rel;
 	struct build_id	 bid;
 	u64		 text_offset;
+	int		 data_sec_index;
 	const char	 *short_name;
 	const char	 *long_name;
 	u16		 long_name_len;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ecd377938eea..ed65dd26d58e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1095,6 +1095,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	Elf *elf;
 	int nr = 0;
 	bool remap_kernel = false, adjust_kernel_syms = false;
+	size_t sec_index;
 
 	if (kmap && !kmaps)
 		return -1;
@@ -1113,6 +1114,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				".text", NULL))
 		dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
 
+	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
+				".data", &sec_index))
+		dso->data_sec_index = sec_index;
+
 	if (runtime_ss->opdsec)
 		opddata = elf_rawdata(runtime_ss->opdsec, NULL);
 
@@ -1227,6 +1232,27 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		gelf_getshdr(sec, &shdr);
 
+		/*
+		 * When the first data structure in .bss section is attributed
+		 * with alignment (e.g. 64-byte aligned), libelf doesn't reflect
+		 * the alignment in the 'shdr.sh_offset' field, at the end the
+		 * field is filled with the end loading address of a prior
+		 * section rather than the aligned address of .bss section.
+		 * This leads to mess for later parsing .bss symbols.
+		 *
+		 * Since .data and .bss sections are in the continuous virtual
+		 * address space, and .data section's info is reliable.  So if
+		 * detects it's a bss symbol, we retrieve .data section info
+		 * for adjusting address.
+		 */
+		if (!strcmp(elf_sec__name(&shdr, secstrs_sym), ".bss")) {
+			sec = elf_getscn(syms_ss->elf, dso->data_sec_index);
+			if (!sec)
+				goto out_elf_end;
+
+			gelf_getshdr(sec, &shdr);
+		}
+
 		secstrs = secstrs_sym;
 
 		/*
-- 
2.25.1

