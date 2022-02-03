Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B188D4A7FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbiBCHfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiBCHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:35:12 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1594C06173B;
        Wed,  2 Feb 2022 23:35:11 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 71so1907210qkf.4;
        Wed, 02 Feb 2022 23:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GV5y/r9SmYnI3xDISz2CmR4cyeVlCQ+WRD07va7sDHc=;
        b=pcCaZ8DqkGiYPtEoKYPb4oQaf8V9u5hP6L7HLfsEG7qP72yZkqzxhtVK85MdYHfcwO
         D7EJSx6Tm2OvCdU+XlcbEyRM9CEKlNw7bTx59NGQoM4MsyPY1TU3Yk5bfJLs6pXZ5rE9
         T/idM1qGVfyHhaICtznvxsBlx8x7p5QR3Z+Kzt/6D/bGo/AOiPxhtJOXKg0gT7FJe8Z8
         08p2pmiN3DGGtyLesEf0lATXRVFCgPcSFYp6hOQbdGsODgV7/oqMhz9psBmM6hRYtz29
         oxust9pRs8cNZIoeGGj9kWPc+xWCtqiEsnK0X0GMwb8N2Kz7i91kIKRGSs3+qJdb5g3x
         kd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GV5y/r9SmYnI3xDISz2CmR4cyeVlCQ+WRD07va7sDHc=;
        b=fD+uiIXAXeLtGeBza5fGyZyq2eJso7175IcHjT8RxCVhPu6kdfu0cVOocW87OaOUhm
         ntMi2z1i1gU2Lon7Xpiq23LdbfXhh4nTLvTLXsqvkpnVcLwAQ1jdumGVcjuk+LRlGBLy
         crKpWkdTDuH1mV/lRCYuDPlrc37o7kmWRnDJxTP8F7IStUUC+eqeI/5USSC/SwVmB/xp
         MhLlTCMLzfNolvD9nusO5f1XQwJykD3Uyd8qmQaT1PLDz80U3gxYeEAjns1/G99+1CpP
         TXUQUprH2XgzYBHNz5m8XEWTmkkDauIuX9XrX4Q9WMy/ReZUDePO5wB741iedJGJz9VV
         LINw==
X-Gm-Message-State: AOAM530GMa2qlxEhyHxIQ34cbUE5U5v62Ag/gkdcwhD+r3a21l7eU/YN
        /qz/U3h5u/fgbTWdRFmx/S4=
X-Google-Smtp-Source: ABdhPJyxHQrbhkVRX4ru6uajR66XLZ/3Ma+mv6E/FfUvaP3tvlwXWCFlyvNDEjS1HYjRS/iNF2UWKg==
X-Received: by 2002:a05:620a:2894:: with SMTP id j20mr23060194qkp.307.1643873710960;
        Wed, 02 Feb 2022 23:35:10 -0800 (PST)
Received: from localhost.localdomain (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id 134sm12712551qkl.50.2022.02.02.23.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 23:35:10 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: Set counter device name
Date:   Thu,  3 Feb 2022 16:34:59 +0900
Message-Id: <20220203073459.90093-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naming the counter device provides a convenient way to identify it in
devres_log events and similar situations. This patch names the counter
device by combining the prefix "counter" with the counter device's
unique ID.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 7e0957eea094..2ebd9adf0bd2 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -22,6 +22,8 @@
 #include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
+#define COUNTER_NAME	"counter"
+
 /* Provides a unique ID for each counter device */
 static DEFINE_IDA(counter_ida);
 
@@ -104,6 +106,10 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 		goto err_ida_alloc;
 	dev->id = err;
 
+	err = dev_set_name(dev, COUNTER_NAME "%d", dev->id);
+	if (err)
+		goto err_dev_set_name;
+
 	mutex_init(&counter->ops_exist_lock);
 	dev->type = &counter_device_type;
 	dev->bus = &counter_bus_type;
@@ -119,6 +125,9 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 err_chrdev_add:
 
+	kfree(dev_name(dev));
+err_dev_set_name:
+
 	ida_free(&counter_ida, dev->id);
 err_ida_alloc:
 
@@ -250,7 +259,8 @@ static int __init counter_init(void)
 	if (err < 0)
 		return err;
 
-	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "counter");
+	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX,
+				  COUNTER_NAME);
 	if (err < 0)
 		goto err_unregister_bus;
 

base-commit: 7b9c8e1a0ca18a62565ee0e28b23baf7b176e96f
-- 
2.35.1

