Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17514488C66
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiAIVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiAIVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:00:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D4C06173F;
        Sun,  9 Jan 2022 13:00:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so8608616wmk.1;
        Sun, 09 Jan 2022 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7FbUBRPfMQ+APn1+cSFpWBY3c2YpTH/gpTFcN8CzO4=;
        b=l+ncaOhmDPg9JS8ME7PfgjuYbDAtCDD/jKZUMX1Gk1oOWn9jAlKnf4UeiEuAjpTHS3
         40YCFlU/Tt5QUCMYE6RfR/uM8DX0SOF6fKB7UREOZmnJfyVKfSU0Yksr4S+EO882eVwK
         +X/vKn4CemSK4BXKvWX5f5wBALNOL0LWam95yiN+MLr0ceN2HW6lV6rXKcNpEqK+lL50
         yv7+EK0xk4Qr7RaSehktgFf7kRKa6KXuwQ2jwsS+JMdAgw9RNOMIuasCuiHRY5jufu3k
         dmxm2qQ50Op7sVp8hNgQ8+X/F4yvFMKO6qfqGXUDRlU61I34YAuPNrl7OChn5k2hTQLg
         JDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7FbUBRPfMQ+APn1+cSFpWBY3c2YpTH/gpTFcN8CzO4=;
        b=UIW3xVgT9rpf+8NrbHSWTnVBt5RZjRvu+gewCbd+bc4lIG5Q1OlHBNh9hirgXRiNU0
         v+CriUShHsh4HqtwuREveFRgLDIYoidptP0uzB9dP0p+ubc6H7kP/MzY/1lD2ea7XxNa
         iB5ZHpYc+G0KDK2GunAiA+yAsfapD/UZVfmVqbQHLD5lQcdwMjc1vTVEV8HwVK5SG2w/
         6TkzxahXA2r7K3pruv9zVTledKpS49+v+ic5laWE+xC+c9vH5WoFDoaZa0kFq33IQtqo
         K8m2TiaTsfAgAZHTeiEF+lYVB6rHLfDvblr7IuC3XeWzvTs7JGzag0mXIcn20AmYkQz+
         NK0A==
X-Gm-Message-State: AOAM5327wghbELZCEgCE+vjxvps+0seLDetNbM6vECDN85FVJlvzAoTe
        M38MlfPNI4fQu3iyX2D935vvSIwLsu40vg==
X-Google-Smtp-Source: ABdhPJyu5leKcJs15kH4ircTRVyd3IJ4easGqSHixz1BdFlQqp+gXKGmUJZ2fUzbh2DHA6CMC/llpw==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr19689604wmq.109.1641762002041;
        Sun, 09 Jan 2022 13:00:02 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r13sm4974460wmq.28.2022.01.09.13.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:00:01 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: media/radio: make array probe_ports static const
Date:   Sun,  9 Jan 2022 21:00:00 +0000
Message-Id: <20220109210000.53156-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array probe_ports on the stack but
instead it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/radio/radio-sf16fmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/radio-sf16fmi.c b/drivers/media/radio/radio-sf16fmi.c
index 54a40d60e4fd..1fb88c2b916c 100644
--- a/drivers/media/radio/radio-sf16fmi.c
+++ b/drivers/media/radio/radio-sf16fmi.c
@@ -275,7 +275,7 @@ static int __init fmi_init(void)
 	struct v4l2_device *v4l2_dev = &fmi->v4l2_dev;
 	struct v4l2_ctrl_handler *hdl = &fmi->hdl;
 	int res, i;
-	int probe_ports[] = { 0, 0x284, 0x384 };
+	static const int probe_ports[] = { 0, 0x284, 0x384 };
 
 	if (io < 0) {
 		for (i = 0; i < ARRAY_SIZE(probe_ports); i++) {
-- 
2.32.0

