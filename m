Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4755460E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355019AbiFVJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353056AbiFVJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:42:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E128E1FA;
        Wed, 22 Jun 2022 02:42:55 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4LSdjB4S8Bz4xZj;
        Wed, 22 Jun 2022 19:42:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSdj64JWlz4xZb;
        Wed, 22 Jun 2022 19:42:50 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Ian Woloschin <ian.woloschin@akamai.com>,
        Ian Woloschin <iwolosch@akamai.com>
Subject: [PATCH v2 2/2] spi: aspeed: Fix division by zero
Date:   Wed, 22 Jun 2022 11:42:33 +0200
Message-Id: <20220622094233.3681843-3-clg@kaod.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220622094233.3681843-1-clg@kaod.org>
References: <20220622094233.3681843-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the normal read operation for data transfers, the dummy bus
width is zero. In that case, they are no dummy bytes to transfer and
setting the dummy field in the controller register becomes useless.

Issue was found on a custom "Bifrost" board based on the AST2500 SoC
and using a MX25L51245GMI-08G SPI Flash.

Reported-by: Ian Woloschin <ian.woloschin@akamai.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Ian Woloschin <iwolosch@akamai.com>
Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index ac64be289e59..3e891bf22470 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -582,9 +582,11 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
 	ctl_val |= aspeed_spi_get_io_mode(op) |
 		op->cmd.opcode << CTRL_COMMAND_SHIFT |
-		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
 		CTRL_IO_MODE_READ;
 
+	if (op->dummy.nbytes)
+		ctl_val |= CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth);
+
 	/* Tune 4BYTE address mode */
 	if (op->addr.nbytes) {
 		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
-- 
2.35.3

