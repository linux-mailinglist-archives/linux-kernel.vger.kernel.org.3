Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46347C8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhLUV6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B96C061574;
        Tue, 21 Dec 2021 13:58:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so512086edd.13;
        Tue, 21 Dec 2021 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=ierSayg6Die2nd/9Aa5Spr4PGfBZiSophXnaVzcqgoD5p8C72hZiPqmIJ81AS1B5JL
         69FNr0LUWL67Bz32Mg7KMqnIzALCaRoUBQO7HHsBxWR+vgde+Ut6VUWOTwQyEJ4SMD5g
         7DF3/yHnWgbob2w1RV4EXKjupojJ43Jtl1YPvqyNRFXMXDEgIu4MQ8/ETKra3O8Mmpwf
         uJ9sgGMHQ9pNCCMVOM6NkU57XPk+uoVnunbkdUjFTLngaLxPrOK9mzzQuAYUlWustn28
         7FFXuSV7fFtegeqMqgnlLD8vxF8IwB7jfNz2zkl2Kq6ut6TzQo1epHon2uu921Dq0laf
         36Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=ZGGnm0qmto6+bF1Qnmvz9laByFMrKdfBKEGYrxA29CdhyAKK6aGyFq76SzHC6Jjcd8
         NmMklbicv3fekmcnSDvMFDnG8pxlIIi3OML9uNblwknlZ1gH9c7pbb5ao6JvhA6+YSJ6
         WWVQnWa7vHf8ScM3y0qRtUy+0rXhhc4Lyh4hjyOfStP48KaVa7jaoudgU2XDow2TQkze
         DXjVMHANgb2LCHIhDEBHuisc3SihPQsZkVcQfHdcSEucb6z+RdPnQcMjvnT+4EUDb0jK
         gnzBE9HkXPaW6mh0565gSbS58Uq2BL3EyMlAMbkLHz7AC04ruMeIJaHGRJNTti/avwhq
         UH4Q==
X-Gm-Message-State: AOAM530FHR2j0o1GWG+Zr/NAdymWmXpKHhagSJVra2WYed07BbPPR592
        Gi4DN1gXXrVsMkkCQWql4Vg=
X-Google-Smtp-Source: ABdhPJwRnHrUM2ZIH+Q2YXLAgYWKFCbG+Vydsnw2lQWh2CD85v+b9zIwEy6KBXunEzn0k0N3ENgoaw==
X-Received: by 2002:a17:906:3e09:: with SMTP id k9mr250919eji.104.1640123923852;
        Tue, 21 Dec 2021 13:58:43 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:43 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] hwmon: (adt7x10) Store bus_dev in private data
Date:   Tue, 21 Dec 2021 23:58:35 +0200
Message-Id: <20211221215841.2641417-2-demonsingur@gmail.com>
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

