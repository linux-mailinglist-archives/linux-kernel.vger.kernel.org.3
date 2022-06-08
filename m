Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5D543781
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiFHPdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbiFHPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:33:45 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958D266C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=sgOi0wZt64PvzV9T5wbU6JWnzoPTwGt8hGmYzxvQxks=;
        b=XhApxaLiOKxmY7hz7GCGsdSFSBwfcy172V0MF8dc3NEUeoWVLgLHjCsguV4DEXCaSRcf/E1VadzjN
         qGknx8qlia51glFKSXpDO2rRf3KY+uij7yYXwDptqaWRL9ZxJFZPDhJxT6eeCDTOtBob6Lwfu0Aco8
         c6MB3JV2S7dXkDh8j6NrR7/SvQPutEIo1lCk8L+bObgEE2m0mRSqucQC3p4CRXY/AIf8XFQLzq3E0b
         MbRznsiP9w+F2VFRZ/dAVDqRNQxIv25kVwS1WWzfWs94A93FADRvpF6Ts6/oqUKp7fsmF1o2SHaeU0
         VrCZM+z9UyBhWL/KFIWkCUeoqGtzVrQ==
X-MSG-ID: 5f31577c-e740-11ec-b450-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Jander <david@protonic.nl>
Subject: [PATCH v2] spi: <linux/spi/spi.h>: Add missing documentation for struct members
Date:   Wed,  8 Jun 2022 17:33:09 +0200
Message-Id: <20220608153309.2899565-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes these "make htmldocs" warnings:

include/linux/spi/spi.h:82: warning: Function parameter or member 'syncp' not described in 'spi_statistics'
include/linux/spi/spi.h:213: warning: Function parameter or member 'pcpu_statistics' not described in 'spi_device'
include/linux/spi/spi.h:676: warning: Function parameter or member 'pcpu_statistics' not described in 'spi_controller'

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David Jander <david@protonic.nl>
---
v2:
 - Correct patch subject line style
 - Add the text of the actual warnings that are being fixed
 - Add a Fixes: tag
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

