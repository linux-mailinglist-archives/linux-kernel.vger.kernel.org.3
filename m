Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF232514601
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355819AbiD2Jzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiD2Jz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:55:29 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C7B274;
        Fri, 29 Apr 2022 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651225931;
  x=1682761931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yv9qQvLfV+7m+faANRRzECiPlLuN7lEO90GMZ1mtz4Q=;
  b=MEGlyVs5hLVF9jduH0InqCx8e2Fy5H0uesb9vSiqfUyQdQZ4w7PBeU62
   WtpojbeqJ77ycoylj1tqgw290ihxndvBun7AYsGN8sq4SBtfMSQbxHQaS
   pm73qDK5O2S8rz8qbE88gbszC3lwVmZpV/l6KihJwSE77ItfpO+Fr2+mq
   jbFxnmK2jjBh7ToSWbWsxNyGa5bEvseeT4/CCLkuNAjF/k56AquP1d1um
   kAm7yHWr0rHSeI3DGlygxSweJavAoWrxA7IaqNj92SR6Luvs6Evh7cAZV
   WxNPMlKwUzywo92+5CBPVfWSWHwpS+L8UBXALkGHGFdh2Vs47gfaZIS3R
   w==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     Camel Guo <camel.guo@axis.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: [PATCH] hwmon: (tmp401) Add of_match_table
Date:   Fri, 29 Apr 2022 11:52:01 +0200
Message-ID: <20220429095201.2932180-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing of_match_table to allow device tree probing

Signed-off-by: Camel Guo <camel.guo@axis.com>
---
 drivers/hwmon/tmp401.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index a58a2f31a07e..cc0a1c219b1f 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -750,10 +750,21 @@ static int tmp401_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id __maybe_unused tmp4xx_of_match[] = {
+	{ .compatible = "ti,tmp401", },
+	{ .compatible = "ti,tmp411", },
+	{ .compatible = "ti,tmp431", },
+	{ .compatible = "ti,tmp432", },
+	{ .compatible = "ti,tmp435", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tmp4xx_of_match);
+
 static struct i2c_driver tmp401_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "tmp401",
+		.of_match_table = of_match_ptr(tmp4xx_of_match),
 	},
 	.probe_new	= tmp401_probe,
 	.id_table	= tmp401_id,
-- 
2.30.2

