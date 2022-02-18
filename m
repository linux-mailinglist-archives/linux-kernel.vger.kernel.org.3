Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177C4BBBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiBRPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:01:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiBRPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:00:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F3E61C0;
        Fri, 18 Feb 2022 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645196349; x=1676732349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1kB/UXvtaiyeXTg8NuvWf/Arx24JYsUgr40cN0Fyi6s=;
  b=TdnaZrZsh2FuRviuIhCzd4htnrysYkQibMjtwxBWtx+e7t0qF7GZSZXV
   DRdcB9F9STv/GFK7yauuqbFxBHV0nsD5ssBJbaPTRgueq9QlS4nktj+SB
   H91ELhbbSikBpJIq1MzIxoAYMCe21UJ/MYN2QvBpeJteqBcRWpnsH8Q0h
   gD8+y+TwOeGZNxLy5gf2JDImmouOOKK8EGzkzDPj8+EM3XCKEvpoH5PWV
   j0/T8fjvqsEdaMoueku18Tx+h9SS2PJGx1/08+oe+apW4D9XvhoQUI5mW
   Y1sLllrfYouK46McTrWZuqq6bfjCNQPZOlYn9OyqOnUNQ9EnyUbQMiIY1
   g==;
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="154088331"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 07:59:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 07:59:08 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 07:59:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/4] spi: spi-mem: Allow specifying the byte order in DTR mode
Date:   Fri, 18 Feb 2022 16:58:57 +0200
Message-ID: <20220218145900.1440045-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
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

There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
when configured in DTR mode. The byte order of 16-bit words is swapped
when read or written in Double Transfer Rate (DTR) mode compared to
Single Transfer Rate (STR) mode. If one writes D0 D1 D2 D3 bytes using
1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will read back
D1 D0 D3 D2. Swapping the bytes is a bad design decision because this may
introduce some endianness problems. It can affect the boot sequence if the
entire boot sequence is not handled in either 8D-8D-8D mode or 1-1-1 mode.
Fortunately there are controllers that can swap back the bytes at runtime,
fixing the endiannesses. Provide a way for the upper layers to specify the
byte order in DTR mode.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 include/linux/spi/spi-mem.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..e1878417420c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -89,6 +89,8 @@ enum spi_mem_data_dir {
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.dtr_bswap16: whether the byte order of 16-bit words is swapped when
+ *		      read or written in DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
@@ -119,6 +121,7 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 dtr_bswap16 : 1;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		union {
-- 
2.25.1

