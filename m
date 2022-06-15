Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7B54D15F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356899AbiFOTL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiFOTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:11:56 -0400
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EC41985;
        Wed, 15 Jun 2022 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2629; q=dns/txt; s=iport;
  t=1655320316; x=1656529916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vnvt0MqP5LNDaqxR7L6ZH2qCRCr8hhIb7hMFw1y0Sp0=;
  b=WjjCodkFJQ2BckZ9hvdPmbAJmQcwgFlpgKlhV1hhFoRocNRM2mkTKZ+K
   Gurwf/mjZruVVFxGOGvvv9VA9Jegb3dhKid1KXLgg4AqxdQ+unRTFojD9
   Wtz0ARY2YrWQaHBryZEXj9+GL6+qlMdEzZbrCHA4oLxYoXRsyCh1FsdpW
   4=;
X-IronPort-AV: E=Sophos;i="5.91,302,1647302400"; 
   d="scan'208";a="862238780"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Jun 2022 19:11:55 +0000
Received: from sjc-ads-3421.cisco.com (sjc-ads-3421.cisco.com [171.68.249.119])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id 25FJBrvQ017942;
        Wed, 15 Jun 2022 19:11:54 GMT
From:   Oleksandr Ocheretnyi <oocheret@cisco.com>
To:     mika.westerberg@linux.intel.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, p.yadav@ti.com, michael@walle.cc,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     mauro.lima@eclypsium.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, oocheret@cisco.com,
        xe-linux-external@cisco.com
Subject: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Date:   Wed, 15 Jun 2022 12:11:53 -0700
Message-Id: <20220615191153.3017939-1-oocheret@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
References: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.68.249.119, sjc-ads-3421.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q*
entries") and following one 8f93826 ("mtd: spi-nor: micron-st: convert
USE_FSR to a manufacturer flag") enabled SPINOR_OP_RDFSR opcode handling
ability, however some controller drivers still cannot handle it properly
in the micron_st_nor_ready() call what breaks some mtd callbacks with
next error logs:

mtdblock: erase of region [address1, size1] on "BIOS" failed
mtdblock: erase of region [address2, size2] on "BIOS" failed

The Intel SPI controller does not support low level operations, like
reading the flag status register (FSR). It only exposes a set of high
level operations for software to use. For this reason check the return
value of micron_st_nor_read_fsr() and if the operation was not
supported, use the status register value only. This allows the chip to
work even when attached to Intel SPI controller (there are such systems
out there).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
Link: https://lore.kernel.org/lkml/YmZUCIE%2FND82BlNh@lahna/
---
 drivers/mtd/spi-nor/micron-st.c | 12 ++++++++++--
 drivers/spi/spi-intel.c         |  3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index a96f74e0f568..fd52e8feea44 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -399,8 +399,16 @@ static int micron_st_nor_ready(struct spi_nor *nor)
 		return sr_ready;
 
 	ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
+	if (ret < 0) {
+		/*
+		 * Some controllers, such as Intel SPI, do not support low
+		 * level operations such as reading the flag status
+		 * register. They only expose small amount of high level
+		 * operations to the software. If this is the case we use
+		 * only the status register value.
+		 */
+		return (ret == -ENOTSUPP || ret == -EOPNOTSUPP) ? sr_ready : ret;
+	}
 
 	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
 		if (nor->bouncebuf[0] & FSR_E_ERR)
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 50f42983b950..2659c8337937 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -352,7 +352,8 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t len)
 		val |= HSFSTS_CTL_FCYCLE_RDSR;
 		break;
 	default:
-		return -EINVAL;
+		dev_dbg(ispi->dev, "%#x not supported\n", opcode);
+		return -EOPNOTSUPP;
 	}
 
 	if (len > INTEL_SPI_FIFO_SZ)
-- 
2.26.2.Cisco

