Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0481D52B2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiERG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiERG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:57:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36713E3F;
        Tue, 17 May 2022 23:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A21F2B81E9F;
        Wed, 18 May 2022 06:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D319C385A5;
        Wed, 18 May 2022 06:56:53 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 3/3] m68knommu: fix 68000 CPU link with no platform selected
Date:   Wed, 18 May 2022 16:56:39 +1000
Message-Id: <20220518065639.2432213-4-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518065639.2432213-1-gerg@linux-m68k.org>
References: <20220518065639.2432213-1-gerg@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If building for a nommu m68k classic CPU and no platform (board) is
selected then the final link fails with:

     LD      vmlinux.o
   m68k-linux-ld: cannot find arch/m68k/kernel/head.o: No such file or directory
   make: *** [Makefile:1158: vmlinux] Error 1

Not selecting a platform is ok, that is a generic 68000 system build.
All of the platform selections are for 68328 variants.

The underlying problem is that the CPU config option (CONFIG_M68000)
ends up not being set, it is currently only selected by one of the
platform choices.

Change CONFIG_M68000 so that it is always enabled for the nommu m68k
classic configuration.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 16ea9a67723c..ed719a855e6a 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -37,7 +37,7 @@ endchoice
 if M68KCLASSIC
 
 config M68000
-	bool
+	def_bool y
 	depends on !MMU
 	select CPU_HAS_NO_BITFIELDS
 	select CPU_HAS_NO_CAS
-- 
2.25.1

