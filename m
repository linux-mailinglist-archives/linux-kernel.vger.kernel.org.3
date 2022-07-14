Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6367B57477B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiGNIpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiGNIpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:45:11 -0400
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02DA63DBDD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:45:09 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id BuRhoA7r5bvrcBuS8oFpnK; Thu, 14 Jul 2022 10:44:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1657788248; bh=d3ojLOveqXbmSiZO4Qo5C01LjgUH9rwc4A6+CEo+xVo=;
        h=From:To:Subject:Date:MIME-Version;
        b=BDA35mUCYAOivdxGzqV/T/0H+XWBYihh2F6mgussmoQJEmxINxaJS0IwGr9h66oXQ
         4gKGq+wbeMUaMMDj7XpnX6C/GcHoutpDSvxEumct9bmw4ibNBUuY1MEMLWuN0LXlxS
         VebVTNqXk7t5e7RFzZ54hIRcsTDMqM4EcMm6+Jgh2LXvDW0MO99v5C41pUcUd7nZL4
         9888QF/rU75d4nIR6Vph8K1kizcpvEzgG6dd9oGMI2JupN5XQqYY7qhllEp/y0d+mN
         ZxDNyuuwuo3Uwf1qaodT2FTiy6dKt/pF3xkEX2iu06+d5DVBELeTFWnZ7UmynKL9KK
         LJh6r9rW8TsSA==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 3/3] ads7846: don't check penirq immediately for 7845
Date:   Thu, 14 Jul 2022 10:43:19 +0200
Message-Id: <20220714084319.107334-4-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
References: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJzV9VCatr6RG2B2PnZzh7ZVU62HDO+BSCRsFLg8V8lw84wpBMsJR6K5ZcTIa797byu74rOs/wRk/H7d82GMTODnvJRcbbPJrttHVhgfmtXH/n0wzWo3
 hoWVK3gLd753yUrHpdQXgc8dp1zXhwIo8QsbCfQNsAvXNDj3WNEWPKrHgGyxDzLHDiM5lDNWeI4WHqx+FNVLwN1gVfJpcu/Ua1zGZfyOOErB0yOpJhlXkkHS
 lOiYZH+4GECM2KU5RGjji+qfwcWgkS6EyuYpQhPhCb1+GDe82It0nTL5pwov5rC3BUle4tJZ05C207UTju+1Y+cKLMAa19xuosY6TLKXQXvzqEv4zKCFw6Ux
 yk222vF3z2Woh51lUXFjH3s5B1wya4kRJVK9y/jzJ6f0m6RIRIp75tVYeE9XMS+fQ3ohbGp/mGiQ/qDwPOrXkYbUR4ITvJtCDdN0WoLj4ZYyn91xRjz+q5yb
 eBSLENMVmFLJ0S9zivlWSKvKLVmynOgAGQgn1TUMbFrCV3k/0riYjr9RyL3IUydVJ1IbtrlIUdXZgf/M3dgq6p9HmtxtvykGqr/X2WoxU4lNJzoqGx7X3+Tg
 fKE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ellero <l.ellero@asem.it>

To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
Checking get_pendown_state() at the beginning, most of the time fails
causing malfunctioning.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 9e15cdf6faa0..122d3a13b7c5 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -843,14 +843,8 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (ts->model == 7843) {
+	if (ts->model == 7843 || ts->model == 7845) {
 		Rt = ts->pressure_max / 2;
-	} else if (ts->model == 7845) {
-		if (get_pendown_state(ts))
-			Rt = ts->pressure_max / 2;
-		else
-			Rt = 0;
-		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
 	} else if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
-- 
2.25.1

