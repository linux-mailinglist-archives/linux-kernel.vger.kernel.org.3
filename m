Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC34B48BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbiBNJ54 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 04:57:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiBNJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:52:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367B7B56B;
        Mon, 14 Feb 2022 01:43:30 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E7I6ln012418;
        Mon, 14 Feb 2022 09:42:49 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4dscne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21E9biMZ021915;
        Mon, 14 Feb 2022 09:42:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jbjsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21E9giSe32112926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 09:42:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A3244C05C;
        Mon, 14 Feb 2022 09:42:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAEEA4C058;
        Mon, 14 Feb 2022 09:42:43 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 09:42:43 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.60.190])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 450A22201DE;
        Mon, 14 Feb 2022 10:42:42 +0100 (CET)
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
Subject: [PATCH 04/10] spi: aspeed: Add support for direct mapping
Date:   Mon, 14 Feb 2022 10:42:25 +0100
Message-Id: <20220214094231.3753686-5-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RDI0kDGsSi27dmJvpa1XfnlHaaH83rG_
X-Proofpoint-ORIG-GUID: RDI0kDGsSi27dmJvpa1XfnlHaaH83rG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_01,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1034 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140058
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Direct mapping for writes will come later when validated.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0aeff6f468af..8d33fcb7736a 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -345,8 +345,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
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
@@ -426,10 +426,73 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
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
 
 static void aspeed_spi_chip_set_type(struct aspeed_spi_chip *chip, int type)
-- 
2.34.1

