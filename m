Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AEE526B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384295AbiEMUXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384245AbiEMUWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428B15E61F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 9-20020a250909000000b006484b89c979so8125313ybj.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sN1MQIdlcLov8VgTjyWeulzGcdWJ7BEX/VgFu9sqEms=;
        b=NDN+pnJemIaCSxm+K2o9kM8xoxP4AQp7FKNhm67B5YN9f5EDBtjQNKeP31f39bv4/X
         u7Sta5zaVqNE8LpDfbgbrzZSc89IJTRdfylKuFMkp86I7w1oQQ7UKjoL47AzIJGV2wY4
         9LsNi1Ao6snjicLqufdQjigC9QuO4Lj+vJJw7hg8/6NkaOuIZDEnaS2id6So0DG0ta2C
         SvvhUKEOlmhey8NHV9HehLbFjkcnVEoZHby8OxicoYYxpFyzgd1HR0qIC2KTzvXjto4r
         dZJbPHQ/lkgGGEiIG2FhPu3ibzslDXp4HRuIKvuvNFZvOS/+/U8h2BmuRQ7EWpXo/BrE
         bNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sN1MQIdlcLov8VgTjyWeulzGcdWJ7BEX/VgFu9sqEms=;
        b=z/VdLY1+CJgmdjbKOY3Ql2TIuquasCVNRUWdXNzoUgazFi5JfCdnw1trHm9IxW4gnn
         x5Qqgx4T0q0sUODa/OEfcB/PuQNbdj5jnrEmsFlFSFEwTQCI9r6a97Ys7iNcxgVrrvjW
         6RPGawM2ZKmIhk/w0kWvPOmMby/65FmOjVCq61YGUGFd2iYPZjm6sEDuHcvbzvxL98iH
         NuSRpGqqUTcqZIFCkKNJ3iP0X+MJMwNsWwTRVkddGuHi4guqlW5/3AW2GJI/QqFmQ7DI
         1L/aiXpWkV73ex1P/TsFg4Vf0JV8EMaCPVDGkjHVd6DJcYNnxnF55sGC1DdHik+5tGkg
         DXHg==
X-Gm-Message-State: AOAM530SA2tmbypdmwhCjiUCHdECkOdFENokns8FKYgCpvDQCJktKaPQ
        4e4IdPhuAf5sXGWJdm8JKoSUrc/o4ewr4v/xI/HwNnSGukxZxVjMLvL8JcNAQZMgF4roZkgiKoS
        Hrohhrmp3AmOdkKpusHQZ12iRfbbrE+EVhHbHExRUwvi4uedzgnZwK3JfV8r+LgNVYZBvOn60Pc
        a6vqXH+JkGdQ==
X-Google-Smtp-Source: ABdhPJx5nJW+fLyEvpdIEtsWTO7Bccf8P7rQGyFfkNsIumtMA98HgpHClV78e0G6XQroqhr1CVABaVT70arCD7DKWJc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:3c4:b0:64b:9947:ae0c with
 SMTP id g4-20020a05690203c400b0064b9947ae0cmr4277666ybs.139.1652473365524;
 Fri, 13 May 2022 13:22:45 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:57 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; h=from:subject;
 bh=57qcu+U/ESwPOD6Y+SONkBgb7Co02QyfDr74Uk03b6A=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3l0ipJhNE6eoVPfJVHE9QVfJa5ZOmTd70bEYHX
 Y/YEamOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695QAKCRBMtfaEi7xW7uSFC/
 0ZKCyQe27MbqBSzxoH/uHRZkF/mRGq3PzbQqycBC63gV53AhsNrxa68cqQI/p9ZTMUlHpbuqgxceYo
 GjOUCTNfeFJQjNAvcAtAQ4FVHmv7MHC5RaI6Zkv+hnIWlXizBxMSPe2QPGCU44v2xkUx2bDxbItGGX
 HU4Yj5bSd0gZIL0BsXOTeqEWlBel1tof7WIru7x5Cc63rAUVarAFiecr4J5owvzEya+9gnBPxYDcra
 ay5jeQ/kViL1zXdWuWv/c8lO2bshaKGI+7byXNTzIm1NyKM1Bc34y+t7X9RVLcTWX6+AalxYela27+
 Cs7ndV9QgHxu5DDVyrwFBg79BVA2y34witGsut8PgrYolzywRZxaAJKu9U5O3U8UX9U83Kk8iiPCg7
 lnvfvJ+JEZUT2MG1p2X4EhWueUL2cbGs3eL+XCeAouQAA4iV2dYhb+hVPp2BwiDIf9yLF5O+QaFQHu
 MWoGpc8TGw8nfWrniueaU8rSDQl15j0/F9fJPb4Z8u43c=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 19/21] x86/vdso: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
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

CC_FLAGS_LTO no longer includes CC_FLAGS_CFI, so filter these flags
out as well.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 693f8b9031fb..abf41ef0f89e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -151,6 +151,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.36.0.550.gb090851708-goog

