Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2D58F49F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiHJXBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHJXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:01:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6216068D;
        Wed, 10 Aug 2022 16:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1904EB81ECC;
        Wed, 10 Aug 2022 23:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AABC433C1;
        Wed, 10 Aug 2022 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660172505;
        bh=NnDvxipWRWd22orltCAXMkg0yBGFjX0zipam7lQ+xZk=;
        h=From:To:Cc:Subject:Date:From;
        b=fQxNqwPVBp5/BwVHJmmCpTrKNt8De6t9ihL+6vUTvAmr8X94LXBb1Kr1ATSYdCpp7
         5795/Y/AupALDlYajNSBCEJsSYz44G3JlGqSkE0776U+lFbAj8TA3ooZwWD+rVEEiS
         41EueM3llhm6ZoHPJK3oG52p2khuVOlPNUbBfc8okBbFsOx6acrpuFhjiZwRrcibeX
         4B70Xbe5flokCaxsL5cjvTWEVP6BeDVQaKNsEaVhegJ1ZeUq3ROqnTzpIeCRggwD9d
         oxYKF60xbEmGx/vyc1ER0LVhwdIdJBJ30ljgMYcSyhxcktgoE1hlEKfX+X+0RryuBG
         F2DQuYibHMKPA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] scripts/Makefile.extrawarn: Do not disable clang's -Wformat-zero-length
Date:   Wed, 10 Aug 2022 16:01:33 -0700
Message-Id: <20220810230133.1895778-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no instances of this warning in the tree across several
difference architectures and configurations. This was added by
commit 26ea6bb1fef0 ("kbuild, LLVMLinux: Supress warnings unless W=1-3")
back in 2014, where it might have been necessary, but there are no
instances of it now so stop disabling it to increase warning coverage
for clang.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 9bbaf7112a9b..69cec45c4e71 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -48,7 +48,6 @@ else
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
 KBUILD_CFLAGS += -Wno-sign-compare
-KBUILD_CFLAGS += -Wno-format-zero-length
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)

base-commit: aeb6e6ac18c73ec287b3b1e2c913520699358c13
-- 
2.37.1

