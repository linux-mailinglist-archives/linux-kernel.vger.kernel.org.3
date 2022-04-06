Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC74F6439
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiDFP6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiDFP5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:57:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4B5A85DD;
        Wed,  6 Apr 2022 06:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4366FCE232F;
        Wed,  6 Apr 2022 13:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B691CC385A1;
        Wed,  6 Apr 2022 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251363;
        bh=8Tfbq//FlhZWD3Cw0VcZ0rfbLlylOVhmSLZROKwe0ws=;
        h=From:To:Cc:Subject:Date:From;
        b=lmBKWZHZuPJb7WAFtjmHzE/A7eR9iNmRM6gDhTJrTFKzuVwpEjo8veG1B++eysUT0
         FxzMEUHBRHcS/LHAjbeskVhKzc2ELWFr+dJJ9KHx0QET1OYTSjIdvOjEqRMa5mAoz3
         F1VfdYvybYCJxj+isHL5g1nvQsMKoHkXzAEFCX8twgWd768A4QXygNsqvc0F+8wns2
         3jXDy5GjyFowV87vx4kSqXnO8fyubYhagNDSgPjA6zTpq2NrWUZWProh/eFMEEgkVy
         zMyu+JiEtBbBj2zbmizF6G9JexLL7zqB9sXHk6OuYTOM5DkYPbdLFbFz1V8EYR0CNJ
         CyJw3AOOEPJLA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: core: add dma_map_dev for __spi_unmap_msg()
Date:   Wed,  6 Apr 2022 18:52:38 +0530
Message-Id: <20220406132238.1029249-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b470e10eb43f ("spi: core: add dma_map_dev for dma device") added
dma_map_dev for _spi_map_msg() but missed to add for unmap routine,
__spi_unmap_msg(), so add it now.

Fixes: b470e10eb43f ("spi: core: add dma_map_dev for dma device")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/spi/spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c4dd1200fe99..32443ae175fd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1130,11 +1130,15 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 	if (ctlr->dma_tx)
 		tx_dev = ctlr->dma_tx->device->dev;
+	else if (ctlr->dma_map_dev)
+		tx_dev = ctlr->dma_map_dev;
 	else
 		tx_dev = ctlr->dev.parent;
 
 	if (ctlr->dma_rx)
 		rx_dev = ctlr->dma_rx->device->dev;
+	else if (ctlr->dma_map_dev)
+		rx_dev = ctlr->dma_map_dev;
 	else
 		rx_dev = ctlr->dev.parent;
 
-- 
2.34.1

