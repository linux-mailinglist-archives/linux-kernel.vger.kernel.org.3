Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E3461C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348906AbhK2RHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:07:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51378 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbhK2REu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:04:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E191615AF;
        Mon, 29 Nov 2021 17:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA77AC53FCD;
        Mon, 29 Nov 2021 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638205291;
        bh=FdV/usD8BxwWA8x2spGK1QnT2FPu5o73sRAP0FcjvFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCW/z4T36E+52UOJWvpOK9qwNgJkwkH9E+Gv2Xw16qeNzZiVO0nROkz+pYjrKklFH
         qZVM6WD87HHgh+8Tu72gEKmJ9GZNuZR59LSOhg1eo/fcQVqt5ekIw6BRT+FW7dwAR2
         Ju9eniTxxWOyv5cK2isnyxLBjx/QiWvLGKrhrekacWrnnVW3MqIICuKCGsZwji2wGC
         CXHl9qaFNat/HzWHmO5c3iiNkfgASTJ/1YMwAljORS4Bj6F/q3Cl9V27hRxyJkdLQh
         p+Q/FiXAlDAKsT+QLqKjrINkycH58o94ctzMI4BTZklx9oxzxtoJk1JmH4N7uUcCxp
         ibS/hraaEdMCQ==
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
Subject: [PATCH RFC 5/6] gcov: Remove compiler version check
Date:   Mon, 29 Nov 2021 09:58:02 -0700
Message-Id: <20211129165803.470795-6-nathan@kernel.org>
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
 kernel/gcov/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 053447183ac5..04f4ebdc3cf5 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,7 +4,6 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 110000
 	depends on !ARCH_WANTS_NO_INSTR || CC_HAS_NO_PROFILE_FN_ATTR
 	select CONSTRUCTORS
 	default n
-- 
2.34.1

