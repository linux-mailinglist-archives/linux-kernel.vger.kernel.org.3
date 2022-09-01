Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7215AA2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiIAWWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiIAWVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:21:03 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0658A2616;
        Thu,  1 Sep 2022 15:19:20 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3D4C42203;
        Fri,  2 Sep 2022 00:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662070753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbvWTun9+QuBUdvSViNHq/GAkH5sJyJindexihmzO3w=;
        b=KIif7isPnk0Dc76Qomin19zwClkFsLjLT/yPPZHVtqxUGc3dV7yFcoZwcd7mn4RisqCe28
        hgw7jicL8B76Fp/WDnYtV7HCXGgR2VosHPsttCXTPaY5TopNLjLBRl3dBAGrYDPPaRurV+
        /x1FCuJVktduFKHORuQWIAn+omsRW0W/tj94otZXgJqFkeOwx4gRSpc3wLQ1mh/lLesiUI
        Q5hv2gQE/ottx83VXZTh2HdoUuwBAjN1/JNm1hb6boaDoA93NimyPF10JQti73LXGTuDCm
        egEltn9AxpqY59kVzxf66b5qfnk3l0EObfEnvA1SOJE2iFc7elyvRZb36vIg4w==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 12/20] nvmem: cell: drop global cell_post_process
Date:   Fri,  2 Sep 2022 00:18:49 +0200
Message-Id: <20220901221857.2600340-13-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901221857.2600340-1-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users anymore for the global cell_post_process callback
anymore. New users should use proper nvmem layouts.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - new patch

 drivers/nvmem/core.c           | 9 ---------
 include/linux/nvmem-provider.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3b65512762b9..d31d3f0ab517 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,7 +38,6 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	struct nvmem_layout	*layout;
 	void *priv;
@@ -874,7 +873,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1531,13 +1529,6 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 			return rc;
 	}
 
-	if (nvmem->cell_post_process) {
-		rc = nvmem->cell_post_process(nvmem->priv, id, index,
-					      cell->offset, buf, cell->bytes);
-		if (rc)
-			return rc;
-	}
-
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 9cb340764b89..9d22dc5a3fa5 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -85,7 +85,6 @@ struct nvmem_cell_info {
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
- * @cell_post_process:	Callback for vendor specific post processing of cell data
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -120,7 +119,6 @@ struct nvmem_config {
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.30.2

