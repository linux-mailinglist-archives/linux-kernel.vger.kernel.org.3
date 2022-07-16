Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCC576B06
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiGPAHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 20:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiGPAHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 20:07:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2495C17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657930028; x=1689466028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ijOUw4M3pLQOKeOImMyQ2h2NflWNsyke1V/y3rcq7g=;
  b=X3aUyhyjp8p8VGOZ49crTcRQBubHTHWGFXVyQCdO5UhnNwBiEKwwhk+6
   7OBB14Y9hy4eV/3ds5+wRrdM8h6fIVUgb8JaEI4hXLi6YRnydwqEZcDLF
   r0JONth2T4JexPMqwyWMkJteFxbN6KEuqnMqpsid5IMFudGj1YTzfLNyA
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Jul 2022 17:07:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 17:07:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 17:07:07 -0700
Received: from maru.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 17:07:06 -0700
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
CC:     Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] mtd: spi-nor: winbond: add support for W25Q512NW-IQ
Date:   Fri, 15 Jul 2022 17:06:43 -0700
Message-ID: <20220716000643.3541839-2-quic_jaehyoo@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
References: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Winbond W25Q512NW-IQ/IN

Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Link: https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
Changes in v2:
 * Change sector size and number of sector to zero so that it can use parsed
   info from sfdp. (Michael)
 * Added md5sum of sfdp block. (Michael)

Changes in v2:
 * Refined commit message. (Michael)

Test result on AST2600 SoC's SPI controller:
$ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/jedec_id
ef6020

$ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/manufacturer
winbond

$ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/partname
w25q512nwq

$ hexdump /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
0000020 6f00 7074 7420 7365 ff74 ffff ffff ffff
*
0000040 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
00000d0 0aff fff0 ff21 ffdc                    
00000d8

$ md5sum /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
e1484fe7c993adaee5ea0d6246f52817

$ flash_otp_info -u /dev/mtd0
Number of OTP user blocks on /dev/mtd0: 3
block  0:  offset = 0x0000  size = 256 bytes  [unlocked]
block  1:  offset = 0x0100  size = 256 bytes  [unlocked]
block  2:  offset = 0x0200  size = 256 bytes  [unlocked]

$ flash_otp_dump -u /dev/mtd0 0x2d0
OTP user data for /dev/mtd0
0x02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

$ echo -n otp test | flash_otp_write -u /dev/mtd0 0x2d0
Writing OTP user data on /dev/mtd0 at offset 0x2d0
Wrote 8 bytes of OTP user data

$ flash_otp_dump -u /dev/mtd0 0x2d0
OTP user data for /dev/mtd0
0x02d0: 6f 74 70 20 74 65 73 74 ff ff ff ff ff ff ff ff
0x02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

$ flash_otp_erase -u /dev/mtd0 0x200 0x100

$ flash_otp_dump -u /dev/mtd0 0x2d0
OTP user data for /dev/mtd0
0x02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

 drivers/mtd/spi-nor/winbond.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ffaa24055259..ca39acf4112c 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -133,6 +133,9 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
 			      SPI_NOR_DUAL_READ) },
+	{ "w25q512nwq", INFO(0xef6020, 0, 0, 0)
+		PARSE_SFDP
+		OTP_INFO(256, 3, 0x1000, 0x1000) },
 	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
 		PARSE_SFDP
 		OTP_INFO(256, 3, 0x1000, 0x1000) },
-- 
2.25.1

