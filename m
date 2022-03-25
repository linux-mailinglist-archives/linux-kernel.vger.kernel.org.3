Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDFB4E70BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358718AbiCYKL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Mar 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiCYKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:11:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8165715F;
        Fri, 25 Mar 2022 03:09:51 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P9kZa3012005;
        Fri, 25 Mar 2022 10:09:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0sd4e335-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:12 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22P9pttB003878;
        Fri, 25 Mar 2022 10:09:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0sd4e327-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22P9xLML008133;
        Fri, 25 Mar 2022 10:09:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ew6t94x3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22PA99gB45547832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 10:09:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E68C42042;
        Fri, 25 Mar 2022 10:09:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B085A4203F;
        Fri, 25 Mar 2022 10:09:04 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 25 Mar 2022 10:09:04 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.95.248])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 1EC0C220158;
        Fri, 25 Mar 2022 11:09:03 +0100 (CET)
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
Subject: [PATCH v4 07/11] spi: aspeed: Add support for the AST2400 SPI controller
Date:   Fri, 25 Mar 2022 11:08:45 +0100
Message-Id: <20220325100849.2019209-8-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325100849.2019209-1-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bLx3DTGnnb3_0mbTsof4KGwop6tvumau
X-Proofpoint-ORIG-GUID: W3tqwvmxnvUuDUaKidCdY2oFBQ6Phc8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1034 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250057
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the driver for the AST2400 SPI Flash Controller (SPI). This
controller has a slightly different interface which requires
adaptation of the 4B handling. Summary of features :

   . host Firmware
   . 1 chip select pin (CE0)
   . slightly different register set, between AST2500 and the legacy
     controller
   . no segment registers
   . single, dual mode.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index ab6fa5cfad9c..7f306da7c44e 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -30,6 +30,7 @@
 #define   CTRL_IO_DUAL_DATA		BIT(29)
 #define   CTRL_IO_QUAD_DATA		BIT(30)
 #define   CTRL_COMMAND_SHIFT		16
+#define   CTRL_IO_ADDRESS_4B		BIT(13)	/* AST2400 SPI only */
 #define   CTRL_IO_DUMMY_SET(dummy)					\
 	(((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
 #define   CTRL_CE_STOP_ACTIVE		BIT(2)
@@ -270,6 +271,8 @@ static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static const struct aspeed_spi_data ast2400_spi_data;
+
 static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
@@ -299,6 +302,9 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 			addr_mode |= (0x11 << chip->cs);
 		else
 			addr_mode &= ~(0x11 << chip->cs);
+
+		if (op->addr.nbytes == 4 && chip->aspi->data == &ast2400_spi_data)
+			ctl_val |= CTRL_IO_ADDRESS_4B;
 	}
 
 	if (op->dummy.buswidth && op->dummy.nbytes)
@@ -390,7 +396,13 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] = { 0 };
 	struct aspeed_spi_window *win = &windows[chip->cs];
 
-	aspeed_spi_get_windows(aspi, windows);
+	/* No segment registers for the AST2400 SPI controller */
+	if (aspi->data == &ast2400_spi_data) {
+		win->offset = 0;
+		win->size = aspi->ahb_window_size;
+	} else {
+		aspeed_spi_get_windows(aspi, windows);
+	}
 
 	chip->ahb_base = aspi->ahb_base + win->offset;
 	chip->ahb_window_size = win->size;
@@ -453,6 +465,10 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 	struct aspeed_spi_window *win = &windows[chip->cs];
 	int ret;
 
+	/* No segment registers for the AST2400 SPI controller */
+	if (aspi->data == &ast2400_spi_data)
+		return 0;
+
 	/*
 	 * Due to an HW issue on the AST2500 SPI controller, the CE0
 	 * window size should be smaller than the maximum 128MB.
@@ -537,6 +553,12 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		else
 			addr_mode &= ~(0x11 << chip->cs);
 		writel(addr_mode, aspi->regs + CE_CTRL_REG);
+
+		/* AST2400 SPI controller sets 4BYTE address mode in
+		 * CE0 Control Register
+		 */
+		if (op->addr.nbytes == 4 && chip->aspi->data == &ast2400_spi_data)
+			ctl_val |= CTRL_IO_ADDRESS_4B;
 	}
 
 	/* READ mode is the controller default setting */
@@ -803,6 +825,14 @@ static const struct aspeed_spi_data ast2400_fmc_data = {
 	.segment_reg   = aspeed_spi_segment_reg,
 };
 
+static const struct aspeed_spi_data ast2400_spi_data = {
+	.max_cs	       = 1,
+	.hastype       = false,
+	.we0	       = 0,
+	.ctl0	       = 0x04,
+	/* No segment registers */
+};
+
 static const struct aspeed_spi_data ast2500_fmc_data = {
 	.max_cs	       = 3,
 	.hastype       = true,
@@ -847,6 +877,7 @@ static const struct aspeed_spi_data ast2600_spi_data = {
 
 static const struct of_device_id aspeed_spi_matches[] = {
 	{ .compatible = "aspeed,ast2400-fmc", .data = &ast2400_fmc_data },
+	{ .compatible = "aspeed,ast2400-spi", .data = &ast2400_spi_data },
 	{ .compatible = "aspeed,ast2500-fmc", .data = &ast2500_fmc_data },
 	{ .compatible = "aspeed,ast2500-spi", .data = &ast2500_spi_data },
 	{ .compatible = "aspeed,ast2600-fmc", .data = &ast2600_fmc_data },
-- 
2.34.1

