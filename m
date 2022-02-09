Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8014A4AF0B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiBIMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiBIMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:16 -0500
X-Greylist: delayed 3611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:42:44 PST
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE4C0364A2;
        Wed,  9 Feb 2022 03:42:44 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 219A0iO4024427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 02:00:44 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 9 Feb 2022 02:00:44 -0800
Received: from pek-lpd-ccm3.wrs.com (128.224.156.163) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 9 Feb 2022 02:00:42 -0800
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <broonie@kernel.org>, <yun.zhou@windriver.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ying.xue@windriver.com>
Subject: [PATCH] spi: disable chipselect after complete transfer
Date:   Wed, 9 Feb 2022 18:00:42 +0800
Message-ID: <20220209100042.22941-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_FAIL,SPF_HELO_NONE,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are 2 slaves or more on a spi bus, e.g. A and B, we processed a
transfer to A, the CS will be selected for A whose 'last_cs_enable' will
be recorded to true at the same time. Then we processed a transfer to B,
the CS will be switched to B. And then if we transmit data to A again, it
will not enable CS back to A because 'last_cs_enable' is true.
In addition, if CS is not disabled, Some controllers in automatic
transmission state will receive unpredictable data, such as Cadence SPI
controller.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/spi/spi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fdd530b150a7..ebbba0b08186 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1417,7 +1417,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-	bool keep_cs = false;
 	int ret = 0;
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
@@ -1486,10 +1485,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		spi_transfer_delay_exec(xfer);
 
 		if (xfer->cs_change) {
-			if (list_is_last(&xfer->transfer_list,
+			if (!list_is_last(&xfer->transfer_list,
 					 &msg->transfers)) {
-				keep_cs = true;
-			} else {
 				spi_set_cs(msg->spi, false, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
 				spi_set_cs(msg->spi, true, false);
@@ -1500,8 +1497,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	}
 
 out:
-	if (ret != 0 || !keep_cs)
-		spi_set_cs(msg->spi, false, false);
+	spi_set_cs(msg->spi, false, false);
 
 	if (msg->status == -EINPROGRESS)
 		msg->status = ret;
-- 
2.26.1

