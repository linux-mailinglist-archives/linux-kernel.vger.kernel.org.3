Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663055E3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbiF1MsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiF1MsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:48:06 -0400
X-Greylist: delayed 155 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 05:48:03 PDT
Received: from mail.intenta.de (mail.intenta.de [178.249.25.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6C1F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de;
        s=dkim1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Subject:CC:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EysddFqfXEvrq+i7Lz/urN4fUbO4wi9cwLiTty7V4Dc=; b=kPQvIUQv9PTPByzHYM1Quw7YJz
        DepJxe/39p7LDFY0Hk1x2Ny4gkBZIxbvu2cq7QsypcmfYO9q5vSRtcGZEyoA+nC7uptvFBss9Ij4y
        pxwlqJXaSR7Bj2eGKVAIU5+VXFUd7l2TyRdQ/PTdxQhdrMhxjP3zs4nb22vFH59/Y9gFBoMchIh4X
        mftTTIIwu4DXFbVfZ5F2elmn1OM+zos5NEJQdBOByRw70Cj+x94QUcAMNS9G33YINTX4iXvLL9Lkj
        giIzs2LII5rkL9KCqJYgZ2ZqwQaqB3S4hf0Gqn8bqy+ImVAlASv468Og7/i8rWWV+fj1qbMDZcMob
        eVuWYM3Q==;
Date:   Tue, 28 Jun 2022 14:45:21 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 1/2] mfd: da9062: enable being a system-power-controller
Message-ID: <bafccf43111a24e20fb36c46740d650dedda04c0.1656418366.git.helmut.grohne@intenta.de>
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
 drivers/mfd/da9062-core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Compared to v2, this addresses the following concerns raised by Lee Jones:
 * Drop unnecessary comment.
 * Restructure da9062_power_off to avoid unnecessary assignments.
 * Make power off failure message user friendly while still including
   the error code for diagnostics.

Lee Jones also questioned the utility of warning about pm_power_off already
being assigned:

> Do we really mind/care?
>
> Is there anything we can do about it?
>
> Thus, do we really need to warn() about it?

I do think this is useful, because it only happens when two nodes decalare
being a system-power-controller. It is a misconfiguration of your device tree
that is being warned here. Other drivers (e.g. rn5t618.c, act8865-regulator.c,
rtc-jz4740.c, and bcm2835_wdt.c) issue a similar warning.

I note that Adam Thomson reviewed v2. Thank you. I did not include the
Reviewed-by, because noticeable code changed compared to what was reviewed.

As pointed out by Adam Thomson, this version still uses regmap (and possibly
mutexes) in pm_power_off (with irqs disabled). This is a fundamental problem
shared with many other pm_power_off hooks.

I've now included Rob Herring's Acked-by on the second patch as the rebase was
trivial.

Helmut
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 2774b2cbaea6..0083a2756f28 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -620,6 +620,26 @@ static const struct of_device_id da9062_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9062_dt_ids);
 
+static struct i2c_client *da9062_i2c_client;
+
+static void da9062_power_off(void)
+{
+	int ret;
+
+	ret = regmap_update_bits(
+		((struct da9062*)i2c_get_clientdata(da9062_i2c_client))->regmap,
+		DA9062AA_CONTROL_A,
+		DA9062AA_SYSTEM_EN_MASK | DA9062AA_POWER_EN_MASK |
+			DA9062AA_POWER1_EN_MASK | DA9062AA_M_SYSTEM_EN_MASK |
+			DA9062AA_M_POWER_EN_MASK | DA9062AA_M_POWER1_EN_MASK,
+		0
+	);
+
+	if (ret < 0)
+		dev_err(&da9062_i2c_client->dev,
+			"failed to power the system off (err=%d)\n", ret);
+}
+
 static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -720,6 +740,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
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
 
@@ -727,6 +756,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
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
