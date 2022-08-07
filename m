Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27C58BB5D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiHGOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiHGOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:53:31 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB4A1A8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883981; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5V+oAmei+VoJpSQsI4DtJbnHY6ZS38K62z7aM+1CLQ=;
        b=BbMvtcabDa/hf0PTcgFuLNu4baYDw0jjVdz5Y2fQ8wH6cHvdnFsrqQjaeWE3XY61r+BhGy
        dVWaic3z554J7QsWcuriQVsz6bp5n+aHG2X4owEL117upoiJ8Dg9XbJvGSjNZCIEtYq4+O
        zBY2jgseo5kLVJCu5cJgHFyygATFraY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 03/28] mfd: adp5520: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:22 +0200
Message-Id: <20220807145247.46107-4-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-1-paul@crapouillou.net>
References: <20220807145247.46107-1-paul@crapouillou.net>
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

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>
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

