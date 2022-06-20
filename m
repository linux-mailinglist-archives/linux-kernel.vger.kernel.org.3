Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF655227E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiFTQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFTQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:50:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89001570C;
        Mon, 20 Jun 2022 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655743856; x=1687279856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BdUjkb8NTulsxFIRGkofEI23e6NLg0pm6UTWDg+7rvM=;
  b=ZAw/TSKr/GkNDqRONNoFWFy3YcIcnDvbIVBeAC+qTGJMo4P8ffG2DBLF
   DRjNNl5Pij4dXrdFcjG9pRilF/8weXHqA9WHTtZlTuoB6csLAArfh9MVH
   usM74UeWmeZgtEGF223jujYC400+Twx0u5+EfMAMXfh80UNU7jnGxRpDy
   FuodVr0+duj47n3N/uLqfEw3YQdi8N3qQxfSSAIPszp+hIO74axUJ9xko
   /ePF24hoMsJ9gx3Pt4qyZ8+7TyG3USa2k749vFTyxsok6YQs1+Dwk6DLU
   vUv9ZsBe04BJtEdq27nLgdxR9QyF+rcjIAD1+myotHZG+LAgv+92bBuFn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305375395"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305375395"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 09:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="620174801"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2022 09:50:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3CAB414F; Mon, 20 Jun 2022 19:50:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH v1 1/1] pinctrl: bcm: Convert drivers to use struct pingroup and PINCTRL_PINGROUP()
Date:   Mon, 20 Jun 2022 19:50:53 +0300
Message-Id: <20220620165053.74170-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
Utilize them instead of open coded variants in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm6318.c  | 121 ++++++++++-----------
 drivers/pinctrl/bcm/pinctrl-bcm63268.c | 139 +++++++++++--------------
 drivers/pinctrl/bcm/pinctrl-bcm6328.c  |  85 +++++++--------
 drivers/pinctrl/bcm/pinctrl-bcm6358.c  |  20 ++--
 drivers/pinctrl/bcm/pinctrl-bcm6362.c  | 121 ++++++++++-----------
 drivers/pinctrl/bcm/pinctrl-bcm6368.c  |  91 +++++++---------
 drivers/pinctrl/bcm/pinctrl-bcm63xx.h  |   2 +
 7 files changed, 259 insertions(+), 320 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6318.c b/drivers/pinctrl/bcm/pinctrl-bcm6318.c
index 9311220fb6cb..64073546310e 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6318.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6318.c
@@ -27,12 +27,6 @@
 #define BCM6318_PAD_REG		0x54
 #define  BCM6328_PAD_MASK	GENMASK(3, 0)
 
