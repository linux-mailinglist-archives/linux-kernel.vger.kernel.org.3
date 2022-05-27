Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE2536747
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354549AbiE0S6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354280AbiE0S6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:58:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6E21817;
        Fri, 27 May 2022 11:58:03 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y15so6033662qtx.4;
        Fri, 27 May 2022 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLBbNa8szjRmsip5647GYDPj8N+sFrnomPibf33jAVM=;
        b=oLRFIcWbhD5SVuXTQCndflnQNXL+eG+46ICbnvxNMbh2oIVwopiRXzlpazR9OzgcOt
         1rKhnd7HamvDXtvzH4ver4kWb8ZagNHvrwzlvXRdBi0Q3mwrUQD96Vn5i8K3dEAnQulz
         EvLk9hAHLpiDjCJFP9VMrt/Vd1qyT5zQk4tyaTfGwreCDZurWHHWmyEzPQfMRvjth/rc
         nwZTmahE7HSEQHz93UcPC9TvkkQKwWgICqHHmFtiN6MOId7fm78q1hlKFHPKlArNmYS6
         CDRgbqJ+fX97FNdnNCpj+FvcowrqBo0GHwVG8az7yjiDNRdFjOfIPEshz7qg0aG3INOK
         QBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLBbNa8szjRmsip5647GYDPj8N+sFrnomPibf33jAVM=;
        b=LCeoi2GCJU530sVxG3SqiBIpVpAkpu3qtNcTKffOjqiZdDl+hQmcmhr7kPoD0MF/6c
         vcWkX3A+kx3J89WuSVCgyr046h5O5aC9ZUWtOQz6uTYkPDWGbmI/KgUASrycDYqOZ1SD
         PltyPr7zHq7cPXoYXlSA1IFjlQ6LK/8nsW9BmgvD2UnyS+IKixHqE9H20Gi044pIWce2
         OqbhcfHbnmno/ke8lzIciPDH2T4inSHJdpERD/mIjoxUjM/s6YFZeyxqKTqjBCngNiK7
         0ACAmSndfY9udajfNSIH1l5Ll5MeAwDgEau8v+UyZYZUcjc1xA4xuz4bg+hq03aTE1jF
         VnWg==
X-Gm-Message-State: AOAM531sieENfdL5J3B5qSHqF/uymdiNvnvbnUfvnBCZBolIfxfT1xro
        Ya9Xcijkyn6YcZNbNoHMaY8=
X-Google-Smtp-Source: ABdhPJwzCVPeJVkCUU8D+gWTLUY/9IBxYrI/3Ljk8wSLVhyOrls3IomAXl/25lFFUQ0WCTDj3J8tqg==
X-Received: by 2002:ac8:57d3:0:b0:2f3:acf2:7981 with SMTP id w19-20020ac857d3000000b002f3acf27981mr34829091qta.81.1653677882753;
        Fri, 27 May 2022 11:58:02 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id ey19-20020a05622a4c1300b002fb8bbffa06sm3135037qtb.27.2022.05.27.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 11:58:02 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH 1/1] iio: Prefer octal over symbolic permissions.
Date:   Fri, 27 May 2022 14:56:52 -0400
Message-Id: <20220527185651.465204-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl use ocatl permissions rather than symbolic
permissions.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-buffer.c  | 12 ++++++------
 drivers/iio/industrialio-core.c    | 10 +++++-----
 drivers/iio/industrialio-trigger.c |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b078eb2f3c9d..c27f74a3c0f3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1391,17 +1391,17 @@ static ssize_t direction_show(struct device *dev,
 	}
 }
 
-static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
+static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
-	S_IRUGO, iio_buffer_read_length, NULL);
-static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
+	0444, iio_buffer_read_length, NULL);
+static DEVICE_ATTR(enable, 0644,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
-static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(watermark, 0644,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
 static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
-	S_IRUGO, iio_buffer_show_watermark, NULL);
-static DEVICE_ATTR(data_available, S_IRUGO,
+	0444, iio_buffer_show_watermark, NULL);
+static DEVICE_ATTR(data_available, 0444,
 		iio_dma_show_data_available, NULL);
 static DEVICE_ATTR_RO(direction);
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..35de348d686e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	dev_attr->attr.name = name;
 
 	if (readfunc) {
-		dev_attr->attr.mode |= S_IRUGO;
+		dev_attr->attr.mode |= 0444;
 		dev_attr->show = readfunc;
 	}
 
 	if (writefunc) {
-		dev_attr->attr.mode |= S_IWUSR;
+		dev_attr->attr.mode |= 0200;
 		dev_attr->store = writefunc;
 	}
 
@@ -1401,7 +1401,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
 	return sysfs_emit(buf, "%s\n", indio_dev->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
+static DEVICE_ATTR(name, 0444, iio_show_dev_name, NULL);
 
 static ssize_t iio_show_dev_label(struct device *dev,
 				 struct device_attribute *attr,
@@ -1411,7 +1411,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
 	return sysfs_emit(buf, "%s\n", indio_dev->label);
 }
 
-static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
+static DEVICE_ATTR(label, 0444, iio_show_dev_label, NULL);
 
 static ssize_t iio_show_timestamp_clock(struct device *dev,
 					struct device_attribute *attr,
@@ -1509,7 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(current_timestamp_clock, 0644,
 		   iio_show_timestamp_clock, iio_store_timestamp_clock);
 
 static int iio_device_register_sysfs(struct iio_dev *indio_dev)
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..e22a35634f2c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -54,7 +54,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 	return sysfs_emit(buf, "%s\n", trig->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static DEVICE_ATTR(name, 0444, iio_trigger_read_name, NULL);
 
 static struct attribute *iio_trig_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -494,7 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(current_trigger, 0644,
 		   iio_trigger_read_current,
 		   iio_trigger_write_current);
 
-- 
2.35.3

