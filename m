Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE135756A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiGNU47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiGNU45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:56:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F396BC1D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:56:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i9-20020a258b09000000b0066efe437da6so2457244ybl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QUqpeU8M4eT15MSqD/BnartlfIY7kCYtJMFstSRxuF8=;
        b=NyEeYk2hC69eFMaSk0Josx4oxWR1Fw4LfEAYWwZxyp575imGZDYXhsKWYy50e9F+Bo
         YGPxB9QU2iqkEiA6h7gMhlOK8fFpLRXEijEBPs9FQPw7rG1KQvyXn4LMsrSlfjCrNlIl
         2xgTGZfmTH0qM41NM9B2AujqAAzkK5KughTx8Aaxh/IJ8kDoLigS5lb4bVYCEaHmjb0V
         y0HTyc71eCPL3GlhFvxZ5CvHY88UH3w9Lv4+lGItJEUhk/2QcAbUhJ2sex6rz5Q6oxgH
         ZqrqciQ8psIEwofly+ywHyNrweQKgL9dgQ7LRsKFe/wm2cHmJkhw/TQCRCSUYm49RrEQ
         M7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QUqpeU8M4eT15MSqD/BnartlfIY7kCYtJMFstSRxuF8=;
        b=tN/zCHorI8z/kjeoYpQeoeIxL/0x8sGJH95x4H7tcJeW1ey6MmzoxPOOEQkKl/KPYi
         vl9zWG7bp0feb462TPpTrb/HGmIPXC9B/wP6JGuFpEP27LoSHAKGdInXs6jfGCr3DjaH
         WSYlLIigyoFaRL/FjIPg5zwOQqUWbyDZ28R4YIfxpIkHcyuiQDXZHUSgr+dhcJz/XHJW
         C3nFnrYg6Ncoe+hD+Du86m+6Jx0w8Qb8FBDK8PzvntDJGZnRUkoSL7wOLqimmZMXZajm
         Nc3oWVn0EZ+UtUTu761d+zjR0PwsJ8684Nidz8TFfoNjWLVNexFkSIMgRyg/sJPKvM57
         17zg==
X-Gm-Message-State: AJIora9Ewi8Jc2DQClR+DlRjOolP+63UK/MI27NAS1L+efIhYB15SFAt
        0tVEIT5yR2cc39/j+0Qh0iGv5GKb2KsyKLxoMJo=
X-Google-Smtp-Source: AGRyM1vmKTM1FaMh8eU2urAb2+GraZv12lCqQp6YihgU9kbN0pGejEVllwkey8v+ez9pXys1HIiTU3tYEB6dltut3lA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:4bc2:7a2b:c53a:2dfb])
 (user=ndesaulniers job=sendgmr) by 2002:a81:4a0b:0:b0:31d:b645:84e8 with SMTP
 id x11-20020a814a0b000000b0031db64584e8mr12085251ywa.239.1657832216295; Thu,
 14 Jul 2022 13:56:56 -0700 (PDT)
Date:   Thu, 14 Jul 2022 13:56:43 -0700
Message-Id: <20220714205646.4023495-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657832203; l=1877;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=Y4sBF3AutOxiL+SHsVeEMPpQpIermTXH5kEyp1GPq6s=;
 b=xAaXgfs85FDQXD5OVaEIdThMCupKgeKa7r1xcwZp0TJeZ/wzFgnNld9VUOf2smHAxawT1Tl+RB0i
 41zv0RrbCoTKsJJu944BR/UI3/BuEGBX+ihO/SpLluzyQ46i8YUm
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

Building with UBSAN_DIV_ZERO with clang produces numerous fallthrough
warnings from objtool.

In the case of uncheck division, UBSAN_DIV_ZERO may introduce new
control flow to check for division by zero. Because the result of the
division is undefined, LLVM may optimize the control flow such that
after the call to __ubsan_handle_divrem_overflow doesn't matter. If
panic_on_warn was set, __ubsan_handle_divrem_overflow would panic. The
problem is is that panic_on_warn is run time configurable. If it's
disabled, then we cannot guarantee that we will be able to recover
safely.  Disable this config for clang until we can come up with a
solution in LLVM.

Link: https://github.com/ClangBuiltLinux/linux/issues/1657
Link: https://github.com/llvm/llvm-project/issues/56289
Link: https://lore.kernel.org/lkml/CAHk-=wj1qhf7y3VNACEexyp5EbkNpdcu_542k-xZpzmYLOjiCg@mail.gmail.com/
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Linus,
I still think we should add explicit checks to gaurd against divide by
zero.

 lib/Kconfig.ubsan | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index a9f7eb047768..fd15230a703b 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -84,6 +84,9 @@ config UBSAN_SHIFT
 config UBSAN_DIV_ZERO
 	bool "Perform checking for integer divide-by-zero"
 	depends on $(cc-option,-fsanitize=integer-divide-by-zero)
+	# https://github.com/ClangBuiltLinux/linux/issues/1657
+	# https://github.com/llvm/llvm-project/issues/56289
+	depends on !CC_IS_CLANG
 	help
 	  This option enables -fsanitize=integer-divide-by-zero which checks
 	  for integer division by zero. This is effectively redundant with the
-- 
2.37.0.170.g444d1eabd0-goog

