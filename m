Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C75A3D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH1J5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1J5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 05:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF355090
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 02:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4708D60FA0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C789C433D6;
        Sun, 28 Aug 2022 09:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661680628;
        bh=LlULD/IKynjpnLtSqXlGpYdUZVoQFXgtjS3/RSpKnMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8bo5YZVuhSDQnFndpW4iAzdcEMAVonsRehPOM8APZU70KhIk5ag74U515mXJa8/b
         S37xpSwEHmCoJt256XoXHz0K7Q0jtpmZaS4psVg4lrjVm5krHX1RrbkGzRu+hIOlHg
         uOOhfahroinEfwulmnCWcUksrD8gLpJ5xHITEkcDju5qcKMitrg7WYs+a+ihsrdz/u
         yXy90Hkfbjwb1TeONnRpuKhNTmMeLjv8DcrQ8T8nXHC6lj2cjs2JZQXC3k/180R75x
         1zpYYFF8d9VDY778nPUL+7MUdjiXcfyqCRSvQ5qWArW3tGl4TTM8tzknQO1QeRfYo9
         T9v+Ez9cSBUUw==
Received: by pali.im (Postfix)
        id A47937B3; Sun, 28 Aug 2022 11:57:05 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/boot: Don't always pass -mcpu=powerpc when building 32-bit uImage
Date:   Sun, 28 Aug 2022 11:56:59 +0200
Message-Id: <20220828095659.4061-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220820105200.30425-1-pali@kernel.org>
References: <20220820105200.30425-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When CONFIG_TARGET_CPU is specified then pass its value to the compiler
-mcpu option. This fixes following build error when building kernel with
powerpc e500 SPE capable cross compilers:

    BOOTAS  arch/powerpc/boot/crt0.o
  powerpc-linux-gnuspe-gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
  powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
  make[1]: *** [arch/powerpc/boot/Makefile:231: arch/powerpc/boot/crt0.o] Error 1

Similar change was already introduced for the main powerpc Makefile in
commit 446cda1b21d9 ("powerpc/32: Don't always pass -mcpu=powerpc to the
compiler").

Fixes: 40a75584e526 ("powerpc/boot: Build wrapper for an appropriate CPU")
Cc: stable@vger.kernel.org # 446cda1b21d9 ("powerpc/32: Don't always pass -mcpu=powerpc to the compiler")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index a9cd2ea4a861..1957a3de7a1c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -38,13 +38,19 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 $(LINUXINCLUDE)
 
 ifdef CONFIG_PPC64_BOOT_WRAPPER
-ifdef CONFIG_CPU_LITTLE_ENDIAN
-BOOTCFLAGS	+= -m64 -mcpu=powerpc64le
+BOOTCFLAGS	+= -m64
 else
-BOOTCFLAGS	+= -m64 -mcpu=powerpc64
+BOOTCFLAGS	+= -m32
 endif
+
+ifdef CONFIG_TARGET_CPU_BOOL
+BOOTCFLAGS	+= -mcpu=$(CONFIG_TARGET_CPU)
+else ifdef CONFIG_PPC64_BOOT_WRAPPER
+ifdef CONFIG_CPU_LITTLE_ENDIAN
+BOOTCFLAGS	+= -mcpu=powerpc64le
 else
-BOOTCFLAGS	+= -m32 -mcpu=powerpc
+BOOTCFLAGS	+= -mcpu=powerpc64
+endif
 endif
 
 BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
-- 
2.20.1

