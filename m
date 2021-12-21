Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1416447C89F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhLUVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbhLUVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:05:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D919C061574;
        Tue, 21 Dec 2021 13:05:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f5so164970edq.6;
        Tue, 21 Dec 2021 13:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Yt9Z3R3Mz6HQLD0UxdravpstVCwaJ2Fm/yBXqM+ku8=;
        b=n4OLQvlvm5aFJWIzBc3FERjNuR4yhgkD1lK9T8MKYXL5tTNS6gkGDPxr1Hlvp/6KnS
         AsrmgKRDUIas/iyyQjSP/PjNwW+wrTHeQZ9cjtaCxMiGvpBpbQyHwtL6g7O9Cr6pUTfx
         cw4QVTwoHWyPGj4pARhneCKAT+5UUh4msyVBvLoAMiMFD4qKalf3l1IZ5eNzUb7AQrYM
         BZPZA/izGmjGhhTFbNMRqq7eqV1omYgTikvOfXjl7rYrRwV8TaTm/MZNW9jygMOPNxPa
         bd2BwOmT9oBd34OZso1vkStFOYZOCfEAlTVr6XIIBGXhj61pPZncdXfaiQ93p4aB0qSi
         kBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Yt9Z3R3Mz6HQLD0UxdravpstVCwaJ2Fm/yBXqM+ku8=;
        b=5Z8nXG2MmQitkUCadDXNjWqt1W+NMiD68ZtxnvuXstRAhxy4t0AZgZTfLowkpPwjXB
         CbS+D1CgmRyeOUSUVTDeJ5bqOK3t0KosXKlVWAOdqmbfng5Gya3vgMBfGmjnjF+VNhYG
         gWoMU81aWm4TC1+rRNe5ztExEm9d0qcqavWwUr4L5iF2TPMn8cRDfNj/9YQF3mgOGDjn
         ltTtGEgoXyn3C+oLcgqDDStXKN47KEtRxPLlR4m+IiCrjIQSvRKrgASGrqhjO4dz9VJN
         3R1e4lDxTTqDnGqjlgMrbzuB6vRjui5LY2An7+K+CBfUBmUwrLkacx3hWt/Zpo3duQG+
         w9MA==
X-Gm-Message-State: AOAM530B6TMRlZ8kjsphaTA52T2ZepwxkMTiwIiB+wbXY0Gx3wQuCkU4
        Zpesbu+2kvS4YlnCZwpnYJE=
X-Google-Smtp-Source: ABdhPJwIcImfbuQL6/fk0MuX0JYLCLcGLsaZzjCJjUTJefgrKdFcDv9rMHlUMTrO7j4ZzbES9/fVAg==
X-Received: by 2002:a17:906:6a0d:: with SMTP id qw13mr89358ejc.490.1640120699786;
        Tue, 21 Dec 2021 13:04:59 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:59 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] hwmon: (adt7x10) Use hwmon_notify_event
Date:   Tue, 21 Dec 2021 23:04:38 +0200
Message-Id: <20211221210438.2637430-9-demonsingur@gmail.com>
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

