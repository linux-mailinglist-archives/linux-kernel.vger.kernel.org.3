Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A54C8A83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiCALT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiCALTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:23 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EE71DA4B;
        Tue,  1 Mar 2022 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646133520;
  x=1677669520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YuiHKE9UCdLhzE7N5PaLG8kJoP7omJAX1x5EYzqzoa8=;
  b=ZHJhjevUuxgRh+ahaoZGo2VphGg2kxo3wsJ0+xmK3mdymomJj+qNgHxa
   7/rVpXKQrFEZjzqzA8kmeWnmeB9DwMjKYJiHjU+m6mmGm6/I+kEs3wYRr
   ElTRbXiqKRGdOxFEya9d08CBJESF7Hffo/PpTcdumDcVe9GUWu4n7TdBZ
   u7Euo1beZCzwgWgXFxbV55fdjO6Wi8mLCarAR/RmzUmxaeXHhTrdW150x
   4cYcD5g5IpYYuNqikMpHWNpQMWTDLz2tkVP5PAdoJ+8t5IVrNNXVvyi7O
   f9k++FOoSFCKmsbtJ29lNt27Uve0TKFbCIqL7h8qGUihed/xL/zgNU4N7
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 1/3] regulator: virtual: use dev_err_probe()
Date:   Tue, 1 Mar 2022 12:18:29 +0100
Message-ID: <20220301111831.3742383-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
References: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() to avoid printing spurious warnings on
probe deferral.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/virtual.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/virtual.c b/drivers/regulator/virtual.c
index 52c5a0e0acd8..50d2e9caaa71 100644
--- a/drivers/regulator/virtual.c
+++ b/drivers/regulator/virtual.c
@@ -295,12 +295,10 @@ static int regulator_virtual_probe(struct platform_device *pdev)
 	mutex_init(&drvdata->lock);
 
 	drvdata->regulator = devm_regulator_get(&pdev->dev, reg_id);
-	if (IS_ERR(drvdata->regulator)) {
-		ret = PTR_ERR(drvdata->regulator);
-		dev_err(&pdev->dev, "Failed to obtain supply '%s': %d\n",
-			reg_id, ret);
-		return ret;
-	}
+	if (IS_ERR(drvdata->regulator))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->regulator),
+				     "Failed to obtain supply '%s'\n",
+				     reg_id);
 
 	ret = sysfs_create_group(&pdev->dev.kobj,
 				 &regulator_virtual_attr_group);
-- 
2.34.1

