Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2115A58CCDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbiHHRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbiHHRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:42:17 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675F21A4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980501; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RmH+YiYpUPBPp3yS1R7ESWCNgocdrFNtdRwVFv9A680=;
        b=dKP7w7NvIGHttdxvoHY8syuZgMiMOf/bUtoTOB1Ac+kCR5gKA7j1VYj3s5x8aARFUDNuuH
        jJXBoE/1YBcYppPyenZgG6XqQE/sPdZ5KJjMBkg/JZS+S2QVaUIkeQcpUJtfp2A5qzvUe/
        VLZ273z1aWT6BvUODalfjk665MiM9u8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2 04/30] mfd: adp5520: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:41 +0200
Message-Id: <20220808174107.38676-5-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/mfd/adp5520.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index 8db15f5a7179..882eddc32f8e 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -305,7 +305,6 @@ static int adp5520_probe(struct i2c_client *client,
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int adp5520_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -326,9 +325,8 @@ static int adp5520_resume(struct device *dev)
 	adp5520_write(chip->dev, ADP5520_MODE_STATUS, chip->mode);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(adp5520_pm, adp5520_suspend, adp5520_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(adp5520_pm, adp5520_suspend, adp5520_resume);
 
 static const struct i2c_device_id adp5520_id[] = {
 	{ "pmic-adp5520", ID_ADP5520 },
@@ -339,7 +337,7 @@ static const struct i2c_device_id adp5520_id[] = {
 static struct i2c_driver adp5520_driver = {
 	.driver = {
 		.name			= "adp5520",
-		.pm			= &adp5520_pm,
+		.pm			= pm_sleep_ptr(&adp5520_pm),
 		.suppress_bind_attrs	= true,
 	},
 	.probe		= adp5520_probe,
-- 
2.35.1

