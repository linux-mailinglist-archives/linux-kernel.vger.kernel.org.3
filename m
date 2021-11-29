Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB83461C69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347776AbhK2RGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:06:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51340 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbhK2REp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:04:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4EF615DB;
        Mon, 29 Nov 2021 17:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0556DC53FAD;
        Mon, 29 Nov 2021 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638205286;
        bh=/ne/8eGyexnTy3fVEdgXTWHbbDJWeY1a8AfrF7JW03A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEwF2HlXXPHDI2XBPajQ05jmYJQIZtedisnlUB6jFQYUyg+AlxM1pUf2mwlIXlVsN
         4bR0M84eNAnSXgDi+WzFWxWeNc1JBwL5Vr5X9GUvsFxbU/qHDS0xZL8FhkCVA7iZfU
         URLCLZfSUeF2aG81yx0Ep5+VWz4kdyPfPnAh20TVDJ829Mnryy3qUhMzJUd/xzFooE
         HgM0Zna7pG4CRIu759uwsNMjgy1NzTo65DHzhZ2aln/qrJOVyietia1v2YcCr6PboQ
         YKzTT+4mTKVZbirvzUGeFlLAL7tva9JE0AvsIzFXTNC+rNY768OihMjElULHm1G9u8
         A2cpZ+2yrBeGQ==
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
Subject: [PATCH RFC 4/6] Revert "ARM: 9070/1: Make UNWINDER_ARM depend on ld.bfd or ld.lld 11.0.0+"
Date:   Mon, 29 Nov 2021 09:58:01 -0700
Message-Id: <20211129165803.470795-5-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129165803.470795-1-nathan@kernel.org>
References: <20211129165803.470795-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7411cfc3c91a08a884463bbc7623087ecc2efdd8.

The minimum supported version of LLVM has been raised to 11.0.0, meaning
this check is always true, so it can be dropped.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Kconfig.debug | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 98436702e0c7..cd2d74b625c1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -66,8 +66,6 @@ config UNWINDER_FRAME_POINTER
 config UNWINDER_ARM
 	bool "ARM EABI stack unwinder"
 	depends on AEABI && !FUNCTION_GRAPH_TRACER
-	# https://github.com/ClangBuiltLinux/linux/issues/732
-	depends on !LD_IS_LLD || LLD_VERSION >= 110000
 	select ARM_UNWIND
 	help
 	  This option enables stack unwinding support in the kernel
-- 
2.34.1

