Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E34D410E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiCJGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiCJGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:20:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED2122F60
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:19:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso3830764wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 22:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hK3i648v5ZRE0u4MjHqsn4u0/9AEYQ3KjKpmR6d4Ca0=;
        b=eUg52CM/HBJNtxq0M1QzN9jctEijngYy/DGxazUSwGYjQLaztjTRMRPQ08epOUfXXs
         0mTlYilpJoocy1Wm1VANEm4yUAzCNM9r62S2NjZIdUD9e19QyJPmZonkEusTOUkmAlla
         UDN13lgOoDDH73/fsmalKiVA04Ljf20quSR5dzc8S3XhXi3/BCxaXxJRgW6kunZJYJBT
         sb68giQPubBxPk3wbbV59pos62YZvTKz/Ll3jXqfZl59yxtnF5pjp9fl4M81J61YGUb8
         E3zH4d45lFJvdfneB/WnRH+UtsNDEju6WlkwPaI3oAi6ERxC3SLe+sBYlIsDa21MjK4m
         SegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hK3i648v5ZRE0u4MjHqsn4u0/9AEYQ3KjKpmR6d4Ca0=;
        b=ixA5u9Ab+5IOD2zKc/q6PhoCinmw1hqr5rzGhF8G7kQlvHw/mirGzcperjEcjoADPS
         Xlc38RX8A5xQB4W0DEP13Y8th+ehMgWlPN/w6Z2iIUDh6GiZHuA/qM+eidWTwKYFkplg
         QdhAULlxTL/zA6AdTqMdeESdQrmy+MxTML0idzFTYk56wsI8QMfllk5Teju2adJMhJgz
         uAaooXd7MrV+w/t5i9Z3O47EzmecQd1lpRcMTxAinAHcrw078oPKTfIK3NqcAMCx5pCd
         VnxPWmBtG2w3d2BXlQxBkwR6sUF9V2EY6xY6HaoQqV5Kl2/qPjU72DorqF+eu4vvENrH
         D9Tw==
X-Gm-Message-State: AOAM533y5gPlhmY7Aiev9DsnOb8vjdVa+/AA5+u3rdjAtfBSFk5AawMx
        VEMD9riolcnpT0SGw+We3J30TaqRUk5KNLeE
X-Google-Smtp-Source: ABdhPJxAhcjgVxeXrz8BV8hZBn7P/icuke3Yd8rG4bfw9T/tQdwR3SThnGaU84eW4VlPqRYtYsfp5Q==
X-Received: by 2002:a05:600c:214a:b0:385:9c42:848 with SMTP id v10-20020a05600c214a00b003859c420848mr2227655wml.176.1646893159959;
        Wed, 09 Mar 2022 22:19:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:40a:e40c:8335:59f7:b7d4:4936])
        by smtp.gmail.com with ESMTPSA id l10-20020a056000022a00b001f017dfb5cdsm4415885wrz.90.2022.03.09.22.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 22:19:19 -0800 (PST)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, John Keeping <john@metanate.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: [PATCH] tools: feature/test-libperl.c: Sync PERL_EMBED_CCOPTS with perf
Date:   Thu, 10 Mar 2022 07:19:09 +0100
Message-Id: <20220310061909.20166-1-sedat.dilek@gmail.com>
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

As an result FLAGS_PERL_EMBED is set differently.

For building perf '-ffat-lto-objects' is filtered-out:

$ git grep ffat-lto-objects tools/perf/
tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))

Sync PERL_EMBED_CCOPTS in tools/build/feature/Makefile to fix this.

For a minimal fix for Linux v5.17 this here was preferred by Arnaldo.

Link: https://marc.info/?t=164646683300002&r=1&w=2
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
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