-struct bcm6318_pingroup {
-	const char *name;
-	const unsigned * const pins;
-	const unsigned num_pins;
-};
-
 struct bcm6318_function {
 	const char *name;
 	const char * const *groups;
@@ -146,64 +140,57 @@ static unsigned gpio47_pins[] = { 47 };
 static unsigned gpio48_pins[] = { 48 };
 static unsigned gpio49_pins[] = { 49 };
 
-#define BCM6318_GROUP(n)					\
-	{							\
-		.name = #n,					\
-		.pins = n##_pins,				\
-		.num_pins = ARRAY_SIZE(n##_pins),		\
-	}
-
-static struct bcm6318_pingroup bcm6318_groups[] = {
-	BCM6318_GROUP(gpio0),
-	BCM6318_GROUP(gpio1),
-	BCM6318_GROUP(gpio2),
-	BCM6318_GROUP(gpio3),
-	BCM6318_GROUP(gpio4),
-	BCM6318_GROUP(gpio5),
-	BCM6318_GROUP(gpio6),
-	BCM6318_GROUP(gpio7),
-	BCM6318_GROUP(gpio8),
-	BCM6318_GROUP(gpio9),
-	BCM6318_GROUP(gpio10),
-	BCM6318_GROUP(gpio11),
-	BCM6318_GROUP(gpio12),
-	BCM6318_GROUP(gpio13),
-	BCM6318_GROUP(gpio14),
-	BCM6318_GROUP(gpio15),
-	BCM6318_GROUP(gpio16),
-	BCM6318_GROUP(gpio17),
-	BCM6318_GROUP(gpio18),
-	BCM6318_GROUP(gpio19),
-	BCM6318_GROUP(gpio20),
-	BCM6318_GROUP(gpio21),
-	BCM6318_GROUP(gpio22),
-	BCM6318_GROUP(gpio23),
-	BCM6318_GROUP(gpio24),
-	BCM6318_GROUP(gpio25),
-	BCM6318_GROUP(gpio26),
-	BCM6318_GROUP(gpio27),
-	BCM6318_GROUP(gpio28),
-	BCM6318_GROUP(gpio29),
-	BCM6318_GROUP(gpio30),
-	BCM6318_GROUP(gpio31),
-	BCM6318_GROUP(gpio32),
-	BCM6318_GROUP(gpio33),
-	BCM6318_GROUP(gpio34),
-	BCM6318_GROUP(gpio35),
-	BCM6318_GROUP(gpio36),
-	BCM6318_GROUP(gpio37),
-	BCM6318_GROUP(gpio38),
-	BCM6318_GROUP(gpio39),
-	BCM6318_GROUP(gpio40),
-	BCM6318_GROUP(gpio41),
-	BCM6318_GROUP(gpio42),
-	BCM6318_GROUP(gpio43),
-	BCM6318_GROUP(gpio44),
-	BCM6318_GROUP(gpio45),
-	BCM6318_GROUP(gpio46),
-	BCM6318_GROUP(gpio47),
-	BCM6318_GROUP(gpio48),
-	BCM6318_GROUP(gpio49),
+static struct pingroup bcm6318_groups[] = {
+	BCM_PIN_GROUP(gpio0),
+	BCM_PIN_GROUP(gpio1),
+	BCM_PIN_GROUP(gpio2),
+	BCM_PIN_GROUP(gpio3),
+	BCM_PIN_GROUP(gpio4),
+	BCM_PIN_GROUP(gpio5),
+	BCM_PIN_GROUP(gpio6),
+	BCM_PIN_GROUP(gpio7),
+	BCM_PIN_GROUP(gpio8),
+	BCM_PIN_GROUP(gpio9),
+	BCM_PIN_GROUP(gpio10),
+	BCM_PIN_GROUP(gpio11),
+	BCM_PIN_GROUP(gpio12),
+	BCM_PIN_GROUP(gpio13),
+	BCM_PIN_GROUP(gpio14),
+	BCM_PIN_GROUP(gpio15),
+	BCM_PIN_GROUP(gpio16),
+	BCM_PIN_GROUP(gpio17),
+	BCM_PIN_GROUP(gpio18),
+	BCM_PIN_GROUP(gpio19),
+	BCM_PIN_GROUP(gpio20),
+	BCM_PIN_GROUP(gpio21),
+	BCM_PIN_GROUP(gpio22),
+	BCM_PIN_GROUP(gpio23),
+	BCM_PIN_GROUP(gpio24),
+	BCM_PIN_GROUP(gpio25),
+	BCM_PIN_GROUP(gpio26),
+	BCM_PIN_GROUP(gpio27),
+	BCM_PIN_GROUP(gpio28),
+	BCM_PIN_GROUP(gpio29),
+	BCM_PIN_GROUP(gpio30),
+	BCM_PIN_GROUP(gpio31),
+	BCM_PIN_GROUP(gpio32),
+	BCM_PIN_GROUP(gpio33),
+	BCM_PIN_GROUP(gpio34),
+	BCM_PIN_GROUP(gpio35),
+	BCM_PIN_GROUP(gpio36),
+	BCM_PIN_GROUP(gpio37),
+	BCM_PIN_GROUP(gpio38),
+	BCM_PIN_GROUP(gpio39),
+	BCM_PIN_GROUP(gpio40),
+	BCM_PIN_GROUP(gpio41),
+	BCM_PIN_GROUP(gpio42),
+	BCM_PIN_GROUP(gpio43),
+	BCM_PIN_GROUP(gpio44),
+	BCM_PIN_GROUP(gpio45),
+	BCM_PIN_GROUP(gpio46),
+	BCM_PIN_GROUP(gpio47),
+	BCM_PIN_GROUP(gpio48),
+	BCM_PIN_GROUP(gpio49),
 };
 
 /* GPIO_MODE */
@@ -368,10 +355,10 @@ static const char *bcm6318_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 
 static int bcm6318_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					  unsigned group, const unsigned **pins,
-					  unsigned *num_pins)
+					  unsigned *npins)
 {
 	*pins = bcm6318_groups[group].pins;
-	*num_pins = bcm6318_groups[group].num_pins;
+	*npins = bcm6318_groups[group].npins;
 
 	return 0;
 }
@@ -424,7 +411,7 @@ static int bcm6318_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				   unsigned selector, unsigned group)
 {
 	struct bcm63xx_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
-	const struct bcm6318_pingroup *pg = &bcm6318_groups[group];
+	const struct pingroup *pg = &bcm6318_groups[group];
 	const struct bcm6318_function *f = &bcm6318_funcs[selector];
 
 	bcm6318_rmw_mux(pc, pg->pins[0], f->mode_val, f->mux_val);
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63268.c b/drivers/pinctrl/bcm/pinctrl-bcm63268.c
index 1c1060a39597..80c2fc55ffa2 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm63268.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm63268.c
@@ -40,12 +40,6 @@ enum bcm63268_pinctrl_reg {
 	BCM63268_BASEMODE,
 };
 
-struct bcm63268_pingroup {
-	const char *name;
-	const unsigned * const pins;
-	const unsigned num_pins;
-};
-
 struct bcm63268_function {
 	const char *name;
 	const char * const *groups;
@@ -185,74 +179,67 @@ static unsigned vdsl_phy1_grp_pins[] = { 12, 13 };
 static unsigned vdsl_phy2_grp_pins[] = { 24, 25 };
 static unsigned vdsl_phy3_grp_pins[] = { 26, 27 };
 
-#define BCM63268_GROUP(n)					\
-	{							\
-		.name = #n,					\
-		.pins = n##_pins,				\
-		.num_pins = ARRAY_SIZE(n##_pins),		\
-	}
-
-static struct bcm63268_pingroup bcm63268_groups[] = {
-	BCM63268_GROUP(gpio0),
-	BCM63268_GROUP(gpio1),
-	BCM63268_GROUP(gpio2),
-	BCM63268_GROUP(gpio3),
-	BCM63268_GROUP(gpio4),
-	BCM63268_GROUP(gpio5),
-	BCM63268_GROUP(gpio6),
-	BCM63268_GROUP(gpio7),
-	BCM63268_GROUP(gpio8),
-	BCM63268_GROUP(gpio9),
-	BCM63268_GROUP(gpio10),
-	BCM63268_GROUP(gpio11),
-	BCM63268_GROUP(gpio12),
-	BCM63268_GROUP(gpio13),
-	BCM63268_GROUP(gpio14),
-	BCM63268_GROUP(gpio15),
-	BCM63268_GROUP(gpio16),
-	BCM63268_GROUP(gpio17),
-	BCM63268_GROUP(gpio18),
-	BCM63268_GROUP(gpio19),
-	BCM63268_GROUP(gpio20),
-	BCM63268_GROUP(gpio21),
-	BCM63268_GROUP(gpio22),
-	BCM63268_GROUP(gpio23),
-	BCM63268_GROUP(gpio24),
-	BCM63268_GROUP(gpio25),
-	BCM63268_GROUP(gpio26),
-	BCM63268_GROUP(gpio27),
-	BCM63268_GROUP(gpio28),
-	BCM63268_GROUP(gpio29),
-	BCM63268_GROUP(gpio30),
-	BCM63268_GROUP(gpio31),
-	BCM63268_GROUP(gpio32),
-	BCM63268_GROUP(gpio33),
-	BCM63268_GROUP(gpio34),
-	BCM63268_GROUP(gpio35),
-	BCM63268_GROUP(gpio36),
-	BCM63268_GROUP(gpio37),
-	BCM63268_GROUP(gpio38),
-	BCM63268_GROUP(gpio39),
-	BCM63268_GROUP(gpio40),
-	BCM63268_GROUP(gpio41),
-	BCM63268_GROUP(gpio42),
-	BCM63268_GROUP(gpio43),
-	BCM63268_GROUP(gpio44),
-	BCM63268_GROUP(gpio45),
-	BCM63268_GROUP(gpio46),
-	BCM63268_GROUP(gpio47),
-	BCM63268_GROUP(gpio48),
-	BCM63268_GROUP(gpio49),
-	BCM63268_GROUP(gpio50),
-	BCM63268_GROUP(gpio51),
+static struct pingroup bcm63268_groups[] = {
+	BCM_PIN_GROUP(gpio0),
+	BCM_PIN_GROUP(gpio1),
+	BCM_PIN_GROUP(gpio2),
+	BCM_PIN_GROUP(gpio3),
+	BCM_PIN_GROUP(gpio4),
+	BCM_PIN_GROUP(gpio5),
+	BCM_PIN_GROUP(gpio6),
+	BCM_PIN_GROUP(gpio7),
+	BCM_PIN_GROUP(gpio8),
+	BCM_PIN_GROUP(gpio9),
+	BCM_PIN_GROUP(gpio10),
+	BCM_PIN_GROUP(gpio11),
+	BCM_PIN_GROUP(gpio12),
+	BCM_PIN_GROUP(gpio13),
+	BCM_PIN_GROUP(gpio14),
+	BCM_PIN_GROUP(gpio15),
+	BCM_PIN_GROUP(gpio16),
+	BCM_PIN_GROUP(gpio17),
+	BCM_PIN_GROUP(gpio18),
+	BCM_PIN_GROUP(gpio19),
+	BCM_PIN_GROUP(gpio20),
+	BCM_PIN_GROUP(gpio21),
+	BCM_PIN_GROUP(gpio22),
+	BCM_PIN_GROUP(gpio23),
+	BCM_PIN_GROUP(gpio24),
+	BCM_PIN_GROUP(gpio25),
+	BCM_PIN_GROUP(gpio26),
+	BCM_PIN_GROUP(gpio27),
+	BCM_PIN_GROUP(gpio28),
+	BCM_PIN_GROUP(gpio29),
+	BCM_PIN_GROUP(gpio30),
+	BCM_PIN_GROUP(gpio31),
+	BCM_PIN_GROUP(gpio32),
+	BCM_PIN_GROUP(gpio33),
+	BCM_PIN_GROUP(gpio34),
+	BCM_PIN_GROUP(gpio35),
+	BCM_PIN_GROUP(gpio36),
+	BCM_PIN_GROUP(gpio37),
+	BCM_PIN_GROUP(gpio38),
+	BCM_PIN_GROUP(gpio39),
+	BCM_PIN_GROUP(gpio40),
+	BCM_PIN_GROUP(gpio41),
+	BCM_PIN_GROUP(gpio42),
+	BCM_PIN_GROUP(gpio43),
+	BCM_PIN_GROUP(gpio44),
+	BCM_PIN_GROUP(gpio45),
+	BCM_PIN_GROUP(gpio46),
+	BCM_PIN_GROUP(gpio47),
+	BCM_PIN_GROUP(gpio48),
+	BCM_PIN_GROUP(gpio49),
+	BCM_PIN_GROUP(gpio50),
+	BCM_PIN_GROUP(gpio51),
 
 	/* multi pin groups */
-	BCM63268_GROUP(nand_grp),
-	BCM63268_GROUP(dectpd_grp),
-	BCM63268_GROUP(vdsl_phy0_grp),
-	BCM63268_GROUP(vdsl_phy1_grp),
-	BCM63268_GROUP(vdsl_phy2_grp),
-	BCM63268_GROUP(vdsl_phy3_grp),
+	BCM_PIN_GROUP(nand_grp),
+	BCM_PIN_GROUP(dectpd_grp),
+	BCM_PIN_GROUP(vdsl_phy0_grp),
+	BCM_PIN_GROUP(vdsl_phy1_grp),
+	BCM_PIN_GROUP(vdsl_phy2_grp),
+	BCM_PIN_GROUP(vdsl_phy3_grp),
 };
 
 static const char * const led_groups[] = {
@@ -487,10 +474,10 @@ static const char *bcm63268_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 static int bcm63268_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					   unsigned group,
 					   const unsigned **pins,
-					   unsigned *num_pins)
+					   unsigned *npins)
 {
 	*pins = bcm63268_groups[group].pins;
-	*num_pins = bcm63268_groups[group].num_pins;
+	*npins = bcm63268_groups[group].npins;
 
 	return 0;
 }
@@ -545,13 +532,13 @@ static int bcm63268_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				    unsigned selector, unsigned group)
 {
 	struct bcm63xx_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
-	const struct bcm63268_pingroup *pg = &bcm63268_groups[group];
+	const struct pingroup *pg = &bcm63268_groups[group];
 	const struct bcm63268_function *f = &bcm63268_funcs[selector];
 	unsigned i;
 	unsigned int reg;
 	unsigned int val, mask;
 
-	for (i = 0; i < pg->num_pins; i++)
+	for (i = 0; i < pg->npins; i++)
 		bcm63268_set_gpio(pc, pg->pins[i]);
 
 	switch (f->reg) {
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6328.c b/drivers/pinctrl/bcm/pinctrl-bcm6328.c
index ffa8864abab6..1eef5ab9a5e5 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6328.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6328.c
@@ -125,49 +125,42 @@ static unsigned gpio31_pins[] = { 31 };
 static unsigned hsspi_cs1_pins[] = { 36 };
 static unsigned usb_port1_pins[] = { 38 };
 
-#define BCM6328_GROUP(n)					\
-	{							\
-		.name = #n,					\
-		.pins = n##_pins,				\
-		.num_pins = ARRAY_SIZE(n##_pins),		\
-	}
-
-static struct bcm6328_pingroup bcm6328_groups[] = {
-	BCM6328_GROUP(gpio0),
-	BCM6328_GROUP(gpio1),
-	BCM6328_GROUP(gpio2),
-	BCM6328_GROUP(gpio3),
-	BCM6328_GROUP(gpio4),
-	BCM6328_GROUP(gpio5),
-	BCM6328_GROUP(gpio6),
-	BCM6328_GROUP(gpio7),
-	BCM6328_GROUP(gpio8),
-	BCM6328_GROUP(gpio9),
-	BCM6328_GROUP(gpio10),
-	BCM6328_GROUP(gpio11),
-	BCM6328_GROUP(gpio12),
-	BCM6328_GROUP(gpio13),
-	BCM6328_GROUP(gpio14),
-	BCM6328_GROUP(gpio15),
-	BCM6328_GROUP(gpio16),
-	BCM6328_GROUP(gpio17),
-	BCM6328_GROUP(gpio18),
-	BCM6328_GROUP(gpio19),
-	BCM6328_GROUP(gpio20),
-	BCM6328_GROUP(gpio21),
-	BCM6328_GROUP(gpio22),
-	BCM6328_GROUP(gpio23),
-	BCM6328_GROUP(gpio24),
-	BCM6328_GROUP(gpio25),
-	BCM6328_GROUP(gpio26),
-	BCM6328_GROUP(gpio27),
-	BCM6328_GROUP(gpio28),
-	BCM6328_GROUP(gpio29),
-	BCM6328_GROUP(gpio30),
-	BCM6328_GROUP(gpio31),
-
-	BCM6328_GROUP(hsspi_cs1),
-	BCM6328_GROUP(usb_port1),
+static struct pingroup bcm6328_groups[] = {
+	BCM_PIN_GROUP(gpio0),
+	BCM_PIN_GROUP(gpio1),
+	BCM_PIN_GROUP(gpio2),
+	BCM_PIN_GROUP(gpio3),
+	BCM_PIN_GROUP(gpio4),
+	BCM_PIN_GROUP(gpio5),
+	BCM_PIN_GROUP(gpio6),
+	BCM_PIN_GROUP(gpio7),
+	BCM_PIN_GROUP(gpio8),
+	BCM_PIN_GROUP(gpio9),
+	BCM_PIN_GROUP(gpio10),
+	BCM_PIN_GROUP(gpio11),
+	BCM_PIN_GROUP(gpio12),
+	BCM_PIN_GROUP(gpio13),
+	BCM_PIN_GROUP(gpio14),
+	BCM_PIN_GROUP(gpio15),
+	BCM_PIN_GROUP(gpio16),
+	BCM_PIN_GROUP(gpio17),
+	BCM_PIN_GROUP(gpio18),
+	BCM_PIN_GROUP(gpio19),
+	BCM_PIN_GROUP(gpio20),
+	BCM_PIN_GROUP(gpio21),
+	BCM_PIN_GROUP(gpio22),
+	BCM_PIN_GROUP(gpio23),
+	BCM_PIN_GROUP(gpio24),
+	BCM_PIN_GROUP(gpio25),
+	BCM_PIN_GROUP(gpio26),
+	BCM_PIN_GROUP(gpio27),
+	BCM_PIN_GROUP(gpio28),
+	BCM_PIN_GROUP(gpio29),
+	BCM_PIN_GROUP(gpio30),
+	BCM_PIN_GROUP(gpio31),
+
+	BCM_PIN_GROUP(hsspi_cs1),
+	BCM_PIN_GROUP(usb_port1),
 };
 
 /* GPIO_MODE */
@@ -292,10 +285,10 @@ static const char *bcm6328_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 
 static int bcm6328_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					  unsigned group, const unsigned **pins,
-					  unsigned *num_pins)
+					  unsigned *npins)
 {
 	*pins = bcm6328_groups[group].pins;
-	*num_pins = bcm6328_groups[group].num_pins;
+	*npins = bcm6328_groups[group].npins;
 
 	return 0;
 }
@@ -338,7 +331,7 @@ static int bcm6328_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				   unsigned selector, unsigned group)
 {
 	struct bcm63xx_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
-	const struct bcm6328_pingroup *pg = &bcm6328_groups[group];
+	const struct pingroup *pg = &bcm6328_groups[group];
 	const struct bcm6328_function *f = &bcm6328_funcs[selector];
 
 	bcm6328_rmw_mux(pc, pg->pins[0], f->mode_val, f->mux_val);
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6358.c b/drivers/pinctrl/bcm/pinctrl-bcm6358.c
index 9f6cd7447887..891de49d76e7 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6358.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6358.c
@@ -35,9 +35,7 @@
 #define  BCM6358_MODE_MUX_SYS_IRQ	BIT(15)
 
 struct bcm6358_pingroup {
-	const char *name;
-	const unsigned * const pins;
-	const unsigned num_pins;
+	struct pingroup grp;
 
 	const uint16_t mode_val;
 
@@ -131,9 +129,7 @@ static unsigned sys_irq_grp_pins[] = { 5 };
 
 #define BCM6358_GPIO_MUX_GROUP(n, bit, dir)			\
 	{							\
-		.name = #n,					\
-		.pins = n##_pins,				\
-		.num_pins = ARRAY_SIZE(n##_pins),		\
+		.grp = BCM_PIN_GROUP(n),			\
 		.mode_val = BCM6358_MODE_MUX_##bit,		\
 		.direction = dir,				\
 	}
@@ -219,15 +215,15 @@ static int bcm6358_pinctrl_get_group_count(struct pinctrl_dev *pctldev)
 static const char *bcm6358_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 						  unsigned group)
 {
-	return bcm6358_groups[group].name;
+	return bcm6358_groups[group].grp.name;
 }
 
 static int bcm6358_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					  unsigned group, const unsigned **pins,
-					  unsigned *num_pins)
+					  unsigned *npins)
 {
-	*pins = bcm6358_groups[group].pins;
-	*num_pins = bcm6358_groups[group].num_pins;
+	*pins = bcm6358_groups[group].grp.pins;
+	*npins = bcm6358_groups[group].grp.npins;
 
 	return 0;
 }
@@ -264,12 +260,12 @@ static int bcm6358_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	unsigned int mask = val;
 	unsigned pin;
 
-	for (pin = 0; pin < pg->num_pins; pin++)
+	for (pin = 0; pin < pg->grp.npins; pin++)
 		mask |= (unsigned long)bcm6358_pins[pin].drv_data;
 
 	regmap_field_update_bits(priv->overlays, mask, val);
 
-	for (pin = 0; pin < pg->num_pins; pin++) {
+	for (pin = 0; pin < pg->grp.npins; pin++) {
 		struct pinctrl_gpio_range *range;
 		unsigned int hw_gpio = bcm6358_pins[pin].number;
 
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6362.c b/drivers/pinctrl/bcm/pinctrl-bcm6362.c
index 13c7230949b2..d9ba1b6c2aeb 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6362.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6362.c
@@ -35,12 +35,6 @@ enum bcm6362_pinctrl_reg {
 	BCM6362_BASEMODE,
 };
 
-struct bcm6362_pingroup {
-	const char *name;
-	const unsigned * const pins;
-	const unsigned num_pins;
-};
-
 struct bcm6362_function {
 	const char *name;
 	const char * const *groups;
@@ -162,63 +156,56 @@ static unsigned nand_grp_pins[] = {
 	18, 19, 20, 21, 22, 23, 27,
 };
 
-#define BCM6362_GROUP(n)				\
-	{						\
-		.name = #n,				\
-		.pins = n##_pins,			\
-		.num_pins = ARRAY_SIZE(n##_pins),	\
-	}
-
-static struct bcm6362_pingroup bcm6362_groups[] = {
-	BCM6362_GROUP(gpio0),
-	BCM6362_GROUP(gpio1),
-	BCM6362_GROUP(gpio2),
-	BCM6362_GROUP(gpio3),
-	BCM6362_GROUP(gpio4),
-	BCM6362_GROUP(gpio5),
-	BCM6362_GROUP(gpio6),
-	BCM6362_GROUP(gpio7),
-	BCM6362_GROUP(gpio8),
-	BCM6362_GROUP(gpio9),
-	BCM6362_GROUP(gpio10),
-	BCM6362_GROUP(gpio11),
-	BCM6362_GROUP(gpio12),
-	BCM6362_GROUP(gpio13),
-	BCM6362_GROUP(gpio14),
-	BCM6362_GROUP(gpio15),
-	BCM6362_GROUP(gpio16),
-	BCM6362_GROUP(gpio17),
-	BCM6362_GROUP(gpio18),
-	BCM6362_GROUP(gpio19),
-	BCM6362_GROUP(gpio20),
-	BCM6362_GROUP(gpio21),
-	BCM6362_GROUP(gpio22),
-	BCM6362_GROUP(gpio23),
-	BCM6362_GROUP(gpio24),
-	BCM6362_GROUP(gpio25),
-	BCM6362_GROUP(gpio26),
-	BCM6362_GROUP(gpio27),
-	BCM6362_GROUP(gpio28),
-	BCM6362_GROUP(gpio29),
-	BCM6362_GROUP(gpio30),
-	BCM6362_GROUP(gpio31),
-	BCM6362_GROUP(gpio32),
-	BCM6362_GROUP(gpio33),
-	BCM6362_GROUP(gpio34),
-	BCM6362_GROUP(gpio35),
-	BCM6362_GROUP(gpio36),
-	BCM6362_GROUP(gpio37),
-	BCM6362_GROUP(gpio38),
-	BCM6362_GROUP(gpio39),
-	BCM6362_GROUP(gpio40),
-	BCM6362_GROUP(gpio41),
-	BCM6362_GROUP(gpio42),
-	BCM6362_GROUP(gpio43),
-	BCM6362_GROUP(gpio44),
-	BCM6362_GROUP(gpio45),
-	BCM6362_GROUP(gpio46),
-	BCM6362_GROUP(gpio47),
-	BCM6362_GROUP(nand_grp),
+static struct pingroup bcm6362_groups[] = {
+	BCM_PIN_GROUP(gpio0),
+	BCM_PIN_GROUP(gpio1),
+	BCM_PIN_GROUP(gpio2),
+	BCM_PIN_GROUP(gpio3),
+	BCM_PIN_GROUP(gpio4),
+	BCM_PIN_GROUP(gpio5),
+	BCM_PIN_GROUP(gpio6),
+	BCM_PIN_GROUP(gpio7),
+	BCM_PIN_GROUP(gpio8),
+	BCM_PIN_GROUP(gpio9),
+	BCM_PIN_GROUP(gpio10),
+	BCM_PIN_GROUP(gpio11),
+	BCM_PIN_GROUP(gpio12),
+	BCM_PIN_GROUP(gpio13),
+	BCM_PIN_GROUP(gpio14),
+	BCM_PIN_GROUP(gpio15),
+	BCM_PIN_GROUP(gpio16),
+	BCM_PIN_GROUP(gpio17),
+	BCM_PIN_GROUP(gpio18),
+	BCM_PIN_GROUP(gpio19),
+	BCM_PIN_GROUP(gpio20),
+	BCM_PIN_GROUP(gpio21),
+	BCM_PIN_GROUP(gpio22),
+	BCM_PIN_GROUP(gpio23),
+	BCM_PIN_GROUP(gpio24),
+	BCM_PIN_GROUP(gpio25),
+	BCM_PIN_GROUP(gpio26),
+	BCM_PIN_GROUP(gpio27),
+	BCM_PIN_GROUP(gpio28),
+	BCM_PIN_GROUP(gpio29),
+	BCM_PIN_GROUP(gpio30),
+	BCM_PIN_GROUP(gpio31),
+	BCM_PIN_GROUP(gpio32),
+	BCM_PIN_GROUP(gpio33),
+	BCM_PIN_GROUP(gpio34),
+	BCM_PIN_GROUP(gpio35),
+	BCM_PIN_GROUP(gpio36),
+	BCM_PIN_GROUP(gpio37),
+	BCM_PIN_GROUP(gpio38),
+	BCM_PIN_GROUP(gpio39),
+	BCM_PIN_GROUP(gpio40),
+	BCM_PIN_GROUP(gpio41),
+	BCM_PIN_GROUP(gpio42),
+	BCM_PIN_GROUP(gpio43),
+	BCM_PIN_GROUP(gpio44),
+	BCM_PIN_GROUP(gpio45),
+	BCM_PIN_GROUP(gpio46),
+	BCM_PIN_GROUP(gpio47),
+	BCM_PIN_GROUP(nand_grp),
 };
 
 static const char * const led_groups[] = {
@@ -463,10 +450,10 @@ static const char *bcm6362_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 
 static int bcm6362_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					  unsigned group, const unsigned **pins,
-					  unsigned *num_pins)
+					  unsigned *npins)
 {
 	*pins = bcm6362_groups[group].pins;
-	*num_pins = bcm6362_groups[group].num_pins;
+	*npins = bcm6362_groups[group].npins;
 
 	return 0;
 }
@@ -519,13 +506,13 @@ static int bcm6362_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				   unsigned selector, unsigned group)
 {
 	struct bcm63xx_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
-	const struct bcm6362_pingroup *pg = &bcm6362_groups[group];
+	const struct pingroup *pg = &bcm6362_groups[group];
 	const struct bcm6362_function *f = &bcm6362_funcs[selector];
 	unsigned i;
 	unsigned int reg;
 	unsigned int val, mask;
 
-	for (i = 0; i < pg->num_pins; i++)
+	for (i = 0; i < pg->npins; i++)
 		bcm6362_set_gpio(pc, pg->pins[i]);
 
 	switch (f->reg) {
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6368.c b/drivers/pinctrl/bcm/pinctrl-bcm6368.c
index b33a74aec82b..6208467ba6f9 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6368.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6368.c
@@ -26,12 +26,6 @@
 #define  BCM6368_BASEMODE_GPIO	0x0
 #define  BCM6368_BASEMODE_UART1	0x1
 
-struct bcm6368_pingroup {
-	const char *name;
-	const unsigned * const pins;
-	const unsigned num_pins;
-};
-
 struct bcm6368_function {
 	const char *name;
 	const char * const *groups;
@@ -127,47 +121,40 @@ static unsigned gpio30_pins[] = { 30 };
 static unsigned gpio31_pins[] = { 31 };
 static unsigned uart1_grp_pins[] = { 30, 31, 32, 33 };
 
-#define BCM6368_GROUP(n)				\
-	{						\
-		.name = #n,				\
-		.pins = n##_pins,			\
-		.num_pins = ARRAY_SIZE(n##_pins),	\
-	}
-
-static struct bcm6368_pingroup bcm6368_groups[] = {
-	BCM6368_GROUP(gpio0),
-	BCM6368_GROUP(gpio1),
-	BCM6368_GROUP(gpio2),
-	BCM6368_GROUP(gpio3),
-	BCM6368_GROUP(gpio4),
-	BCM6368_GROUP(gpio5),
-	BCM6368_GROUP(gpio6),
-	BCM6368_GROUP(gpio7),
-	BCM6368_GROUP(gpio8),
-	BCM6368_GROUP(gpio9),
-	BCM6368_GROUP(gpio10),
-	BCM6368_GROUP(gpio11),
-	BCM6368_GROUP(gpio12),
-	BCM6368_GROUP(gpio13),
-	BCM6368_GROUP(gpio14),
-	BCM6368_GROUP(gpio15),
-	BCM6368_GROUP(gpio16),
-	BCM6368_GROUP(gpio17),
-	BCM6368_GROUP(gpio18),
-	BCM6368_GROUP(gpio19),
-	BCM6368_GROUP(gpio20),
-	BCM6368_GROUP(gpio21),
-	BCM6368_GROUP(gpio22),
-	BCM6368_GROUP(gpio23),
-	BCM6368_GROUP(gpio24),
-	BCM6368_GROUP(gpio25),
-	BCM6368_GROUP(gpio26),
-	BCM6368_GROUP(gpio27),
-	BCM6368_GROUP(gpio28),
-	BCM6368_GROUP(gpio29),
-	BCM6368_GROUP(gpio30),
-	BCM6368_GROUP(gpio31),
-	BCM6368_GROUP(uart1_grp),
+static struct pingroup bcm6368_groups[] = {
+	BCM_PIN_GROUP(gpio0),
+	BCM_PIN_GROUP(gpio1),
+	BCM_PIN_GROUP(gpio2),
+	BCM_PIN_GROUP(gpio3),
+	BCM_PIN_GROUP(gpio4),
+	BCM_PIN_GROUP(gpio5),
+	BCM_PIN_GROUP(gpio6),
+	BCM_PIN_GROUP(gpio7),
+	BCM_PIN_GROUP(gpio8),
+	BCM_PIN_GROUP(gpio9),
+	BCM_PIN_GROUP(gpio10),
+	BCM_PIN_GROUP(gpio11),
+	BCM_PIN_GROUP(gpio12),
+	BCM_PIN_GROUP(gpio13),
+	BCM_PIN_GROUP(gpio14),
+	BCM_PIN_GROUP(gpio15),
+	BCM_PIN_GROUP(gpio16),
+	BCM_PIN_GROUP(gpio17),
+	BCM_PIN_GROUP(gpio18),
+	BCM_PIN_GROUP(gpio19),
+	BCM_PIN_GROUP(gpio20),
+	BCM_PIN_GROUP(gpio21),
+	BCM_PIN_GROUP(gpio22),
+	BCM_PIN_GROUP(gpio23),
+	BCM_PIN_GROUP(gpio24),
+	BCM_PIN_GROUP(gpio25),
+	BCM_PIN_GROUP(gpio26),
+	BCM_PIN_GROUP(gpio27),
+	BCM_PIN_GROUP(gpio28),
+	BCM_PIN_GROUP(gpio29),
+	BCM_PIN_GROUP(gpio30),
+	BCM_PIN_GROUP(gpio31),
+	BCM_PIN_GROUP(uart1_grp),
 };
 
 static const char * const analog_afe_0_groups[] = {
@@ -358,10 +345,10 @@ static const char *bcm6368_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 
 static int bcm6368_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					  unsigned group, const unsigned **pins,
-					  unsigned *num_pins)
+					  unsigned *npins)
 {
 	*pins = bcm6368_groups[group].pins;
-	*num_pins = bcm6368_groups[group].num_pins;
+	*npins = bcm6368_groups[group].npins;
 
 	return 0;
 }
@@ -393,14 +380,14 @@ static int bcm6368_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct bcm63xx_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
 	struct bcm6368_priv *priv = pc->driver_data;
-	const struct bcm6368_pingroup *pg = &bcm6368_groups[group];
+	const struct pingroup *pg = &bcm6368_groups[group];
 	const struct bcm6368_function *fun = &bcm6368_funcs[selector];
 	int i, pin;
 
 	if (fun->basemode) {
 		unsigned int mask = 0;
 
-		for (i = 0; i < pg->num_pins; i++) {
+		for (i = 0; i < pg->npins; i++) {
 			pin = pg->pins[i];
 			if (pin < BCM63XX_BANK_GPIOS)
 				mask |= BIT(pin);
@@ -419,7 +406,7 @@ static int bcm6368_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				   BIT(pin));
 	}
 
-	for (pin = 0; pin < pg->num_pins; pin++) {
+	for (pin = 0; pin < pg->npins; pin++) {
 		struct pinctrl_gpio_range *range;
 		int hw_gpio = bcm6368_pins[pin].number;
 
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63xx.h b/drivers/pinctrl/bcm/pinctrl-bcm63xx.h
index d58c8cd5b6b8..95243027ecd9 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm63xx.h
+++ b/drivers/pinctrl/bcm/pinctrl-bcm63xx.h
@@ -21,6 +21,8 @@ struct bcm63xx_pinctrl_soc {
 	unsigned int ngpios;
 };
 
+#define BCM_PIN_GROUP(n)	PINCTRL_PINGROUP(#n, n##_pins, ARRAY_SIZE(n##_pins))
+
 struct bcm63xx_pinctrl {
 	struct device *dev;
 	struct regmap *regs;
-- 
2.35.1

