Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3359547C818
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhLUULb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhLUUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB4C061574;
        Tue, 21 Dec 2021 12:11:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so56569098edd.3;
        Tue, 21 Dec 2021 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=m/de/yD2sHNNMg5WvFIFvr8GV7EWEddhE3u5XLi2Qy7uMleWXeTtM67bsyBLOr/Z0F
         wI/D0OollyRtvUqmzYRdOQAS4ZgQw+HKrM4LlV7YQyXTFILDJase3WA87e2HE6FrxAR+
         W5E7h37cobYkBvvMsbpyVWJqw06upScj+K5tPVRSX0AhgsoA3Y5O0mh6EYpaH3p5RnPm
         U9AFjo3V/5KTFiDaxm9pVKjViKU4lWn+rTHez3U/rDSQboXd1cIHfxR3L/9/ssqXfwmI
         KPMwpBskFpIaJNU28wlLVXHnp7VFQOV0R5E36MyFeXLve8KHaCWzAfIhTbEwYWTtKyIa
         GUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=Lu05q91Yi76+NWwMkAR3sX5It8KyWcOj5BSsTGmFs5FKhI19TUUjg+ZqPW66ftK55t
         zOdO4GoO4Z/NM6TI70MJ2lwVF1U8P8OD7cVyys3j+82v1banWqEwcyWIGmpDPAGo0y4z
         TybMA0ujgMh22EoxpYP25xgSwJNh6zjP8zeHUQn2/sCCeZbCYZ7lCe+QfkxCJsVLO7bO
         OsGb6iZX6wsHrPO8SA7+e2XFxZ+6pG44HQa/lYfvHsWpjHPslVDiQDf7Kf5SVfTE9D6M
         idfzbns13W0NQMhFxsXmetm+ML3NZzY2nB1f/bUS0jOPezNX7hl4jvUFlE07OGj8MWXH
         sqPg==
X-Gm-Message-State: AOAM531go97H7Og8uRopk7gWRPtSqa2KqdOgSYhffboKIhnwtP9XrunJ
        NgISHjd30dDi3h2qUQja7o0=
X-Google-Smtp-Source: ABdhPJxccYsYczsiZNqc2hpn7BGX9N1CsCcLoTMwYBpR9JY8irIG3Sx1o13Zg2tz8rvruE9+XFGA0A==
X-Received: by 2002:a17:907:6d04:: with SMTP id sa4mr4258959ejc.526.1640117486494;
        Tue, 21 Dec 2021 12:11:26 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:26 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/8] hwmon: (adt7x10) Store bus_dev in private data
Date:   Tue, 21 Dec 2021 22:11:07 +0200
Message-Id: <20211221201113.752827-2-demonsingur@gmail.com>
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

