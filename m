Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143DB585FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiGaQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiGaQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:49:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634DFD32
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:49:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5668674cso76027597b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OL+B7EnrTdtYNwErJE1sbP32av4EoWUFSVKH32bLKO8=;
        b=pSG7/nw8odGOnNOLEY5o8A3KB0ajMWFg7ohAU7dxO2o0hGn/pK2D8CBmses/8VUNPY
         XIh3C0cChzkPEleG4M+S5cE4j0Mh5EY10K6ENXENdA+6VVmEPob5uhbsvS4ki4qdWdaY
         bwmpQVWKMqY+P0/ToTW4PxFYZIh538j1ns1Cvjl9BToJyju/qikF/spXALYsLzJXW1r8
         B9w/vwB5uE3VmJUEpqnWOs95+3sJ4ojGrzbyvba1TRxYA5U0sBCaok/1ANfzlLY2eLcJ
         jDSfffzyyw7qe9/UqmY8lhFKkeDPeG1jtmWT7cJxnYDm8qLGndZhU66xY5K6YcAWw5YK
         TU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OL+B7EnrTdtYNwErJE1sbP32av4EoWUFSVKH32bLKO8=;
        b=KC71QWv5Q2Ca6f5bo4Tv47IEiv/0bmmMPkzsqx4It7piNPGuzShaDWOa1NbrZoo6/j
         37XK+zACNEjrp0vJCLAdqgic6yzPYu9HhyT/YrMYFzlJp89kPKmcus0akGHzK7K7GI3V
         spzUXmPrj3c4UaKG6aEFvXxVGdYW3jG3Ja2VHQY4ku47k60R80E9uxVjLcqRD/4v4FD2
         BEt+qn5CFp+iFR3xTVFgj9gisEUVceR1B3uDbPPqpLuzsmmjGcZNzs5V5hGsArsbOFmR
         VLwBG3krK4o1jozXY1qeEvqUKibhq589Io6+XOZBGqavHNIEzIelRqcpAEeyhrRVhXF3
         wVlg==
X-Gm-Message-State: ACgBeo3Tzur3uBtlSG96OvAufspo3JzZ8zU+Qq720/s4cdSyLJPFWAKN
        cDJq+DAQHCZ7JCRHkCM95YZfiS/BtgWP
X-Google-Smtp-Source: AA6agR5GKiV0bGJ4FU5pWdN7yoW6QtCV+zJv0pHXYRfCu1+5rvOT2My0ig8e2zZRCiD+MSDI3MHg8x8ZM3v7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:839c:1c69:c3d6:1570])
 (user=irogers job=sendgmr) by 2002:a05:6902:154e:b0:676:b762:cd7d with SMTP
 id r14-20020a056902154e00b00676b762cd7dmr7746252ybu.179.1659286167135; Sun,
 31 Jul 2022 09:49:27 -0700 (PDT)
Date:   Sun, 31 Jul 2022 09:49:23 -0700
Message-Id: <20220731164923.691193-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] perf symbol: Fail to read phdr workaround
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf jvmti agent doesn't create program headers, in this case
fallback on section headers as happened previously.

Fixes: 882528d2e776 ("perf symbol: Skip symbols if SHF_ALLOC flag is not set")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b3be5b1d9dbb..75bec32d4f57 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1305,16 +1305,29 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 			if (elf_read_program_header(syms_ss->elf,
 						    (u64)sym.st_value, &phdr)) {
-				pr_warning("%s: failed to find program header for "
+				pr_debug4("%s: failed to find program header for "
 					   "symbol: %s st_value: %#" PRIx64 "\n",
 					   __func__, elf_name, (u64)sym.st_value);
-				continue;
+				pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
+					"sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n",
+					__func__, (u64)sym.st_value, (u64)shdr.sh_addr,
+					(u64)shdr.sh_offset);
+				/*
+				 * Fail to find program header, let's rollback
+				 * to use shdr.sh_addr and shdr.sh_offset to
+				 * calibrate symbol's file address, though this
+				 * is not necessary for normal C ELF file, we
+				 * still need to handle java JIT symbols in this
+				 * case.
+				 */
+				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+			} else {
+				pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
+					"p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
+					__func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
+					(u64)phdr.p_offset);
+				sym.st_value -= phdr.p_vaddr - phdr.p_offset;
 			}
-			pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
-				  "p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
-				  __func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
-				  (u64)phdr.p_offset);
-			sym.st_value -= phdr.p_vaddr - phdr.p_offset;
 		}
 
 		demangled = demangle_sym(dso, kmodule, elf_name);
-- 
2.37.1.455.g008518b4e5-goog

