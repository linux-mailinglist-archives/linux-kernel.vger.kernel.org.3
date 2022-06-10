Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54816546D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347061AbiFJTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:16:54 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 12:16:53 PDT
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E679EE0A;
        Fri, 10 Jun 2022 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2055; q=dns/txt; s=iport;
  t=1654888613; x=1656098213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u72bLTf2B+c8SBz+AstWagpFwrtX94lEUqCSNIL9kHo=;
  b=d1jkO5u3qGS/m0jkcW0iJL9yFO63TChd1ZI4SSMA3/loFmBj1qUyF0LE
   IQgPwCggPk04Ez8kUP4TqKYXytu8NXVUWSxaFQV9DzAs5bwIsif2IQDpk
   1wlvbCCo9xWfwA5sQFqvFnnjQpHlPzG9jyiydWDIgdwA19Y1U/RmUMKjz
   k=;
X-IronPort-AV: E=Sophos;i="5.91,291,1647302400"; 
   d="scan'208";a="886185543"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 10 Jun 2022 19:15:49 +0000
Received: from sjc-ads-3421.cisco.com (sjc-ads-3421.cisco.com [171.68.249.119])
        by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id 25AJFmaB012979;
        Fri, 10 Jun 2022 19:15:48 GMT
From:   Oleksandr Ocheretnyi <oocheret@cisco.com>
To:     mika.westerberg@linux.intel.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, p.yadav@ti.com, michael@walle.cc,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     mauro.lima@eclypsium.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, oocheret@cisco.com,
        xe-linux-external@cisco.com
Subject: [PATCH] mtd: spi-nor: handle unsupported FSR opcodes properly
Date:   Fri, 10 Jun 2022 12:15:48 -0700
Message-Id: <20220610191548.3626218-1-oocheret@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <YmZUCIE/ND82BlNh@lahna>
References: <YmZUCIE/ND82BlNh@lahna>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.68.249.119, sjc-ads-3421.cisco.com
X-Outbound-Node: alln-core-10.cisco.com
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q* entries")
and following one 8f93826 ("mtd: spi-nor: micron-st: convert USE_FSR
to a manufacturer flag") enables SPINOR_OP_RDFSR opcode handling ability,
however some controller drivers still cannot handle it properly in
the micron_st_nor_ready() call what breaks some mtd callbacks with
next error logs:

mtdblock: erase of region [address1, size1] on "BIOS" failed
mtdblock: erase of region [address2, size2] on "BIOS" failed

Just skip subsequent processing of the SPINOR_OP_RDFSR opcode's results
because of -ENOTSUPP return value of the micron_st_nor_read_fsr()
if there is no proper handling of that opcode as it's been before
commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q* entries")

Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
---
 drivers/mtd/spi-nor/micron-st.c | 6 +++++-
 drivers/spi/spi-intel.c         | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index a96f74e0f568..507e675d81e0 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -399,8 +399,12 @@ static int micron_st_nor_ready(struct spi_nor *nor)
 		return sr_ready;
 
 	ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
-	if (ret)
+	if (ret < 0) {
+		/* Check if read FSR is supported. If not, skip it. */
+		if (ret == -ENOTSUPP)
+			return sr_ready;
 		return ret;
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
2.28.0

