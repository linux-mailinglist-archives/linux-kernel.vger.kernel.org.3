Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19F4D23B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350533AbiCHV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350520AbiCHV6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:58:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89656C3B;
        Tue,  8 Mar 2022 13:57:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79442B81DFE;
        Tue,  8 Mar 2022 21:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B2AC340EC;
        Tue,  8 Mar 2022 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646776629;
        bh=eGD/su/n2B61nqlOmpuFpZhwnQeDphrdFbvHLaijoSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7OJ9Rf2Y+g8br7xVIjyOlcfvW8+SyMmqJCm6j/ZXEEyA4S+LY+3b8r4799BuOLYk
         TLWFQ5r2ZbzLJTRSMjAzXn/8CWEfEfz1etzwIxlED128hvB271uttJhrCazgihEbWI
         ZL1t0qMlBb2KK9yZ1W+SfHMT4ii+vS/0aMPrtuDh443A3/VIYXgiF7k4hXqJeKl8C9
         NIjUTtcubyLdk09OagrHy1D+bABzL0S6Jg3Seoq8jjBHPgnXrOeqAzoMcl/uKsiSOv
         th/iWa4NXq8H+a/FDexq0GqMBOEUlcUVL//Cz2ehBBxRMMuabOH5nsxZdwJ6hBII3t
         FbwQteQSri0DA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     alexs@kernel.org, arnd@arndb.de, arnd@kernel.org, dsterba@suse.com,
        elver@google.com, jani.nikula@intel.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        ndesaulniers@google.com, ojeda@kernel.org,
        torvalds@linux-foundation.org
Subject: [PATCH 4/4] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
Date:   Tue,  8 Mar 2022 22:56:15 +0100
Message-Id: <20220308215615.14183-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220308215615.14183-1-arnd@kernel.org>
References: <20220308215615.14183-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As we change the C language standard for the kernel from gnu89 to
gnu11, it makes sense to also update the version for user space
compilation.

Some users have older native compilers than what they use for
kernel builds, so I considered using gnu99 as the default version
for wider compatibility with gcc-4.6 and earlier.

However, testing with older compilers showed that we already require
HOSTCC version 5.1 as well because a lot of host tools include
linux/compiler.h that uses __has_attribute():

  CC      tools/objtool/exec-cmd.o
In file included from tools/include/linux/compiler_types.h:36:0,
                 from tools/include/linux/compiler.h:5,
                 from exec-cmd.c:2:
tools/include/linux/compiler-gcc.h:19:5: error: "__has_attribute" is not defined [-Werror=undef]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1ba8dc523952..e0b11ddd0760 100644
--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,7 @@ HOSTCXX	= g++
 endif
 
 KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-			 -O2 -fomit-frame-pointer -std=gnu89 \
+			 -O2 -fomit-frame-pointer -std=gnu11 \
 			 -Wdeclaration-after-statement
 KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
 KBUILD_USERLDFLAGS := $(USERLDFLAGS)
-- 
2.29.2

