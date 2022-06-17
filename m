Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56B54F9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383045AbiFQPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383036AbiFQPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:09:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31BA35868;
        Fri, 17 Jun 2022 08:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF63B82ADA;
        Fri, 17 Jun 2022 15:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7D3C3411B;
        Fri, 17 Jun 2022 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655478569;
        bh=EqeIczttIjGDCNdZQIUDAQxE7sJSTKC4MZTUe2Cu0R0=;
        h=From:To:Cc:Subject:Date:From;
        b=tbu8deuodKH704UoDQYNcnzUbyUqxZkBljz7YZdlHTo7HTHCmlvghDrQazQsN4h35
         FVG8VGGpbjCbQXdjC+a3mMY/gMtf1i61gKVDlgUfTUkVHTsKfI/k5k1jkoPvjKzqBs
         qa4rHugmyoOBDgZ8l+pgxKWkUIaFpSnvnJiYjVGgShCN3ICSXiJ58126+uos465Bvd
         kKc8YF3pp12EQgt2QI2RVGA7h0ahT/goQdSjrrTcDfJ4GSlvFPQDbRgeeCPAdvBIk+
         grj8+IP5LXkLOPe3RG+iY0XVfee3+BC0iaW0c9P+R2ddYpJ/XuGjNJ531AZLN/Ct6E
         La1uyAOzWiO2w==
From:   Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] Kbuild: change CONFIG_FRAME_WARN for 32-bit
Date:   Fri, 17 Jun 2022 17:08:53 +0200
Message-Id: <20220617150922.1878926-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The introduction of CONFIG_GCC_PLUGIN_LATENT_ENTROPY raised the
warning limit for 32-bit architectures to a much higher value in
2016. Initially this had no effect for Arm machines as their kernels
tend to be cross-compiled, and the feature detection for the plugin did
not work with common cross compilers.

I could not find the original regression report that led to the warning
limit getting raised, but I have been unable to reproduce this with gcc-12
and linux-5.18 -- all frame sizes appear to be be below the normal 1024
byte limit on at least arm32 and i386.

However, the KASAN feature introduced later on does raise the frame size
of a number of functions above the warning limit, in almost all cases to
somewhere below 1280 bytes. The effect is that an arm allmodconfig build
produces no warnings because of the check for the latent entropy plugin,
but a normal KASAN based build with gcc does produce build warnings or
failures when CONFIG_WERROR is set.

The 1280 byte limit is an arbitrary choice here, as it disables almost
all warnings but leaves a few outliers that are probably better addressed
with code changes. There are a number of functions that are just below the
normal 1024 byte limit at the moment, and an extra 256 bytes for those
is within the expectation, but more than that is probably an indication
of a bad design or a real bug.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3da5f9acb966..8a3afd837e99 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -387,9 +387,9 @@ endif # DEBUG_INFO
 config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
-	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 2048 if PARISC
 	default 1536 if (!64BIT && XTENSA)
+	default 1280 if (!64BIT && KASAN_STACK)
 	default 1024 if !64BIT
 	default 2048 if 64BIT
 	help
-- 
2.29.2

