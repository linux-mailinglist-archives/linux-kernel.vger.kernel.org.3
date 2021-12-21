Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD81C47C89E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhLUVFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbhLUVFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:05:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450F1C061574;
        Tue, 21 Dec 2021 13:05:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j6so64672edw.12;
        Tue, 21 Dec 2021 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Jkv8qUJh2Qvz2gJBqyHxg6YZrouzoh2tHirL2oPEjY=;
        b=igfTCNPeEqrqU2Hlj2M3+4Twi3UY6fy00PXLLPVMJHkVRtq+C6LNSOPfeO1myu9+sG
         7C486YJZmJ2QLd3bpJ/HgjczJViInA/lSBYRZXYah+AOLGB4l/8jktXDSImj0dnnzjRx
         xbaX7sISKTDtlGZqT2sGPRP6m0Tyg/ZoqvNemXUKwcv1w7Ax8131WmwWPpWmt/6xgd8H
         bnNdM0rFMJcx0k0/hfmjqAoVXUYOem7LaslXcxfhey/BBtH6N3xkOFuQie+AkNhBI8+M
         4icpt/NkPigDKo5mKLm/+9PjxXKI6+NSNKFURDtRshZfB9E7iVXc8CMjEu4tcfly4BTO
         6lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Jkv8qUJh2Qvz2gJBqyHxg6YZrouzoh2tHirL2oPEjY=;
        b=KKaqSi3vD1jGIT22X5ghP9mrYOLtfkgOnIyVQ4ODsP5xL97ABHo1wjHGrxEg4CfpCJ
         PjE/JsW2cP88A8cnB+U0Ru6lW/JYcO+199QW7wP6vpysGCEebQxNXbZWvNQ/0bKHYMon
         cXsvdm8nkn+w1oBCXO5X1sdK/8dT0fLSn8Sed26GEiK0Enym3dJWQnLOHoz0OwcolXws
         O8UbTvDmCQkbbDEpaiYsobHoVnLIAq/0gUWfIIVynnlxCLkOypXs0CwlPx2slbE16FIv
         sz0PrTFGy0guQkP8IHY2YZ2TpElG9ukBsIqSbIwhsuTYEUK4SZGvEXQ64CNqg1WLJsCW
         dv0Q==
X-Gm-Message-State: AOAM5338R9l7xoI5laej0txnSFHBb17UMuAE2kIqWL71Hfl4RRfAo9Ge
        7xjM4v0IfBiAPxLANFIbDog=
X-Google-Smtp-Source: ABdhPJw2FNEV6mhN+5J/mxizTrVgzadVXqSACd6DMMMlfaVPvw/gXCJGg4WrGD73vqPN617f3lUmaw==
X-Received: by 2002:a17:907:7f8f:: with SMTP id qk15mr65929ejc.455.1640120698934;
        Tue, 21 Dec 2021 13:04:58 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:58 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] hwmon: (adt7x10) Pass hwinfo dev to irq handler
Date:   Tue, 21 Dec 2021 23:04:37 +0200
Message-Id: <20211221210438.2637430-8-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221210438.2637430-1-demonsingur@gmail.com>
References: <20211221210438.2637430-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The irq handler will need to trigger events on the
hwmon device. Pass it so that we don't store it in
private data.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 72d3a5de359e..964cbe43de46 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -101,7 +101,9 @@ static const u8 ADT7X10_REG_TEMP[4] = {
 
 static irqreturn_t adt7x10_irq_handler(int irq, void *private)
 {
-	struct device *dev = private;
+	struct device *hdev = private;
+	struct adt7x10_data *d = dev_get_drvdata(hdev);
+	struct device *dev = d->bus_dev;
 	int status;
 
 	status = adt7x10_read_byte(dev, ADT7X10_STATUS);
@@ -454,7 +456,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 						adt7x10_irq_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
-						dev_name(dev), dev);
+						dev_name(dev), hdev);
 		if (ret)
 			return ret;
 	}
-- 
2.34.1

