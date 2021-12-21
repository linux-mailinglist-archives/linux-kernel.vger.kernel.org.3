Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3D47C893
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhLUVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbhLUVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:04:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A71C061574;
        Tue, 21 Dec 2021 13:04:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so50608edd.13;
        Tue, 21 Dec 2021 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=VK+87iuBvV8zx2wZiGTy57iAglu49ew5ziU8ZI4+Dooq4lZjOPXnCxmAZZ0SJOpX3M
         vrb/hcifRNBScCQaExQCQVWxSMUXyTLUJBKusKEDR7axBTYJGN1VgpE2JJXTIrYoJ5k6
         aNi5yTWLoMYASXuPEt+6lsqpmFdXuPOO64h7NRqWKn3V8W2ssRCPnJBcVou2EQ/SSmx/
         6szrByGskCZj7QKB3yhYY3TCaezW2tniVZ/BMWJcysK8jxiIVr8u9KNJ9fjl5qxdcer0
         0m002iEQH+BYaFT9X+jNK6AsyQadVWPNNJYEHwNvTPQQv2rmIzbUdJfYD5TyKntk8cj2
         GrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=xsBVogarOt4NvmBuLws1NfppGVLYokH1P10lWeCAi/q9yfeN6s8QIHz2PWvc+rZJ+U
         DI+SwI7JlzVxLWeI05rOH/IKI4DYLthnHkWujT5+hYDR5AOulQ6+O9e5I9ctumV1lMb7
         C0/XCLWpbWut3dKcXXZd4/UAWcdJ8w3uhyfW0MvaPVloTtRPDdUiEV2yZK9QCLn77iSR
         2bb3fotRE9GIbODHEuDTy1vlHhk78YUWzwgusDPAFGxpWQvmjATIRC0OBKx3jBt7or+f
         6UcVtEchBxL3xKqLfCbFofsDXyYMoAWSptHM+Nw79hfIOc+F9I9OG4q8rrh99BEh7haR
         l4Og==
X-Gm-Message-State: AOAM531OIirmxv9fviJ5hfRrD9xOLKSBiIX/kLpCYVXHUoS+ZRWXzbFC
        7rtbDYrmJ0+15OzRg7m5Puk=
X-Google-Smtp-Source: ABdhPJwPotBXoPTQTGEYuzkga9vzLD7AUMEIRJUZXKT4zZrSr29PC+yP9x16UH0cggJKMjOlt6kvBw==
X-Received: by 2002:a17:907:169f:: with SMTP id hc31mr51798ejc.703.1640120694107;
        Tue, 21 Dec 2021 13:04:54 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:53 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] hwmon: (adt7x10) Store bus_dev in private data
Date:   Tue, 21 Dec 2021 23:04:32 +0200
Message-Id: <20211221210438.2637430-3-demonsingur@gmail.com>
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

It will later be used to access the bus device because
callbacks only provide the hwmon device.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index e9d33aa78a19..2439da9b64e6 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -56,6 +56,7 @@ struct adt7x10_data {
 	const struct adt7x10_ops *ops;
 	const char		*name;
 	struct device		*hwmon_dev;
+	struct device		*bus_dev;
 	struct mutex		update_lock;
 	u8			config;
 	u8			oldconfig;
@@ -368,6 +369,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 
 	data->ops = ops;
 	data->name = name;
+	data->bus_dev = dev;
 
 	dev_set_drvdata(dev, data);
 	mutex_init(&data->update_lock);
-- 
2.34.1

