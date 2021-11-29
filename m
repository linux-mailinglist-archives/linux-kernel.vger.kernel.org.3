Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147BD462234
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhK2U35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhK2UZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:25:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E827C0254FD;
        Mon, 29 Nov 2021 09:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05213B81261;
        Mon, 29 Nov 2021 17:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF54C53FD0;
        Mon, 29 Nov 2021 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638205281;
        bh=5lvhSd/r5Bz+9HqEC9NczjkzGVk2pSL4AVcx7svZ7Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvXcRnCIYhSoj4jJ4znxB57N5Y1WjY7FI0LEnnD0MzQBU6+PKQV+VjZocHm9vUlZR
         JyldbIHKDUgxbtIqxJWA0Q8MetGJfhQ0bbBmVD/CxwMUhkSL0w96dZSYhqh4+umk5d
         bYgvEZYYtWTXaXV/fQNoaddWFk3hIgkyozJPGP0LCDIIA0Xy7RP44HPFa+FqQKZ6X7
         33f4VqzkTnx2HLyhtp4I0vMQsD9jS7JUO3g+DOwSC8Nx/GGiiLhC2JDix73xFsLZFn
         HLZALfVERur0p1l3Bqp2sWr8UBgrdhBGiybdehFcgVCQwlCDSGw67PLjMhzaQtjJOm
         3zLSM5awteDsg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        kernelci@groups.io, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH RFC 3/6] arch/Kconfig: Remove CLANG_VERSION check in HAS_LTO_CLANG
Date:   Mon, 29 Nov 2021 09:58:00 -0700
Message-Id: <20211129165803.470795-4-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129165803.470795-1-nathan@kernel.org>
References: <20211129165803.470795-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum supported version of LLVM has been raised to 11.0.0, meaning
this check is always true, so it can be dropped.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d3c4ab249e9c..86e071f693ce 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -648,8 +648,7 @@ config ARCH_SUPPORTS_LTO_CLANG_THIN
 
 config HAS_LTO_CLANG
 	def_bool y
-	# Clang >= 11: https://github.com/ClangBuiltLinux/linux/issues/510
-	depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD && AS_IS_LLVM
+	depends on CC_IS_CLANG && LD_IS_LLD && AS_IS_LLVM
 	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
 	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
 	depends on ARCH_SUPPORTS_LTO_CLANG
-- 
2.34.1

