Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4E4B7CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiBPBlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiBPBkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:40:46 -0500
Received: from mail-m17640.qiye.163.com (mail-m17640.qiye.163.com [59.111.176.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EACF237CA;
        Tue, 15 Feb 2022 17:40:36 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id EA20B5401E7;
        Wed, 16 Feb 2022 09:40:33 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v3 2/6] spi: rockchip: terminate dma transmission when slave abort
Date:   Wed, 16 Feb 2022 09:40:24 +0800
Message-Id: <20220216014028.8123-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216014028.8123-1-jon.lin@rock-chips.com>
References: <20220216014028.8123-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJPTBpWHU0aSUxNThpDSh
        4fVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6Azo*Cz5IPBYRUQ0IGQ04
        DjQaFBdVSlVKTU9PQkxOTUhPTU5IVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJSklDNwY+
X-HM-Tid: 0a7f003036d7d995kuwsea20b5401e7
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After slave abort, all DMA should be stopped, or it will affect the
next transmission and maybe abort again.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2:
- Fix patches should be at the start of the series
- Delete useless messages

Changes in v1: None

 drivers/spi/spi-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 4f65ba3dd19c..c6a1bb09be05 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -585,6 +585,12 @@ static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
+	if (atomic_read(&rs->state) & RXDMA)
+		dmaengine_terminate_sync(ctlr->dma_rx);
+	if (atomic_read(&rs->state) & TXDMA)
+		dmaengine_terminate_sync(ctlr->dma_tx);
+	atomic_set(&rs->state, 0);
+	spi_enable_chip(rs, false);
 	rs->slave_abort = true;
 	spi_finalize_current_transfer(ctlr);
 
-- 
2.17.1

