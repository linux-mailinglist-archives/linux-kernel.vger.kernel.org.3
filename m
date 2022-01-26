Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9F49D668
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiAZXzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiAZXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:55:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB5C06161C;
        Wed, 26 Jan 2022 15:55:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so5801524pjj.4;
        Wed, 26 Jan 2022 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3L6v+eB5jsrBJkBgYQ+6zr2KzEGgUqT+LgiXyOcWAU8=;
        b=lV4biAMb6vryeM9/n3eT867ieF/2Y/4/TTRMJ5aHkTZ7jTg33RLLlEU4AUTy+wEMGd
         FwjbZ/wAHRPqt5kLQs6M9v1I59AyUsB35fN9Q60OBSE73dklBJFzka0UiOpJ4W05fSJH
         WOf+rBhQGRpHYzrqwEkHdNqYRRGWE41xfZ1b74CTyfjvxV5ziDILFv6W5KlxQK39jdPC
         0L568amDYei5YEzjyWm3Ajp5O7cKkaC+fPjo/o+UhXKS1Gx0AA2Bi6yxpaRnQUj+Ch3P
         +c8F00lY4mXfJOu8Gf0+LJt7oq8cyADcqvkhZN/Bpac+sEce9+QGm/g3AnTDQewpPAdp
         fnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3L6v+eB5jsrBJkBgYQ+6zr2KzEGgUqT+LgiXyOcWAU8=;
        b=UHlSb9WR6XjQGJv44+NH6Udiy570L60Pe5dvwVEifEbPKyULjcYGNXvqU8N30Pi1y7
         RucYT9rEPvs3xiYMxhCzJB8hVxc3g/pzi5avqh8M0vazqgt9jNGjJdL+jOobwnDGWbpi
         8icxOy0xYnOOMddba5xCaDX93clsQOciV/vjDH+A1T73uIdyDnaqdmPa/VqNXknP9ESc
         XHOwaL/UaLF4CkQqdtIpc6riJBE7KM0ERV11NEmU08fQkfUohovzmep0OIcMrluFXh4s
         CAWoc2+QEn7ufDKB5sKFC4bDEU+YLgNnaMOfw7/J95YQ9WId/jDnuobOKx33qeHHib23
         WBQw==
X-Gm-Message-State: AOAM530hBG/KP8QGhK8qxXT8yKdnPa1zNcWTqV5H2gn88UYFBu3dqTob
        UK5pTOzojQ1xIYx2n1DER8UVS9h15c4=
X-Google-Smtp-Source: ABdhPJyPIc4xgKfrPlxE3cxzGkzj+/nRRgSdFBEsQenDx49qAzGaGnRMrVhsvjBVnx/gxFa+nUq0Bw==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12mr1307721plt.83.1643241310338;
        Wed, 26 Jan 2022 15:55:10 -0800 (PST)
Received: from localhost.localdomain (192.243.120.23.16clouds.com. [192.243.120.23])
        by smtp.gmail.com with ESMTPSA id on5sm306310pjb.26.2022.01.26.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:55:09 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     davidcomponentone@gmail.com, bhelgaas@google.com,
        yang.guang5@zte.com.cn, rajatja@google.com,
        Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: core: replace snprintf with sysfs_emit
Date:   Thu, 27 Jan 2022 07:54:54 +0800
Message-Id: <e205c334a8c65c03702a94ee382ec488bcc1d019.1643183299.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/usb/core/sysfs.c:921:8-16:
WARNING: use scnprintf or sprintf
./drivers/usb/core/sysfs.c:730:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/usb/core/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index fa2e49d432ff..6387c0dfe30e 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usb_device *usb_dev = to_usb_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
+	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
 }
 
 /*
@@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
 	struct usb_hcd *hcd;
 
 	hcd = bus_to_hcd(usb_bus);
-	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
+	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
 }
 
 static ssize_t authorized_default_store(struct device *dev,
-- 
2.30.2

