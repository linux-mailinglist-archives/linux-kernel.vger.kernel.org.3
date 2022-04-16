Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121595032E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiDPCH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDPCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:07 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D23403D7;
        Fri, 15 Apr 2022 18:55:56 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id v15so6785684vsm.5;
        Fri, 15 Apr 2022 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/yp2SiPCDYhZ9QJZ/VkI3pUZmOOKH2y3TvYwr4r/ZY=;
        b=KaItwtfz20xnWMtNTiOqG2T72TphlDwszWNLq4pqt1Jy2NZGmz4xPEv7EjGhIFMi2E
         F9OgIDcC54Zx2zt/Hc+cI8xZuyo5DfmMAdWKoggxKdi7cqSaPSSOvQeZo4IkNe6FZqjW
         766dPYHxy1CDcGyaM/Z80nLgd+sTo05wF5k6mWrg8+8FRzyf7bZpXhpKU1TmqG2iAc+T
         trXclf97t/OX+AuOY1U0xx/4aO1cfsSbMRR8jpD1VLLVDXr57cYQeftuyZwU7l5NQ2uC
         mmuQdoTbb24IrxRsmtippfaiePCKwvbxgOuSPIEYDge1N3I/qm3TPyMI9RYvYE1jdoL9
         d4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=C/yp2SiPCDYhZ9QJZ/VkI3pUZmOOKH2y3TvYwr4r/ZY=;
        b=XMiXR3yNWGb8vqEqR+UFh4CrCQmBPAoy7n14Vx2KhSDBxB/Mr5lB/DtVd7g+MCG3B+
         9Inv6fPOlpIKJdL9xwJfaoTHBCPt8XYh4MJwHDtPwT+olngQ6Nx+0/9Greptv0r67szn
         3HCAltkmnCyeqQwfFss/9NhNDxmAHzGMAa9dzcM+IcIsd1bHmBX0FGjxX+08JlVrS7ET
         FC6zF8R9yOKhfCwGUJJSJFOTGth0IlLf2qs720ptaLAbDBHSAxRWrT8vjQgZ5sNLGTYV
         1ClpbzKeeJo6M/BShg4fscz21KCdKhXfGSc/gG4YAli+YZrYK6r0khO5dDaWicNRY9EQ
         ei4w==
X-Gm-Message-State: AOAM530aZlJi2+6QTqL6b09AvP0jyCB8jbEzwbtgwaePocnFyjz7OjvF
        LtPK758f0NO6B9Ty/lrR5OHOABcSvaA=
X-Google-Smtp-Source: ABdhPJzsACZqcMn+IVHVYYnMsaYkZAQYl/1YN2wyFMIwCE7NodBJ76t90Djj26qvoMib2GCP1YQ1Lg==
X-Received: by 2002:a17:902:7884:b0:158:b5b6:572c with SMTP id q4-20020a170902788400b00158b5b6572cmr1452146pll.144.1650069656404;
        Fri, 15 Apr 2022 17:40:56 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:461:36d2:dba1:7530:2cda:19b1])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm3913537pfu.82.2022.04.15.17.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:40:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 1/3] perf symbol: Pass is_kallsyms to symbols__fixup_end()
Date:   Fri, 15 Apr 2022 17:40:46 -0700
Message-Id: <20220416004048.1514900-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220416004048.1514900-1-namhyung@kernel.org>
References: <20220416004048.1514900-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol fixup is necessary for symbols in kallsyms since they don't
have size info.  So we use the next symbol's address to calculate the
size.  Now it's also used for user binaries because sometimes they
miss size for hand-written asm functions.

There's a arch-specific function to handle kallsyms differently but
currently it cannot distinguish kallsyms from others.  Pass this
information explicitly to handle it properly.  Note that those arch
functions will be moved to the generic function so I didn't added it
to the arch-functions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-elf.c | 2 +-
 tools/perf/util/symbol.c     | 7 ++++---
 tools/perf/util/symbol.h     | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 31cd59a2b66e..ecd377938eea 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1290,7 +1290,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * For misannotated, zeroed, ASM function sizes.
 	 */
 	if (nr > 0) {
-		symbols__fixup_end(&dso->symbols);
+		symbols__fixup_end(&dso->symbols, false);
 		symbols__fixup_duplicate(&dso->symbols);
 		if (kmap) {
 			/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dea0fc495185..1b85cc1422a9 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -217,7 +217,8 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 	}
 }
 
-void symbols__fixup_end(struct rb_root_cached *symbols)
+void symbols__fixup_end(struct rb_root_cached *symbols,
+			bool is_kallsyms __maybe_unused)
 {
 	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
@@ -1467,7 +1468,7 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 	if (kallsyms__delta(kmap, filename, &delta))
 		return -1;
 
-	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_end(&dso->symbols, true);
 	symbols__fixup_duplicate(&dso->symbols);
 
 	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
@@ -1659,7 +1660,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 #undef bfd_asymbol_section
 #endif
 
-	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_end(&dso->symbols, false);
 	symbols__fixup_duplicate(&dso->symbols);
 	dso->adjust_symbols = 1;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index fbf866d82dcc..5fcdd1f94c56 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -203,7 +203,7 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
 		       bool kernel);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
-void symbols__fixup_end(struct rb_root_cached *symbols);
+void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
 void maps__fixup_end(struct maps *maps);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
-- 
2.36.0.rc0.470.gd361397f0d-goog

