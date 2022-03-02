Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258714CAC2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiCBReQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 12:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbiCBRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:33:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F2D227B;
        Wed,  2 Mar 2022 09:32:12 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222HIjQc030946;
        Wed, 2 Mar 2022 17:31:29 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejcvcg7nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 17:31:29 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222HCnKr027063;
        Wed, 2 Mar 2022 17:31:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3efbu8wx22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 17:31:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222HKSAG46137690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 17:20:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D8BDA404D;
        Wed,  2 Mar 2022 17:31:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4908A4051;
        Wed,  2 Mar 2022 17:31:23 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  2 Mar 2022 17:31:23 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.58.125])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 6DD70220294;
        Wed,  2 Mar 2022 18:31:22 +0100 (CET)
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
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 05/10] spi: aspeed: Add support for direct mapping
Date:   Wed,  2 Mar 2022 18:31:09 +0100
Message-Id: <20220302173114.927476-6-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302173114.927476-1-clg@kaod.org>
References: <20220302173114.927476-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YrwodOc56BQdphnNE7fKZ0a7_Z5eki6X
X-Proofpoint-ORIG-GUID: YrwodOc56BQdphnNE7fKZ0a7_Z5eki6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1034 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020076
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use direct mapping to read the flash device contents. This operation
mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
Control Register for the settings to apply when a memory operation is
performed on the flash device mapping window.

If the window is not big enough, fall back to the "User mode" to
perform the read.

Since direct mapping now handles all reads of the flash device
contents, also use memcpy_fromio for other address spaces, such as
SFDP.

Direct mapping for writes will come later when validated.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 688f9472e0d7..b4854b521477 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -324,8 +324,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		if (!op->addr.nbytes)
 			ret = aspeed_spi_read_reg(chip, op);
 		else
-			ret = aspeed_spi_read_user(chip, op, op->addr.val,
-						   op->data.nbytes, op->data.buf.in);
+			memcpy_fromio(op->data.buf.in, chip->ahb_base + op->addr.val,
+				      op->data.nbytes);
 	} else {
 		if (!op->addr.nbytes)
 			ret = aspeed_spi_write_reg(chip, op);
@@ -405,10 +405,73 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	return chip->ahb_window_size ? 0 : -1;
 }
 
+static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
+	struct spi_mem_op *op = &desc->info.op_tmpl;
+	u32 ctl_val;
+	int ret = 0;
+
+	chip->clk_freq = desc->mem->spi->max_speed_hz;
+
+	/* Only for reads */
+	if (op->data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
+	if (desc->info.length > chip->ahb_window_size)
+		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
+			 chip->cs, chip->ahb_window_size >> 20);
+
+	/* Define the default IO read settings */
+	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
+	ctl_val |= aspeed_spi_get_io_mode(op) |
+		op->cmd.opcode << CTRL_COMMAND_SHIFT |
+		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
+		CTRL_IO_MODE_READ;
+
+	/* Tune 4BYTE address mode */
+	if (op->addr.nbytes) {
+		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
+
+		if (op->addr.nbytes == 4)
+			addr_mode |= (0x11 << chip->cs);
+		else
+			addr_mode &= ~(0x11 << chip->cs);
+		writel(addr_mode, aspi->regs + CE_CTRL_REG);
+	}
+
+	/* READ mode is the controller default setting */
+	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+
+	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
+		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
+
+	return ret;
+}
+
+static int aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				  u64 offset, size_t len, void *buf)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
+
+	/* Switch to USER command mode if mapping window is too small */
+	if (chip->ahb_window_size < offset + len)
+		aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
+	else
+		memcpy_fromio(buf, chip->ahb_base + offset, len);
+
+	return len;
+}
+
 static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
 	.supports_op = aspeed_spi_supports_op,
 	.exec_op = aspeed_spi_exec_op,
 	.get_name = aspeed_spi_get_name,
+	.dirmap_create = aspeed_spi_dirmap_create,
+	.dirmap_read = aspeed_spi_dirmap_read,
 };
 
 static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned int cs, int type)
-- 
2.34.1

