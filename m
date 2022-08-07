Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902E558BB77
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiHGO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiHGO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:56:30 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B1B1EB
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883988; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDstWh8ONHhQiaISt3lPcKYc1wUzyQ3iFEhG0tcL52Y=;
        b=ny6l/qwaMOdLtlBwngP9cEdL9zEkAxXXaEYjrvuFx4gvI14iwSce1EeGZsvtGiCAkGc0hz
        Jacblh3nCtaKHQ65klSErWes6V8rxo1XWxjgMbCrbS7P0WdeaRsMZQD0gRrbo8RpK9Xn7H
        jfxbZnUnvvukQ+qzvsOdFh35mIDP2y0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 23/28] mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:42 +0200
Message-Id: <20220807145247.46107-24-paul@crapouillou.net>
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
---
 drivers/mfd/motorola-cpcap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 265464b5d7cc..ae8930eff72d 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -221,7 +221,6 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int cpcap_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -239,9 +238,8 @@ static int cpcap_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
 static const struct mfd_cell cpcap_mfd_devices[] = {
 	{
@@ -346,7 +344,7 @@ static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
 		.of_match_table = cpcap_of_match,
-		.pm = &cpcap_pm,
+		.pm = pm_sleep_ptr(&cpcap_pm),
 	},
 	.probe = cpcap_probe,
 	.id_table = cpcap_spi_ids,
-- 
2.35.1

