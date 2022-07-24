Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9057F36E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiGXGAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiGXGA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:00:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2C713D5A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:00:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so7663778pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMzC+sDhG88M55FlEFZSmk/W9b9O2exUBS8ELGOOwbI=;
        b=m/CAQYimVf1if5/iN4j9OObyDuMH02KfXenpyEwJjaW/lwMNZmKCs8evsbtZ9AX+TC
         L3KNZhY8r3CLJZKy5c37I5yolFlAoyk+rOJxMiGYkBQsIBIpqpyANun4ZQx5h9KEEsnn
         Fr+npRsNApUDXb0qggA5WMENw7wu98vXtuJeaxeSOPICFQqK2XUvBuzQhB3yW5VLFRKr
         my3AdB5llTwkb9N1WZvHxJMohJH9BuT5fADdt0H5E/e1OzqWFnqeVXYkle7njap7Zgzk
         KH1P7VmKu4IT+SH8uS46pyZ1ynL8gRkU4refwxiK4YxSSb9kLXghSDm2LZzoAgJ8O5ZF
         /mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMzC+sDhG88M55FlEFZSmk/W9b9O2exUBS8ELGOOwbI=;
        b=Ic7qRIPC/Ey+Li18EUVKWRDT/wgUFC5x1SobDEyhSfjJwqRzMJ3qLdXTbKGS7nzKeu
         9mJLPEPwKk2xFIuOzrn9rm5nCK2h5F70qLidzPVYe2YVgnrBXrw1sAuIthZLPv/kQjy+
         yeGCZYwcqCohIlm/yF41isj4hHnxxc/hEaXMxUmCcnvl4Lnk9TEweibVeTK9ZG3XJ5xl
         6shSgT+/VpFC635VqzxrC/OSipsJVoeufpK+1B9rtFbI+LfR5X8BgY1F9C1iEPKs/ScT
         WM/Ec9fBZJE6DQBCQGjHpqUSCDQcJt1RymYlbEHJy1Ntwympy8rA2vsj0LxwcKdEQerZ
         oa0Q==
X-Gm-Message-State: AJIora+UWnCryUSTU1NcRDc1opnrHIiiPV/tJU1K5XtSVWku6Q3vjm3r
        G1AKH8YaRe6VFyvs6hQPRJaSFA==
X-Google-Smtp-Source: AGRyM1vSGNkgQlC2X3AoZH/uNyq5YoxHZ3t0nHFE2VEEN5tnzhscAqsZxYjM8wF+NauGxaNj9nqNGw==
X-Received: by 2002:a62:4e04:0:b0:52b:30f5:59b8 with SMTP id c4-20020a624e04000000b0052b30f559b8mr7253962pfb.37.1658642425112;
        Sat, 23 Jul 2022 23:00:25 -0700 (PDT)
Received: from localhost (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id in2-20020a17090b438200b001ec85441515sm6308961pjb.24.2022.07.23.23.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 23:00:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/2] perf symbol: Skip symbols if SHF_ALLOC flag is not set
Date:   Sun, 24 Jul 2022 14:00:13 +0800
Message-Id: <20220724060013.171050-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220724060013.171050-1-leo.yan@linaro.org>
References: <20220724060013.171050-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some symbols are observed the 'st_value' field are zeros.  E.g.
libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
resides in the '.gnu.warning.getwd' section.

Unlike normal sections, such kind of sections are used for linker
warning when a file calls deprecated functions, but they are not part of
memory images, the symbols in these sections should be dropped.

This patch checks the section attribute SHF_ALLOC bit, if the bit is not
set, it skips symbols to avoid spurious ones.

Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/symbol-elf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ef6ced5c5746..b3be5b1d9dbb 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1255,6 +1255,17 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		gelf_getshdr(sec, &shdr);
 
+		/*
+		 * If the attribute bit SHF_ALLOC is not set, the section
+		 * doesn't occupy memory during process execution.
+		 * E.g. ".gnu.warning.*" section is used by linker to generate
+		 * warnings when calling deprecated functions, the symbols in
+		 * the section aren't loaded to memory during process execution,
+		 * so skip them.
+		 */
+		if (!(shdr.sh_flags & SHF_ALLOC))
+			continue;
+
 		secstrs = secstrs_sym;
 
 		/*
-- 
2.25.1

