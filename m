Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C978547C0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhLUNSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhLUNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:18:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FBC061574;
        Tue, 21 Dec 2021 05:18:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39DB5B816B8;
        Tue, 21 Dec 2021 13:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27243C36AEB;
        Tue, 21 Dec 2021 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092699;
        bh=rmNCe/Fcv2Cch+PQTMUw4LOnj/3R7KOxvik2UJk4xCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEIoMBrrKnxFBsjjGjh+jvTnZ/d73gaJabQeSpd+S2Ca2PwMsYNNELGBItT1QPg7Y
         2I+CR++g4v7Udhme+dzwaT94Q8yUqdPJn9zMMgJLbSRZagbWtjPM7RsmLvFriYHiSj
         Lwn/duPfkwmi7k8y7un0OQ34F2MKktBhmnpczr+zaEdZlXBpGmvAid1Kr7vGqbMqHD
         kumI7u3W6+S8eULAF5ywElvzwozEGUKddGcHIC8h4Nw4nqDJU7x3XSjixQ7nPOD6qE
         bSBI7wWVzrZowFMP7ssHjruyqArqJpnr8ZeXVZTAC1veUwC/DsWiBZPSDth6UqXEBy
         pv+wgGOWX9oNw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, miquel.raynal@bootlin.com,
        tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 4/4] mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
Date:   Tue, 21 Dec 2021 15:17:57 +0200
Message-Id: <20211221131757.2030-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221131757.2030-1-rogerq@kernel.org>
References: <20211221131757.2030-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPMC device driver is required for NAND controller
to work on K3 Architecture. Select it if required.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 67b7cb67c030..587f20c6184f 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -42,6 +42,7 @@ config MTD_NAND_OMAP2
 	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
 	depends on HAS_IOMEM
+	select OMAP_GPMC if ARCH_K3
 	help
 	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
 	  and Keystone platforms.
-- 
2.17.1

