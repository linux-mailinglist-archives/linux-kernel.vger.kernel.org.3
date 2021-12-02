Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5146601B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbhLBJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:09:27 -0500
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:59954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231655AbhLBJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:09:25 -0500
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E08F0837F27E;
        Thu,  2 Dec 2021 09:06:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 025C660009;
        Thu,  2 Dec 2021 09:06:01 +0000 (UTC)
Message-ID: <c6189daaac183ddf51da1444c597d8577c1ac416.camel@perches.com>
Subject: [PATCH] media: i2c: ov8865: Neaten unnecessary indentation
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Dec 2021 01:06:01 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 025C660009
X-Spam-Status: No, score=-4.89
X-Stat-Signature: 8w1jacxyozb3txyx8m9rgwz38uirn6wz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18YUlA6yDz9UyZcBrKA1TSWARTY71967yQ=
X-HE-Tag: 1638435961-600384
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jumping to the start of a labeled else block isn't typical.

Unindent the code by reversing the test and using a goto instead.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/media/i2c/ov8865.c | 81 +++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index ebdb20d3fe9d8..7ef83a10f586f 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -2396,56 +2396,57 @@ static int ov8865_sensor_init(struct ov8865_sensor *sensor)
 
 static int ov8865_sensor_power(struct ov8865_sensor *sensor, bool on)
 {
-	/* Keep initialized to zero for disable label. */
-	int ret = 0;
+	int ret;
 
-	if (on) {
-		gpiod_set_value_cansleep(sensor->reset, 1);
-		gpiod_set_value_cansleep(sensor->powerdown, 1);
+	if (!on) {
+		ret = 0;
+		goto disable;
+	}
 
-		ret = regulator_enable(sensor->dovdd);
-		if (ret) {
-			dev_err(sensor->dev,
-				"failed to enable DOVDD regulator\n");
-			goto disable;
-		}
+	gpiod_set_value_cansleep(sensor->reset, 1);
+	gpiod_set_value_cansleep(sensor->powerdown, 1);
 
-		ret = regulator_enable(sensor->avdd);
-		if (ret) {
-			dev_err(sensor->dev,
-				"failed to enable AVDD regulator\n");
-			goto disable;
-		}
+	ret = regulator_enable(sensor->dovdd);
+	if (ret) {
+		dev_err(sensor->dev, "failed to enable DOVDD regulator\n");
+		goto disable;
+	}
 
-		ret = regulator_enable(sensor->dvdd);
-		if (ret) {
-			dev_err(sensor->dev,
-				"failed to enable DVDD regulator\n");
-			goto disable;
-		}
+	ret = regulator_enable(sensor->avdd);
+	if (ret) {
+		dev_err(sensor->dev, "failed to enable AVDD regulator\n");
+		goto disable;
+	}
 
-		ret = clk_prepare_enable(sensor->extclk);
-		if (ret) {
-			dev_err(sensor->dev, "failed to enable EXTCLK clock\n");
-			goto disable;
-		}
+	ret = regulator_enable(sensor->dvdd);
+	if (ret) {
+		dev_err(sensor->dev, "failed to enable DVDD regulator\n");
+		goto disable;
+	}
+
+	ret = clk_prepare_enable(sensor->extclk);
+	if (ret) {
+		dev_err(sensor->dev, "failed to enable EXTCLK clock\n");
+		goto disable;
+	}
 
-		gpiod_set_value_cansleep(sensor->reset, 0);
-		gpiod_set_value_cansleep(sensor->powerdown, 0);
+	gpiod_set_value_cansleep(sensor->reset, 0);
+	gpiod_set_value_cansleep(sensor->powerdown, 0);
+
+	/* Time to enter streaming mode according to power timings. */
+	usleep_range(10000, 12000);
+
+	return 0;
 
-		/* Time to enter streaming mode according to power timings. */
-		usleep_range(10000, 12000);
-	} else {
 disable:
-		gpiod_set_value_cansleep(sensor->powerdown, 1);
-		gpiod_set_value_cansleep(sensor->reset, 1);
+	gpiod_set_value_cansleep(sensor->powerdown, 1);
+	gpiod_set_value_cansleep(sensor->reset, 1);
 
-		clk_disable_unprepare(sensor->extclk);
+	clk_disable_unprepare(sensor->extclk);
 
-		regulator_disable(sensor->dvdd);
-		regulator_disable(sensor->avdd);
-		regulator_disable(sensor->dovdd);
-	}
+	regulator_disable(sensor->dvdd);
+	regulator_disable(sensor->avdd);
+	regulator_disable(sensor->dovdd);
 
 	return ret;
 }


