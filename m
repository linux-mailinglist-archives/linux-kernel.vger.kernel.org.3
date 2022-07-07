Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75856AAF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiGGSno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiGGSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816330F5A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19D4EB8215D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFFBC3411E;
        Thu,  7 Jul 2022 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657219419;
        bh=X91w2s3hUBEJKzueE4a8QnnBJdFZ4qmysMaFWqtieW8=;
        h=From:To:Cc:Subject:Date:From;
        b=RaYdur2UIQSvJZV5FQkxANnCQt0U0P0pzQmezpzqVeElD3fyiyWi5oueWfNNKCPoy
         WuClWYYENFBlKMAjZnxj3838d6FtG58MNDul78DsgAfmnXRA44qqtLONw+ozeT3CFG
         B1jR3HFVGJ/C5yuxgWQ6ALKXSds5lXEC2RdtcOoFpUvkQ+/yJOVpqL6ep40vaBOFkC
         Ie2ov+8Rx6yYiY/Q6j7Y0mUmFZDhc3JyyhJyeCmAcwAydKKnxYKBAc8q9v/G+Nflp2
         nXzJ/MORl7D6V68xPONc6ywJdgF+zvBRMx3TmlAXkTKZVeT0XbrcoagbmgjPAoKk97
         zVENHjZIjlkAg==
Received: by pali.im (Postfix)
        id AC6DE7B1; Thu,  7 Jul 2022 20:43:36 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: fsl_elbc: Fix none ECC mode
Date:   Thu,  7 Jul 2022 20:43:28 +0200
Message-Id: <20220707184328.3845-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work") added
support for specifying ECC mode via DTS and skipping autodetection.

But it broke explicit specification of HW ECC mode in DTS as correct
settings for HW ECC mode are applied only when NONE mode or nothing was
specified in DTS file.

Also it started aliasing NONE mode to be same as when ECC mode was not
specified and disallowed usage of ON_DIE mode.

Fix all these issues. Use autodetection of ECC mode only in case when mode
was really not specified in DTS file by checking that ecc value is invalid.
Set HW ECC settings either when HW ECC was specified in DTS or it was
autodetected. And do not fail when ON_DIE mode is set.

Fixes: f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mtd/nand/raw/fsl_elbc_nand.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index aab93b9e6052..a18d121396aa 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -726,36 +726,40 @@ static int fsl_elbc_attach_chip(struct nand_chip *chip)
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	unsigned int al;
 
-	switch (chip->ecc.engine_type) {
 	/*
 	 * if ECC was not chosen in DT, decide whether to use HW or SW ECC from
 	 * CS Base Register
 	 */
-	case NAND_ECC_ENGINE_TYPE_NONE:
+	if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_INVALID) {
 		/* If CS Base Register selects full hardware ECC then use it */
 		if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
 		    BR_DECC_CHK_GEN) {
-			chip->ecc.read_page = fsl_elbc_read_page;
-			chip->ecc.write_page = fsl_elbc_write_page;
-			chip->ecc.write_subpage = fsl_elbc_write_subpage;
-
 			chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
-			mtd_set_ooblayout(mtd, &fsl_elbc_ooblayout_ops);
-			chip->ecc.size = 512;
-			chip->ecc.bytes = 3;
-			chip->ecc.strength = 1;
 		} else {
 			/* otherwise fall back to default software ECC */
 			chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
 			chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
 		}
+	}
+
+	switch (chip->ecc.engine_type) {
+	/* if HW ECC was chosen, setup ecc and oob layout */
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		chip->ecc.read_page = fsl_elbc_read_page;
+		chip->ecc.write_page = fsl_elbc_write_page;
+		chip->ecc.write_subpage = fsl_elbc_write_subpage;
+		mtd_set_ooblayout(mtd, &fsl_elbc_ooblayout_ops);
+		chip->ecc.size = 512;
+		chip->ecc.bytes = 3;
+		chip->ecc.strength = 1;
 		break;
 
-	/* if SW ECC was chosen in DT, we do not need to set anything here */
+	/* if none or SW ECC was chosen, we do not need to set anything here */
+	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
 		break;
 
-	/* should we also implement *_ECC_ENGINE_CONTROLLER to do as above? */
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

