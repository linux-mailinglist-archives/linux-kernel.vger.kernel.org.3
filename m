Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A7529299
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349376AbiEPVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349058AbiEPVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:15:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7317E17
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d188-20020a25cdc5000000b00648429e5ab9so14101407ybf.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gJH2vNlNQIo9Al56TVOkq6UollYkHvbAT4XCJVkzPlo=;
        b=q8K57O1NPaavHFGg8uevoHd8vdNfGOvgh5pa5KLXfjH6qslBYym5QnuEHVweXdP12g
         z6txr4GPWzThnSCbUR1Orzix+VGdmbg0HPNmI2AuqbeGHQX7Z0AkjtITu67cNr1l+0jC
         XkhOp95c5xWDmHOByjvnElyeG9S5e4uHfneDqEY8KNrD3QDyEZE34jzN/5MiJxTf+Qmb
         7NulqRHaMKEATCJL4wIHfiBsXD7osQCwMOrqbtPOK2maO8352MdpFqyf8uLLu9iYXjAC
         YsKgZ+iz4mWWqQfSBbQH8PkBBmd1FA0Xgc5Se+YF86Ca9/poFTbVnlz1hqbkifIXWyr0
         rVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gJH2vNlNQIo9Al56TVOkq6UollYkHvbAT4XCJVkzPlo=;
        b=118Hw8Grkh7twK7B15oRtS81DxYK479WvN8JXHHJoV6bXELDRKNQEyHrg95G616Np4
         X9myAEvL/vH6rCp/8QezPYEyly55Gajq66Acb3wu13cG5oyiYCJj5UWJ6AKNmZgWeUAM
         05FssSFl67bmONJLsOkr5Ak4ui9UdgmJ5g2eNYt4vk4jJpMYRw9qiStXwAmbzVkn/v7C
         axI7gtSHE8Kja46HN8wFV2Ic8DeCznMyGfffJjyYOuk9pO3XmXWdKXZa3w0nvZD1z54n
         Ax9ZjCrvp9oB5vRaWPtBWCwKG4N55QmknAaJXxeIj1SH+cahXuSK0zlJ7HDEV+yKQwaW
         uPRg==
X-Gm-Message-State: AOAM530G5nj0W/I4oR359YoN21YiAPqUrbJE9tXM49F2Ftu7umfZqIvQ
        cR7PL8kGP4kERxF4BWVEe9V1Mj3ohixCqHNqb08=
X-Google-Smtp-Source: ABdhPJyCTvkarlEdqOvsqNv4kNm1LQOPAQvPW5Wh+33cc828J7QmhJc760oZpsnGrmxMB0MDS1kB3BoYZFYpEhJuP8U=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2ef0:b8de:b9c8:da45])
 (user=ndesaulniers job=sendgmr) by 2002:a25:54c:0:b0:64d:69bb:e090 with SMTP
 id 73-20020a25054c000000b0064d69bbe090mr12087349ybf.429.1652735409881; Mon,
 16 May 2022 14:10:09 -0700 (PDT)
Date:   Mon, 16 May 2022 14:09:53 -0700
In-Reply-To: <20220516210954.1660716-1-ndesaulniers@google.com>
Message-Id: <20220516210954.1660716-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220516210954.1660716-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652735394; l=938; s=20211004;
 h=from:subject; bh=T9BSmoUTZZ/l/4cKzU/17oPppOyCGzetEds5NOZIrWQ=;
 b=8FrOhkyvfC7vArFsPvAnd24amfcR4JlfF0QbPfyYrJ5dNOBuwKcXRFBPcYEjIvovyC8NaU6XW8kg
 0rstkQerBW6KdT7Rc+cTUyjdSir5seoBM0spKRrjhKOvZ+34H6kG
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 3/4] ARM: only use -mtp=cp15 for the compiler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ard@google.com,
        Biesheuvel@google.com
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
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

Avoids an error from the assembler for CONFIG_THUMB2 kernels:

clang-15: error: hardware TLS register is not supported for the thumbv4t
sub-architecture

This flag only makes sense to pass to the compiler, not the assembler.

Perhaps CFLAGS_ABI can be renamed to CPPFLAGS_ABI to reflect that they
will be passed to both the compiler and assembler for sources that
require pre-processing.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 99a7ed7e9f09..1029c2503aef 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -108,7 +108,7 @@ CFLAGS_ABI	+= -meabi gnu
 endif
 
 ifeq ($(CONFIG_CURRENT_POINTER_IN_TPIDRURO),y)
-CFLAGS_ABI	+= -mtp=cp15
+KBUILD_CFLAGS	+= -mtp=cp15
 endif
 
 # Accept old syntax despite ".syntax unified"
-- 
2.36.0.550.gb090851708-goog

