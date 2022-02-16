Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C24B82D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiBPIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:20:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBPIUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:20:41 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1320602A;
        Wed, 16 Feb 2022 00:20:28 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 99A9022175;
        Wed, 16 Feb 2022 09:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644999626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GYCb7jDMB1MdvVyw4SIwn4Hfy8z4CTkry5OojqG7RqY=;
        b=rNSaSNgSSIu/f9PSFbsuY1t/HWPsosdGVSQdOhtVDdCooLeHQu16YYcmz3S9lKWSfF19IO
        CrM4rvE+J7snVnJXONG+Gyvy5tn5BXvEJCPzBtps19YD3AXiEj/o3OSnGLVvKSJrIrWLlV
        923hFGFlYcjli/1t9w/rNtFKQI5OJNg=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] pinctrl: ocelot: fix confops resource index
Date:   Wed, 16 Feb 2022 09:20:20 +0100
Message-Id: <20220216082020.981797-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit ad96111e658a ("pinctrl: ocelot: combine get resource and
ioremap into single call") the resource index was 1, now it is 0. But 0
is the base region for the pinctrl block. Fix it.
I noticed this because there was an error that the memory region was
ioremapped twice.

Fixes: ad96111e658a ("pinctrl: ocelot: combine get resource and ioremap into single call")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 685c79e08d40..a859fbcb09af 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1892,7 +1892,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.max_register = 32,
 	};
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
 		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
 		return NULL;
-- 
2.30.2

