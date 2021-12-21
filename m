Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37E847C821
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhLUULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhLUULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169DFC06173F;
        Tue, 21 Dec 2021 12:11:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so943708edc.0;
        Tue, 21 Dec 2021 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Yt9Z3R3Mz6HQLD0UxdravpstVCwaJ2Fm/yBXqM+ku8=;
        b=bC5mDLBffrpjxhP74SsDcqbCtldL7iv5RMYhAojPGVYe3AfzmNgwr/aLOSd/av0I1g
         3JDiU0LENFq/NWiuvkg2KIrIVavgltwj0jmGDqcW2QDuv4zTWGw2c33gitzujf2gcOGQ
         7RS6vQsSHXfoDJN+xQYl8y5JNvL1y83d3ABH8PT+C0rDv2dss3nC0k4gvjv4GH9sGCRn
         saoAk541XLKhv64VKoaA23dECf6Hj/uSVd2X05PUqWGQpxzf7jmGi2UvZq1P/Sfzhuel
         +0WVRgiqEVj27Ij4Woy/K9TlDXjOI1rK8Kmzrktj2GbyUpdPn9ljw+YIcSUhipOFxTQ1
         c0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Yt9Z3R3Mz6HQLD0UxdravpstVCwaJ2Fm/yBXqM+ku8=;
        b=eesWALFBtKxsA4Qv9t0ticRFRC+DdBq5LiY0YctR0AxUeM8Zg/5/jFqxY3HlKsqeKC
         VZFFjoVUsF8HPm2FfxLWAyjsiz6Um2U4CSz4+4RksZWU9u3XRerUG19ab8lxrONv6yJ0
         b5ghXpReq2r5kA4qsYxTKyk2H8E6o4pAUgiw26Reif4igpkr1H+yVW81qnBhrJTJrvPA
         sGBFqNZpQzs51HoV56DsYLoGcBUdpB4/lrQ/2wxYg4IrMYagUIoD0zP0s28iwi7pne2X
         mt5GU9c/viDME6soZ/E+tqem+VScxEhWCfQ8WQF/GEWxH3NtvnGzSvs+opdTVTJ8gAFt
         od7g==
X-Gm-Message-State: AOAM532zXkuCQey4oBjNabYpeC89iBE0vPV5aHngB/2AXnRvmHo+uY6h
        7mapW1XmPgbY+JlpD5hlOPk=
X-Google-Smtp-Source: ABdhPJxqBIF3l2S0ltYO5l0DH4DmRrWHmYEpRCiiiozmgYiU91cxkq2LKI7iWWLguVkqFAKTZnaj+w==
X-Received: by 2002:a17:907:1c02:: with SMTP id nc2mr4174991ejc.333.1640117492694;
        Tue, 21 Dec 2021 12:11:32 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:32 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] hwmon: (adt7x10) Use hwmon_notify_event
Date:   Tue, 21 Dec 2021 22:11:13 +0200
Message-Id: <20211221201113.752827-8-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221201113.752827-1-demonsingur@gmail.com>
References: <20211221201113.752827-1-demonsingur@gmail.com>
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

