Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928D64FA1A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiDIC2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiDIC2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:28:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DABCF4A0;
        Fri,  8 Apr 2022 19:26:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t13so9300623pgn.8;
        Fri, 08 Apr 2022 19:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UdmH2TSJ6/W5WTIzQNOvHyLqEMqCn/FlcP3EV3SVAY=;
        b=o0oAp1sMWxOU33K7DKS0ihI+p+e2vYYKndOPxUtGsl/FUN7jRivXToBoMM9zq9fNuF
         T9rgaqKDb4dzI1Jip3QSiOgv6ix/VU2f5/NyERiaQhOS4cEj5No/zndT2n/9gB8sjvBW
         5a3XljgbtaX7eUaRtHIZG017vA2is52yLAgoL6wszVq7AeV4IBZep5sq0c5fcu/RUzY+
         8rcWc5J6juZ3o3akWsJzlZ9ufnOWYVCJXWEUf6bHBv7lpHAEosgB2Jidumybwlco57xr
         OEyybBFs808C+G36xoQkfoqIHrhjMSY4YkS/5kil7pQ3PjUJyobG/LEBYW5wmUkXkcxq
         b5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UdmH2TSJ6/W5WTIzQNOvHyLqEMqCn/FlcP3EV3SVAY=;
        b=gadfT25EhVn3VE5JbYQN9xEP2e2xUinMqGWFAd4KnQdzEkuWjghXQ9cgNiRSKqPdJf
         T5FXdG83EVMrvAjV5eWr5B/juobMsYxim31lGbJIGtNyPTJgQpyONYMkc+c+XF/xpJqz
         Jg99dLxXO4pMrVCZKes9gK0UcfR5xsSxtOFITkzDLLAHt3jAsuaQKVshNEWr4ocYJEfG
         XKKnJSnjSGn1/tMenuFhH6dNylHpkh3kqvsEC6lDxw9pZomQUmmpVY6r+Qh9O0vw1vFv
         WKxjuKcmfbdS7dLVyOW5/hSDHzQFQYldaHQwJRPzakJliAN0Uh2vP0tXuvl0yRjRfFr7
         78dQ==
X-Gm-Message-State: AOAM530vzLxb98mntPB4cId1loMOoaass+XlZFRcLZNPeSB0Vy3xChDs
        Rhc22OpnnbIUYUuMAVKphg==
X-Google-Smtp-Source: ABdhPJykHg1fTfGUL3jdbE9lNYg5/XgGDc01mI0XemcQ3hG9AIui77Qu6318cAQkfL8p5bj6Si8jHw==
X-Received: by 2002:a05:6a00:b95:b0:4fa:ec15:7eb7 with SMTP id g21-20020a056a000b9500b004faec157eb7mr22686404pfj.74.1649471198871;
        Fri, 08 Apr 2022 19:26:38 -0700 (PDT)
Received: from localhost.localdomain ([202.112.51.162])
        by smtp.gmail.com with ESMTPSA id lx13-20020a17090b4b0d00b001c9989c721esm14080066pjb.17.2022.04.08.19.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:26:38 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     y.oudjana@protonmail.com, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] input: cypress-sf: Register a callback to disable the regulators
Date:   Sat,  9 Apr 2022 10:26:29 +0800
Message-Id: <20220409022629.3493557-1-zheyuma97@gmail.com>
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

[   19.311970] ------------[ cut here ]------------
[   19.312566] WARNING: CPU: 3 PID: 375 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[   19.317591] RIP: 0010:_regulator_put+0x3ec/0x4e0
[   19.328831] Call Trace:
[   19.329112]  <TASK>
[   19.329369]  regulator_bulk_free+0x82/0xe0
[   19.329860]  devres_release_group+0x319/0x3d0
[   19.330357]  i2c_device_probe+0x766/0x940

Fix this by adding a callback that will deal with the disabling when the
driver fails to probe.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/input/keyboard/cypress-sf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/keyboard/cypress-sf.c b/drivers/input/keyboard/cypress-sf.c
index c28996028e80..798611b76de6 100644
--- a/drivers/input/keyboard/cypress-sf.c
+++ b/drivers/input/keyboard/cypress-sf.c
@@ -61,6 +61,13 @@ static irqreturn_t cypress_sf_irq_handler(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static void cypress_sf_disable_regulator(void *arg)
+{
+	struct cypress_sf_data *data = arg;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 static int cypress_sf_probe(struct i2c_client *client)
 {
 	struct cypress_sf_data *touchkey;
@@ -84,6 +91,10 @@ static int cypress_sf_probe(struct i2c_client *client)
 		return error;
 	}
 
+	error = devm_add_action_or_reset(&client->dev, cypress_sf_disable_regulator, touchkey);
+	if (error)
+		return error;
+
 	touchkey->num_keys = device_property_read_u32_array(&client->dev,
 							    "linux,keycodes",
 							    NULL, 0);
-- 
2.25.1

