Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFE4DC92D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiCQOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCQOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:48:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867892013F8;
        Thu, 17 Mar 2022 07:47:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h15so7697081wrc.6;
        Thu, 17 Mar 2022 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAY6mibbxuK/0wWYDuqywXzaMd/5FzXh9vcIhJweRKY=;
        b=SJBt57bnGy6HdTYOTZBTGdtMyB/8XA9RnrVj74KIFig/GnWzV7XpERQS1SHmX/fGkT
         tscdW8wbobBuMLGWv+OUUZZdB1GGnJcIq30C7ljrlfnJWIjFn2EbUfetzzjArQGMhVjW
         QUylAYAX27+pCNkXZItJmoE8/u87Fs+POSqLHaBAffZUPNRJ5Ua8RNggcwjDtXqNUrAt
         p1W3UEFTX1wB1gRtyJDECJ9+7rJxDca/2wGklOCK8/NIWbu50opk5KwI5Vg1SSAHu6s+
         EhC2WbBVS/n1gHFZhq8YOrTrLJ43LB5att9rsRZNQet3j133wbbtM6Ac51EwnO6ux1y1
         cfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAY6mibbxuK/0wWYDuqywXzaMd/5FzXh9vcIhJweRKY=;
        b=Pxgy63Eqf2poyz+U36okyZwTRUuRGike6tVCBu7ZbE/4sNolBxH82zyO+iNFke4LdS
         vXJb4MWirU6C3QGKyMN9DcdeiW516klJClwxoSsnFyevMn+uSj3M+D361uch88P1SdEA
         645rlaqz85CGr0XHc4F1/CUoKpd/uy0M7A9DLoMwyY8jcnHqEbT4i2RrRLlELS88M4N9
         GFEcV3mKypVkJYJ/+XlaJ+a+OC8jVFFwt9R75qORgUBOsmVd6V/nZGjWV3670ydE1qy9
         5+a2mcUg6+Z6OKSTc5j1GG1RffgHuW4gUxxtE+0moWL7zQPIe4uG8BrXdJE0hlZ5p4JZ
         Fsxg==
X-Gm-Message-State: AOAM532GXd37VDWR3v2w71bkgSPg1N1TxB1md78DwcSTpGjdt+sUHSjE
        coJoIMj7nYlHwKHqBrar50Q0IHRD5rY=
X-Google-Smtp-Source: ABdhPJx/2+gFste4yVyJ6+zjQpmPqk5zxgPGnsAv4etjAm3ffaBI/rYPNqu5+Zuxa90g3U9S7GtgYQ==
X-Received: by 2002:a05:6000:156a:b0:1f1:f168:69ac with SMTP id 10-20020a056000156a00b001f1f16869acmr4568180wrz.184.1647528458014;
        Thu, 17 Mar 2022 07:47:38 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d64cc000000b00203d01e1075sm4612768wri.50.2022.03.17.07.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:47:37 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] media: ov7640: Use ARRAY_SIZE instead of manual checking
Date:   Thu, 17 Mar 2022 15:47:14 +0100
Message-Id: <20220317144714.47442-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Currently, the driver ends the reg-val list with a 0xFF as a check to stop
the loop. Instead an array of reg-vals can be used to avoid this check,
by using the ARRAY_SIZE(arr) macro to obtain the length of the array and
iterate over it.

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/ov7640.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov7640.c b/drivers/media/i2c/ov7640.c
index 010803d58ce8..977cd2d8ad33 100644
--- a/drivers/media/i2c/ov7640.c
+++ b/drivers/media/i2c/ov7640.c
@@ -13,23 +13,28 @@
 MODULE_DESCRIPTION("OmniVision ov7640 sensor driver");
 MODULE_LICENSE("GPL v2");
 
-static const u8 initial_registers[] = {
-	0x12, 0x80,
-	0x12, 0x54,
-	0x14, 0x24,
-	0x15, 0x01,
-	0x28, 0x20,
-	0x75, 0x82,
-	0xFF, 0xFF, /* Terminator (reg 0xFF is unused) */
+struct reg_val {
+	u8 reg;
+	u8 val;
 };
 
-static int write_regs(struct i2c_client *client, const u8 *regs)
-{
-	int i;
+static const struct reg_val regval_init[] = {
+	{0x12, 0x80},
+	{0x12, 0x54},
+	{0x14, 0x24},
+	{0x15, 0x01},
+	{0x28, 0x20},
+	{0x75, 0x82},
+};
 
-	for (i = 0; regs[i] != 0xFF; i += 2)
-		if (i2c_smbus_write_byte_data(client, regs[i], regs[i + 1]) < 0)
+static int write_regs(struct i2c_client *client,
+		const struct reg_val *rv, int len)
+{
+	while (--len >= 0) {
+		if (i2c_smbus_write_byte_data(client, rv->reg, rv->val) < 0)
 			return -1;
+		rv++;
+	}
 	return 0;
 }
 
@@ -56,7 +61,7 @@ static int ov7640_probe(struct i2c_client *client,
 	v4l_info(client, "chip found @ 0x%02x (%s)\n",
 			client->addr << 1, client->adapter->name);
 
-	if (write_regs(client, initial_registers) < 0) {
+	if (write_regs(client, regval_init, ARRAY_SIZE(regval_init)) < 0) {
 		v4l_err(client, "error initializing OV7640\n");
 		return -ENODEV;
 	}
-- 
2.30.2

