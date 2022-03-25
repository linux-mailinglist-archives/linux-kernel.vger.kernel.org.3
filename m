Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C8D4E6E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiCYHIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbiCYHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:08:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E54C6808
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648191999; x=1679727999;
  h=from:to:cc:subject:date:message-id;
  bh=j6Td5TpnOWmb3KGmbzhrZ4whBzMuWB5Bs6fm0b0ClBs=;
  b=rPrDmBhajFLnlyg/RQ0MlFqCg8HIrcJgCqFR3zmZ6UbC0VIf0O6IsKb7
   UqdRaN8MtPDYPxICDMMFzVz91o+f7pN/Zqylwlv/UtATTbhy9XZgNA0lu
   7O0HzDaDcseoIF+DlSVZ+S7Sxs1T/36PuU4KJE+b4sinfIYOxE2n0gs47
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Mar 2022 00:06:38 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Mar 2022 00:06:37 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Mar 2022 12:36:18 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id CE20359AC; Fri, 25 Mar 2022 12:36:16 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V8] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Date:   Fri, 25 Mar 2022 12:36:15 +0530
Message-Id: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond W25Q512NW-IM chip.

Below are the tests done:

1. Verified flashing binary image on spi card using flashrom tool.
2. Verified OTP support, below are the test results:

 localhost / # cat
 /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
 spi16.0/spi-nor/jedec_id
 ef8020

 localhost / # cat
 /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
 spi16.0/spi-nor/manufacturer
 winbond

 localhost / # cat
 /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
 spi16.0/spi-nor/partname
 w25q512nwm

 localhost / # hexdump
 /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/sp
 i16/spi16.0/spi-nor/sfdp
 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
 0000020 6800 6c65 6f6c 7720 726f 646c ffff ffff
 0000030 ffff ffff ffff ffff ffff ffff ffff ffff
 *
 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
 00000d0 0aff fff0 ff21 ffdc
 00000d8

 localhost / # md5sum
 /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi
 16/spi16.0/spi-nor/sfdp
 106d89d6c049110bc94c01517cb4ce24
 /sys/bus/platform/devices/soc@0/88dc000.spi/
 spi_master/spi16/spi16.0/spi-nor/sfdp

3. Tested flash lock, below are the test results (looks like the lock is
 not working as expected, so when we do lock the whole card and tried to
 write, write was successful without any errors.)

 localhost ~ # flash_lock -i /dev/mtd0
 Device: /dev/mtd0
 Start: 0
 Len: 0x4000000
 Lock status: locked
 Return code: 1
 localhost ~ # mtd_debug erase /dev/mtd0 0x400000 4096
 Erased 4096 bytes from address 0x00400000 in flash
 localhost ~ # mtd_debug read /dev/mtd0 0x400000 4096
 temp
 Copied 4096 bytes from address 0x00400000 in flash
 to temp
 localhost ~ # mtd_debug write /dev/mtd0 0x400000
 4096 temp
 Copied 4096 bytes from temp to address 0x00400000
 in flash
 localhost ~ # flash_lock -u /dev/mtd0
 localhost ~ # flash_lock -i /dev/mtd0
 Device: /dev/mtd0
 Start: 0
 Len: 0x4000000
 Lock status: unlocked
 Return code: 0
 localhost ~ # mtd_debug erase /dev/mtd0 0x400000 4096
 Erased 4096 bytes from address 0x00400000 in flash
 localhost ~ # mtd_debug read /dev/mtd0 0x400000
 4096 tempCopied 4096 bytes from address 0x00400000 in
 flash to temp
 localhost ~ # mtd_debug write /dev/mtd0 0x400000 4096 temp
 Copied 4096 bytes from temp to address 0x00400000 in flash
 localhost ~ #

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Michael Walle <michael@walle.cc>
---

localhost / # cat
/sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
spi16.0/spi-nor/jedec_id
ef8020

localhost / # cat
/sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
spi16.0/spi-nor/manufacturer
winbond

localhost / # cat
/sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
spi16.0/spi-nor/partname
w25q512nwm

localhost / # hexdump
/sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/sp
i16/spi16.0/spi-nor/sfdp
0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
0000020 6800 6c65 6f6c 7720 726f 646c ffff ffff
0000030 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
00000d0 0aff fff0 ff21 ffdc
00000d8

localhost / # md5sum
/sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi
16/spi16.0/spi-nor/sfdp
106d89d6c049110bc94c01517cb4ce24
/sys/bus/platform/devices/soc@0/88dc000.spi/
spi_master/spi16/spi16.0/spi-nor/sfdp

Changes since V1:
	- Added space before name of the flash part as suggested by
	  Doug.

Changes since V2:
	- Updated chip name as w25q512nwm as suggested by Doug.

Changes since V3:
	- Updated flash_info flags passing according to
	  below patch.

Changes since V4:
	- Added OTP support for SPI card as suggested by Michael Walle.
	- Updated SFDP flags passing as suggested by Pratyush Yadav.

Changes since V5:
	- Reordered flags passing info for spi nor as suggested by
	  Michael Walle.
	- Added SFDP dump info in commit as suggested by Michael Walle.

Changes since V6:
	- Updated commit subject and added md5sum in commit as suggested by
	  Michael Walle.
	- Reordered flags passing info for spi nor which has missed in V5 patch
	  as suggested by Michael Walle.

Changes since V7:
	- Updated commit message with test cases info as suggested by
	  Tudor Ambarus.
---
 drivers/mtd/spi-nor/winbond.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index fe80dff..048ffb4 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -124,6 +124,10 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
 			      SPI_NOR_DUAL_READ) },
+	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
+		PARSE_SFDP
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+		OTP_INFO(256, 3, 0x1000, 0x1000) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

