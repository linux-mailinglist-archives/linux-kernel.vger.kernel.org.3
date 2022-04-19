Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230A5507ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357035AbiDSUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354068AbiDSUX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:23:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E23286CA;
        Tue, 19 Apr 2022 13:21:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t1so23958791wra.4;
        Tue, 19 Apr 2022 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuUgvlE4fmeiilILKG1ZLlvrT1f2Vl+nDCg070wtPPg=;
        b=e7JughPR4wMB3RJe6fqu/lzWsw6B7hEBwHd8NxXPclDSYtwrgro6K+QnKtJgSSdW3J
         Mr3+MqBCCIn3xGByGzsIJk9vfIJVmi+E+7ap5eK0HEcnRSvp1Q9zhijODxrfTAZNsgGB
         xO04RX+xgEK7xKV8yyGrdQQcMcRd0ttkx22VTZEC0THa7OOiw1ywZgQLr8t2x9bb7Vmf
         LZJvZ6ZmJVzOTBJ+TY64en8ojJ3atfgrlzEV0/aUMjmJ6JhqcbhZYlDB6RAPlZ0AU23J
         3PZqWnSnfL1PHqd5v66rnKC59964jH+59oqPbh5PNyRfFqO+6npawKF8zAGh05mlsMQn
         vhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuUgvlE4fmeiilILKG1ZLlvrT1f2Vl+nDCg070wtPPg=;
        b=bpum+bCaZdhr/+LUxRcTHdlquS83tqBvPgoQsww9KuGT0Sp8qzYV9Fh6x7okWIXLda
         LU8x2qYodatI3ixOIuHcWOrWDZrfXGfHEwpnPVRf/EwGk4wKnJgcXaVWOk1uCw2dK8d6
         cvhcvs0zD34HReRjvURmlRKyGlOr6W0Rt2+MAZusrCrBBR0f7jdhxS4FRPdQAwojgXzm
         rSTrafZa/z6czB6zg8hIJ3BEXUPCwEpDgF2sRAst3uca0KKQbd6E6dZ4ip9TuoBmdPZy
         smNV3ID8ZsJiS67cST2r7+zT3+8S8nFKC1F7+4yE0cZjVe5cJNxDbYUJbsQdQbJPUNgP
         s3Pw==
X-Gm-Message-State: AOAM532bsMyL/sRIf37ruH+KEmQ/oyFuEjhFv4+dlqa7ZmWZr0OfKqJ/
        dTGXHl5sS0rQObiloJFWNLhNNQCnpgQ=
X-Google-Smtp-Source: ABdhPJyrQuLDn1Jn7QM5XCw/RXqBWMTbpcRjH4K7vsPjpbVj6MgZT7J7LZQYUvotmPbX1SdGtP5nJQ==
X-Received: by 2002:adf:8162:0:b0:207:99d3:6c0b with SMTP id 89-20020adf8162000000b0020799d36c0bmr13032294wrm.429.1650399673289;
        Tue, 19 Apr 2022 13:21:13 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm9959168wrs.5.2022.04.19.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:21:12 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     matt.ranostay@konsulko.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH 3/3] media: i2c: video-i2c: Use GENMASK for masking bits
Date:   Tue, 19 Apr 2022 22:20:51 +0200
Message-Id: <20220419202051.44013-4-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419202051.44013-1-mosescb.dev@gmail.com>
References: <20220419202051.44013-1-mosescb.dev@gmail.com>
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

Replace 0x0380 with GENMASK(9, 7) to obtain 0b0000_0011_1000_0000

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/video-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 1d5f48329cb2..e08e3579c0a1 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -9,6 +9,7 @@
  * - Melexis MLX90640 Thermal Cameras
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/hwmon.h>
@@ -62,7 +63,7 @@
 
 /* Control register */
 #define MLX90640_REG_CTL1		0x800d
-#define MLX90640_REG_CTL1_MASK		0x0380
+#define MLX90640_REG_CTL1_MASK		GENMASK(9, 7)
 #define MLX90640_REG_CTL1_MASK_SHIFT	7
 
 struct video_i2c_chip;
-- 
2.30.2

