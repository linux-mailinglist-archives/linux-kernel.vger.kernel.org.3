Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1484756885C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiGFMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiGFMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:31:30 -0400
Received: from mail.intenta.de (mail.intenta.de [178.249.25.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6526AC9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de;
        s=dkim1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Subject:CC:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=w4pHfmZD0IlO48upKT0jymWFM3XUku7K9TO4KSQqx44=; b=ekgqeH0R3TIx7YeKE/3c5/hjwW
        1lOKsp25xtyAcwV/X7vqdt3OHCae4wnXYGQuVq/xgxJKOZxXkqJDIQJouZZz7qZ6eN9k7ojC4n1YE
        gtoLiGDSaKhNYxtMvSSqJmJhxZZRGnhPIdyY2APZC2DgEwJrnRXVsoBWVib7blaGIiuQPQ6NE6Hk1
        5ZI09mFxH/L7fOtHie3dMSPUTPoATs9qwG3mnAc6/DExa8N6r9P95yAXlT3XXFAIkdJAggYcNVY3V
        5hzjxD51LTK5TjtCqKF0FIB8g8k5QikftEnmUPC9wJnRZLCLDG+4sQ8rQmJnHuq9nXdDgtp1qK5mi
        l0WSMa4A==;
Date:   Wed, 6 Jul 2022 14:29:48 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v4 1/2] mfd: da9062: enable being a system-power-controller
Message-ID: <c6e19670802355222a228061f37aadace2764933.1657104160.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: 0e788d66-80ec-4ac3-b2f1-4d8c6f55fd77
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/mfd/da9062-core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Compared to v3, this addresses the following concerns raised by Lee Jones:
 * Consistently start error messages upper case.
 * Pull i2c_get_clientdata out of the call again. In his previous review he
   remarked the joint declaration and call as "passable", which I misunderstood
   as "can be passed to regmap_update_bits directly" while the intended meaning
   was more like "acceptable". This is part is now reverted back to the v2
   form.

Adam Thomson's observation about the use of i2c in atomic context is observable
in reality since a few kernel releases. When powering off the system, I now see
this:

reboot: Power down
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:40 i2c_transfer+0x104/0x134
---[ end trace 0000000000000000 ]---

Looking at the actual warning, this is actually about using non-atomic xfers in
atomic context (i.e. he's totally right). Wolfram Sang worked on this problem
on a more fundamental level and added a patch "i2c: core: introduce callbacks
for atomic transfers" (63b96983a5dd). Unfortunately, the relevant i2c driver in
use here (i2c-cadence) does not include atomic transfer callbacks yet, which is
why I see the warning. However, that only confirms the way of using i2c code in
pm_power_off hooks as the "right" way to do it.

In all of my tests, the system powered off reliably.

I still didn't include Adam Thomson's Reviewed-by from v2, because the code is
still noticeably different.

Thanks for bearing with me

Helmut
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 2774b2cbaea6..94d447769da3 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -620,6 +620,27 @@ static const struct of_device_id da9062_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9062_dt_ids);
 
+static struct i2c_client *da9062_i2c_client;
+
+static void da9062_power_off(void)
+{
+	struct da9062 *chip = i2c_get_clientdata(da9062_i2c_client);
+	int ret;
+
+	ret = regmap_update_bits(
+		chip->regmap,
+		DA9062AA_CONTROL_A,
+		DA9062AA_SYSTEM_EN_MASK | DA9062AA_POWER_EN_MASK |
+			DA9062AA_POWER1_EN_MASK | DA9062AA_M_SYSTEM_EN_MASK |
+			DA9062AA_M_POWER_EN_MASK | DA9062AA_M_POWER1_EN_MASK,
+		0
+	);
+
+	if (ret < 0)
+		dev_err(&da9062_i2c_client->dev,
+			"Failed to power the system off (err=%d)\n", ret);
+}
+
 static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -720,6 +741,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
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
 
@@ -727,6 +757,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
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
2.30.2
 
Dipl.-Inf. Helmut Grohne
Research and Development
Application Engineering
 
Phone: +49 (371) 24354 0 ∙ Fax:  +49 (371) 24354 020
helmut.grohne@intenta.de ∙ https://www.intenta.de
 
Intenta GmbH ∙ Ahornstraße 55 ∙ 09112 Chemnitz, Germany
Managing Director: Dr.-Ing. Basel Fardi ∙ VAT/USt-IdNr.: DE 275745394
Commercial register: HRB 26404 Amtsgericht Chemnitz
