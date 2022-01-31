Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB25E4A492D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiAaORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379387AbiAaORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:17:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3D0C061714;
        Mon, 31 Jan 2022 06:17:16 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:2ed0:139:90e3:dfa5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 110431F433EC;
        Mon, 31 Jan 2022 14:17:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643638635;
        bh=oQeYQnRXQUqnbqQFQgb/37k7wXUdazy3hfN1laLB+Lk=;
        h=From:To:Cc:Subject:Date:From;
        b=L7deuu4aR2RlGFj1lAojoy+j3ez7MsMDwljPKt63ue2hcm1nxoSJXsyJABkSJPoK6
         usHml7nZaiwvoxg1jWn4ZvWAN8wh5pu0x4Phxsm0iAR6GZ4lNeaiFTy6E0xVbHnr0p
         4wpaUYA0fQ1sn53l1n5HeNay1uNaKczEH3t9f/sdzzjNFPpzJcmobwy3gyGfN2tMvr
         LnC5TqT2e0iiUvj+X40hDx1YcP4Cm1R4HlmGx4d0SKpI7ott5anBwu2ciox9I/kn5o
         7yz8buHkX7tO07/N/4mak/paJMOKRLhSH/n8AhsELs3YuaXkvYz17K8CloQODV5POS
         7H6NLkM+rTXvQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     broonie@kernel.org, matthias.bgg@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] spi: mediatek: Avoid NULL pointer crash in interrupt
Date:   Mon, 31 Jan 2022 15:17:08 +0100
Message-Id: <20220131141708.888710-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case, like after a transfer timeout, master->cur_msg pointer
is NULL which led to a kernel crash when trying to use master->cur_msg->spi.
mtk_spi_can_dma(), pointed by master->can_dma, doesn't use this parameter
avoid the problem by setting NULL as second parameter.

Fixes: a568231f46322 ("spi: mediatek: Add spi bus for Mediatek MT8173")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index a15de10ee286..753bd313e6fd 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -624,7 +624,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	else
 		mdata->state = MTK_SPI_IDLE;
 
-	if (!master->can_dma(master, master->cur_msg->spi, trans)) {
+	if (!master->can_dma(master, NULL, trans)) {
 		if (trans->rx_buf) {
 			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
-- 
2.30.2

