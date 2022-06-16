Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6754E09F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiFPMOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiFPMOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:14:49 -0400
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E0D220DB;
        Thu, 16 Jun 2022 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2777; q=dns/txt; s=iport;
  t=1655381688; x=1656591288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utAeUQ7pAkd42bz7uEkmhVg3HUntGqQ92mWa3gY3aqc=;
  b=SkojEQy6YLV0oR7dLLEgFO1kpqP6HKzrIV8pweXu7vj3ZY6ZxB9UDiLc
   WXcLrS//7u1YESoNBMq+SURzu3Kyc8LLXOFlAKerY7iDJUTFsPxQwfd0u
   f4tsxa7Bk7QnSKVYgvNksZIqeElDdtfnLi/ppoIZFeekuD4J+FTnQkCoV
   w=;
X-IronPort-AV: E=Sophos;i="5.91,305,1647302400"; 
   d="scan'208";a="871309368"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Jun 2022 12:14:47 +0000
Received: from sjc-ads-3421.cisco.com (sjc-ads-3421.cisco.com [171.68.249.119])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 25GCEk4r029590;
        Thu, 16 Jun 2022 12:14:46 GMT
From:   Oleksandr Ocheretnyi <oocheret@cisco.com>
To:     mika.westerberg@linux.intel.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, p.yadav@ti.com, michael@walle.cc,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     mauro.lima@eclypsium.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, oocheret@cisco.com,
        xe-linux-external@cisco.com
Subject: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Date:   Thu, 16 Jun 2022 05:14:45 -0700
Message-Id: <20220616121446.293408-1-oocheret@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <YqsHcL5NPcZ4De77@lahna>
References: <YqsHcL5NPcZ4De77@lahna>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.68.249.119, sjc-ads-3421.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
Link: https://lore.kernel.org/lkml/YmZUCIE%2FND82BlNh@lahna/
---
 PATCH v2 updates PATCH v1 taking into account changes from
 https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.westerberg@linux.intel.com
 to check -EOPNOTSUPP value from micron_st_nor_read_fsr() as well.

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
index 50f42983b950..f0313a718d1b 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -352,7 +352,8 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t len)
 		val |= HSFSTS_CTL_FCYCLE_RDSR;
 		break;
 	default:
-		return -EINVAL;
+		dev_dbg(ispi->dev, "%#x not supported\n", opcode);
+		return -ENOTSUPP;
 	}
 
 	if (len > INTEL_SPI_FIFO_SZ)
-- 
2.27.0

