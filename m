Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA15573FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiGMWwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGMWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:52:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D02633A2D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:52:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so281256edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MHdm9iY1d4Q10WtmyTX7hMBUbCtLdf0+91ofjXUg6U=;
        b=kBjBwbM6IQflSJUh3ffta1lfkKAs2Ii2V7YMbR5b7x2tsUjXAFCOxgwGybjsdEqVKY
         IrAyOkcXWZeAUllGcEvuojwaVpsQGXMPJUtapm+2TCbsa9rIKGfqJBjKMBhieuO8jt6y
         lM2A/9HU4kqcBdT0kHcyY3EjhQfqbdGDroJnasa9RyxghPK2lX296sVQP7ySgYN0qrJs
         1JpghRdxxrmOFd/tQjK8NoVPVhW5CYhT9RSClpc0rfq3f6r5o7APZDBJq47y2AUUc+vC
         aJo0wddUxl5C/0aFzN1J2GLp2RRxIVXE8dEubnUUJd044CvU3olVg1ihrxIsh4twlgiq
         iAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MHdm9iY1d4Q10WtmyTX7hMBUbCtLdf0+91ofjXUg6U=;
        b=3R6OEYxFi9Zc2hiRDu401A5Yg0JAtOPaaVbOmYNIk9d/4sH72AaB0bChl4xygXrzLb
         pnpXUWJaKgefzMZG9AUi2cQDe0/AeXnS1faGB6AiYiAeBpF1NYzy1+mlbsxbJoI13s8V
         VQqsZmczefFLZGBiGoFha8o7NQKbmFGZj4RP+Pi+tsECqV6mb4jSI8PQdoFJyAJPW20i
         yPIE+Ylt01QMHU4OYufPI6K5SV62riTEkW8JM62XbJAiMkk+YSQ1wC4+lu2v/D/HXXaw
         gE+6KsQGgkPBeGRzq+t7Za8+vXZ2xD3UN/N8N35tmWkTLibD5zKXbCC2yyNFUDFZpReR
         yBjg==
X-Gm-Message-State: AJIora88L/KbCp4EwBcFb22pX16KLaj8dRDsvPwBa+DqVPqdeg84wDAd
        QfdeX/sNZTOwOaRPdZjb8vu4YQ==
X-Google-Smtp-Source: AGRyM1vYhdOuVl7Fhm14tnKuIiaqQ+p1HwzVmyj9A/MUze6JZcJHRXJyioc2k2bXNBprCvUbcYAlIQ==
X-Received: by 2002:a05:6402:2cd:b0:43a:70f7:1af2 with SMTP id b13-20020a05640202cd00b0043a70f71af2mr8046448edx.357.1657752722644;
        Wed, 13 Jul 2022 15:52:02 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-197.xnet.hr. [88.207.98.197])
        by smtp.googlemail.com with ESMTPSA id kw11-20020a170907770b00b006f3ef214e27sm5538254ejc.141.2022.07.13.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:52:02 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, colin.foster@in-advantage.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] pinctrl: ocelot: correct pincfg regmap max_register
Date:   Thu, 14 Jul 2022 00:51:50 +0200
Message-Id: <20220713225151.1476041-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "pinctrl: ocelot: convert pinctrl to regmap" set the pincfg regmap
max_register to 32 which is incorrect as there are 64 pins in total.

Actual register space length is 0x100, which matches the DTS and can
actually fit one register per pin with stride of 4.

So, correct the max_register to 0xfc.

Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 349e063a04fa..84bfbe649b67 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1899,7 +1899,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.reg_bits = 32,
 		.val_bits = 32,
 		.reg_stride = 4,
-		.max_register = 32,
+		.max_register = 0xfc,
 		.name = "pincfg",
 	};
 
-- 
2.36.1

