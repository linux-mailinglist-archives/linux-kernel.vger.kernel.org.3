Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD54ED055
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351877AbiC3XsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351885AbiC3Xry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5126AF1;
        Wed, 30 Mar 2022 16:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB6161835;
        Wed, 30 Mar 2022 23:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90909C340F3;
        Wed, 30 Mar 2022 23:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648683968;
        bh=GgLh9GaXBFfzZFvigI/FoQkf3w02HRSkun2SLU+RGKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOLS35aUbOhsV8s0ZpKxFUrs8U+D1Hh4dgnhfk3eufxMR5GOnL0m8sNkoUExtfZpZ
         QXKOyJGaa0Ni2jFx6uH/hDmbzujyhPdi7CSZ5rc3X55EuMXIitMZDo9eELAvYbw7v5
         ItxhzHRnWaEB4TjILQhK/bBc1AuuUq6OU53og5uQ52cjVlb31tO2pvr0DIQNplJSz2
         xMihUHpU9ldtX7V91wFu9BqLYGjEJ+8uiTyigeix4zPJ+FQ4PUsqPDn/4GqWi3QOfk
         f3iLZXjvlrD3MYFVlCHjUUJDL45Z+1vGc5N3UIUTs7iLVWMFFtZ/9C6v2pJ8KZtTx+
         zpaY4C11rSbuw==
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
Subject: [PATCH 2/2] Revert "um: clang: Strip out -mno-global-merge from USER_CFLAGS"
Date:   Wed, 30 Mar 2022 16:45:28 -0700
Message-Id: <20220330234528.1426991-3-nathan@kernel.org>
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

This reverts commit 6580c5c18fb3df2b11c5e0452372f815deeff895.

This patch is buggy, as noted in the patch linked below. The root cause
has been solved by removing '-mno-global-merge' for the entire kernel.

Link: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 320b09cd513c..f2fe63bfd819 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -75,10 +75,6 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
-ifdef CONFIG_CC_IS_CLANG
-USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
-endif
-
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
-- 
2.35.1

