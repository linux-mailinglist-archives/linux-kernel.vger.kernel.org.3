Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F14ED056
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351865AbiC3XsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351881AbiC3Xrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB962A38;
        Wed, 30 Mar 2022 16:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E703C61835;
        Wed, 30 Mar 2022 23:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30F2C340EC;
        Wed, 30 Mar 2022 23:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648683966;
        bh=uKYOWCNiJwOEjCoRKb6g6YV42LmzgDRTIg6qPpnEHkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3vHdiBi0jcpYheTDatiqR+gw+80pR/T/bIjzUWsbIFZfntE99R4wqw+EEkey6SLh
         eS/Rv6beB7qtmqyZIspDp/SaXLgZCKWuK5U48fuhITXQtARsGCjfOzfkfl9V2wIIp8
         fFROFTaPbz6m/pZaall+y5vz3kKlCc+OIDYFgxUtKmqyHlLW1XwEFNaM44q698VXVe
         nkXFaIqTJnmoNavy1ooUs/oXG899cpFcrn0Mei8mT8QUknWX0zA8lXW4y5DK242prO
         ZmVQVzyaeugF0wsxdMn9DCVfqvGl0mPOpA9iC8j6NT5nawL3yr2zMU5ytyml7l0P8B
         ItO1C8b5uu5yA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
Date:   Wed, 30 Mar 2022 16:45:27 -0700
Message-Id: <20220330234528.1426991-2-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330234528.1426991-1-nathan@kernel.org>
References: <20220330234528.1426991-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is specific to clang, where it is only used by the 32-bit and
64-bit ARM backends. In certain situations, the presence of this flag
will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
out -mno-global-merge from USER_CFLAGS").

Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
building kernel with Clang") that added this flag back in 2014, there
have been quite a few changes to the GlobalMerge pass in LLVM. Building
several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
(minimum) and 15 (current main version) with this flag removed (i.e.,
with the default of '-mglobal-merge') reveals no modpost warnings, so it
is likely that the issue noted in the comment is no longer relevant due
to changes in LLVM or modpost, meaning this flag can be removed.

If any new warnings show up that are a result of the removal of this
flag, it can be added back under arch/arm{,64}/Makefile to avoid
warnings on other architectures.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Makefile b/Makefile
index daeb5c88b50b..f2723d9bfca4 100644
--- a/Makefile
+++ b/Makefile
@@ -784,10 +784,6 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
 # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
-# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-# source of a reference will be _MergedGlobals and not on of the whitelisted names.
-# See modpost pattern 2
-KBUILD_CFLAGS += -mno-global-merge
 else
 
 # gcc inanely warns about local variables called 'main'
-- 
2.35.1

