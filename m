Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8F4FC5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbiDKUed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349903AbiDKUeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867863630A;
        Mon, 11 Apr 2022 13:31:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 12so3067810pll.12;
        Mon, 11 Apr 2022 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHf/BMrM4IDiFNkGBeStENyE+6vkeKtpmqEY0HT77/Y=;
        b=bjhBwoGvNFC2ffjYE/8W6ufUnPXB6zBcdL02HYrVqASINmgA1NgHBt8O1kXQ5Flkxk
         qY86BXxQLh6kw+oY5lEKlqxmA9AhukWPntUjLNOoFBur9B7fcNUnF+2GU5TaoHwsCA28
         UuyKYkGRXuBaqGBmIqlOnFt59/w0XRwzgONvUOUuy9gefGi5w0b36XMa+4LdZ9lD50HL
         muV5BhYzx3MwjHYQP6//AAaoyuynrO+xHe9vkhtjz3lPFSAS9NKrzbdrYtPljhlKbkNJ
         XGCyih0XMOhQs4Pe2NxzMQ57jnbCYsrZAVIEoO2qW+nIIZtUMm6RJpoGSiP+ECnhnLc/
         YChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHf/BMrM4IDiFNkGBeStENyE+6vkeKtpmqEY0HT77/Y=;
        b=DForRaELr7Ie/TvIF+VxsoMFR054dIL/D6WvJbXjVKAmIHVD4EnyvJq46HoZs7v5eT
         xO9kYAlWA2b6nZ8y6VqG9UTDWQSPcP7mwXQH4Ff/8Ys/nXXQ6djSt8xSBt+KSP1EtxKL
         sI6bOY6g7lL/0VLTKL9nQowSttZd05zCBG1P/3U8nobovG9Q0U08IH+cNYh9lQBCdaNE
         nZCFGE7lbzR3JGIcDwTJxRvbnXRY6sLcI1QKenEg5NFUUZVXy2j5q/Wcltwm8DV9vJmq
         3Oa8XCsJpvKXzYxnPyIjJuA3LxgSsKhBFkSITHnXVUYC0o3lcvNUL4tgqqo+nPETtpPa
         /7Lw==
X-Gm-Message-State: AOAM533Oe5/HWAIBhMdaDSKltxqkXpiS+kjrA3fQuJrN3Voex1GhlRO0
        JGioMymy4aVsRcJeG8DGaaY=
X-Google-Smtp-Source: ABdhPJwvED6ZmidCJkIUMw/pCTbM9oQ/KYGik9Nf2kyHDbPtCWCGDQF4oTj/79aQFNqOwr+9+Z2niQ==
X-Received: by 2002:a17:902:ea0a:b0:157:31:e828 with SMTP id s10-20020a170902ea0a00b001570031e828mr24751037plg.19.1649709116623;
        Mon, 11 Apr 2022 13:31:56 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:56 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] iio: accel: bma400: Add debugfs register access support
Date:   Tue, 12 Apr 2022 02:01:32 +0530
Message-Id: <20220411203133.19929-9-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411203133.19929-1-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read/write byte from/to bma400 device from the userspace
using debugfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 69d2caa4ed18..b6c79cfabaa4 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1028,6 +1028,23 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma400_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg,
+				     unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	if (readval)
+		ret = regmap_read(data->regmap, reg, readval);
+	else
+		ret = regmap_write(data->regmap, reg, writeval);
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
 static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
@@ -1058,6 +1075,7 @@ static const struct iio_info bma400_info = {
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
 	.read_event_config = bma400_read_event_config,
 	.write_event_config = bma400_write_event_config,
+	.debugfs_reg_access = bma400_debugfs_reg_access,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
-- 
2.17.1

