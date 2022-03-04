Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9EB4CD028
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiCDIiv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 03:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiCDIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:38:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94D36168;
        Fri,  4 Mar 2022 00:37:40 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2248Nfrw022009;
        Fri, 4 Mar 2022 08:37:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekf7j06v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:37:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2248YcLf023379;
        Fri, 4 Mar 2022 08:37:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekf7j06uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:37:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2248XpCV010670;
        Fri, 4 Mar 2022 08:37:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3ek4kg97hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:37:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2248avVP48693588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 08:36:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE0B252050;
        Fri,  4 Mar 2022 08:36:57 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 3E4A452054;
        Fri,  4 Mar 2022 08:36:57 +0000 (GMT)
Received: from yukon.home (unknown [9.171.91.16])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id A78222200FD;
        Fri,  4 Mar 2022 09:36:55 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 06/11] spi: aspeed: Adjust direct mapping to device size
Date:   Fri,  4 Mar 2022 09:36:38 +0100
Message-Id: <20220304083643.1079142-7-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304083643.1079142-1-clg@kaod.org>
References: <20220304083643.1079142-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ct2EAHYCSUWyU7RIvLyAusI7qOo6DQAy
X-Proofpoint-ORIG-GUID: 3nipNoVki59muBsYk_Z7XmXktv9TzCPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_02,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1034
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040044
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The segment registers of the FMC/SPI controllers provide a way to
configure the mapping window of the flash device contents on the AHB
bus. Adjust this window to the size of the spi-mem mapping.

Things get more complex with multiple devices. The driver needs to
also adjust the window of the next device to make sure that there is
no overlap, even if there is no available device. The proposal below
is not perfect but it is covering all the cases we have seen on
different boards with one and two devices on the same bus.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 88 ++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0951766baef4..9f7910e79ae8 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -403,6 +403,92 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	return chip->ahb_window_size ? 0 : -1;
 }
 
+static int aspeed_spi_set_window(struct aspeed_spi *aspi,
+				 const struct aspeed_spi_window *win)
+{
+	u32 start = aspi->ahb_base_phy + win->offset;
+	u32 end = start + win->size;
+	void __iomem *seg_reg = aspi->regs + CE0_SEGMENT_ADDR_REG + win->cs * 4;
+	u32 seg_val_backup = readl(seg_reg);
+	u32 seg_val = aspi->data->segment_reg(aspi, start, end);
+
+	if (seg_val == seg_val_backup)
+		return 0;
+
+	writel(seg_val, seg_reg);
+
+	/*
+	 * Restore initial value if something goes wrong else we could
+	 * loose access to the chip.
+	 */
+	if (seg_val != readl(seg_reg)) {
+		dev_err(aspi->dev, "CE%d invalid window [ 0x%.8x - 0x%.8x ] %dMB",
+			win->cs, start, end - 1, win->size >> 20);
+		writel(seg_val_backup, seg_reg);
+		return -EIO;
+	}
+
+	if (win->size)
+		dev_dbg(aspi->dev, "CE%d new window [ 0x%.8x - 0x%.8x ] %dMB",
+			win->cs, start, end - 1,  win->size >> 20);
+	else
+		dev_dbg(aspi->dev, "CE%d window closed", win->cs);
+
+	return 0;
+}
+
+/*
+ * Yet to be done when possible :
+ * - Align mappings on flash size (we don't have the info)
+ * - ioremap each window, not strictly necessary since the overall window
+ *   is correct.
+ */
+static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
+					 u32 local_offset, u32 size)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] = { 0 };
+	struct aspeed_spi_window *win = &windows[chip->cs];
+	int ret;
+
+	aspeed_spi_get_windows(aspi, windows);
+
+	/* Adjust this chip window */
+	win->offset += local_offset;
+	win->size = size;
+
+	if (win->offset + win->size > aspi->ahb_window_size) {
+		win->size = aspi->ahb_window_size - win->offset;
+		dev_warn(aspi->dev, "CE%d window resized to %dMB", chip->cs, win->size >> 20);
+	}
+
+	ret = aspeed_spi_set_window(aspi, win);
+	if (ret)
+		return ret;
+
+	/* Update chip mapping info */
+	chip->ahb_base = aspi->ahb_base + win->offset;
+	chip->ahb_window_size = win->size;
+
+	/*
+	 * Also adjust next chip window to make sure that it does not
+	 * overlap with the current window.
+	 */
+	if (chip->cs < aspi->data->max_cs - 1) {
+		struct aspeed_spi_window *next = &windows[chip->cs + 1];
+
+		/* Change offset and size to keep the same end address */
+		if ((next->offset + next->size) > (win->offset + win->size))
+			next->size = (next->offset + next->size) - (win->offset + win->size);
+		else
+			next->size = 0;
+		next->offset = win->offset + win->size;
+
+		aspeed_spi_set_window(aspi, next);
+	}
+	return 0;
+}
+
 static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
@@ -417,6 +503,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (op->data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
+	aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info.length);
+
 	if (desc->info.length > chip->ahb_window_size)
 		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
 			 chip->cs, chip->ahb_window_size >> 20);
-- 
2.34.1

