Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C25A71E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiH3XeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiH3Xda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFEEA287F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-336c3b72da5so189025527b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=JGJThSQrG14h993s8rjwM8jNb3CuBSnZl7zjhnevu+g=;
        b=DOh9amPi8sdlIOf+BiQAcIL4C8dBW/B9BWrb3DDZwGjZRuBGPkwG8kg8wpUGEynqN4
         HbwlJ211/vN250153b8eTEEz+hJGiHPIdyx8Zz5WSB/eRxv4x+R8c6xaiPurZnqHBUe3
         7eUibXAR1rL0QJGQFURQEgHMRLr+JSZOLcNBOIXbJOXcNuGf4he8R/RcghJuPZwG87Gp
         L+pDTBkMbM7mIefPA4Unu/iXF4eeVd9tDHBc5q6aRSwecfYH2copC/6dCggsaXuVuvUw
         fzuv78FCYDYsach0a90W8IsCcCNCzrOKyw5GIQzwfi8hwWvxOfgq6EoJfTjPWYbOy/X8
         OGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=JGJThSQrG14h993s8rjwM8jNb3CuBSnZl7zjhnevu+g=;
        b=r2Zl8lWmS5bjHn8OzHgkjyQDaHfuK2jKuwcntE/iq/leIR3VrI4C7852e7ZXkOwPo8
         lknUeHMIkx4QwR7QuUCUaFEJGXJK6Aait1UMnNs432QZ8FfR69VXoTBMTKZgwALIE0Vx
         xljvwxba1+TXyiuzneXLVuoCIZ2Z1LgxU3n7fa/nY27tUMT5UcdOR6P8WnU0i7+zi7G4
         hkgPcpNpvCBAwFSU7wMHPCLmj71v/BgqXimhLWdpbin7ELO+G3qJDrL85eM21bts7crW
         +VFY7mqn8GIqPDTmcg9kZ97+Lx4TLA7xGMDY4RiZjIbrv4eyQTddZyRpMexXo7vC5+2R
         Hdmw==
X-Gm-Message-State: ACgBeo3F4ZiBEDrIpekFTQlonzpuVNrS8Ae/fOiWVV3QI3IvtfqWuX1O
        6HbTCGCs3vIzPPl8Y8vuu8H386lheN5F2sx/ii3M5AMRxiioucCnB/gzOrlGqxqEGT/5T7c7aWe
        raNqHnLriJLxznUrQRRhS/4EvD5hKa6rdIotD5KlEFmXEclZsoEmb/SJtmqHx1DRx3DXpMSh60H
        DQsC2Pbw3wrw==
X-Google-Smtp-Source: AA6agR4PyO0IKBEZVO/AvffiR0akECN3URvghZTslxK3C371SGy+urp8y7XT0ytOb7JDjFdBCeYbfFF5vHW2XgdhiqQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:d34a:0:b0:31f:4467:4ae0 with SMTP
 id d10-20020a81d34a000000b0031f44674ae0mr15725365ywl.477.1661902348134; Tue,
 30 Aug 2022 16:32:28 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:28 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=samitolvanen@google.com;
 h=from:subject; bh=m63Aw2OCZubNDlnS2Bm9+IxQqtHz35eVVBHmUgLi/wI=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3PBebzwTJ+52Sw6ogCU/KIG0JsWDvzXb2RlSP7
 p3Tx7bKJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzwAKCRBMtfaEi7xW7gtjC/
 46Gj3n4xq2s5nOkzOlhRg6U2y6bfUnt9ieyOLUS5LwZTt+4P1YtZ1bAy7fXQjlY5N5Jru8Wxiou2NQ
 XkZHG3/eLGFq67shCldfkkdKJuw3zTrocl0l0U3bI95JISYisD70CC/v6rHsGqKjP/uSRXNRP30aAm
 8suLZ5bim00kqnPRf6F4sy1mk6/W6hXGgUi6oz2niBNwvb3cYpY3LEd4WZl8pIbELZtdYdrW7jGWrG
 jGzA1gDMc6M1m0iQyrWFLfMS8Z/Ox52XdhaR+isbHp7AtJxqO0qbN9Fh/L6E3lJiJiGcQgwAhgGfYw
 OElKjGI/zYiSnKS1XqBhHYQ44Sy0ZrW3vzzzSSERj0TNDSVk87P9KWRlJ2zsEDrD4S3t8So/m9NEcP
 4nl6pCyebjHvO7PMvnuJ5Ds/WxR8rqm5SuxbPGbmdyvl6F+LZ7o+EKzgevJrNFIW3c7+8RRcbkr+OL
 PaYZxJCu03C4/PK10hnG4Dww9r1ervjssX1vNaeEtQoUw=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 20/21] x86/purgatory: Disable CFI
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 31c634a22818..58a200dc762d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.37.2.672.g94769d06f0-goog

