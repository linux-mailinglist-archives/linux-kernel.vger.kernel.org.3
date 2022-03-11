Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4823A4D5AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiCKFq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiCKFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:46:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE881A58D0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:45:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so4753753wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11FvPvpUVotQ9jY+zQvOHGZO2byI0bkimo/rEQnPxJE=;
        b=ekozbChKbpW8GZL9kUFBEDUxX05BOSH5K9gUF2d9I0XZ4OI7yg7wjlBL75B3Uxqbn1
         mmUTiRDhPalAbzG0/H2FxM2m+IBTS8Lt7RSuU9vYAwovoN7/bgwvWzgkJJT2q7dhA+s7
         dKiIo2z7yyBCoUqIgknT1iN5tDFgheAanLnZRPY3RCn/HrCN+x3RoGItWYnFeea2gXRA
         XQ9qzYAmAO6ow9mtiMMoiOrjs2F9SVxruHVkOb/2szt3vmwML8Ld73jiDkqPVaxRDSPR
         rpVacc7gtvg+4Eq23IILSLyKfcXj/j9xzWHGabYlbZFSngIX1SD1J1vxdgsRq9K+m+X+
         cRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11FvPvpUVotQ9jY+zQvOHGZO2byI0bkimo/rEQnPxJE=;
        b=s5yS7m9p7MZIva1lKkj6Ry2w9QcvcZogyg/hCSP+vafdOaJpwBF8slrhAW3YhAKJkP
         7eDwLCHz94Ps8pOPS83Tq3UMEGfsIrCLtWn4UYQ7//s6CWfUNSX2nRne6iEduBtq5Ckn
         g6q9ERd9cyL5zCXaOwF6xQF/JhErdJP/ZxaBM2uhzwivG8pSktMA28KCAEz6s4jWFCjj
         kmHsiDsZanmhBs/t5oUVG91J6idX6qUGSWcfhMCLEfOoJMghoEmomUDLgsCQjRadWnqJ
         wjpJCXEWJ1snzDggIr5grt2eaoVv+9SS74+M8aCxMmOQ4dtqUAjyN4cPKJuh4y9DWKx3
         LC/g==
X-Gm-Message-State: AOAM530b4z5liAu17Bd+wxsL2OKs/NoJRWXt6vWECkhBRAzm67ujv/KT
        fodWf8ILuAEQH3aIqFYImqE=
X-Google-Smtp-Source: ABdhPJxvBwFmzse2Kx1hsyFAMg8k8RWVvVr0RzVZVok/Ojk1rmfowT0jWel05bJdkcDXj2WeQlwdDQ==
X-Received: by 2002:a7b:c150:0:b0:389:95ee:4a20 with SMTP id z16-20020a7bc150000000b0038995ee4a20mr6220285wmi.145.1646977518091;
        Thu, 10 Mar 2022 21:45:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:40f:58f5:e8dd:8a44:b12a:d7ed])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b0020397ea11d2sm352593wry.20.2022.03.10.21.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 21:45:17 -0800 (PST)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, John Keeping <john@metanate.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: [PATCH 5.17] tools: feature/test-libperl.c: Sync PERL_EMBED_CCOPTS with perf
Date:   Fri, 11 Mar 2022 06:44:55 +0100
Message-Id: <20220311054455.5911-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to build perf with a LLVM/Clang toolchain people see errors
when testing for libperl feature.

Jiri reports:

> I'm getting some other lto related error:
>
>         $ cat test-libperl.make.output
>         clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
>

The reason is PERL_EMBED_CCOPTS is defined in two places:

tools/build/feature/Makefile
tools/perf/Makefile.config

As a result FLAGS_PERL_EMBED is set differently.

For building perf '-ffat-lto-objects' is filtered out:

$ git grep ffat-lto-objects tools/perf/
tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))

Sync PERL_EMBED_CCOPTS in tools/build/feature/Makefile to fix this.

For a minimal fix for Linux v5.17 this here was preferred by Arnaldo.

Link: https://lore.kernel.org/lkml/CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com/
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
Changes v1->v2:
- Fix some typos and use lore link as requested by Nick
- Add credits for Nick

 tools/build/feature/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1480910c792e..869073cf8449 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -218,6 +218,7 @@ PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
 PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
+PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
 FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
 $(OUTPUT)test-libperl.bin:
-- 
2.35.1

