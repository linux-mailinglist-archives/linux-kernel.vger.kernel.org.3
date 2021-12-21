Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42747BFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhLUMkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbhLUMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E691C061574;
        Tue, 21 Dec 2021 04:39:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y22so51604184edq.2;
        Tue, 21 Dec 2021 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBWf5Ppx/7/fPv+nycLzgXWnMKE3Jr3+eX+TUHaX4/c=;
        b=KoNUzHGpgrrSXFs6K6HgqGD0vm2SvFkfsxXPlJNt+KI/wq+tdab4/hFC6/57aACmIA
         AKu1DuR7R6MTOF0sTPXQrrM/27V6vyYCgzjhSh9JcPEwHkqOouCBIPtZRIJptLNRNDNP
         IVBULjwqfM6TbhDKWxjS87WEOrnElrpx4mk82PeaNavs33dpuA4denZXEsfzrq7j73x9
         3V1fg059bL3DalmuRWHnSF5xNEKjLnsOGMiR4Tf+jbSF3sdtgj/nFWat0smn3exuigrW
         EUhajQCYaRfuGdc/RVpn9zNM63nVkVPVbbN10ksoQutnwZDAqWVtRDBsDRcMy/rqkZVS
         Bx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBWf5Ppx/7/fPv+nycLzgXWnMKE3Jr3+eX+TUHaX4/c=;
        b=EnXegOmqFRL3HNFjYgGTmqZ12IsCsb0uozF1mmag3ZnXTfQumGZehCzqcy/On8cKtE
         vmcuH8S/ELAkqtFTCYHz7xFBn+UHHfxHUbWncN8DUoi3Q7eXFbttP0WLhZOv00U3d71c
         HJHnWhOE0FAWSnVzLPB/zyc0wlZvhYunz6x5byl0Pr577VSTHCU5Y8KOtlBPutJOLn5u
         +XUJ6EyXORrQxp1baod5B79WeIpAaEDCfQmEZntJG8Q0iOhqNsCsoMTRpaZj/CAM66Qx
         FBXUcfxeq+aaQ9OKCgMvb7YBOVChhZ/FpKKPZem2Rj6aIJ1mbpfBmSqeHzyL7kXK3e5I
         AWKw==
X-Gm-Message-State: AOAM5329IHxpeSgNCSTXm8rtyvJB51blQOmVlggUr8uhsXr0q/3AJY9V
        TG6thjO7k1u7OvdfKybeBGo=
X-Google-Smtp-Source: ABdhPJyPmJ26z4eTRp+XmO+ZZ7PKM1K2ZN34dxMKBq2pz5GJ3s3eLofqRJUF/q9z+CXfNPUjCDoW2g==
X-Received: by 2002:aa7:d593:: with SMTP id r19mr3140820edq.168.1640090396802;
        Tue, 21 Dec 2021 04:39:56 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:56 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/10] hwmon: adt7x10: avoid storing hwinfo dev into private data
Date:   Tue, 21 Dec 2021 14:39:38 +0200
Message-Id: <20211221123944.2683245-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221123944.2683245-1-demonsingur@gmail.com>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Store it later in the code to reduce the number of references
to the private data structure, so it is easier to remove it
altogether.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 48adc0344e88..25c1ab199658 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -351,6 +351,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
 {
 	struct adt7x10_data *data;
+	struct device *hdev;
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -395,9 +396,9 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		goto exit_restore;
 
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
+	hdev = hwmon_device_register(dev);
+	if (IS_ERR(hdev)) {
+		ret = PTR_ERR(hdev);
 		goto exit_remove;
 	}
 
@@ -411,10 +412,12 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 			goto exit_hwmon_device_unregister;
 	}
 
+	data->hwmon_dev = hdev;
+
 	return 0;
 
 exit_hwmon_device_unregister:
-	hwmon_device_unregister(data->hwmon_dev);
+	hwmon_device_unregister(hdev);
 exit_remove:
 	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 exit_restore:
-- 
2.34.1

