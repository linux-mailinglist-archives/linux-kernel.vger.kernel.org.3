Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06EB52A271
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiEQNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346842AbiEQM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE64EF52;
        Tue, 17 May 2022 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652792323; x=1684328323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8KDh0p8KFTd35tP8LLvLdRjkmfaxl9tbAokhnHY/ik=;
  b=gh7elHJaCSKKgMtCl5DVgXt3quykvtyfmSjjaOS39MnTDPxGrvBUW4wF
   4Hdt8h7LPiqTK0K7+BLAtzc0OUT6/XDaMd1cd8yAwwtk5cS+elhH1+OIb
   kNnwHO38VSu4P2s9Fqp3DuIay4tX06TQfVDwgHbcHqvuJbRVWTs1cJZWq
   fE2DXGBE1Atg2m28JtnPRO4qZIVDDIBbtudXLFECc4FgVTL45J+tVq47V
   UrXry5hVYR8w1pJ1L4Q/MAAtFlFS5v/E5wmk0vnBe37V4aOa0s0parcg8
   iDPK++zfqbQ9TGWYBhzh9llNlo0KB1pMGiU7EETXDktmQ6GMUeO70JOo3
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="164419682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 05:58:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 05:58:38 -0700
Received: from ROB-ULT-M18063.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 05:58:36 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/2] nvmem: microchip-otpc: add support
Date:   Tue, 17 May 2022 15:58:22 +0300
Message-ID: <20220517125822.579580-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220517125822.579580-1-claudiu.beznea@microchip.com>
References: <20220517125822.579580-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip OTP controller available on SAMA7G5. The OTPC
controls the access to a non-volatile memory. The memory behind OTPC is
organized into packets, packets are composed by a fixed length header
(4 bytes long) and a variable length payload (payload length is available
in the header). When software request the data at an offset in memory
the OTPC will return (via header + data registers) the whole packet that
has a word at that offset. For the OTP memory layout like below:

offset  OTP Memory layout

         .           .
         .    ...    .
         .           .
0x0E     +-----------+	<--- packet X
         | header  X |
0x12     +-----------+
         | payload X |
0x16     |           |
         |           |
0x1A     |           |
         +-----------+
         .           .
         .    ...    .
         .           .

if user requests data at address 0x16 the data started at 0x0E will be
returned by controller. User will be able to fetch the whole packet
starting at 0x0E (or parts of the packet) via proper registers. The same
packet will be returned if software request the data at offset 0x0E or
0x12 or 0x1A.

The OTP will be populated by Microchip with at least 2 packets first one
being boot configuration packet and the 2nd one being temperature
calibration packet. The packet order will be preserved b/w different chip
revisions but the packet sizes may change.

