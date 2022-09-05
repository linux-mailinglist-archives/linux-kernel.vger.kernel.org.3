Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D158F5AD4C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiIEO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiIEO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:28:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FB42ADD;
        Mon,  5 Sep 2022 07:28:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso6273808otv.1;
        Mon, 05 Sep 2022 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/HmuyMJMLt8ALaWgV3Gf78kLSUZRzuNCL0jDYFaGvBo=;
        b=ga5TC7MQO3uI2t0sE1+ujHbv5Vk7ozxdWe0fsiXPTTcakqXwnGY36QTHbs6X+No7OG
         E6d7ZzYBsNTGC1Di2tovmccNK+gVtlSEHzKGJV8eoDMO+SnQ0AO+jN/iZFPGdlGb9XSN
         Xq7ySiz14XtkBWz13kTUDVv1ZMZ8ryQmcui+3u0RVImDGHF6qujV7ujR/AvHNBccIJAS
         uVgS5G3N6/9wPaNLjp8/ko75prkSm7NoD6B8NTvYVvdty+nXshXTSP+MozZk2wouAOt7
         dMeeOIUWXVxRiMQWo+1hYUh3NgDSenuYM/0YLkvRWXQ0O9W5koqBx+Uyt5sonzkvVHit
         curA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/HmuyMJMLt8ALaWgV3Gf78kLSUZRzuNCL0jDYFaGvBo=;
        b=7hGo5zKLOFT6i8Zi3uVGAcWZbOZhOBgPBkMLRMrtf/hbg9At6W75QMI3Kq6nv/t/+O
         EDh9UyoZjCGetYIywV/ecprs8H7gwfSWOkbo6K+NGGv9HpM2deZLYAhHGHfsV8jKFap8
         b1Hijc0ZbPOJ3SoIDRnPukw4wHF+2XBHKmI5LYIUSYQ8GCE9cAd+3OL+qf9O22hiyt5s
         h1xHnU2gPaxhhXZFCFLboQzJyLElZyjFCfw+MlNlQjd78f2YawbeJQbOj+YBXorr7NiL
         /xpeYIgJgS+akq4IBIAnaWamRnu5c6eYi6vpaomwLBYdyNKM9Q+2oT2WaHrRDGIvG6pB
         QkLg==
X-Gm-Message-State: ACgBeo2Yc9qaM5MUwoRxls8WH96S7plMuzMZWP3bjbGmhsujfZwwEo30
        h+g0C9I/WZJ1juWMWx5GrOo=
X-Google-Smtp-Source: AA6agR49PxFevx6nxud0x7z08SpxLv2Ocrby9FJ/C4R11kbipooER0pHaoy4J0zdEscbU2RxKxs1vw==
X-Received: by 2002:a9d:6254:0:b0:639:746f:1383 with SMTP id i20-20020a9d6254000000b00639746f1383mr18617907otk.167.1662388099428;
        Mon, 05 Sep 2022 07:28:19 -0700 (PDT)
Received: from nuclearis3.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id n17-20020a056870241100b0011f00b027bdsm2052857oap.45.2022.09.05.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:28:19 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, jdelvare@suse.com,
        dev@aboehler.at, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 3/3] hwmon: (tps23861) create unique debugfs directory per device
Date:   Mon,  5 Sep 2022 09:28:06 -0500
Message-Id: <20220905142806.110598-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220905142806.110598-1-mr.nuke.me@gmail.com>
References: <20220905142806.110598-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with more than one tps23861, creating the debugfs directory
for additional devices fails with

    debugfs: Directory 'tps23861' with parent '/' already present!

To resolve this, include the hwmon device name in the directory name.
Since the name is unique, this guarantees that the debugfs directory
is unique.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/hwmon/tps23861.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 0dbd12060b50..3e9df72702c0 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -503,9 +503,17 @@ static int tps23861_port_status_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(tps23861_port_status);
 
-static void tps23861_init_debugfs(struct tps23861_data *data)
+static void tps23861_init_debugfs(struct tps23861_data *data,
+				  struct device *hwmon_dev)
 {
-	data->debugfs_dir = debugfs_create_dir(data->client->name, NULL);
+	const char *debugfs_name;
+
+	debugfs_name = devm_kasprintf(&data->client->dev, GFP_KERNEL, "%s-%s",
+				      data->client->name, dev_name(hwmon_dev));
+	if (!debugfs_name)
+		return;
+
+	data->debugfs_dir = debugfs_create_dir(debugfs_name, NULL);
 
 	debugfs_create_file("port_status",
 			    0400,
@@ -554,7 +562,7 @@ static int tps23861_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
-	tps23861_init_debugfs(data);
+	tps23861_init_debugfs(data, hwmon_dev);
 
 	return 0;
 }
-- 
2.34.3

