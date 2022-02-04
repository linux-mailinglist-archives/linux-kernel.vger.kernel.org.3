Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F114A956D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357170AbiBDIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357166AbiBDIqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:46:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC2C061714;
        Fri,  4 Feb 2022 00:46:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k17so4616056plk.0;
        Fri, 04 Feb 2022 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLm1Xd58kZdRJgQxfBatH1zJyJ5hT921Y/jdnN6VFT0=;
        b=l8WS47NjCGx58W8XGL6HxsWueH0OEPntNnxwO6pqtWLLw5So50Y+2GGjQiLw2j4KeV
         3SIWZJ2MWaLBA393cexcMJd+6nowPmTlHdDF1iHkiT16lCSXA7iZtaHv35kKpGA2ycYi
         MsZm87uTeLlwWmyD2XzlzRQDXDHSI8mgbT5XKOXugwcugJCku4qnYddUU1d1m8v5ayCI
         mVtdC1RqylD7NqSXHzMEAjbAMYePtPshg+rq3gXoRKZe6SfeDOsZuiDkcvtu1bUq90Aa
         F4HUBkEVTdoJqRyWuSXOdlWZJki0c2kfeqLhY/7OfbqZ4tcTwXoj9bIwmea79VJsBkUv
         3Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLm1Xd58kZdRJgQxfBatH1zJyJ5hT921Y/jdnN6VFT0=;
        b=OweR5LRD8LTO5lf3T8M64RmFhaRNU54I1A0+wVULn1iRytSDp8l20zturUJ3oM8idN
         eXF1MjMVZlTsN1lbZm94fuxfJD9PzgUvLKpK/y781b7CY7e7mWNgNf3xXVGdA8kvSoZg
         RXt0BkXQ+kQ2sbMF0v9/hDS2v47EwBOCr2sLaFNUfhX9Um9+7QEvqhL8R0/dtuwgHmpe
         KOi+WWjzedFhliePtVxq3wpKb1a4Byipex1y9l62WIdRhJ148lXK13ncEDtZa3L5317u
         4raezkzomSRbE83dc24yEAUa6qwZcVki6jBYFTSlym/26ODUvq5EFW6t9pffAneFV9Xk
         3mKg==
X-Gm-Message-State: AOAM531lUWA5SVTgARBqTIoYP4dy/qhh8CTTJodjkbx8SNzjdivS1OgS
        oubs7+R0teaBlhDdjZIlXBZxcWM/tzFqyg==
X-Google-Smtp-Source: ABdhPJx5CgRsgoRdhYdVnW5qcZz1NQsKsJtwY6UJcp5T4KLl9uWSnW4iiyC8PFi6GQqJYqCop+FBVg==
X-Received: by 2002:a17:903:1212:: with SMTP id l18mr2141871plh.77.1643964364337;
        Fri, 04 Feb 2022 00:46:04 -0800 (PST)
Received: from localhost.localdomain (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id g17sm1630784pfj.148.2022.02.04.00.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:46:03 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2] counter: Set counter device name
Date:   Fri,  4 Feb 2022 17:45:51 +0900
Message-Id: <20220204084551.16397-1-vilhelm.gray@gmail.com>
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
Changes in v2:
 - Move dev_set_name() after device_initialize() so that device core
   takes care of cleanup on error

 drivers/counter/counter-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 7e0957eea094..6219d62bf223 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -22,6 +22,8 @@
 #include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
+#define COUNTER_NAME	"counter"
+
 /* Provides a unique ID for each counter device */
 static DEFINE_IDA(counter_ida);
 
@@ -115,8 +117,15 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 	device_initialize(dev);
 
+	err = dev_set_name(dev, COUNTER_NAME "%d", dev->id);
+	if (err)
+		goto err_dev_set_name;
+
 	return counter;
 
+err_dev_set_name:
+
+	counter_chrdev_remove(counter);
 err_chrdev_add:
 
 	ida_free(&counter_ida, dev->id);
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

