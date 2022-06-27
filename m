Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703355DD95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiF0HCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiF0HCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:02:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CD5F85;
        Mon, 27 Jun 2022 00:02:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.45.206.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02B056601824;
        Mon, 27 Jun 2022 08:02:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656313356;
        bh=NkkjEoi7BGZXZx4C9tWVopSMwjLqJE9iVqgsolVJlSw=;
        h=From:To:Cc:Subject:Date:From;
        b=lKK4GWAkOcn735UQAKvXWrnaV0iS4KwEjAcKoYvhhXAyCVszdbqVNqzqagzj6t96Y
         ZhbM7BsvunS3+mIJRRg27KY8qsj3UxCGy36BxWB9xNfnCYFpGfGNQQxJOr0AVyXzMa
         eqBxqS897B3bVyjGj7zEEG+dse5/xwu9dIevruuaXdjaLCq3zTSXKreG/hJ7ydB3Yv
         j4u4I+gvf21bICypl0x+t3Q7KSc9p9MPHABJpWScWUeuH/jVYQu3iubmp4r2SVHz2o
         DQ4W0Jr1mWjGX7eN9f83S0lb0qH52g+bX5bTHs0uXe1Z22RiTXTFbVpMxwPJ3mYxE0
         0mvHNtZ2NMBtw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] kbuild: fix sub directory output build of kselftests
Date:   Mon, 27 Jun 2022 12:02:14 +0500
Message-Id: <20220627070214.432390-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build of kselftests fail if kernel's top most Makefile is used for
running or building kselftests with separate output directory which is
sub-directory. srctree is set to .. erroneously.

make kselftest-all O=/linux_mainline/build
Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory

make kselftest-all O=build
Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory

Fix this by comparing abs_srctree with CURDIR instead of abs_objtree.
CURDIR changes based on from where the command has been run and it sets
the srctree correctly.

Fixes: 25b146c5b8cee("kbuild: allow Kbuild to start from any directory")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V2:
- Correct the bugfix instead of workaround

V1: https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e66358b64ede..4090d7afcda4 100644
--- a/Makefile
+++ b/Makefile
@@ -238,12 +238,12 @@ ifeq ($(need-sub-make),)
 # so that IDEs/editors are able to understand relative filenames.
 MAKEFLAGS += --no-print-directory
 
-ifeq ($(abs_srctree),$(abs_objtree))
+ifeq ($(abs_srctree),$(CURDIR))
         # building in the source tree
         srctree := .
 	building_out_of_srctree :=
 else
-        ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
+        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
                 # building in a subdirectory of the source tree
                 srctree := ..
         else
-- 
2.30.2

