Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D821D5B114A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIHAcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiIHAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:31:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E28B84EFC;
        Wed,  7 Sep 2022 17:31:18 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-158-249.ewe-ip-backbone.de [95.33.158.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC8076601F80;
        Thu,  8 Sep 2022 01:31:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662597074;
        bh=TH5RKawR8fUzI9ml8ZupcHOujoAZfQCPkmxXhLYxYXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuB/f8o/u+ITQE3vCmryUVKLmiG1nzpeVNf2hF52sQTCjK+C0nIAawpweJu3CEJ0h
         Dgam1zZzBBBHkc1v2NSlwFg981d/cA+xp+D8J4qR5JcnWbAVHX0f19Hf8vyAlqkTDK
         DbGeqwcVj8zeBnJPDWvFe+J53eJU3PtOPYQzjShQEzRauOS0QWspf67eg9+0Bn4CUN
         3BrPlt0gkOlFG9Q6buTlwImHqCupgBv1NnoChXZaFnAX30PzzT1aWa7VOYFP9hCtnz
         Pj9HtxVvZRzHZq5tHMPJ2qJad3zO6aorJD7M6+WNXv0rmzufDnadJnh5ty4rqb5ldz
         NKgNKnXWG9Txg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7713A4807A1; Thu,  8 Sep 2022 02:31:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 11/13] regulator: rk808: Use dev_err_probe
Date:   Thu,  8 Sep 2022 02:31:05 +0200
Message-Id: <20220908003107.220143-12-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908003107.220143-1-sebastian.reichel@collabora.com>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
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

Print error message for potential EPROBE_DEFER error using
dev_err_probe, which captures the reason in
/sys/kernel/debug/devices_deferred and otherwise silences
the message.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/rk808-regulator.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index ce9c64cadeba..fa9fc1aa1ae3 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1343,11 +1343,9 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < nregulators; i++) {
 		rk808_rdev = devm_regulator_register(&pdev->dev,
 						     &regulators[i], &config);
-		if (IS_ERR(rk808_rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %d regulator\n", i);
-			return PTR_ERR(rk808_rdev);
-		}
+		if (IS_ERR(rk808_rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rk808_rdev),
+					     "failed to register %d regulator\n", i);
 	}
 
 	return 0;
-- 
2.35.1

