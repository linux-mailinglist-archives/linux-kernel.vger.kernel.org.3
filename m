Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23630461408
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbhK2Lqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:46:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43662 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhK2Low (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:44:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B58261290;
        Mon, 29 Nov 2021 11:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1788C004E1;
        Mon, 29 Nov 2021 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638186094;
        bh=e5g2fTpXGyGRbFWlIdsWgxSW+lrXgDyxZTWLAs8w6BE=;
        h=From:To:Cc:Subject:Date:From;
        b=nJP88wHNdT/d5/VxltEgOWBnGP+Vwtve3nMrTq8E3K+SwmdtsqpYX5bdFknjl+q7y
         62fcbYsTWuGyjqUicPE8FdGQQcquRl+lVytnBmPlePG7apTqNGSqYvj+EbjZXEQLkh
         1pc+o8NTyxZVo0NOcrkgceFc0e5gcFHWEaZQRQCRK2uRiNw8xQARtVO1wBN68rahtb
         8a9wDu6ZTRrEgTYQmyXzpZM/gzr0/6rGkTlLCFItb/9OKl3CpSIVKU6rPZz0xU4++h
         S5mIxvGybAl0FqZwOcl2uZyoQyTBSMDgtCy3/xif56fymRsBN7DJYB96tg0ZdPMA5F
         Jh0HeZOBJlbbQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrf2K-000TzS-Fz; Mon, 29 Nov 2021 12:41:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Joe Perches" <joe@perches.com>, Hans Verkuil <hverkuil@xs4all.nl>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: si470x: consolidate multiple printk's
Date:   Mon, 29 Nov 2021 12:41:31 +0100
Message-Id: <1fb7915dd3bc60afa9f69da9607700af9cccb383.1638186086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the version warning is given, multiple dev_warn() are
called. Consolidate the ones that could be merged altogether.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/radio/si470x/radio-si470x-i2c.c | 17 +++--------------
 drivers/media/radio/si470x/radio-si470x-usb.c | 16 +++++-----------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index 7ea7c6326f53..bdb13c974b02 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -334,7 +334,6 @@ static int si470x_i2c_probe(struct i2c_client *client)
 {
 	struct si470x_device *radio;
 	int retval = 0;
-	unsigned char version_warning = 0;
 
 	/* private data allocation and initialization */
 	radio = devm_kzalloc(&client->dev, sizeof(*radio), GFP_KERNEL);
@@ -410,20 +409,10 @@ static int si470x_i2c_probe(struct i2c_client *client)
 			radio->registers[DEVICEID], radio->registers[SI_CHIPID]);
 	if ((radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE) < RADIO_FW_VERSION) {
 		dev_warn(&client->dev,
-			"This driver is known to work with firmware version %u,\n",
-			RADIO_FW_VERSION);
-		dev_warn(&client->dev,
-			"but the device has firmware version %u.\n",
+			"This driver is known to work with firmware version %u, but the device has firmware version %u.\n"
+			"If you have some trouble using this driver, please report to V4L ML at linux-media@vger.kernel.org\n",
+			RADIO_FW_VERSION,
 			radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE);
-		version_warning = 1;
-	}
-
-	/* give out version warning */
-	if (version_warning == 1) {
-		dev_warn(&client->dev,
-			"If you have some trouble using this driver,\n");
-		dev_warn(&client->dev,
-			"please report to V4L ML at linux-media@vger.kernel.org\n");
 	}
 
 	/* set initial frequency */
diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index 1e70e6971fe4..6b2768623c88 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -681,10 +681,8 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 			radio->registers[DEVICEID], radio->registers[SI_CHIPID]);
 	if ((radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE) < RADIO_FW_VERSION) {
 		dev_warn(&intf->dev,
-			"This driver is known to work with firmware version %u,\n",
-			RADIO_FW_VERSION);
-		dev_warn(&intf->dev,
-			"but the device has firmware version %u.\n",
+			"This driver is known to work with firmware version %u, but the device has firmware version %u.\n",
+			RADIO_FW_VERSION,
 			radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE);
 		version_warning = 1;
 	}
@@ -698,10 +696,8 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 			radio->software_version, radio->hardware_version);
 	if (radio->hardware_version < RADIO_HW_VERSION) {
 		dev_warn(&intf->dev,
-			"This driver is known to work with hardware version %u,\n",
-			RADIO_HW_VERSION);
-		dev_warn(&intf->dev,
-			"but the device has hardware version %u.\n",
+			"This driver is known to work with hardware version %u, but the device has hardware version %u.\n",
+			RADIO_HW_VERSION,
 			radio->hardware_version);
 		version_warning = 1;
 	}
@@ -709,9 +705,7 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 	/* give out version warning */
 	if (version_warning == 1) {
 		dev_warn(&intf->dev,
-			"If you have some trouble using this driver,\n");
-		dev_warn(&intf->dev,
-			"please report to V4L ML at linux-media@vger.kernel.org\n");
+			"If you have some trouble using this driver, please report to V4L ML at linux-media@vger.kernel.org\n");
 	}
 
 	/* set led to connect state */
-- 
2.33.1

