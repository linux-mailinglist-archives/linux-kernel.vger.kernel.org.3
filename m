Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD82554775
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354717AbiFVJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353024AbiFVJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:42:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD11111C;
        Wed, 22 Jun 2022 02:42:54 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4LSdj60YbKz4xZh;
        Wed, 22 Jun 2022 19:42:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSdj25Vydz4xZb;
        Wed, 22 Jun 2022 19:42:46 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/2] spi: aspeed: Add pr_debug in aspeed_spi_dirmap_create()
Date:   Wed, 22 Jun 2022 11:42:32 +0200
Message-Id: <20220622094233.3681843-2-clg@kaod.org>
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

It helps to analyze the default setting of the control register.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 496f3e1e9079..ac64be289e59 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -558,6 +558,14 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	u32 ctl_val;
 	int ret = 0;
 
+	dev_dbg(aspi->dev,
+		"CE%d %s dirmap [ 0x%.8llx - 0x%.8llx ] OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x\n",
+		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
+		desc->info.offset, desc->info.offset + desc->info.length,
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth,
+		op->addr.nbytes, op->dummy.nbytes);
+
 	chip->clk_freq = desc->mem->spi->max_speed_hz;
 
 	/* Only for reads */
-- 
2.35.3

