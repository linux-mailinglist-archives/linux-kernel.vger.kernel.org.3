Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C75A37F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiH0Njz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiH0Nju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:39:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF18C3D
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 06:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35394B80108
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 13:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E6CC433D6;
        Sat, 27 Aug 2022 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661607585;
        bh=WpVdubWclY2UMHlcAsADqLj3KpeQOgXN4jbUOblbBQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbnCrUrhQ7FWd0XKQtnR0RZ1wAKCkv9XM5JBDTtTJq6j1jcmGUkVTrrc3NKM3ZNKa
         Yhs2QadSfAP0ZnCrIPCR4G6kf84K9KhBv/d2bP3UZbz03Lke2mAAKcZmWa0iPKQBIk
         iv3BDBidEAjZPirYGZn0t+0Off0jJhUymt24PenMb+lsawQ1zZHaVqAMHcgoXsJcO2
         U+7cDY3SBtqs7qxA3IaP0O0e6+0fyqf0EiIilyQGwKgzLMlNOf6x0LEqDmUacY6/E1
         iLwcK40zDTueJuA0wsPR8kedQfWgbaO20IJtKPC/fTfSVcZojZTgB+dNRb50jwY3Rx
         wGTc20x1q2nMw==
Received: by pali.im (Postfix)
        id 1BDEEC7A; Sat, 27 Aug 2022 15:39:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/boot: Don't always pass -mcpu=powerpc when building 32-bit uImage
Date:   Sat, 27 Aug 2022 15:39:00 +0200
Message-Id: <20220827133900.16634-1-pali@kernel.org>
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

For 32-bit uImage try to use CONFIG_TARGET_CPU option for -mcpu. This fixes
following compiler error when building kernel with powerpc e500 SPE capable
cross compilers:

    BOOTAS  arch/powerpc/boot/crt0.o
  powerpc-linux-gnuspe-gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
  powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
  make[1]: *** [arch/powerpc/boot/Makefile:231: arch/powerpc/boot/crt0.o] Error 1

For 64-bit uImage and 64-bit kernels with 32-bit uImage wrapper there is no
change.

Similar change was already introduced for the main powerpc Makefile in
commit 446cda1b21d9 ("powerpc/32: Don't always pass -mcpu=powerpc to the
compiler").

Fixes: 40a75584e526 ("powerpc/boot: Build wrapper for an appropriate CPU")
Cc: stable@vger.kernel.org
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index a9cd2ea4a861..f56a5f90a5d8 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -44,8 +44,16 @@ else
 BOOTCFLAGS	+= -m64 -mcpu=powerpc64
 endif
 else
+ifdef CONFIG_PPC32
+ifdef CONFIG_TARGET_CPU_BOOL
+BOOTCFLAGS	+= -m32 -mcpu=$(CONFIG_TARGET_CPU)
+else
+BOOTCFLAGS	+= -m32 -mcpu=powerpc
+endif
+else
 BOOTCFLAGS	+= -m32 -mcpu=powerpc
 endif
+endif
 
 BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
 
-- 
2.20.1

