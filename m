Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F785AA2E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiIAWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiIAWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:20:59 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC99A2223;
        Thu,  1 Sep 2022 15:19:19 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7B95521C6;
        Fri,  2 Sep 2022 00:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662070751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mp1Anrg7RvtSnRweTlYNf0dthMjXidxRy4304FCk4PI=;
        b=WMetcScz3c92KdUF5vL3GP2woDolbQbrOFvSwM5HWetbrnJdWEQ6AIbOZwK0HfdJ0WBQ9x
        UjSKDDX+BV3qpnl25BoRj1Z9XPG1AZ4cOAy8Cq1/CBasQ9PMrm4dnbJZ0kkWcwXhzntikR
        7NwDg6LelDwwbKzOHStD6BqRQ7nv7Zltus8m2lPifwgV8vUQif5jvYTvVMWsDF/d36znFH
        wmDoQWSmNnaoJ9z6vzLVRBYzGDaTt+V42ZfRkphxjpwfo4xXq3uCaYmEJzUlOiT4CP/+ju
        HnaxMnnL5cCH/fohA8JuaG6z42FatZoCJZfuZeyyFxTum7Tz9vrR01wPnyn3gg==
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
Subject: [PATCH v2 07/20] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
Date:   Fri,  2 Sep 2022 00:18:44 +0200
Message-Id: <20220901221857.2600340-8-michael@walle.cc>
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

Convert nvmem_add_cells_from_of() to use the new nvmem_add_one_cell().
This will remove duplicate code and it will make it possible to add a
hook to a nvmem layout in between, which can change fields before the
cell is finally added.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - new patch

 drivers/nvmem/core.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3dfd149374a8..c640d411ab15 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -687,15 +687,15 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
-	struct device_node *parent, *child;
 	struct device *dev = &nvmem->dev;
 	struct nvmem_cell_entry *cell;
+	struct device_node *child;
 	const __be32 *addr;
-	int len;
+	int len, ret;
 
-	parent = dev->of_node;
+	for_each_child_of_node(dev->of_node, child) {
+		struct nvmem_cell_info info = {0};
 
-	for_each_child_of_node(parent, child) {
 		addr = of_get_property(child, "reg", &len);
 		if (!addr)
 			continue;
@@ -711,34 +711,24 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			return -ENOMEM;
 		}
 
-		cell->nvmem = nvmem;
-		cell->offset = be32_to_cpup(addr++);
-		cell->bytes = be32_to_cpup(addr);
-		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
+		info.offset = be32_to_cpup(addr++);
+		info.bytes = be32_to_cpup(addr);
+		info.name = kasprintf(GFP_KERNEL, "%pOFn", child);
 
 		addr = of_get_property(child, "bits", &len);
 		if (addr && len == (2 * sizeof(u32))) {
-			cell->bit_offset = be32_to_cpup(addr++);
-			cell->nbits = be32_to_cpup(addr);
+			info.bit_offset = be32_to_cpup(addr++);
+			info.nbits = be32_to_cpup(addr);
 		}
 
-		if (cell->nbits)
-			cell->bytes = DIV_ROUND_UP(
-					cell->nbits + cell->bit_offset,
-					BITS_PER_BYTE);
+		info.np = of_node_get(child);
 
-		if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
-				cell->name, nvmem->stride);
-			/* Cells already added will be freed later. */
-			kfree_const(cell->name);
-			kfree(cell);
+		ret = nvmem_add_one_cell(nvmem, &info);
+		kfree(info.name);
+		if (ret) {
 			of_node_put(child);
-			return -EINVAL;
+			return ret;
 		}
-
-		cell->np = of_node_get(child);
-		nvmem_cell_entry_add(cell);
 	}
 
 	return 0;
-- 
2.30.2

