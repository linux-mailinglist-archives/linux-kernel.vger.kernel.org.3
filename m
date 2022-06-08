Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF954304F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiFHM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiFHM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:29:38 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8924F947
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=vTMdtugGnM584xfHBfo4nxQBMNqaBwaPOIcXdoD7whU=;
        b=REGfi+758xN+f1Ie3nbnSv2+F8c5C+rXbVp1UTXplbPa7yJMT7nogbP0UFO41VgIzD6mHX/7G10WI
         63pLfykULb+h0c5JHTB93BCgk3eenlroPRF0YS30oxucEu/tYWtxyaAM9pw25dosFKculZqa4/35rt
         /KJZ392VD43UAiUzwyxuiqGG/4EQn3DJhGEGY+DD+dTHig1Me/PmmxM1clfLVw1T4SCDgQMxCPs2DZ
         EP+FfcSnXhlon84f7MhjXR+HnAyBny4KPIoy01jTMlYVCctQQbgrnOjmDlf7wi6rsQ9enWWCFdX1PT
         QwaaOhYqK+Ps88rdW+jS0Ejr57jpZzA==
X-MSG-ID: a6fb1b21-e726-11ec-a2aa-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Jander <david@protonic.nl>
Subject: [PATCH] include: linux: spi: spi.h: Add missing documentation for struct members
Date:   Wed,  8 Jun 2022 14:29:17 +0200
Message-Id: <20220608122917.2892953-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes "make htmldocs" warnings.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David Jander <david@protonic.nl>
---
 include/linux/spi/spi.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index eac8d3caf954..2e63b4935deb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -35,7 +35,8 @@ extern struct bus_type spi_bus_type;
 
 /**
  * struct spi_statistics - statistics for spi transfers
- * @lock:          lock protecting this structure
+ * @syncp:         seqcount to protect members in this struct for per-cpu udate
+ *                 on 32-bit systems
  *
  * @messages:      number of spi-messages handled
  * @transfers:     number of spi_transfers handled
@@ -155,7 +156,7 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  * @cs_inactive: delay to be introduced by the controller after CS is
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
- * @statistics: statistics for the spi_device
+ * @pcpu_statistics: statistics for the spi_device
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -439,7 +440,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @max_native_cs: When cs_gpiods is used, and this field is filled in,
  *	spi_register_controller() will validate all native CS (including the
  *	unused native CS) against this value.
- * @statistics: statistics for the spi_controller
+ * @pcpu_statistics: statistics for the spi_controller
  * @dma_tx: DMA transmit channel
  * @dma_rx: DMA receive channel
  * @dummy_rx: dummy receive buffer for full-duplex devices
-- 
2.32.0

