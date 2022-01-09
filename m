Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0E4887A5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 05:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiAIEou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 23:44:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45246 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiAIEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 23:44:49 -0500
Received: from microsoft.com (unknown [50.47.106.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1967D20B7179;
        Sat,  8 Jan 2022 20:44:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1967D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641703489;
        bh=lM17pZ6iCOU37RIPTzxAvgHmS64CHTJOGzcs8Z4rB34=;
        h=From:To:Cc:Subject:Date:From;
        b=Pt81cE8fadR7R460L1iG8bsxgGyCM/Bsiat2And1RpMyQOdUl5tByVzm35+6jCJTE
         UJ0Y8oWiMG2cPhiVvBlAh5dCxLpYFjBKOPB5KbOGmM9OOu6gpEKeLgZLFNL9F/Y8Wa
         fat3yJpF4IuUWzWQlsNUoannnzAKi2cZALoSiq04=
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dhananjay Phadke <dphadke@linux.microsoft.com>
Subject: [PATCH] mtd: spi-nor: Add support for w25q512jvm
Date:   Sat,  8 Jan 2022 20:44:18 -0800
Message-Id: <20220109044418.4657-1-dphadke@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Winbond 64MB W25Q512JV-DTR NOR flash.
Use PARSE_SFDP flag to init parameters during SFDP parsing.

Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 675f32c136b3..ebc826e21f76 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -118,6 +118,8 @@ static const struct flash_info winbond_parts[] = {
 		.fixups = &w25q256_fixups },
 	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512)
 		PARSE_SFDP },
+	{ "w25q512jvm", INFO(0xef7020, 0, 64 * 1024, 1024),
+		PARSE_SFDP },
 	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
-- 
2.25.1

