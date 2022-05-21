Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB3652FD4E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355150AbiEUOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353151AbiEUOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:30:51 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21922B59;
        Sat, 21 May 2022 07:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653143370; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YmQVY556BiB5ox5y8PXNUjNRS9ozj0KmNZjYG6fzzLqWPKOljAcAZUugMmn4fFcsMs/AZqSKWdDeRKd0h/xokD9wMmPeUhEUxeGQL6TEWgW50DvxPK5v0f3nzdbiNx8OtQCCozZ5kcWh+KMwnvMNVHo8uICWQEAHvPEPd42zwaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653143370; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1uplxa2t3JmqaYVHdP2jpDOm9CDjpZeLGLqC5pe6p6U=; 
        b=APLirMOzbpNRybXIsKwmw1CqKXq5aCeN30dkdlJsHl5XVyMIdjsClOOHzkHIt7DJxvMyJNf1YUQeps7sliMM1UPn5zGcK2oyMDctSK9kxWrr30t1IkZRlOx5RYQ3avVfvIglGwLz1mndcf0ByTt7LQbaAhY/6ZyjdmIZ1rTqB7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653143370;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=1uplxa2t3JmqaYVHdP2jpDOm9CDjpZeLGLqC5pe6p6U=;
        b=DgOMEtCpUZ2ARhoTMr2uAQ8hXFJgspYlzQSLE9n2DmG9yOgzMrWV548fuOrUdKkV
        G1chSwAMCVkx4pMC/dzWyXVZ6RmqaPXop1y04YXCFwgoJDfMQ/Ko4PYJmS3cILwrBRm
        +m4TKssaUEsfhUHZG/Wg+jOTxaPehmVjcpk5I7k0=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653143369973677.7315354282247; Sat, 21 May 2022 07:29:29 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sat, 21 May 2022 07:29:29 -0700 (PDT)
Date:   Sat, 21 May 2022 07:29:29 -0700
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
Message-ID: <180e705f8de.1012cdc8c45890.1645144071309904245@zohomail.com>
In-Reply-To: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
Subject: [PATCH 4/4] pinctrl: st: Switch to use regmap_field_test_bits
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112267cf364621b3b792c124082760000e7e088bdddfac7607cfb9ed75c25ebb0ae36151ee2127976:zu08011227a6949e549385956098fdd8970000b0614889ccf8be8f90fa47d8a8e113acf06e6c8b3d7d8d0400:rf0801122c15ba42b8235095a91707cffe0000a891b0ca85c325025b4f94f07a70129da6fe31daec4a1e77eb2e73b78d41:ZohoMail
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

Appropriately change calls to regmap_field_read() with
regmap_field_test_bits() for improved readability.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pinctrl/pinctrl-st.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 0fea71fd9a00..971b54bb478a 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -573,23 +573,18 @@ static void st_pinconf_set_retime_dedicated(struct st_pinctrl *info,
 static void st_pinconf_get_direction(struct st_pio_control *pc,
 	int pin, unsigned long *config)
 {
-	unsigned int oe_value, pu_value, od_value;
-
 	if (pc->oe) {
-		regmap_field_read(pc->oe, &oe_value);
-		if (oe_value & BIT(pin))
+		if (regmap_field_test_bits(pc->oe, BIT(pin)))
 			ST_PINCONF_PACK_OE(*config);
 	}
 
 	if (pc->pu) {
-		regmap_field_read(pc->pu, &pu_value);
-		if (pu_value & BIT(pin))
+		if (regmap_field_test_bits(pc->pu, BIT(pin)))
 			ST_PINCONF_PACK_PU(*config);
 	}
 
 	if (pc->od) {
-		regmap_field_read(pc->od, &od_value);
-		if (od_value & BIT(pin))
+		if (regmap_field_test_bits(pc->od, &od_value, BIT(pin)))
 			ST_PINCONF_PACK_OD(*config);
 	}
 }
@@ -599,22 +594,22 @@ static int st_pinconf_get_retime_packed(struct st_pinctrl *info,
 {
 	const struct st_pctl_data *data = info->data;
 	struct st_retime_packed *rt_p = &pc->rt.rt_p;
-	unsigned int delay_bits, delay, delay0, delay1, val;
+	unsigned int delay_bits, delay, delay0, delay1;
 	int output = ST_PINCONF_UNPACK_OE(*config);
 
-	if (!regmap_field_read(rt_p->retime, &val) && (val & BIT(pin)))
+	if (!regmap_field_test_bits(rt_p->retime, BIT(pin)))
 		ST_PINCONF_PACK_RT(*config);
 
-	if (!regmap_field_read(rt_p->clk1notclk0, &val) && (val & BIT(pin)))
+	if (!regmap_field_test_bits(rt_p->clk1notclk0, BIT(pin)))
 		ST_PINCONF_PACK_RT_CLK(*config, 1);
 
-	if (!regmap_field_read(rt_p->clknotdata, &val) && (val & BIT(pin)))
+	if (!regmap_field_test_bits(rt_p->clknotdata, BIT(pin)))
 		ST_PINCONF_PACK_RT_CLKNOTDATA(*config);
 
-	if (!regmap_field_read(rt_p->double_edge, &val) && (val & BIT(pin)))
+	if (!regmap_field_test_bits(rt_p->double_edge, BIT(pin)))
 		ST_PINCONF_PACK_RT_DOUBLE_EDGE(*config);
 
-	if (!regmap_field_read(rt_p->invertclk, &val) && (val & BIT(pin)))
+	if (!regmap_field_test_bits(rt_p->invertclk, BIT(pin)))
 		ST_PINCONF_PACK_RT_INVERTCLK(*config);
 
 	regmap_field_read(rt_p->delay_0, &delay0);
-- 
2.36.1


