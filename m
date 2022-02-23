Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5DD4C18C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiBWQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiBWQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B757168;
        Wed, 23 Feb 2022 08:35:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso679552pjb.4;
        Wed, 23 Feb 2022 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qwCO6oz8VP1/6wMfQ6D1bt50DiPSQlvwOligZ6UZ0U0=;
        b=mbmiq7QI8dAK+pShCCZt7PIKpHBDpLCTKo7TLsAHhsIALUAkmvXmpVKGsTv/cGewID
         nuU5YqXBXZ2Ksp5Hsu4S1p6+RgVTKkTemCVEENyCWqSt0bcER6Zhckeudxu+5ZfQ9LQX
         H8I7mWaUHNgGpFceBlrVk6RoaeVvbgCQLcV0a+v4TyplAf0w7vwFt/Q1FooVWqYXRTk4
         +xQwb6stntn8MxmNecIcYwRf40SpCKKQCczmUDcCNm0Y5OWhg/wU5X2BTRZUXVogne4A
         mTaSytFfKKtuUWg18w+qVMLDVmNVd8Lyg2gy5OAAxYjppTtOLFSeh1EtKNHVvs07QiZD
         GOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qwCO6oz8VP1/6wMfQ6D1bt50DiPSQlvwOligZ6UZ0U0=;
        b=mM9jjGVCM6g/I91USmOlznNy9fBjIRKKxffUvf1nG+vtlCRtx0zRQMqMYzdv9whuMD
         0O3VaGuTudcsAXQr3pp5Zo8JRupAl08EW3gp0NXxTeNDj1rs0s9+8DmINedigeXiAPT/
         ayOmfHqfTElXqaj00x3OYGspuzVi+rJ74RNFsON6EXaYUHhz8Wkkhd0rUXf/CXrk6nWg
         i1uyCn36UtMqJVF3jlCGjyclSkn/nY1mbeoKeM78zTdtowCyXhPs2Blhigm7+G17p550
         +bpC5au64rixX0Dtv0uDSJV3EM1rjlc6ExAEtv/QaNO4Anq8Yds3QH3aMr0vBtIpiDfa
         UJkA==
X-Gm-Message-State: AOAM533FYuPGpdD8qQIa6Eb0XIFL35rgfnDjssEpTiAG9QVWqzQw/jLJ
        AgOFapK2NCgXWQVFIzM+BfU=
X-Google-Smtp-Source: ABdhPJy79ozUt4jv/QsDI0/li6lXu61zmHSwllKaVzSIHRN2RrwxKjbHXBri4Rx6A4HjbSMDpDmHnQ==
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id i12-20020a1709026acc00b001498f60a526mr399077plt.25.1645634145325;
        Wed, 23 Feb 2022 08:35:45 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:45 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] iio: potentiometer: Change to firmware provided data
Date:   Wed, 23 Feb 2022 22:05:22 +0530
Message-Id: <20220223163525.13399-5-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using firmware provided data to get the device specific
structure if not available fall back to id->driver_data.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index f93cd342e09a..aeb74ee46fbc 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -15,6 +15,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #define DS1803_WIPER_0         0xA9
 #define DS1803_WIPER_1         0xAA
@@ -166,7 +167,9 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->cfg = &ds1803_cfg[id->driver_data];
+	data->cfg = device_get_match_data(dev);
+	if (!data->cfg)
+		data->cfg = &ds1803_cfg[id->driver_data];
 
 	indio_dev->info = &ds1803_info;
 	indio_dev->channels = data->cfg->channels;
-- 
2.17.1

