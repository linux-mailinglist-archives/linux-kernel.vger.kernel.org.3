Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA994B1D16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiBKDuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:50:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiBKDtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:49:51 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406465F70;
        Thu, 10 Feb 2022 19:49:51 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 6DED2140218;
        Fri, 11 Feb 2022 11:49:49 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [RFC PATCH v1 5/6] spi: rockchip: terminate dma transmission when slave abort
Date:   Fri, 11 Feb 2022 11:49:37 +0800
Message-Id: <20220211034938.25097-6-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211034938.25097-1-jon.lin@rock-chips.com>
References: <20220211034938.25097-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIaTUNWTBpNSUNCH05CGk
        NIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46NTo5Ij5REh4RNklKDTMP
        FR4aCxlVSlVKTU9PTk5KSENCQ0NJVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFISE5JNwY+
X-HM-Tid: 0a7ee6e6c1acda2fkuws6ded2140218
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After slave abort, all DMA should be stopped, or it will affect the
next transmission:

[   31.693877] Unable to handle kernel paging request at virtual address ffffff8105a2a7c0
[   31.694643] Mem abort info:
[   31.694898]   ESR = 0x96000045
[   31.695179]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.695653]   SET = 0, FnV = 0
[   31.695931]   EA = 0, S1PTW = 0
[   31.696218] Data abort info:
[   31.696485]   ISV = 0, ISS = 0x00000045
[   31.696832]   CM = 0, WnR = 1
[   31.697112] swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000000142f000
[   31.697713] [ffffff8105a2a7c0] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[   31.698502] Internal error: Oops: 96000045 [#1] SMP
[   31.698943] Modules linked in:
[   31.699235] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.43 #8
[   31.699895] Hardware name: Rockchip RK3588 EVB1 LP4 V10 Board (DT)
[   31.700455] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
[   31.701000] pc : rockchip_spi_slave_abort+0x150/0x18c
[   31.701456] lr : rockchip_spi_slave_abort+0x78/0x18c

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5457af616a44..3d4e95eda4a6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -617,8 +617,6 @@ static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
 	if (atomic_read(&rs->state) & RXDMA) {
 		dmaengine_pause(ctlr->dma_rx);
 		status = dmaengine_tx_status(ctlr->dma_rx, ctlr->dma_rx->cookie, &state);
-		dmaengine_terminate_sync(ctlr->dma_rx);
-		atomic_set(&rs->state, 0);
 		if (status == DMA_ERROR) {
 			rs->rx = rs->xfer->rx_buf;
 			rs->xfer->len = 0;
@@ -648,6 +646,11 @@ static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
 	}
 
 out:
+	if (atomic_read(&rs->state) & RXDMA)
+		dmaengine_terminate_sync(ctlr->dma_rx);
+	if (atomic_read(&rs->state) & TXDMA)
+		dmaengine_terminate_sync(ctlr->dma_tx);
+	atomic_set(&rs->state, 0);
 	spi_enable_chip(rs, false);
 	rs->slave_abort = true;
 	spi_finalize_current_transfer(ctlr);
-- 
2.17.1

