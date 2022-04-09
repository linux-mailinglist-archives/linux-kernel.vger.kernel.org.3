Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8504FA8EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbiDIOMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiDIOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:12:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA9118D299;
        Sat,  9 Apr 2022 07:09:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h5so9278009pgc.7;
        Sat, 09 Apr 2022 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywLuhURZWup0XZ6PxVth2US3qHe3GrcEUeZbxf/aXSM=;
        b=XPerBaaYc64nNazrcqt6orH0B/waCDinTWwvSwI6kw8hGXx1cXNQYzZhUn8Mpkd3p0
         lzduX8cW5/jQ+tspZ+AyvGEM51AJnIwAjHGzMOZsY0PDwJfKokvDnZ9vqZwc98Q3Z4jr
         +C+27rdo6xoDrGyEj2hyLdamOqp4UWM71XpfpHm+r0nxSthTc+iJwctRp0pVg/PULfAk
         AJi82PFbcACkW8nblMH8palQbp8zYb+Hiu1uNsN1hUB8g9QVbb6fLrMVFOv1/ZdRtX7c
         AS2bsT9mQWdZZA4cWYgkvorsCEAW0pWcdDxhO0v1HVYiLgxR56lO2S+TibG0Q7ipDbau
         oT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywLuhURZWup0XZ6PxVth2US3qHe3GrcEUeZbxf/aXSM=;
        b=mKZRO+41e+O2/5GhHQ8mofJDQ68Wb+mqGfXRMQVbWqrBFGG+RBsdC0L4TYMRiyLiEO
         tNRDOLCzD5p518NNZMMKzftlIxzWY2Amz2p9NKzYeMYBvPnIZwYrZT2Zg0BFKvzZcts7
         EqHiTVDJUisgpK0iDpLkj6I13t7l2KlLNELbGPirbIRe55aXnjn8gv+QI9k5H+7f0LYl
         3KdNmDd2fQNo7zZLD7AFbmUVitPi6iK9J/GwpOwPzQxj752SvyXNs3934Aaf+tScZ1Dr
         VLkTwlQ/8VjM1/eQk7N8ffQAA28oEcLvEiD21jHC5tXtwNBbb5HKScr/hHz993scbgBC
         J6Kw==
X-Gm-Message-State: AOAM532UiHcyGvgDzN0nwv8AAozC2C4s+mgwOmQYaGTdmud9kGQxi68Y
        NIYhiVURrrmadpuk+bw0AjCZQaSbOL2zkLs=
X-Google-Smtp-Source: ABdhPJy3TzY6qIU4BBZZaEhggmYBaZfm48TYSK3WF/HHnhQ3NwLUlV+V/xWqtEL0xALwsZBxkjZI2g==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr24608724pfh.14.1649513396257;
        Sat, 09 Apr 2022 07:09:56 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm15339097pjy.35.2022.04.09.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 07:09:55 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: i2c: dw9714: Register a callback to disable the regulator
Date:   Sat,  9 Apr 2022 22:09:39 +0800
Message-Id: <20220409140939.2176161-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver fails to probe, we will get the following splat:

[   59.305988] ------------[ cut here ]------------
[   59.306417] WARNING: CPU: 2 PID: 395 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[   59.310345] RIP: 0010:_regulator_put+0x3ec/0x4e0
[   59.318362] Call Trace:
[   59.318582]  <TASK>
[   59.318765]  regulator_put+0x1f/0x30
[   59.319058]  devres_release_group+0x319/0x3d0
[   59.319420]  i2c_device_probe+0x766/0x940

Fix this by adding a callback that will deal with the disabling when the
driver fails to probe.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/i2c/dw9714.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index cd7008ad8f2f..eccd05fc50c7 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -137,6 +137,13 @@ static int dw9714_init_controls(struct dw9714_device *dev_vcm)
 	return hdl->error;
 }
 
+static void dw9714_disable_regulator(void *arg)
+{
+	struct dw9714_device *dw9714_dev = arg;
+
+	regulator_disable(dw9714_dev->vcc);
+}
+
 static int dw9714_probe(struct i2c_client *client)
 {
 	struct dw9714_device *dw9714_dev;
@@ -157,6 +164,10 @@ static int dw9714_probe(struct i2c_client *client)
 		return rval;
 	}
 
+	rval = devm_add_action_or_reset(&client->dev, dw9714_disable_regulator, dw9714_dev);
+	if (rval)
+		return rval;
+
 	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
 	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
 				V4L2_SUBDEV_FL_HAS_EVENTS;
-- 
2.25.1

