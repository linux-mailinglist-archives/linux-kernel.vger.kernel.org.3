Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469A750B080
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444335AbiDVG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389148AbiDVG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:26:58 -0400
Received: from mail.intenta.de (mail.intenta.de [178.249.25.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB45F506DE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de;
        s=dkim1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Subject:CC:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7B/VqgbHM/0dbgLUWiUslXlOopYmPI8epDqq4H9Eigs=; b=qoA4u4BysNZ2De6LP6pgNopZvs
        CnEETbMIHvod3HMwVGawJv4dRHHwsgOCfjd/CsPzQXH0ai7EcE8NUrhR4sSI78gUQDXcrohuheR+C
        0jgU7MP5X2JbWzTcXgNlCOzHAxdymtYSTRZuVfP94GHu/T06phDMSnspDKt612iA7Wn5qcmUybzTn
        Lnp8kHxPu3Gij8h58GKmxadBHMx26Z4fLAyE6bSIKX2FHrq5iIgNr3OIqVtu9NZYZ+2rtlLjO/LHF
        ryOPoyva+hT2Qq7hnLmAN2Ttu/CaRzknknIjcN87hXBrUL/0JOEOrAQIk2iphkAJnHtg+bUALqZCF
        pEdmN+oQ==;
Date:   Fri, 22 Apr 2022 08:16:31 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 1/2] mfd: da9062: enable being a system-power-controller
Message-ID: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EXCLAIMER-MD-CONFIG: 0e788d66-80ec-4ac3-b2f1-4d8c6f55fd77
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9062 can be the device used to power the CPU. In that case, it can
be used to power off the system. In the CONTROL_A register, the M_*_EN
bits must be zero for the corresponding *_EN bits to have an effect. We
zero them all to turn off the system.

Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/mfd/da9062-core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

This series effectively is a rebased resend. The earlier posting was
https://lore.kernel.org/all/20200107120559.GA700@laureti-dev/. At that time,
Adam Thomson critisized the use of regmap and i2c inside a pm_power_off hook
since irqs are disabled. He reached out to Lee Jones, who asked Mark Brown and
Wolfram Sang, but never got any reply. I noted that a fair number of other
drivers do use regmap and i2c despite this issue. In the mean time, more
instances were added:
 * drivers/mfd/acer-ec-a500.c uses i2c
 * drivers/mfd/ntxec.c uses i2c
 * drivers/mfd/rk808.c uses regmap and i2c
Given that we proceeded with accepting the use of i2c and regmap inside
pm_power_off hooks, I think we can proceed with this patch as well.

Helmut

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 2774b2cbaea6..e7af5b5f16e0 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -620,6 +620,23 @@ static const struct of_device_id da9062_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9062_dt_ids);
 
+/* Hold client since pm_power_off is global. */
+static struct i2c_client *da9062_i2c_client;
+
+static void da9062_power_off(void)
+{
+	struct da9062 *chip = i2c_get_clientdata(da9062_i2c_client);
+	const unsigned int mask = DA9062AA_SYSTEM_EN_MASK |
+		DA9062AA_POWER_EN_MASK | DA9062AA_POWER1_EN_MASK |
+		DA9062AA_M_SYSTEM_EN_MASK | DA9062AA_M_POWER_EN_MASK |
+		DA9062AA_M_POWER1_EN_MASK;
+	int ret = regmap_update_bits(chip->regmap, DA9062AA_CONTROL_A, mask, 0);
+
+	if (ret < 0)
+		dev_err(&da9062_i2c_client->dev,
+			"DA9062AA_CONTROL_A update failed, %d\n", ret);
+}
+
 static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -720,6 +737,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
+		if (!pm_power_off) {
+			da9062_i2c_client = i2c;
+			pm_power_off = da9062_power_off;
+		} else {
+			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
+		}
+	}
+
 	return ret;
 }
 
@@ -727,6 +753,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
 {
 	struct da9062 *chip = i2c_get_clientdata(i2c);
 
+	if (pm_power_off == da9062_power_off)
+		pm_power_off = NULL;
+	if (da9062_i2c_client)
+		da9062_i2c_client = NULL;
+
 	mfd_remove_devices(chip->dev);
 	regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
 
-- 
2.20.1

Dipl.-Inf. Helmut Grohne
Research and Development
Application Engineering
 
Phone: +49 (371) 24354 0 ∙ Fax:  +49 (371) 24354 020
helmut.grohne@intenta.de ∙ https://www.intenta.de
 
Intenta GmbH ∙ Ahornstraße 55 ∙ 09112 Chemnitz, Germany
Managing Director: Dr.-Ing. Basel Fardi ∙ VAT/USt-IdNr.: DE 275745394
Commercial register: HRB 26404 Amtsgericht Chemnitz
