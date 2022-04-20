Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87350860B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377717AbiDTKiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351890AbiDTKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:37:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32962676
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650450899; x=1681986899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CgU0M9Ctm66tAtz7ZrqfIj4aDO8PJLE7JPM+0GAyffk=;
  b=lFZnQHxwUWRG/OUKn9Gt/JkUlv7H9q6QnosDFX5o9MWk2eNlgHxn+rkS
   0i3EFc/tAEisjB5o80dHNLim55aEQoCQ37OXRNMwGZikAutZnV/+HX3hm
   Mjt5FL4hSiXCrX0af9Nq93QpBXg0YQN/JO7jYrzRL1YjW/MKzKgoOI1g7
   QKz9ZhEjpUAlNDyV2QjIT+xPnfjw1Jxifr7IXKbHPbH0GyRdn4qbMty7f
   khFC1RoAgdbpBjPHtS+fV3JRF2m9WZPfNpxOicsgfwRIx1/44DhARWlNy
   gLdpBDbSMSeeOXZy1iVUQgci/aEZ9WuoSoqLC66zhlqxvv91MifcwO9P5
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="170245898"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 03:34:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 03:34:58 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 03:34:56 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v4 11/11] mtd: spi-nor: micron-st: Remove status polling on volatile registers write
Date:   Wed, 20 Apr 2022 13:34:27 +0300
Message-ID: <20220420103427.47867-12-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420103427.47867-1-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing volatile registers are instant according to Micron and do not
need any status polling. Remove status polling on volatile registers write.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/micron-st.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 61db4896e327..a96f74e0f568 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -58,9 +58,6 @@ static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
 	op = (struct spi_mem_op)
 		MICRON_ST_NOR_WR_ANY_REG_OP(3, SPINOR_REG_MT_CFR1V, 1, buf);
 	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
-	if (ret)
-		return ret;
-	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
 
-- 
2.25.1

