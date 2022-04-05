Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88944F50D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843387AbiDFBkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350041AbiDEJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:52:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C743CA4E;
        Tue,  5 Apr 2022 02:50:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so5103436pll.10;
        Tue, 05 Apr 2022 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEQsB4O9a4zfsJ2kScECV7mUZsYRm4ja4eXkna6qyvQ=;
        b=MqPzOGyjOxCnBCOjwZau3YU8/dUvS8nN96ULSTnlqKuv/Q2MVHXYQnMTLM32W+s6zb
         wvuyXcP2zW6SO8zSZyFA8EBzgr2wAzM6FX7J84heak1nc93M2jX1LjEiY4gvEig7Z/m4
         W5V1GmVo6Syrf6ybnF+hZEAFCZBYqdEAZLI+Epmse2sleWFVQUIJpF2/nY76xV5E72BZ
         Rqp+R23ntXoftcTQrMgg9uqvukZTQwObUu3pA2XpyujAcLcDlDfUuuoXiFZ6JH1IFexl
         Tn/HxmYjGkiOlTs5gt9IAnf7AuiaFsUvzKsSj8rNCKKizoEiPM+EkaxmdHNDMBXVtoU9
         yGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEQsB4O9a4zfsJ2kScECV7mUZsYRm4ja4eXkna6qyvQ=;
        b=1CjyEHDwBAquc4rbySqnGGdDQxjukeqJN/FvF0pKuzSM4TzXs2/PxYTOTe+9r0yGHi
         GC0o97d1LdsWAWSDTfjXshHotNlDrsLcaesP3Ir9eW+Yk8Xtk6RYzxxYyfIwKFHqMAD1
         Fk5D4Qg7rYG7cjI4lyAyq/l/YTh7VLDWopEn3oE75QyQsHsxdlgQkd2avThCGv3pysiQ
         r8E8U6rvIa/Zt9DxcmIwNlzKTcFCT5VdQe4s+BEqpP9GSTimrL9o/gYQG2eUs+iaNScs
         Uxgq66WbHLEqCJCUKpkbtvrByCx65mKdUtgutiYm7Hb/5eHgnpJ6LY5BXvsQ3WjHJ5vw
         ZzMA==
X-Gm-Message-State: AOAM530QoMJOS/0iSsmfnZC1wY8dAnw1k79YNFjhehAJNj2cFLGHANpz
        VtahyapGyY2bB1X7wFhzSOL50YuvYFhHQhQ=
X-Google-Smtp-Source: ABdhPJxFLqzS3BVvc+IKyWsmMh4Y4AswfBuiNSkNmhl8dH8X4SiB2P7HuXJoufJHa9jamRFDs4oS0w==
X-Received: by 2002:a17:90a:db08:b0:1c9:7cf3:6363 with SMTP id g8-20020a17090adb0800b001c97cf36363mr3074782pjv.35.1649152229023;
        Tue, 05 Apr 2022 02:50:29 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id pf2-20020a17090b1d8200b001c6f65ca66fsm1916389pjb.47.2022.04.05.02.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:50:28 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     mchehab@kernel.org
Cc:     sean@mess.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: lgdt3306a: Add a check against null-pointer-def
Date:   Tue,  5 Apr 2022 17:50:18 +0800
Message-Id: <20220405095018.3993578-1-zheyuma97@gmail.com>
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

The driver should check whether the client provides the platform_data.

The following log reveals it:

[   29.610324] BUG: KASAN: null-ptr-deref in kmemdup+0x30/0x40
[   29.610730] Read of size 40 at addr 0000000000000000 by task bash/414
[   29.612820] Call Trace:
[   29.613030]  <TASK>
[   29.613201]  dump_stack_lvl+0x56/0x6f
[   29.613496]  ? kmemdup+0x30/0x40
[   29.613754]  print_report.cold+0x494/0x6b7
[   29.614082]  ? kmemdup+0x30/0x40
[   29.614340]  kasan_report+0x8a/0x190
[   29.614628]  ? kmemdup+0x30/0x40
[   29.614888]  kasan_check_range+0x14d/0x1d0
[   29.615213]  memcpy+0x20/0x60
[   29.615454]  kmemdup+0x30/0x40
[   29.615700]  lgdt3306a_probe+0x52/0x310
[   29.616339]  i2c_device_probe+0x951/0xa90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/dvb-frontends/lgdt3306a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 136b76cb4807..6f1703546500 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -2177,6 +2177,11 @@ static int lgdt3306a_probe(struct i2c_client *client,
 	struct dvb_frontend *fe;
 	int ret;
 
+	if (!client->dev.platform_data) {
+		dev_err(&client->dev, "platform data is mandatory\n");
+		return -EINVAL;
+	}
+
 	config = kmemdup(client->dev.platform_data,
 			 sizeof(struct lgdt3306a_config), GFP_KERNEL);
 	if (config == NULL) {
-- 
2.25.1

