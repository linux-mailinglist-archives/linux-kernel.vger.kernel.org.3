Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834BA4BCA7D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiBSTg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 14:36:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBSTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 14:36:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186951B5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 11:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D9C60EA5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 19:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F872C004E1;
        Sat, 19 Feb 2022 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645299366;
        bh=MWwZOSqZ7f5adLPO0YY0SGSCohCq0Qr7LrSuLEInp3I=;
        h=From:To:Cc:Subject:Date:From;
        b=AfqFfwvXBmS4O0Jyhy7BQnDlLe5CEIQDqmKwmf4SIhucNcomOhg/BjP2eURijq+Yy
         LmEskNE2fLTKm9Td3OV7vbAvmnk8shLrEvtkX69UzU/wst/b456GvU47MCJvp3Is3z
         r4Ex/Mvl10NhT8xncZrkjz6k68ihUI4CSylawKijGtf8sHHxj6pXY36cW1hN5z0bXk
         ZLbGYUKsJRQmzxnKO8BMaLxCpIZpem4JDPgRuNl5YPr3cJKdCFbgy036bSllMyUNAs
         ItGTti4v+i6eeRee4nG6h6dlyEpqS9ol+U4aqzLJ+zLJOJP4IgVVRdiqxzE7mtESp/
         NAtHZTEGp/M5w==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, krzysztof.kozlowski@canonical.com
Cc:     vigneshr@ti.com, nm@ti.com, linux@roeck-us.net,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] mtd: rawnand: omap2: Actually prevent invalid configuration and build error
Date:   Sat, 19 Feb 2022 21:36:00 +0200
Message-Id: <20220219193600.24892-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root of the problem is that we are selecting symbols that have
dependencies. This can cause random configurations that can fail.
The cleanest solution is to avoid using select.

This driver uses interfaces from the OMAP_GPMC driver so we have to
depend on it instead.

Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 36e697456ec4..9b078e78f3fa 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
 	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on HAS_IOMEM
-	select MEMORY
-	select OMAP_GPMC
+	depends on OMAP_GPMC
 	help
 	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
 	  and Keystone platforms.
-- 
2.17.1

