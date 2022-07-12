Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FE572922
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiGLWRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGLWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:17:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FFC053E;
        Tue, 12 Jul 2022 15:17:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so658824pjn.0;
        Tue, 12 Jul 2022 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pSWqQLPzGCmh4WIT75be5rc1+0dauWv9WtCYsyw1neg=;
        b=PRu54UlfcnmszTEjKzE3IFCDZrLM6jVDqupfbnFk4pdd9Wi3QvkpF2Jk5QF/2M2/IP
         tFybVI7jFusbtKhxFTNwhQpHjsO+R3MXl6n/IL2MQvr/s+OZH1szKdlLIuwxoMhQyMQe
         O7GXomf4J7pcnQd5rUDF9f8aQNxpZCz5PNtNWoWVqbDucRDi6+kwliweadiBIPdvjfsW
         yvfcLQtBl/TKlxMQlbOHZjD5JYj3yUWTCpDQK+23j42cP9nFhf6STMDhDlE5NOYx9dYH
         qR0cqm1h66bEmgrt8bwthEr/nzi7NOsTYe7Lzcwv9i2Lo3a5/pQ5VQ4m9Iu6mUQWovW6
         2E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pSWqQLPzGCmh4WIT75be5rc1+0dauWv9WtCYsyw1neg=;
        b=5BlxdhotUCrPw5Dl2QGeBjxL13a2KuUHIg89u7vwZdmJecsoWJevBF1jZWAkEUXvi1
         e5XkyubfNiJ2XpiDx/oEdmIajq9O9I2NrkYQ48HlY8vBZrZ38hf6sGkmC0DiGd/3Rhuw
         Dd4FfZttF9NT1NSmyCBnOyyX7ISjYJXyLKZ5VulEtTBCr3t8LJdbOYWW0iKqYUK2rkHe
         VHYhheUJpOGPjUsVMUrkFiFAxlHkVzASSa7i5gRWqnOSbnbX7yJdcOLRdQWC0POZQzum
         I7/fftQ12lCC3ahW30Pbis1i9BSbjqDZGnZgLYWqQZoCuGwO+AMIqaKnKMjz1x76JaC5
         Vu8A==
X-Gm-Message-State: AJIora9njypedaAsNQfXKKxmuF9VZLsCIGlqeoHU6129bfQjpq8REiTM
        +OQWqIOx9YN0/5zybJXq9sM=
X-Google-Smtp-Source: AGRyM1suK+wAC874fac4wQuIogjEeFI6uqvENhpnssrl/pjhWHjOk9ywgCuPJ1++0XgfI6aNu4Zilw==
X-Received: by 2002:a17:90a:e7c4:b0:1f0:78a7:bf37 with SMTP id kb4-20020a17090ae7c400b001f078a7bf37mr1141093pjb.77.1657664229153;
        Tue, 12 Jul 2022 15:17:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0016c36b368d1sm6804111plr.150.2022.07.12.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:17:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nergi Rahardi <nergi@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Daniel J . Ogorchock" <djogorchock@gmail.com>
Subject: [PATCH] HID: nintendo: Add missing array termination
Date:   Tue, 12 Jul 2022 15:17:05 -0700
Message-Id: <20220712221705.1847793-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

joycon_dpad_inputs_jc[] is unterminated. This may result in odd warnings
such as

input: input_set_capability: invalid code 3077588140 for type 1

or in kernel crashes in nintendo_hid_probe(). Terminate the array to fix
the problem.

Fixes: 2af16c1f846bd ("HID: nintendo: add nintendo switch controller driver")
Cc: Daniel J. Ogorchock <djogorchock@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hid/hid-nintendo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 2204de889739..4b1173957c17 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1586,6 +1586,7 @@ static const unsigned int joycon_button_inputs_r[] = {
 /* We report joy-con d-pad inputs as buttons and pro controller as a hat. */
 static const unsigned int joycon_dpad_inputs_jc[] = {
 	BTN_DPAD_UP, BTN_DPAD_DOWN, BTN_DPAD_LEFT, BTN_DPAD_RIGHT,
+	0 /* 0 signals end of array */
 };
 
 static int joycon_input_create(struct joycon_ctlr *ctlr)
-- 
2.35.1

