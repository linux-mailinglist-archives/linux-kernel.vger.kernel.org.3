Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431074925C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiARMff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiARMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:35:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B94C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:35:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EA36B8169C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572DCC00446;
        Tue, 18 Jan 2022 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642509331;
        bh=VG2Z/EYZoovWfQJb9a0Asmj3TQLSNNxBCPcZ49i1f9I=;
        h=From:To:Cc:Subject:Date:From;
        b=uj8Sh6rkyoGZOzGYQsnt4Ma+SZk0BAxUHjY1hd61+mAez8Xa56vT2pDWo5jv0dArs
         +VRLBO2KFHlRcX41FzGFYxMXzXbrxgCfZ8UNRmqF9coPLZegDTeBB2C6MStRQK1wiv
         juhsOFIUWSyI3oxMk3rb+/k2wRaYEpUh0H1EVwMAjfyyWXKPYGRIH4Y6eheEZn9hcg
         aNfDAgFgM2GFCwaH9Qkzx62r6jX7ANfLnArreK6iocVZn6ufc0QKkBC1eDlX6pRMPl
         vnGtiiwsy4ueMgEr4MfevvrKDEM4FnNmUZnv41Q6Be7RYsNVyYLUyjqvKYcZ1Usq5H
         QcnG+8CMHDV3A==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, krzysztof.kozlowski@canonical.com
Cc:     vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] mtd: rawnand: omap2: Prevent invalid configuration and build error
Date:   Tue, 18 Jan 2022 14:35:25 +0200
Message-Id: <20220118123525.8020-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to select MEMORY as well otherwise OMAP_GPMC will not be built.
For simplicity let's select MEMORY and OMAP_GPMC unconditionally as
this driver depends on OMAP_GPMC driver and uses symbols from there.

Fixes: dbcb124acebd ("mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 20408b7db540..d986ab4e4c35 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
 	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on HAS_IOMEM
-	select OMAP_GPMC if ARCH_K3
+	select MEMORY
+	select OMAP_GPMC
 	help
 	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
 	  and Keystone platforms.
-- 
2.17.1

