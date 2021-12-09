Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0909246E514
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbhLIJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40110 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbhLIJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 254B5B81FA7;
        Thu,  9 Dec 2021 09:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E36AC341CC;
        Thu,  9 Dec 2021 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040719;
        bh=MWHUAT+QSRf94eotQxVo99grDUjLT8VxsVL550Wj88g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkQf2K0Y6j7bt+RJ9zI+50lehAJcEYqCZilCaVzboEP8Q4+CRANRhGgMYBj18OmHV
         dM9Iu9kTYA2aSwzxLETZqb4xcdaHMWziTndXX4OCslCxC4HwgEWZRJ3lUj1LjsnJwT
         tGRkqbOVMClKdzaaJ3ezOgAw4527Qiq4vthSuEsWBpAUN/423Y0jSsBURhsuMYN541
         XyV5QnjrUhhMTaFoOc8lae9oe8SBTsZEx52IXl6aIKWwkUhAa9nblV9Hz7agWsJcDX
         VPHpg0lXNWwVyCVOkGv78JAHiRxXUER2YGbjC1nA2aXRcT7ocaNjzkR3gDYovl4g8N
         QL9Zr06i+bz+w==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 5/6] mtd: rawnand: omap2: fix force_8bit flag behaviour for DMA mode
Date:   Thu,  9 Dec 2021 11:04:57 +0200
Message-Id: <20211209090458.24830-6-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209090458.24830-1-rogerq@kernel.org>
References: <20211209090458.24830-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In DMA mode we were not considering the force_8bit flag.

Fix it by using regular non-DMA 8-bit I/O if force_8bit flag is set.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 0c7ee26171ad..2b58ddea3b01 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -447,6 +447,11 @@ static void omap_nand_data_in_dma_pref(struct nand_chip *chip, void *buf,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (force_8bit) {
+		omap_nand_data_in(chip, buf, len, force_8bit);
+		return;
+	}
+
 	if (len <= mtd->oobsize)
 		omap_nand_data_in_pref(chip, buf, len, false);
 	else
@@ -463,6 +468,11 @@ static void omap_nand_data_out_dma_pref(struct nand_chip *chip,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (force_8bit) {
+		omap_nand_data_out(chip, buf, len, force_8bit);
+		return;
+	}
+
 	if (len <= mtd->oobsize)
 		omap_nand_data_out_pref(chip, buf, len, false);
 	else
-- 
2.17.1

