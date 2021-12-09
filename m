Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E146E519
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhLIJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhLIJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:09:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436EEC0698E1;
        Thu,  9 Dec 2021 01:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90433CE2534;
        Thu,  9 Dec 2021 09:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597A7C341C8;
        Thu,  9 Dec 2021 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040722;
        bh=LBmhnf0dVpaCEhWvKn4Yu0weT1lsq5kGXmqi1azjEcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Auni7Z2cL/8AjhnGEUBqK9u57c+Vya/MAbCPZ4siy3xeTcHU7chBUM8s2qGEIGn1G
         uJrAiD4VCYTNNGMINYH5pQE+x4QWBxAVQAc5hWEFYoYS7xHFX6AA66VD+hc1VWCjUL
         0lM68eUI9Vk5kcjB0CcdEIC3ze+G9ZBIdNvumEJiwlL5QlDR/K3O+rvT7bTM8ZeXh+
         QfymTXc1z9eetyvy0ziojn/0W7ydemRlMnTGJ6ER1/uue/FYi4QJFj8tdIdDz0/RWP
         YzU8VUvIfxMMYItElcPiSM1aZXka4/gm1DARMw0euPNfZQe/imBAVs+8GmlqqsCPz8
         fTWhO59Ckja5g==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 6/6] mtd: rawnand: omap2: drop unused variable
Date:   Thu,  9 Dec 2021 11:04:58 +0200
Message-Id: <20211209090458.24830-7-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209090458.24830-1-rogerq@kernel.org>
References: <20211209090458.24830-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devsize is not used anywhere in code. Drop it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 2b58ddea3b01..cc61f4858a3b 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -148,7 +148,6 @@ struct omap_nand_info {
 	int				gpmc_cs;
 	bool				dev_ready;
 	enum nand_io			xfer_type;
-	int				devsize;
 	enum omap_ecc			ecc_opt;
 	struct device_node		*elm_of_node;
 
@@ -2246,9 +2245,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	if (info->flash_bbt)
 		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
 
-	/* scan NAND device connected to chip controller */
-	nand_chip->options |= info->devsize & NAND_BUSWIDTH_16;
-
 	/* default operations */
 	info->data_in = omap_nand_data_in;
 	info->data_out = omap_nand_data_out;
-- 
2.17.1

