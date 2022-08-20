Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424359AD4C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbiHTKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHTKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4022B12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D1B61134
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 10:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00753C433D6;
        Sat, 20 Aug 2022 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660992766;
        bh=kjl8KFfWfLt1gRh1KXUyvdPAfOQf/V79CB8AnlsUiX8=;
        h=From:To:Cc:Subject:Date:From;
        b=AVYVU8HhkItCb7pSBIgp8UVduS0OM7h107GiQgb0SgQTADOiV1nSh7D1HRy0+MsLT
         WsK4uhjLiRDtN/66bu2EVxk0R+NJXwrCENHGE4cQXnnjpJGPPkH6Ayi4VBIPMlpH9y
         yIrv9SbVIAlevhJwCIFd+pEKfIrMoCCIfLbeIl7JEYtprBO77NNEJVNZsugJOXgyNN
         r98HNcw277u9R58JGMb/Fh4DzUnMelAW46YLyW2cf/eUJMlcZ0H8O4DaM5LChnpF2O
         i2H7vUt/XLJ0eThr+zMcVFFg2O58gQ11W07vpHY02mzmqlcUQoEDA5twO09Tm/eOzZ
         H6T5/uR6MQ6ow==
Received: by pali.im (Postfix)
        id 067B15D0; Sat, 20 Aug 2022 12:52:42 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Fix compilation of uImage for e500 platforms
Date:   Sat, 20 Aug 2022 12:52:00 +0200
Message-Id: <20220820105200.30425-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Commit 40a75584e526 ("powerpc/boot: Build wrapper for an appropriate CPU")
broke compilation of uImage target for mpc85xx platforms by powerpc e500
SPE capable cross compilers. After that commit build process throws error:

    BOOTAS  arch/powerpc/boot/crt0.o
  powerpc-linux-gnuspe-gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
  powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
  make[1]: *** [arch/powerpc/boot/Makefile:231: arch/powerpc/boot/crt0.o] Error 1

Fix this issue by checking for CONFIG_PPC_E500MC / CONFIG_E500 options and
applying appropriate -mcpu options for building uImage boot code.

Fixes: 40a75584e526 ("powerpc/boot: Build wrapper for an appropriate CPU")
Cc: stable@vger.kernel.org
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index a9cd2ea4a861..d7cf5d87e4bc 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -44,8 +44,14 @@ else
 BOOTCFLAGS	+= -m64 -mcpu=powerpc64
 endif
 else
+ifdef CONFIG_PPC_E500MC
+BOOTCFLAGS	+= -m32 $(call cc-option,-mcpu=e500mc,-mcpu=powerpc)
+else ifdef CONFIG_E500
+BOOTCFLAGS	+= -m32 $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
+else
 BOOTCFLAGS	+= -m32 -mcpu=powerpc
 endif
+endif
 
 BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
 
-- 
2.20.1

