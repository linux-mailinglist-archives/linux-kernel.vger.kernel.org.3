Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6456CD99
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiGJHLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 03:11:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20606DEA1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 00:11:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so1795389ybq.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yAMjD7bFyIwsVP6jYrt8xQond+JqwS9zkIdAHuIkxN4=;
        b=liUn+rKXpXfrSoXvO27l9hLOj7oo5CX3m8yhnF3O8Uo0ba67YaoDhrup80Hbcz/pZt
         3kEuSGbXJ20Wjh0GYHTqFpZtKEZTJfIOo6ThgYoOEp2lTm2OD1kiiQOE5AlkPCIb7FhR
         Tgr1uBsd4QNXfMDjRN98RrNJXH2RxHP4DsVvOShzHxsugmZFmGMPWkmfqWEUF6RLrBlh
         cvl2b5KOOrsYKyDUTpPB8jei5OI4Mvz7jOa92WwuRm+EyFtKNtzWbal3Xi9gB2ZoXySc
         /UwtJaMhzidFnMAMzLeSU447Q7mJxgTTUU8bSkvqarH+A4jBk0DqFjmT0m4eHC3F5Kka
         kbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yAMjD7bFyIwsVP6jYrt8xQond+JqwS9zkIdAHuIkxN4=;
        b=1uXfxSt1b1NB0HGJgHISQhpOapwZ2Hb99ebIGjh7oZEFncOjMcvgJPvJiuQv5ORdcO
         +TqaxYaz1oycDtcsVNGdOSTSSmqIemoPT/KakZUogD60wia1182tMUFZKVScWuZl2iJg
         Jv1m8Dd/z3czC2aoYJjy9c08JQIIzba5QTMHt3UJihgiV0bpiKE0YPFTidBxvtGpsA3N
         ycL2WwZpyLgVcYnCvILjdPjNG/thEV8jJ484UPx3JPLUjWY3Hl58b5WSNdtyVNfOu/33
         j2E9P+0vNP/Y6brrCYXxtOn1zos2DZAwXVSgJwttc0zMWim63/8k1oXOL9fP+EYBWl+Q
         RLrA==
X-Gm-Message-State: AJIora8eY9b/pdq5+jK+5Epy+I9b0SRoWfgqlJxssvm7529PVsEWPhxb
        XOIsCwIhiw7nGk19sz6DIZJt+6NGw9zA
X-Google-Smtp-Source: AGRyM1uY19WwEDO1WCIR2j0jrtOz0gxs4GLwPuef+3yW0ZQEqrwPS8ucUN0ZHVTBtuSCTsnBGf4HM4ONI3cb
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:200:1844:d82b:e1a:5303])
 (user=maskray job=sendgmr) by 2002:a05:6902:706:b0:66e:ef10:1f7 with SMTP id
 k6-20020a056902070600b0066eef1001f7mr5952684ybt.610.1657437080152; Sun, 10
 Jul 2022 00:11:20 -0700 (PDT)
Date:   Sun, 10 Jul 2022 00:11:17 -0700
Message-Id: <20220710071117.446112-1-maskray@google.com>
Mime-Version: 1.0
Subject: [PATCH] riscv: Pass -mno-relax only on lld < 15.0.0
From:   Fangrui Song <maskray@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Khem Raj <raj.khem@gmail.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lld since
https://github.com/llvm/llvm-project/commit/6611d58f5bbcbec77262d392e2923e1d680f6985
(milestone: 15.0.0) has implemented some RISC-V linker relaxation.
-mno-relax is no longer needed in KBUILD_CFLAGS/KBUILD_AFLAGS to
suppress R_RISCV_ALIGN which older lld can not handle:

ld.lld: error: capability.c:(.fixup+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax but the .o is already compiled with -mno-relax

Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/riscv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 34cf8a598617..7e4ceb2a0981 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -37,6 +37,7 @@ else
 endif
 
 ifeq ($(CONFIG_LD_IS_LLD),y)
+ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
 	KBUILD_CFLAGS += -mno-relax
 	KBUILD_AFLAGS += -mno-relax
 ifndef CONFIG_AS_IS_LLVM
@@ -44,6 +45,7 @@ ifndef CONFIG_AS_IS_LLVM
 	KBUILD_AFLAGS += -Wa,-mno-relax
 endif
 endif
+endif
 
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-- 
2.37.0.144.g8ac04bfd2-goog

