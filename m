Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2947C8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhLUV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhLUV6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C8C061746;
        Tue, 21 Dec 2021 13:58:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z29so604123edl.7;
        Tue, 21 Dec 2021 13:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Yt9Z3R3Mz6HQLD0UxdravpstVCwaJ2Fm/yBXqM+ku8=;
        b=MYoLkBG+axga/Oggw4eeYKGjRf8jdqPMoctwhgKBRq0IcUGwMTdG5zRFDAYFISzuJr
         uQyNfH679XJC+jZtn+RgzXExlmb6ZMYk6Hk4RfSYH6IBcZIpm4lnYvahEcFlgUWIuQVO
         R+VLL00pq5B2o4XQrfDMOUykbBQUYFtjOOT6b4i5pcfntTcYRUuHKLbXetSR205E7acv
         Ban5x6+GXTlEC5Zkta8uymPetyCQ0qRa0WO1S7T16YMc7Bu6rs97rFHrcO6gFfgbFtDZ
         /7uzYCSxOaRBE7Hfi908hLLAAF6bkgAUXhj1QTuPoI4yLvBnhtRbbkCzgaXu9+rduwpz
         h13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Yt9Z3R3Mz6HQLD0UxdravpstVCwaJ2Fm/yBXqM+ku8=;
        b=lg3SVABjX+uutWYJJs9uByWOS2kRANeWwOVik5zkgmhYW0Ct7kxvjxbWN8p2d62JKR
         Errx3i8+Nwtgbr79DoXjVEFLt3WslCOvsJ/KTnR63jqaJUPC5stLrW6GO2RpfNbHUdqE
         s/ZAYgufQtTLgw/2cU3b2Z7SHv+FOa/ppvz2Nk7n8Mw8RWMdcmCvY9hIq40GGS50uzk+
         3TxFcs8Z1r+2OvM0ayq4FM3bgtrxRtvosIF5dqIw4aIWWscLhUCi8OujGvFVRD1MWCOz
         uRGSI8AELO4wGyykkiUtRrbZ8Wg2T1GwQI4bJIW5kGIol8GnlV41HiRb8fch052Bxh2d
         HOng==
X-Gm-Message-State: AOAM530g3/rWnG3lCq/TXzBE6WynEoTSZET6TJtw3HD2R5hjx0xoJBoC
        yg0NBblhgoI/806jcjrgGKY=
X-Google-Smtp-Source: ABdhPJxQB6VZO9ytHpTGwPPz1Y+BwHv9b0sjQTvuy4A3o7avgCr9CXxOtjQ23PVRHAiuxg+9zj/uQQ==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr256187edu.186.1640123929806;
        Tue, 21 Dec 2021 13:58:49 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:49 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] hwmon: (adt7x10) Use hwmon_notify_event
Date:   Tue, 21 Dec 2021 23:58:41 +0200
Message-Id: <20211221215841.2641417-8-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221215841.2641417-1-demonsingur@gmail.com>
References: <20211221215841.2641417-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The hwmon subsystem provides means of notifying userspace
about events. Use it.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 964cbe43de46..994160bd8901 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -111,11 +111,11 @@ static irqreturn_t adt7x10_irq_handler(int irq, void *private)
 		return IRQ_HANDLED;
 
 	if (status & ADT7X10_STAT_T_HIGH)
-		sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
+		hwmon_notify_event(hdev, hwmon_temp, hwmon_temp_max_alarm, 0);
 	if (status & ADT7X10_STAT_T_LOW)
-		sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
+		hwmon_notify_event(hdev, hwmon_temp, hwmon_temp_min_alarm, 0);
 	if (status & ADT7X10_STAT_T_CRIT)
-		sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");
+		hwmon_notify_event(hdev, hwmon_temp, hwmon_temp_crit_alarm, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.34.1

