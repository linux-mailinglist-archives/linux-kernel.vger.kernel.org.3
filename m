Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720B530817
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbiEWDcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351227AbiEWDcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:32:23 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B696B31379;
        Sun, 22 May 2022 20:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653276566; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fNNN4gVmX7g6l5sOV/P9Q23pxSFhqaZZfi5VJiiRtZufKZJoxf8WdvSyxbWIFFMPwveLnvDQ/1xYxfTlrGzEBLyMetQxhzNS6AvNoUa55v+2NZeubo/113VgWJYVyg0b/mkK8YCYj/QUpTZHiagMXn23nr5tgOjoLNp3ZFP2QE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653276566; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6Y3a2rgqTa+y/A+6b7ejIUWPHMPluHbYkwTV2tC9EVY=; 
        b=ZYr/jPoGzgtRWn00lq6uVruYbB0HwK6b0lzOVgkoDzVLXzwL2iht0ZEz2+5N08sZX7ICcnjvRs9U+eJEJ27wOfcuHModktOW2aEzcfEbKHyoHL8CMDI2LdjknypPd9GDJq/BX+KWK/8aXufNYNPgAyhQR7vkCujG2YSdY0N5BH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653276566;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=6Y3a2rgqTa+y/A+6b7ejIUWPHMPluHbYkwTV2tC9EVY=;
        b=dJYOf229ttvDIQTleCtbfOB85CpuaxVkezkuOMMBEvSFe9TWxWUWUij3zXM3Q1WS
        SaWOQ2PLs63hN4PJ7bYRR2uMDc2/QzfGYfZxBxW3yKn1DIe+zb17T4fkylwH2EBZiGi
        l6qyYzOIN6dsEnGP+z6oK0IA5JJgs1IURiy2SVds=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653276565914920.2020919127932; Sun, 22 May 2022 20:29:25 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 20:29:25 -0700 (PDT)
Date:   Sun, 22 May 2022 20:29:25 -0700
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
Message-ID: <180eef6617d.e8980cca60760.7125525107711306420@zohomail.com>
In-Reply-To: <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
Subject: [PATCH v3 4/4] pinctrl: st: Switch to use regmap_field_test_bits
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122656e5cd6958fd4c7ab94adfc500001fdd7fdaf26b00c40900fee6fcc267d0f5cc243561ae8014:zu08011227be15db908130756bfd6197d7000079ca5556e9ca4072f705e96ed88ba82c548fa4e0655aa79a18:rf0801122c6b0c60d1fae0235f510c60b60000e5ab222c1e075c932ea2810b9b23169e1ecd448bf137269266dd888fceb0:ZohoMail
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


