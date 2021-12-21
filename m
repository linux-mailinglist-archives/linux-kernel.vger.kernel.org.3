Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E201A47BFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhLUMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbhLUMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:40:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E64C061748;
        Tue, 21 Dec 2021 04:40:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so22921026edd.8;
        Tue, 21 Dec 2021 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fSw3aeBsQx4xHt3HVrtz0g005ZmrGJREKdBB2cH2X4=;
        b=MtmcEKI8cC5idJ79i5BqiKloiR5o/Q0cRSsSYbjLFnfyLfzF6itgj2AyQ6p4s1YdPE
         UaZPLo8hq6LzrJ3Rw+XUK8Lg5c91uaao8B7MbgGNCFwujexN03DkLmTk1kjymqPxkWRv
         PZ5l0/WKrjzn64I6cZSs60YbF3LzcSNqhkWu4bQH3tn+thalP6bQUxLPXtX3KdvgnJAg
         Pv069O76miMCRVmuQfa5NjLeUycKr5voQ78lr1WiukOlKuUbd6H7zwU/hd+lkhJS/i/p
         nlNZc8ApDQZq2ACbGn1aFK+ZHrxXqZiuL7NC1GT4ZFFqYdSFKnWkrX8Z5dWtGfr5shAh
         ry7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fSw3aeBsQx4xHt3HVrtz0g005ZmrGJREKdBB2cH2X4=;
        b=yk2CFHVYlul5NdFfJ9eRnNtBbLr4KYX78//JRzF9ZFq07b1q2Iq9reNf0mu0b09rXy
         PY8cWCemXuW/f4mh3WQ3mW1bT+XTR52nrpxu885MzbxR/6tLlvvx/FMPVPcbv0jJ9+3M
         Z9FdkxrUziLWUhexYmNnfUwL1wcrqxEuzsE1D+D4j1kxwP0+KByPkwMmI7UPOEd7+OD5
         RHgP7TlxUxPQ93MMmKG7QTxD8QRgbRqfWe1Ix6ssre7wRoonOgU0uZFEnn8OUBkXnPGk
         cj0NiWezlE9AXkAErem0GNYR4bt55rLbSgVbbJ2bIfeOHBTZzkuO3ikmTFJDc+nSJUvA
         YMTA==
X-Gm-Message-State: AOAM532Ltd/AAYOJxfVIuSJMQatTn0wmFu1wUDUav4cy8InYvBAZtoOr
        W0bgPwtZ8bgpltWCs0QLkP8=
X-Google-Smtp-Source: ABdhPJwvlurP56Bp5BBsbroOfW+6MYGEuJe02XFaboGtQnxI7w06JmAUCdrOf+ImtYbfoi1X0DR1wA==
X-Received: by 2002:aa7:c0d2:: with SMTP id j18mr3102268edp.281.1640090401482;
        Tue, 21 Dec 2021 04:40:01 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:40:01 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/10] hwmon: adt7x10: use devm_hwmon_device_register_with_info
Date:   Tue, 21 Dec 2021 14:39:43 +0200
Message-Id: <20211221123944.2683245-9-demonsingur@gmail.com>
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

To simplify core driver remove function.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index dd4901299590..c03805c72906 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -54,7 +54,6 @@
 /* Each client has this additional data */
 struct adt7x10_data {
 	const struct adt7x10_ops *ops;
-	struct device		*hwmon_dev;
 	struct device		*bus_dev;
 	struct mutex		update_lock;
 	u8			config;
@@ -430,8 +429,8 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		goto exit_restore;
 
-	hdev = hwmon_device_register_with_info(dev, name, data,
-					       &adt7x10_chip_info, NULL);
+	hdev = devm_hwmon_device_register_with_info(dev, name, data,
+						    &adt7x10_chip_info, NULL);
 
 	if (IS_ERR(hdev)) {
 		ret = PTR_ERR(hdev);
@@ -445,15 +444,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 						IRQF_ONESHOT,
 						dev_name(dev), hdev);
 		if (ret)
-			goto exit_hwmon_device_unregister;
+			goto exit_restore;
 	}
 
-	data->hwmon_dev = hdev;
-
 	return 0;
 
-exit_hwmon_device_unregister:
-	hwmon_device_unregister(hdev);
 exit_restore:
 	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 	return ret;
@@ -464,7 +459,6 @@ void adt7x10_remove(struct device *dev, int irq)
 {
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 
-	hwmon_device_unregister(data->hwmon_dev);
 	if (data->oldconfig != data->config)
 		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 }
-- 
2.34.1

