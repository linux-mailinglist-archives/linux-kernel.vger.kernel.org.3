Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6297D5307AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352405AbiEWC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiEWC2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:28:06 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2403702B;
        Sun, 22 May 2022 19:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653272743; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Em3CyMziUfMyb2Ke9Rew/25b8PL2RUI8784W3WiQQoHcIGyZJ51udjwu34XDe/Cynhyps9AJiVgNDRHzn5n19A4a44QR8C1677XQ67+aKHoIp1xQFKJm0pYtzQ9jewhVV1z+/xS+tRoxK9VNjBEckN+HsMueezsXJH2lvcmuZS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653272743; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6Y3a2rgqTa+y/A+6b7ejIUWPHMPluHbYkwTV2tC9EVY=; 
        b=b7m17VbiyHdoSowcQN1KFKUO+BrO2mfhGUEABGvvIZOCWqLwxUUFsLmVxNd83IFuZpPmgrdCCYVxmb4zygwfzcMO89lKWIznsikIjoQ0TN03f7MOd0yalb7FvP5CQVHOwXyv9Dls3WGVkpTqNH/QEtw3qHihPZIP84r2Q3y7R54=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653272743;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=6Y3a2rgqTa+y/A+6b7ejIUWPHMPluHbYkwTV2tC9EVY=;
        b=cmegWyj21gvIXeJVQ4Im3h7WUkoR2+szgtmOW/llh/xtwXJi5/vkNWCXp8bhQm/p
        q7rES8QIdXzpS6+y/EtnZTHzV3iz8pe7qfhFEpLqZVm7kQRft9gIzRunB+gfrh/U49J
        +HPPLuaRVMJ5jEjCqDV5ZDUUOqTomxpXG2xVmsjY=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 165327274252945.40475680553243; Sun, 22 May 2022 19:25:42 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 19:25:42 -0700 (PDT)
Date:   Sun, 22 May 2022 19:25:42 -0700
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
Message-ID: <180eebc0a68.1213567e360188.4128572766389616428@zohomail.com>
In-Reply-To: <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
Subject: [PATCH v2 4/4] pinctrl: st: Switch to use regmap_field_test_bits
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226c81fff77cfb172051bb436070000ef21e1d993c2a55c01ff1bade2a6d546b94b3ff9d69998ce:zu080112271e839f8acf638f74714b99d20000340fa72a3f103abecd542078fe39e42ef0f758ace926067986:rf0801122cba061c57510890781b2afc5f00005905e73cb464f94c463b10decb0ec92d506f90932586c1790432f98ded57:ZohoMail
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pinctrl/pinctrl-st.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 0fea71fd9a00..198b4a9d263b 100644
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
+		if (regmap_field_test_bits(pc->od, BIT(pin)))
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


