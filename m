Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17F34DC889
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiCQOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiCQOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:16:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2FA11F79B;
        Thu, 17 Mar 2022 07:15:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 15BE31F454EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647526518;
        bh=Rvj6hXhx5oIiMiRqmZhlQH3DWaZRCDTwJBG35a0p9L8=;
        h=From:To:Cc:Subject:Date:From;
        b=LdgTTzMOJD8D6qwFBMDuLepdYJp+dym4eoyhYqf66I14W9X5oiG3kQZoQLSlrr5gF
         Q3Qn2PdHii409uSmzNNymxZFRFb3wUHEN7HJyu0yzPpprqdWpBF0RcyxU+4/KTM/Go
         iRiK4YZhw/sA9mk/D9NSBbA4ewIoOOghbXqqhCGoEWsWEuaDC75EftPaflvDkdhtg6
         zWSbuXzFU9e0oXkgGM9BXq2xT64EtYJOg/o1mi5sJ4uv7hhzAbLE3KQvOQ1edb89O0
         L2HXMoU885/Pdo8IOM9YQb8Up4vSxKv+JPKibyJcoRUP26q7g3WZ2S/FVbCVOTLEyp
         byGh/7RYluMbQ==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Stephen Rothwell <sfr@canb.auug.org.au>, krisman@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] spi: amd: Configure device speed
Date:   Thu, 17 Mar 2022 11:14:53 -0300
Message-Id: <20220317141453.15868-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create mechanism to configure device clock frequency. For now, it can
only set the device to use the maximum speed.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/spi/spi-amd.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d909afac6e21..ce4cce50496b 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -35,6 +35,36 @@
 
 #define AMD_SPI_MEM_SIZE	200
 
+#define AMD_SPI_ENA_REG		0x20
+#define AMD_SPI_ALT_SPD_SHIFT	20
+#define AMD_SPI_ALT_SPD_MASK	GENMASK(23, AMD_SPI_ALT_SPD_SHIFT)
+#define AMD_SPI_SPI100_SHIFT	0
+#define AMD_SPI_SPI100_MASK	GENMASK(AMD_SPI_SPI100_SHIFT, AMD_SPI_SPI100_SHIFT)
+#define AMD_SPI_SPEED_REG	0x6C
+#define AMD_SPI_SPD7_SHIFT	8
+#define AMD_SPI_SPD7_MASK	GENMASK(13, AMD_SPI_SPD7_SHIFT)
+
+#define AMD_SPI_MAX_HZ		100000000
+#define AMD_SPI_MIN_HZ		800000
+
+/* Set device speed to the maximum frequency supported */
+static bool max_speed;
+module_param(max_speed, bool, 0644);
+
+enum amd_spi_speed {
+	F_66_66MHz,
+	F_33_33MHz,
+	F_22_22MHz,
+	F_16_66MHz,
+	F_100MHz,
+	F_800KHz,
+	SPI_SPD6,
+	SPI_SPD7,
+	F_50MHz = 0x4,
+	F_4MHz = 0x32,
+	F_3_17MHz = 0x3F
+};
+
 /* M_CMD OP codes for SPI */
 #define AMD_SPI_XFER_TX		1
 #define AMD_SPI_XFER_RX		2
@@ -48,6 +78,19 @@ struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	enum amd_spi_versions version;
+	unsigned int speed_hz;
+};
+
+/**
+ * struct amd_spi_freq - Matches device speed with values to write in regs
+ * @speed_hz: Device frequency
+ * @ena: Value to be written to "enable register"
+ * @spd7: Some frequencies requires to have a value written at SPISPEED register
+ */
+struct amd_spi_freq {
+	unsigned int speed_hz;
+	unsigned int enable_val;
+	unsigned int spd7_val;
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
@@ -170,12 +213,67 @@ static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 	}
 }
 
+static const struct amd_spi_freq amd_spi_freq[] = {
+	{ AMD_SPI_MAX_HZ,   F_100MHz,         0},
+	{       66660000, F_66_66MHz,         0},
+	{       50000000,   SPI_SPD7,   F_50MHz},
+	{       33330000, F_33_33MHz,         0},
+	{       22220000, F_22_22MHz,         0},
+	{       16660000, F_16_66MHz,         0},
+	{        4000000,   SPI_SPD7,    F_4MHz},
+	{        3170000,   SPI_SPD7, F_3_17MHz},
+	{ AMD_SPI_MIN_HZ,   F_800KHz,         0},
+};
+
+static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
+{
+	unsigned int i, spd7_val, enable_val;
+
+	if (speed_hz == amd_spi->speed_hz)
+		return 0;
+
+	if (speed_hz < AMD_SPI_MIN_HZ)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++) {
+		if (speed_hz >= amd_spi_freq[i].speed_hz) {
+			if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
+				return 0;
+
+			amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
+
+			enable_val = (amd_spi_freq[i].enable_val << AMD_SPI_ALT_SPD_SHIFT)
+				     & AMD_SPI_ALT_SPD_MASK;
+			amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, enable_val,
+					       AMD_SPI_ALT_SPD_MASK);
+
+			if (amd_spi->speed_hz == AMD_SPI_MAX_HZ)
+				amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, 1,
+						       AMD_SPI_SPI100_MASK);
+
+			if (amd_spi_freq[i].spd7_val) {
+				spd7_val = (amd_spi_freq[i].spd7_val << AMD_SPI_SPD7_SHIFT)
+					   & AMD_SPI_SPD7_MASK;
+				amd_spi_setclear_reg32(amd_spi, AMD_SPI_SPEED_REG, spd7_val,
+						       AMD_SPI_SPD7_MASK);
+			}
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+};
+
 static int amd_spi_master_setup(struct spi_device *spi)
 {
 	struct amd_spi *amd_spi = spi_master_get_devdata(spi->master);
 
 	amd_spi_clear_fifo_ptr(amd_spi);
 
+	if (max_speed)
+		amd_set_spi_freq(amd_spi, spi->max_speed_hz);
+
 	return 0;
 }
 
-- 
2.35.1