For the above reasons and to keep the same software able to work on all
chip variants the read function of the driver is working with a packet
id instead of an offset in OTP memory.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS                    |   8 +
 drivers/nvmem/Kconfig          |   7 +
 drivers/nvmem/Makefile         |   2 +
 drivers/nvmem/microchip-otpc.c | 288 +++++++++++++++++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 drivers/nvmem/microchip-otpc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bf57fd937b5..19aee05c85cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12953,6 +12953,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 F:	drivers/mtd/nand/raw/atmel/*
 
+MICROCHIP OTPC DRIVER
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml
+F:	drivers/nvmem/microchip-otpc.c
+F:	dt-bindings/nvmem/microchip-sama7g5,otpc.h
+
 MICROCHIP PWM DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 967d0084800e..d72d879a6d34 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -107,6 +107,13 @@ config MTK_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called efuse-mtk.
 
+config MICROCHIP_OTPC
+	tristate "Microchip OTPC support"
+	depends on ARCH_AT91 || COMPILE_TEST
+	help
+	  This driver enable the OTP controller available on Microchip SAMA7G5
+	  SoCs. It controlls the access to the OTP memory connected to it.
+
 config NVMEM_NINTENDO_OTP
 	tristate "Nintendo Wii and Wii U OTP Support"
 	depends on WII || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 00e136a0a123..c710b64f9fe4 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -67,3 +67,5 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 		:= apple-efuses.o
+obj-$(CONFIG_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
+nvmem-microchip-otpc-y		:= microchip-otpc.o
diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
new file mode 100644
index 000000000000..5c5ac1bca074
--- /dev/null
+++ b/drivers/nvmem/microchip-otpc.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OTP Memory controller
+ *
+ * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#define MCHP_OTPC_CR			(0x0)
+#define MCHP_OTPC_CR_READ		BIT(6)
+#define MCHP_OTPC_MR			(0x4)
+#define MCHP_OTPC_MR_ADDR		GENMASK(31, 16)
+#define MCHP_OTPC_AR			(0x8)
+#define MCHP_OTPC_SR			(0xc)
+#define MCHP_OTPC_SR_READ		BIT(6)
+#define MCHP_OTPC_HR			(0x20)
+#define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
+#define MCHP_OTPC_DR			(0x24)
+
+#define MCHP_OTPC_NAME			"mchp-otpc"
+#define MCHP_OTPC_SIZE			(11 * 1024)
+
+/**
+ * struct mchp_otpc - OTPC private data structure
+ * @base: base address
+ * @dev: struct device pointer
+ * @packets: list of packets in OTP memory
+ * @npackets: number of packets in OTP memory
+ */
+struct mchp_otpc {
+	void __iomem *base;
+	struct device *dev;
+	struct list_head packets;
+	u32 npackets;
+};
+
+/**
+ * struct mchp_otpc_packet - OTPC packet data structure
+ * @list: list head
+ * @id: packet ID
+ * @offset: packet offset (in words) in OTP memory
+ */
+struct mchp_otpc_packet {
+	struct list_head list;
+	u32 id;
+	u32 offset;
+};
+
+static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
+						       u32 id)
+{
+	struct mchp_otpc_packet *packet;
+
+	if (id >= otpc->npackets)
+		return NULL;
+
+	list_for_each_entry(packet, &otpc->packets, list) {
+		if (packet->id == id)
+			return packet;
+	}
+
+	return NULL;
+}
+
+static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
+				  unsigned int offset)
+{
+	u32 tmp;
+
+	/* Set address. */
+	tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
+	tmp &= ~MCHP_OTPC_MR_ADDR;
+	tmp |= FIELD_PREP(MCHP_OTPC_MR_ADDR, offset);
+	writel_relaxed(tmp, otpc->base + MCHP_OTPC_MR);
+
+	/* Set read. */
+	tmp = readl_relaxed(otpc->base + MCHP_OTPC_CR);
+	tmp |= MCHP_OTPC_CR_READ;
+	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);
+
+	/* Wait for packet to be transferred into temporary buffers. */
+	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
+				 10000, 2000, false, otpc->base + MCHP_OTPC_SR);
+}
+
+/*
+ * OTPC memory is organized into packets. Each packets contains a header and
+ * a payload. Header is 4 bytes long and contains the size of the payload.
+ * Payload size varies. The memory footprint is something as follows:
+ *
+ * Memory offset  Memory footprint     Packet ID
+ * -------------  ----------------     ---------
+ *
+ * 0x0            +------------+   <-- packet 0
+ *                | header  0  |
+ * 0x4            +------------+
+ *                | payload 0  |
+ *                .            .
+ *                .    ...     .
+ *                .            .
+ * offset1        +------------+   <-- packet 1
+ *                | header  1  |
+ * offset1 + 0x4  +------------+
+ *                | payload 1  |
+ *                .            .
+ *                .    ...     .
+ *                .            .
+ * offset2        +------------+   <-- packet 2
+ *                .            .
+ *                .    ...     .
+ *                .            .
+ * offsetN        +------------+   <-- packet N
+ *                | header  N  |
+ * offsetN + 0x4  +------------+
+ *                | payload N  |
+ *                .            .
+ *                .    ...     .
+ *                .            .
+ *                +------------+
+ *
+ * where offset1, offset2, offsetN depends on the size of payload 0, payload 1,
+ * payload N-1.
+ *
+ * The access to memory is done on a per packet basis: the control registers
+ * need to be updated with an offset address (within a packet range) and the
+ * data registers will be update by controller with information contained by
+ * that packet. E.g. if control registers are updated with any address within
+ * the range [offset1, offset2) the data registers are updated by controller
+ * with packet 1. Header data is accessible though MCHP_OTPC_HR register.
+ * Payload data is accessible though MCHP_OTPC_DR and MCHP_OTPC_AR registers.
+ * There is no direct mapping b/w the offset requested by software and the
+ * offset returned by hardware.
+ *
+ * For this, the read function will return the first requested bytes in the
+ * packet. The user will have to be aware of the memory footprint before doing
+ * the read request.
+ */
+static int mchp_otpc_read(void *priv, unsigned int off, void *val,
+			  size_t bytes)
+{
+	struct mchp_otpc *otpc = priv;
+	struct mchp_otpc_packet *packet;
+	u32 *buf = val;
+	u32 offset;
+	size_t len = 0;
+	int ret, payload_size;
+
+	/*
+	 * We reach this point with off being multiple of stride = 4 to
+	 * be able to cross the subsystem. Inside the driver we use continuous
+	 * unsigned integer numbers for packet id, thus devide off by 4
+	 * before passing it to mchp_otpc_id_to_packet().
+	 */
+	packet = mchp_otpc_id_to_packet(otpc, off / 4);
+	if (!packet)
+		return -EINVAL;
+	offset = packet->offset;
+
+	while (len < bytes) {
+		ret = mchp_otpc_prepare_read(otpc, offset);
+		if (ret)
+			return ret;
+
+		/* Read and save header content. */
+		*buf++ = readl_relaxed(otpc->base + MCHP_OTPC_HR);
+		len += sizeof(*buf);
+		offset++;
+		if (len >= bytes)
+			break;
+
+		/* Read and save payload content. */
+		payload_size = FIELD_GET(MCHP_OTPC_HR_SIZE, *(buf - 1));
+		writel_relaxed(0UL, otpc->base + MCHP_OTPC_AR);
+		do {
+			*buf++ = readl_relaxed(otpc->base + MCHP_OTPC_DR);
+			len += sizeof(*buf);
+			offset++;
+			payload_size--;
+		} while (payload_size >= 0 && len < bytes);
+	}
+
+	return 0;
+}
+
+static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
+{
+	struct mchp_otpc_packet *packet;
+	u32 word, word_pos = 0, id = 0, npackets = 0, payload_size;
+	int ret;
+
+	INIT_LIST_HEAD(&otpc->packets);
+	*size = 0;
+
+	while (*size < MCHP_OTPC_SIZE) {
+		ret = mchp_otpc_prepare_read(otpc, word_pos);
+		if (ret)
+			return ret;
+
+		word = readl_relaxed(otpc->base + MCHP_OTPC_HR);
+		payload_size = FIELD_GET(MCHP_OTPC_HR_SIZE, word);
+		if (!payload_size)
+			break;
+
+		packet = devm_kzalloc(otpc->dev, sizeof(*packet), GFP_KERNEL);
+		if (!packet)
+			return -ENOMEM;
+
+		packet->id = id++;
+		packet->offset = word_pos;
+		INIT_LIST_HEAD(&packet->list);
+		list_add_tail(&packet->list, &otpc->packets);
+
+		/* Count size by adding header and paload sizes. */
+		*size += 4 * (payload_size + 1);
+		/* Next word: this packet (header, payload) position + 1. */
+		word_pos += payload_size + 2;
+
+		npackets++;
+	}
+
+	otpc->npackets = npackets;
+
+	return 0;
+}
+
+static struct nvmem_config mchp_nvmem_config = {
+	.name = MCHP_OTPC_NAME,
+	.type = NVMEM_TYPE_OTP,
+	.read_only = true,
+	.word_size = 4,
+	.stride = 4,
+	.reg_read = mchp_otpc_read,
+};
+
+static int mchp_otpc_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+	struct mchp_otpc *otpc;
+	u32 size;
+	int ret;
+
+	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
+	if (!otpc)
+		return -ENOMEM;
+
+	otpc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(otpc->base))
+		return PTR_ERR(otpc->base);
+
+	otpc->dev = &pdev->dev;
+	ret = mchp_otpc_init_packets_list(otpc, &size);
+	if (ret)
+		return ret;
+
+	mchp_nvmem_config.dev = otpc->dev;
+	mchp_nvmem_config.size = size;
+	mchp_nvmem_config.priv = otpc;
+	nvmem = devm_nvmem_register(&pdev->dev, &mchp_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id mchp_otpc_ids[] = {
+	{ .compatible = "microchip,sama7g5-otpc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mchp_otpc_ids);
+
+static struct platform_driver mchp_otpc_driver = {
+	.probe = mchp_otpc_probe,
+	.driver = {
+		.name = MCHP_OTPC_NAME,
+		.of_match_table = of_match_ptr(mchp_otpc_ids),
+	},
+};
+module_platform_driver(mchp_otpc_driver);
+
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");
+MODULE_DESCRIPTION("Microchip SAMA7G5 OTPC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

