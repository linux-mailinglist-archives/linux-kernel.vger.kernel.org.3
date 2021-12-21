Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992A147BFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhLUMkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbhLUMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:40:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C77C061574;
        Tue, 21 Dec 2021 04:40:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so51534893edd.3;
        Tue, 21 Dec 2021 04:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDU6EJnDi6WvDkKmHwhya2IVRURBubZ/mSUv5bglbg4=;
        b=qHvP+2Q2Qfb+Y3QOhtSDJKJVIKl4tRJlReBpbrSXA9xTsPDbENJUjdXSdstuxr9ker
         FU3oKs/pwwzn1wBIdcAYkksLlCIdibs1C3U/lb9s4Em+KkNqtKuaH09v+MbBO8TuJZIv
         WxqJslFndp+SyH9VWHjPdwyLNIa0qKhvnQ07v/c5CbAc/n2psQe2nuQi3tdFIvlsb58u
         5TUMKLuK83O5hy8rkT5Ig8NWRFyDJdOGFpW8oc2XG/+cc3GaVz6iFU3cmHKJSvlaBXtS
         Iin+tI1kqJmRV/s1nDkJVdnVU+F85oDBWLa0A0aBBXXcl0A72Gr5B19gUYCuRKmvpiWx
         KmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDU6EJnDi6WvDkKmHwhya2IVRURBubZ/mSUv5bglbg4=;
        b=nqg2lCvItlPxF9oW+bcAaruEvfcN59GHSXXQon9rhoYbvjVUP/G/CAjb3umJveAC2c
         62W44r3PwB4WhHlJYRGPXU29gjO6Oyv9ApG/N2lgvkXmr1Aqh8xSMTTz8Jm7hSPNlaMR
         lNyrGs8vIpGQ1+pikowMTPQXIQPrYhIuZ4l/cQWVSqJ1JxcLyZ+dU9F9JvNzmMeiJeSn
         M+Aw/zfBFXGDuhRhqOetGUnMlXckZUfJRyIXra+0q1SZZFW2TOKasRdbZkEe8Ar5c8Z5
         0SMwg8m0y697DYYyKB1V+bX0d4MuBWCXsmAAHgeT24r7NktRVaovg+MC0bglDNE4Q2KX
         2rbQ==
X-Gm-Message-State: AOAM531vCxX3X4laSMQeU21PObgW1Ugj8HqjApHTivYSZKk4y8xqu/4D
        D79bQ7DAA0lddgtU2SKLP4dqd4CTBxw=
X-Google-Smtp-Source: ABdhPJzMaIlI84TReDumH3BOgLnU3Oh89XQvF84HO5TTuwZQ0X6qFNocxBcU4p1/NV0hkGgnSgn+Gg==
X-Received: by 2002:aa7:d94d:: with SMTP id l13mr3054747eds.208.1640090402531;
        Tue, 21 Dec 2021 04:40:02 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:40:02 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/10] hwmon: adt7x10: use hwmon_notify_event
Date:   Tue, 21 Dec 2021 14:39:44 +0200
Message-Id: <20211221123944.2683245-10-demonsingur@gmail.com>
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

The hwmon subsystem provides means of notifying userspace
about events. Use it.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index c03805c72906..1a99989a744d 100644
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

