Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20A546115F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347099AbhK2Jxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:53:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53440 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245364AbhK2JvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:51:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF5E6126D;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9494CC58332;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=UVxFR05FKMhOYLbyC9BEQE9pXiwUc5eHmgE5lfAnxhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/pdwFHOU9TVEpdPPb2IJ76QsNuU6pWoBy9UOglfJshvug865l6fNdIwmW5fPfKKZ
         vTgHcW/DiAZ1IiGB3fHAArL9bV/0dnD98UNom4jNxcjhQpCugchUDxy53Y1oMqIiHj
         500XRR7o8hK+h/FXMyMDBNtMIMYboEvZsGch5VmDe1ZlsiZX50IxQwPRB7XrNkV4AV
         IsIvJahlaOizMOyeJKsEdg1Jat1tw5dMPhuiEbTZqOnJ+XARhifkEb5w1sXk0CVosd
         0QKyMJG8zPP1oPdYc7WXy0OoGfUeYVWPLFSd4/e5DvIgmUitxjY/jjCh3liWSFRP6B
         NZXseLLNigLOA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBS-GG; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 09/20] media: si470x: fix printk warnings with clang
Date:   Mon, 29 Nov 2021 10:47:41 +0100
Message-Id: <442df11dd08158df88e95a457175a65f20dc8369.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang doesn't like "%hu" on macros:

	drivers/media/radio/si470x/radio-si470x-i2c.c:414:4: error: format specifies type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
	drivers/media/radio/si470x/radio-si470x-i2c.c:417:4: error: format specifies type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]

Besides that, changeset cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
dropped recomendation of using %h.

So, just replace them with "%u".

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/radio/si470x/radio-si470x-i2c.c | 4 ++--
 drivers/media/radio/si470x/radio-si470x-usb.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index a972c0705ac7..7ea7c6326f53 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -410,10 +410,10 @@ static int si470x_i2c_probe(struct i2c_client *client)
 			radio->registers[DEVICEID], radio->registers[SI_CHIPID]);
 	if ((radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE) < RADIO_FW_VERSION) {
 		dev_warn(&client->dev,
-			"This driver is known to work with firmware version %hu,\n",
+			"This driver is known to work with firmware version %u,\n",
 			RADIO_FW_VERSION);
 		dev_warn(&client->dev,
-			"but the device has firmware version %hu.\n",
+			"but the device has firmware version %u.\n",
 			radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE);
 		version_warning = 1;
 	}
diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index 3f8634a46573..1e70e6971fe4 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -681,10 +681,10 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 			radio->registers[DEVICEID], radio->registers[SI_CHIPID]);
 	if ((radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE) < RADIO_FW_VERSION) {
 		dev_warn(&intf->dev,
-			"This driver is known to work with firmware version %hu,\n",
+			"This driver is known to work with firmware version %u,\n",
 			RADIO_FW_VERSION);
 		dev_warn(&intf->dev,
-			"but the device has firmware version %hu.\n",
+			"but the device has firmware version %u.\n",
 			radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE);
 		version_warning = 1;
 	}
@@ -698,10 +698,10 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 			radio->software_version, radio->hardware_version);
 	if (radio->hardware_version < RADIO_HW_VERSION) {
 		dev_warn(&intf->dev,
-			"This driver is known to work with hardware version %hu,\n",
+			"This driver is known to work with hardware version %u,\n",
 			RADIO_HW_VERSION);
 		dev_warn(&intf->dev,
-			"but the device has hardware version %hu.\n",
+			"but the device has hardware version %u.\n",
 			radio->hardware_version);
 		version_warning = 1;
 	}
-- 
2.33.1

