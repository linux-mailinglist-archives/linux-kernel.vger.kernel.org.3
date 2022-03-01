Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6651E4C8E50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiCAOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiCAOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:53:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26EF483BC;
        Tue,  1 Mar 2022 06:52:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76EC36159D;
        Tue,  1 Mar 2022 14:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC19EC340F2;
        Tue,  1 Mar 2022 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646146371;
        bh=LfiWmfs6qErICD+TfIJqX84uNv2I/FQMxqCURJD4QRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oj5yynkamny/AtSQRD5xLhnAE4W3TodX8euUSgx+w4IDEx9hwirHYK/YzcWwlAiKe
         Mg3CZZjAlee0DdCyh69ulex4StSRHfMowWaXSiygI/D7T3pAtRjY/7TduakOK2tRp0
         ruh5tHf11STcPDIDu7/jTpRxTT5Ep9eXIh3KpArhOdIc5KNHgjEgBMUVOZccPOHz8d
         SKWzudpfx2tkaCKiX3qXiLE+5BEHg+bZoUdHwM9tmQhSEHDsr0peusS2SV76uDkNwp
         mOBX1cTcDDulQKZqtFCr+w47Nq6KtbMZwHVWg9lzZJrJ/gDP0JG4lL2HDvHsc8Pxnx
         14M0Azozwf7pw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
Date:   Tue,  1 Mar 2022 15:52:33 +0100
Message-Id: <20220301145233.3689119-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220301145233.3689119-1-arnd@kernel.org>
References: <20220301145233.3689119-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 37ef6a555dcd..7c9be7f1ccd4 100644
--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,7 @@ HOSTCXX	= g++
 endif
 
 export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-			    -O2 -fomit-frame-pointer -std=gnu89 \
+			    -O2 -fomit-frame-pointer -std=gnu11 \
 			    -Wdeclaration-after-statement
 export KBUILD_USERLDFLAGS :=
 
-- 
2.29.2

