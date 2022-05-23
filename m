Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A232530815
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiEWDbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355482AbiEWDbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:31:15 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813C643F;
        Sun, 22 May 2022 20:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653276526; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=D0fkNpDPzsA2EuGEHBR0s+MqO+mReMfgpm1vPEaKabZWS7GCLUFKDHtBMEQImHtzsumnZC2aHxPkCzvQUoqXJy5Q4KbfNKGZT8/gdLanpTGwTrCu34DpkXu5zdfKftzy8c30AgYcE24aKGgkoTmzAgFUhBaCG4lpTIi0d0Bwgi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653276526; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fvKlICVNUUrLCUJvTxodNTr2NlUW+NUhpKNpJF53DY0=; 
        b=M5S+FFVK6Mhl0bVPiR9i3uk+3C1QFX8ha2wsSgNM5KxXxStPxj2+5vg4WDqC9U5HDxjzHRKUnhKH37m7236YjiP56ExUuu4o41yriXIxbw/x8YhUDOcet+wHEf04BC2KWpr575xMR/c0zgOchLvjquyzkjx9Z+rRar5mUeJOgoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653276526;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=fvKlICVNUUrLCUJvTxodNTr2NlUW+NUhpKNpJF53DY0=;
        b=OuYUp2YImrVwOfdieSiPpSIXEbfglaJJTnlzPpPX7jW3vw02wQxzycOBC8jdz97x
        MywoLJvK04gBjkPnZFDVauUc0GXZlmgslGUdquwSt95negFNDg1LMyvDkf+9LxyxFQn
        0obl3z7FfW6YIlLB0iGe309DAuRXcHTe1gCd1EHI=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653276524341734.1163480582672; Sun, 22 May 2022 20:28:44 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 20:28:44 -0700 (PDT)
Date:   Sun, 22 May 2022 20:28:44 -0700
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
Message-ID: <180eef5bf1c.ce3c2e5460752.6975656435857169231@zohomail.com>
In-Reply-To: <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
Subject: [PATCH v3 3/4] pinctrl: bcm: Use regmap_field_{set/clear}_bits
  helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112263aae783704b494f131d3dbd000002d3a325e92674abb122f82f22c7a9c5da378767f82d6032c:zu08011227505fe070e568cc739ba225340000b822ef5bf7536055237e90505f92f98fcc7d4acca3a8b480f8:rf0801122c1810a98d6b346697f9da013c00009478e6a0e2a5388c91658b745d4c18fecd2cc3a43e4d0d843db1977bfd61:ZohoMail
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


