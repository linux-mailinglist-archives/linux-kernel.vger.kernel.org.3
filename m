Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E34B96B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiBQDhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:37:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBQDhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:37:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E51A4D53
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:36:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 7900E1F44EB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645069016;
        bh=iDLSpiQBEjHsZP331/5Du7RK3TpSCutWYVzHueSHCrM=;
        h=From:To:Cc:Subject:Date:From;
        b=C0wxkxG9k+G183vEGi0sDeMFPDJQiD8moZTKmWP3q81QWY2eQOE7s+3IKRXfGynKC
         +GO2uiWQlhcNGxt1AblhO3E2tpW9ijdwL1uIpSc1RHgNFVIdQDFR1y3m0FwwMGBzoo
         lapw6OHOMy5C+D0LhyHJN11gF9LGnKhbb0mtRLWh0pMUblN3qWmoOQKT1fC7KWn1dw
         LIqQuuv8dsi1INZ6hGj3jVWy+hyc7wL4mWhdNagBYd7rd8HfHr7Z49EtjCcNzAstx9
         KJ9ClT0Y73NY4QGf56CO8szDJwRxy8HXIXk6NjhA+nFvyYDvT9AGYQ7v7OQevE2At+
         S5yzioJgz3/bw==
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Manoj Gupta <manojgupta@chromium.com>
Subject: [PATCH] tools: fix unavoidable GCC call in Clang builds
Date:   Thu, 17 Feb 2022 05:36:48 +0200
Message-Id: <20220217033648.1453303-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ChromeOS and Gentoo we catch any unwanted mixed Clang/LLVM
and GCC/binutils usage via toolchain wrappers which fail builds.
This has revealed that GCC is called unconditionally in Clang
configured builds to populate GCC_TOOLCHAIN_DIR.

Allow overriding the variable to avoid the GCC call - in our
case we can set GCC_TOOLCHAIN_DIR directly in the ebuild recipe.

Suggested-by: Manoj Gupta <manojgupta@chromium.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 tools/scripts/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 79d102304470..98c098c064dd 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -90,7 +90,7 @@ EXTRA_WARNINGS += -Wstrict-aliasing=3
 
 else ifneq ($(CROSS_COMPILE),)
 CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
+GCC_TOOLCHAIN_DIR ?= $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
 ifneq ($(GCC_TOOLCHAIN_DIR),)
 CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
 CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
-- 
2.35.0

