Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC5469619
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbhLFNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:02:05 -0500
Received: from smtp2.axis.com ([195.60.68.18]:8220 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243421AbhLFNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638795515;
  x=1670331515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H2jnq/eyxVHd0kHPlBaFHWHff3G6/VmaGVv3aUGnxCc=;
  b=GUy834/4lujyDYSyYd0DFSBnca+C1XcrcyUEVgXQYQ0LpcvD8JJzMDor
   UNY/oy68HoOVCw8RyvIEGCpICGXDryWdQGKnjcFbmxBPo/3alqCs35xw7
   ZYsaoCWoHV52BMWqkIhDTvwhsHXUm0avw0rnia6/hcT1QXFlRnMmA/A4U
   GH5VvSpeqfX2qmZmpg4DAFN8CoWchxJtwP/MriZH584eB5gU3S6pd2RRY
   oYP0QWe7hEZyVqRxB1lIIUUM2NVl2EOwbhscZNjdtwLVvsXlrtIYffPfR
   jEaodgAr1luHjfv2o203VeyPBkc1qqmXQwqANblBa8zzYxvnf1+t8JMPZ
   w==;
From:   Camel Guo <camel.guo@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: rs5c372: fix incorrect oscillation value on r2221tl
Date:   Mon, 6 Dec 2021 13:58:31 +0100
Message-ID: <20211206125832.6461-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

The XSL bit only exists in RS5C372A/B. On other Ricoh RTC chips
supported in rs5c372, this bit has different meaning. For example, on
R2221x and R2223x, this bit of oscillation adjustment register
determines the operation frequency of oscillation adjustment circuit and
the oscillation is always 32768HZ. But rs5c372_get_trim gives 32000HZ to
osc when DEV is 1.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 drivers/rtc/rtc-rs5c372.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 80980414890c..f031f83fa1a2 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -28,7 +28,7 @@
 #define RS5C372_REG_MONTH	5
 #define RS5C372_REG_YEAR	6
 #define RS5C372_REG_TRIM	7
-#	define RS5C372_TRIM_XSL		0x80
+#	define RS5C372_TRIM_XSL		0x80		/* only if RS5C372[a|b] */
 #	define RS5C372_TRIM_MASK	0x7F
 
 #define RS5C_REG_ALARM_A_MIN	8			/* or ALARM_W */
@@ -324,8 +324,12 @@ static int rs5c372_get_trim(struct i2c_client *client, int *osc, int *trim)
 	struct rs5c372 *rs5c372 = i2c_get_clientdata(client);
 	u8 tmp = rs5c372->regs[RS5C372_REG_TRIM];
 
-	if (osc)
-		*osc = (tmp & RS5C372_TRIM_XSL) ? 32000 : 32768;
+	if (osc) {
+		if (rs5c372->type == rtc_rs5c372a || rs5c372->type == rtc_rs5c372b)
+			*osc = (tmp & RS5C372_TRIM_XSL) ? 32000 : 32768;
+		else
+			*osc = 32768;
+	}
 
 	if (trim) {
 		dev_dbg(&client->dev, "%s: raw trim=%x\n", __func__, tmp);
-- 
2.20.1

