Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527A047BFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhLUMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbhLUMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839DC061574;
        Tue, 21 Dec 2021 04:39:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so22919314edd.8;
        Tue, 21 Dec 2021 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=cYxoDmd5pHtB+fdeCXL9u3p5LFjnVJR5wWCzVbFPhtTY9S/iLZRItpeZndrhGfP8Ou
         wod5QyiZj5cZo3KzXTC2oh5ojx2nq3qv3Q7ZYlbGPKCbbNeM36LnxiQDcFj8oxjfYvcp
         m/3VCJppwjLApDFwsc8K2tCNG6yN8R3dcLJ1R/UhQFboRB5fRo9SL1cbOdcr6xJTTz2D
         5ItNdNhyo/48uiGphLRwG5EBXFh/nkyWxxc+WVt6g52mIkNGRDIvJTcxwcT1Gyy+ykLq
         byKe4OSmmhskIRhLUtTSyGrCLsGBEmFkzdFYEV74FI7t3dkSiplTBKnf4YVXyxLYwUVj
         vB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TZKAtR6UT3uSpTIEo5wgVOep5oODFFJr46+sXEmJhnY=;
        b=yxT4he0hhq9OFFXYKbpNBWWkBTBNE4n0RNG3ubjx0sKPKyPDKfKuVwEBh2cOVpxPvu
         3BkdCS8/C7AsEuOMq49HVJGFmaN6EIWd2rbVTWwTZzVmdmJKYAhFJXxU6vS0AYWk04G0
         khtM8mdmYxquC7Yb70XaIjfmVk44Ov8y3ZfqLryg2LmGHAJcZY1rv8I58JV0bBZFat4O
         OFTkeEl13cir+uDiQMEWomnCvXLYDqRh4nH2Ywu311cyaq7ifCY6XQQkKbfcZWO0Uwmy
         zyO/AJO2kbO08yzHqOA83CZP+smweF+IM+fA3LVGHDcmdBSjeF3OCTBnS///kX4fMEAG
         mKgQ==
X-Gm-Message-State: AOAM530M/LhhhDEYEr1N+6/26IWRaqzlq208Nzlmz4tKyaKMFAf8z68Y
        tdJ2j4EHsCapltQ8+5/OCKY=
X-Google-Smtp-Source: ABdhPJxorBbs+ZOY4zrPiT3tvXwEQD7t8LKd8Ic0fGCMm81ZtPpPeeNsDQVKo+AeLchg5K1AYcLStw==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr2521978ejp.373.1640090393563;
        Tue, 21 Dec 2021 04:39:53 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:53 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/10] hwmon: adt7x10: store bus_dev in private data
Date:   Tue, 21 Dec 2021 14:39:35 +0200
Message-Id: <20211221123944.2683245-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
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

