Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DF4BA153
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiBQNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:35:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbiBQNfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:35:41 -0500
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA232AED97;
        Thu, 17 Feb 2022 05:35:26 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 21HDZBBC023666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 05:35:11 -0800
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 17 Feb 2022 05:35:11 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 05:35:10 -0800
Received: from pek-lpd-ccm3.wrs.com (128.224.156.163) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Thu, 17 Feb 2022 05:35:09 -0800
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <broonie@kernel.org>, <yun.zhou@windriver.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ying.xue@windriver.com>, <richard.danter@windriver.com>
Subject: [PATCH] spi: use specific last_cs instead of last_cs_enable
Date:   Thu, 17 Feb 2022 21:35:08 +0800
Message-ID: <20220217133508.69409-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_FAIL,SPF_HELO_NONE,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d40f0b6f2e21 instroduced last_cs_enable to avoid setting
chipselect if it's not necessary, but it also introduces a bug. The
chipselect may not be set correctly on multi-device SPI busses. The
reason is that we can't judge the chipselect by bool last_cs_enable,
since chipselect may be modified after other devices were accessed.

So we should record the specific state of chipselect in case of
confusion.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/spi/spi.c       | 4 ++--
 include/linux/spi/spi.h | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..3114b8e5c954 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -936,13 +936,13 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	 * Avoid calling into the driver (or doing delays) if the chip select
 	 * isn't actually changing from the last time this was called.
 	 */
-	if (!force && (spi->controller->last_cs_enable == enable) &&
+	if (!force && (spi->controller->last_cs == spi->chip_select) &&
 	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
 		return;
 
 	trace_spi_set_cs(spi, activate);
 
-	spi->controller->last_cs_enable = enable;
+	spi->controller->last_cs = enable ? spi->chip_select : -1;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
 	if ((spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..5a54ea354053 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -373,7 +373,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @cur_msg_prepared: spi_prepare_message was called for the currently
  *                    in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
- * @last_cs_enable: was enable true on the last call to set_cs.
+ * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
+ *           selected
  * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy
@@ -611,7 +612,7 @@ struct spi_controller {
 	bool				auto_runtime_pm;
 	bool                            cur_msg_prepared;
 	bool				cur_msg_mapped;
-	bool				last_cs_enable;
+	char				last_cs;
 	bool				last_cs_mode_high;
 	bool                            fallback;
 	struct completion               xfer_completion;
-- 
2.26.1

