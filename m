Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3E59A622
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbiHSTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349429AbiHSTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8411233F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACE2AB82894
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38254C433C1;
        Fri, 19 Aug 2022 19:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936623;
        bh=FunJVKQSfy3ipKaxhp/fmwSG564pofyswuXNHKDIGX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBqtss7lMKUrZnALSK7L1enBXFMdQzo+Ne+N2zmcqN5b68LDIZxPRVJ5xwoP8vowR
         9dzWlCg89mxHbXdnxU+593VLBFP5eug5fc5imlCM1jSNIs25X/tugUSRFOupt6DTbe
         gu7n9Y9E8xKwxwbIfTxfrt26B1o53eMWhIZ3DihnUaCGzhmL0ik6FviGE4vQ4KIKAf
         ijsoc9oOJU28dRAunJgR/wsOeyxCXWlUoxYMXjZmonNQZE8OP+Pa6GeFqpQFenHFqH
         7QpXEZoVEJMC8qjWuJzFiodSZuvwjpYFHZnvH+Cbrzz2VOwMifrfQ78vKwtv/YNBrl
         7HW63a52i5jMw==
Received: by pali.im (Postfix)
        id E4DB1761; Fri, 19 Aug 2022 21:17:02 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] powerpc/85xx: p2020: Enable boards by new config option CONFIG_P2020
Date:   Fri, 19 Aug 2022 21:15:56 +0200
Message-Id: <20220819191557.28116-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819191557.28116-1-pali@kernel.org>
References: <20220819191557.28116-1-pali@kernel.org>
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

Generic unified P2020 machine description which supports all P2020-based
boards is now in separate file p2020.c. So create a separate config option
CONFIG_P2020 for it.

Previously machine descriptions for P2020 boards were enabled by
CONFIG_MPC85xx_DS or CONFIG_MPC85xx_RDB option. So set CONFIG_P2020 to be
enabled by default when one of those option is enabled.

This allows to compile support for P2020 boards without need to have
enabled support for older mpc85xx boards. And to compile kernel for old
mpc85xx boards without having enabled support for new P2020 boards.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/Kconfig  | 22 ++++++++++++++++++----
 arch/powerpc/platforms/85xx/Makefile |  3 +--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index be16eba0f704..2cb4e9248b42 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -78,16 +78,16 @@ config MPC8536_DS
 	  This option enables support for the MPC8536 DS board
 
 config MPC85xx_DS
-	bool "Freescale MPC8544 DS / MPC8572 DS / P2020 DS"
+	bool "Freescale MPC8544 DS / MPC8572 DS"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
-	  This option enables support for the MPC8544 DS, MPC8572 DS and P2020 DS boards
+	  This option enables support for the MPC8544 DS and MPC8572 DS boards
 
 config MPC85xx_RDB
-	bool "Freescale P102x MBG/UTM/RDB and P2020 RDB"
+	bool "Freescale P102x MBG/UTM/RDB"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
@@ -95,7 +95,21 @@ config MPC85xx_RDB
 	help
 	  This option enables support for the P1020 MBG PC, P1020 UTM PC,
 	  P1020 RDB PC, P1020 RDB PD, P1020 RDB, P1021 RDB PC, P1024 RDB,
-	  P1025 RDB, P2020 RDB and P2020 RDB PC boards
+	  and P1025 RDB boards
+
+config P2020
+	bool "Freescale P2020"
+	default y if MPC85xx_DS || MPC85xx_RDB
+	select DEFAULT_UIMAGE
+	select SWIOTLB
+	imply PPC_I8259
+	imply FSL_ULI1575 if PCI
+	help
+	  This option enables generic unified support for any board with the
+	  Freescale P2020 processor.
+
+	  For example: P2020 DS board, P2020 RDB board, P2020 RDB PC board or
+	  CZ.NIC Turris 1.x boards.
 
 config P1010_RDB
 	bool "Freescale P1010 RDB"
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 1ad261b4eeb6..021e168442d7 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -23,8 +23,7 @@ obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
 obj-$(CONFIG_P1023_RDB)   += p1023_rdb.o
-obj-$(CONFIG_MPC85xx_DS)  += p2020.o
-obj-$(CONFIG_MPC85xx_RDB) += p2020.o
+obj-$(CONFIG_P2020)       += p2020.o
 obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
 obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
 obj-$(CONFIG_FB_FSL_DIU)	+= t1042rdb_diu.o
-- 
2.20.1

