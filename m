Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAC5716CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiGLKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGLKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:09:57 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8689BAC07D;
        Tue, 12 Jul 2022 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657620571; bh=DPGdqSGhmEWAw3do58iJLw426/BrSVvrm6dZCPnb6sg=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=BIab1jSnrcfjyXtaTMcv7H4c7NE2AllXhnRsNsf1gOGJv/aFzXPAcxwGaJGfeyKTn
         6Z2VU9VVNaUOegGkPy1cJBkSxGXe4MXXKWrQLuIaEl4cDoMU+YO0bH7VyQ7W2QIHU9
         jYCngFyhKbVQyEGK/2p0TMgwRdDhSiPbpmtPfejQ=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.207]
        Tue, 12 Jul 2022 12:09:31 +0200 (CEST)
X-EA-Auth: fIrO8Uw6UjpI8UagY7F1eZ1Uw0kxVaPs37zeJksxAxhmSq+YBb/2S1e6o2g3EKOv74B247gUIO06e/piUEPUmhAwo9gB2YmeaWYA0PpaIX0=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 11/12] leds: is31fl319x: use simple i2c probe function
Date:   Tue, 12 Jul 2022 12:08:37 +0200
Message-Id: <20220712100841.1538395-12-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
References: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 233ed67830a3..52b59b62f437 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -494,8 +494,7 @@ static inline int is31fl3196_db_to_gain(u32 dezibel)
 	return dezibel / IS31FL3196_AUDIO_GAIN_DB_STEP;
 }
 
-static int is31fl319x_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int is31fl319x_probe(struct i2c_client *client)
 {
 	struct is31fl319x_chip *is31;
 	struct device *dev = &client->dev;
@@ -597,7 +596,7 @@ static struct i2c_driver is31fl319x_driver = {
 		.name           = "leds-is31fl319x",
 		.of_match_table = of_is31fl319x_match,
 	},
-	.probe    = is31fl319x_probe,
+	.probe_new = is31fl319x_probe,
 	.id_table = is31fl319x_id,
 };
 
-- 
2.35.3



