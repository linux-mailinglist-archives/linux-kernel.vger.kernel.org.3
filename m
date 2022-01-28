Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177B949FA34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiA1NAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:00:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36046 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiA1NAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:00:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id AD94F1F45F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643374800;
        bh=qpjsngu8uHb7twpIdfcS2cTWB2a6x0Zf7hcMkNFCCDg=;
        h=From:To:Cc:Subject:Date:From;
        b=ka8jRs3ohT4RnrJ4hfU0FL2r3gzE/orqRLHZRhPg9LOki6toywWd0J3osiikd8jfi
         ZXv46gsxUWTMc4vx78IZx5Cd00/OOEUQWOrZXD4+E49ceBjRlhzl3SvheaG1KjrS9c
         +kVmVBafu2sXXCvuJZAUzdby9rLYgrVgjbVynoedKTI8YZJH6B695rb2/SmH4hzXdv
         tcuDOMnSJbAdH1MVrOjEvp0+j41LZZE05+d3n7s+fcmpeXereu3oXLUPmolTx07lmr
         37rLEVI5223LsaDML8LjRAoFqhQO4vRtAnSkIYwD2t5f6L/uKUdCr6hAsOtN5ZqILL
         M90tZDOopcKjQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: Remove checks for validity of dev
Date:   Fri, 28 Jan 2022 17:59:13 +0500
Message-Id: <20220128125913.1291533-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev is being dereferenced in device_property_present() which means that
it is valid. Don't check its validity again and simplify the code.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/hwmon/hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index e36ea82da1474..aec32abd0a89f 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -822,7 +822,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	hwdev->name = name;
 	hdev->class = &hwmon_class;
 	hdev->parent = dev;
-	hdev->of_node = dev ? dev->of_node : NULL;
+	hdev->of_node = dev->of_node;
 	hwdev->chip = chip;
 	dev_set_drvdata(hdev, drvdata);
 	dev_set_name(hdev, HWMON_ID_FORMAT, id);
@@ -834,7 +834,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 
 	INIT_LIST_HEAD(&hwdev->tzdata);
 
-	if (dev && dev->of_node && chip && chip->ops->read &&
+	if (dev->of_node && chip && chip->ops->read &&
 	    chip->info[0]->type == hwmon_chip &&
 	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
 		err = hwmon_thermal_register_sensors(hdev);
-- 
2.30.2

