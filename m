Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562EF588F01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiHCO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiHCO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:59:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7552613E91;
        Wed,  3 Aug 2022 07:59:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FD811FB;
        Wed,  3 Aug 2022 07:59:02 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A98DB3F70D;
        Wed,  3 Aug 2022 07:59:01 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bitbang: Fix lsb-first Rx
Date:   Wed,  3 Aug 2022 15:58:57 +0100
Message-Id: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting the recieved bit by "bits" inserts it at the top of the
*currently remaining* Tx data, so we end up accumulating the whole
transfer into bit 0 of the output word. Oops.

For the algorithm to work as intended, we need to remember where the
top of the *original* word was, and shift Rx to there.

Fixes: 1847e3046c52 ("spi: gpio: Implement LSB First bitbang support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/spi/spi-bitbang-txrx.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index 267342dfa738..2dcbe166df63 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -116,6 +116,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
+	u8 rxbit = bits - 1;
 	u32 oldbit = !(word & 1);
 	/* clock starts at inactive polarity */
 	for (; likely(bits); bits--) {
@@ -135,7 +136,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
 		/* sample LSB (from slave) on leading edge */
 		word >>= 1;
 		if ((flags & SPI_MASTER_NO_RX) == 0)
-			word |= getmiso(spi) << (bits - 1);
+			word |= getmiso(spi) << rxbit;
 		setsck(spi, cpol);
 	}
 	return word;
@@ -148,6 +149,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
+	u8 rxbit = bits - 1;
 	u32 oldbit = !(word & 1);
 	/* clock starts at inactive polarity */
 	for (; likely(bits); bits--) {
@@ -168,7 +170,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
 		/* sample LSB (from slave) on trailing edge */
 		word >>= 1;
 		if ((flags & SPI_MASTER_NO_RX) == 0)
-			word |= getmiso(spi) << (bits - 1);
+			word |= getmiso(spi) << rxbit;
 	}
 	return word;
 }
-- 
2.36.1.dirty

