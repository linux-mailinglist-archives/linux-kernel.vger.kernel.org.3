Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39D5307A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbiEWC1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiEWC1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:27:00 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7F3701F;
        Sun, 22 May 2022 19:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653272705; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZM2bRB0Sm5R9Qn3jURNOw/M6vzJzdqqj7EtQHiZMGRvWba/iAcd7RpDBdm1yiVPpOsNS7ixeuxk9z+/7x5SgkEaZ29842jEU+JBhtVztZ/AILFLkxZhB4+G9XLHt1W0M9KRjtDTktUPoFxnr7o18symJq56c/fVbtlS8M6yWIS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653272705; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fvKlICVNUUrLCUJvTxodNTr2NlUW+NUhpKNpJF53DY0=; 
        b=Abz/pfqHHs0HJpgg3wVPJxOQ+E2xUJXMQsB4tnmCcOatGePV4kAkj59JiSkD8yrIdkcbb2W7YDOal1V+7Gfe6FFtINv0bulFcIk6mlF1yDpm6YO87Sh63SLju9xbMHBaQ3DMFPC3BMtl+fpq3f4DzTNIhRkbwM633oR6qa5m4b8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653272705;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=fvKlICVNUUrLCUJvTxodNTr2NlUW+NUhpKNpJF53DY0=;
        b=AIchS6mYj8eWSd7yuCQA0wuAkIRFA8RhIN8kHPhghsowiuzQ3MnzwcDR2N4oLdHA
        Uqktm/hfqSOL+r3QZaO0cPG2bK44cBmg0yDEgOMtIjLS6+t8yV8r3k/h3YU8spurLJ2
        hZe6apS90PDQe3IHvSTqcYAKXInYxYLxgYbQ8vTQ=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653272703637648.493441998478; Sun, 22 May 2022 19:25:03 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 19:25:03 -0700 (PDT)
Date:   Sun, 22 May 2022 19:25:03 -0700
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Mark Brown" <broonie@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-gpio" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "linux-sunxi" <linux-sunxi@lists.linux.dev>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Message-ID: <180eebb727d.10ba4638860182.6950312744013746736@zohomail.com>
In-Reply-To: <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
Subject: [PATCH v2 3/4] pinctrl: bcm: Use regmap_field_{set/clear}_bits
  helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226ae110814a09a362c48165f4b00008eeb45bd2d65ef2780937ee6d60290f1710ab925d2423565:zu080112270d8d662acbbc0476a95403a2000082419318e6a1ec3c617ddd389efafd29a4813f34251e63ea0b:rf0801122cbe7ad45308199e6fd2fea2fe000042cc5f54ab3e442d95be0447b400bf129d594f38055bd1c8a6ec2e5a166d:ZohoMail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

Appropriately change calls to regmap_field_update_bits()
with regmap_field_clear_bits() for improved readability.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm6358.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6358.c b/drivers/pinctrl/bcm/pinctrl-bcm6358.c
index 9f6cd7447887..b03dfcb171d1 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6358.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6358.c
@@ -300,7 +300,7 @@ static int bcm6358_gpio_request_enable(struct pinctrl_dev *pctldev,
 		return 0;
 
 	/* disable all functions using this pin */
-	return regmap_field_update_bits(priv->overlays, mask, 0);
+	return regmap_field_clear_bits(priv->overlays, mask);
 }
 
 static const struct pinctrl_ops bcm6358_pctl_ops = {
-- 
2.36.1


