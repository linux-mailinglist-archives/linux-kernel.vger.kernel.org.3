Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79F449E13C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiA0LgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:36:04 -0500
Received: from mx.socionext.com ([202.248.49.38]:9862 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240566AbiA0LgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:36:03 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jan 2022 20:36:02 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 46FD82006F56;
        Thu, 27 Jan 2022 20:36:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Jan 2022 20:36:02 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E76D8C1E22;
        Thu, 27 Jan 2022 20:36:01 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
Subject: [PATCH 2/3] pinctrl: uniphier: Divide pinmux group to support 1ch and 2ch I2S
Date:   Thu, 27 Jan 2022 20:35:43 +0900
Message-Id: <1643283344-24911-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pinmux group for audio in/out assumes 4ch I2S case but the
UniPhier AIO hardware also supports 1ch and 2ch I2S. So divide current
ain1 group into ain1, ain1_dat2 and ain1_dat4 groups. Divide other
ain and aout in the same way.

Signed-off-by: Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 26 +++++++---
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 64 ++++++++++++++++++------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 55 +++++++++++++++-----
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 52 ++++++++++++++-----
 4 files changed, 153 insertions(+), 44 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index a4fa8e3af607..65ed20bc1fa2 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -461,10 +461,18 @@ static const struct pinctrl_pin_desc uniphier_ld11_pins[] = {
 			     166, UNIPHIER_PIN_PULL_DOWN),
 };
 
-static const unsigned ain1_pins[] = {151, 152, 153, 154, 155, 156, 157};
-static const int ain1_muxvals[] = {4, 4, 4, 4, 4, 4, 4};
-static const unsigned aout1_pins[] = {137, 138, 139, 140, 141, 142};
-static const int aout1_muxvals[] = {0, 0, 0, 0, 0, 0};
+static const unsigned ain1_pins[] = {151, 152, 153, 154};
+static const int ain1_muxvals[] = {4, 4, 4, 4};
+static const unsigned ain1_dat2_pins[] = {155};
+static const int ain1_dat2_muxvals[] = {4};
+static const unsigned ain1_dat4_pins[] = {156, 157};
+static const int ain1_dat4_muxvals[] = {4, 4};
+static const unsigned aout1_pins[] = {137, 138, 139, 140};
+static const int aout1_muxvals[] = {0, 0, 0, 0};
+static const unsigned aout1_dat2_pins[] = {141};
+static const int aout1_dat2_muxvals[] = {0};
+static const unsigned aout1_dat4_pins[] = {142, 143};
+static const int aout1_dat4_muxvals[] = {0, 3};
 static const unsigned ainiec1_pins[] = {150};
 static const int ainiec1_muxvals[] = {4};
 static const unsigned ainiec1b_pins[] = {141};
@@ -582,7 +590,11 @@ static const unsigned int gpio_range5_pins[] = {
 
 static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(ain1),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout1),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat4),
 	UNIPHIER_PINCTRL_GROUP(ainiec1),
 	UNIPHIER_PINCTRL_GROUP(ainiec1b),
 	UNIPHIER_PINCTRL_GROUP(aoutiec1),
@@ -626,8 +638,10 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range5),
 };
 
-static const char * const ain1_groups[] = {"ain1"};
-static const char * const aout1_groups[] = {"aout1"};
+static const char * const ain1_groups[] = {"ain1", "ain1_dat2",
+					   "ain1_dat4"};
+static const char * const aout1_groups[] = {"aout1", "aout1_dat2",
+					    "aout1_dat4"};
 static const char * const ainiec1_groups[] = {"ainiec1", "ainiec1b"};
 static const char * const aoutiec1_groups[] = {"aoutiec1"};
 static const char * const aoutiec2_groups[] = {"aoutiec2"};
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index 850736998206..a68b21fbd0c7 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -542,18 +542,38 @@ static const struct pinctrl_pin_desc uniphier_ld20_pins[] = {
 			     175, UNIPHIER_PIN_PULL_DOWN),
 };
 
-static const unsigned ain1_pins[] = {150, 151, 152, 153, 154, 155, 156};
-static const int ain1_muxvals[] = {4, 4, 4, 4, 4, 4, 4};
-static const unsigned ain2_pins[] = {116, 117, 118, 119, 120, 121, 122};
-static const int ain2_muxvals[] = {26, 26, 26, 26, 26, 26, 26};
+static const unsigned ain1_pins[] = {150, 151, 152, 153};
+static const int ain1_muxvals[] = {4, 4, 4, 4};
+static const unsigned ain1_dat2_pins[] = {154};
+static const int ain1_dat2_muxvals[] = {4};
+static const unsigned ain1_dat4_pins[] = {155, 156};
+static const int ain1_dat4_muxvals[] = {4, 4};
+static const unsigned ain2_pins[] = {116, 117, 118, 119};
+static const int ain2_muxvals[] = {26, 26, 26, 26};
+static const unsigned ain2_dat2_pins[] = {120};
+static const int ain2_dat2_muxvals[] = {26};
+static const unsigned ain2_dat4_pins[] = {121, 122};
+static const int ain2_dat4_muxvals[] = {26, 26};
 static const unsigned ain3_pins[] = {116, 117, 118, 119};
 static const int ain3_muxvals[] = {27, 27, 27, 27};
-static const unsigned aout1_pins[] = {137, 138, 139, 140, 141, 142};
-static const int aout1_muxvals[] = {0, 0, 0, 0, 0, 0};
-static const unsigned aout1b_pins[] = {150, 151, 152, 153, 154, 155, 156};
-static const int aout1b_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
-static const unsigned aout2_pins[] = {165, 157, 162, 158, 159, 160, 161};
-static const int aout2_muxvals[] = {2, 2, 2, 1, 1, 1, 1};
+static const unsigned aout1_pins[] = {137, 138, 139, 140};
+static const int aout1_muxvals[] = {0, 0, 0, 0};
+static const unsigned aout1_dat2_pins[] = {141};
+static const int aout1_dat2_muxvals[] = {0};
+static const unsigned aout1_dat4_pins[] = {142, 156};
+static const int aout1_dat4_muxvals[] = {0, 1};
+static const unsigned aout1b_pins[] = {150, 151, 152, 153};
+static const int aout1b_muxvals[] = {1, 1, 1, 1};
+static const unsigned aout1b_dat2_pins[] = {154};
+static const int aout1b_dat2_muxvals[] = {1};
+static const unsigned aout1b_dat4_pins[] = {155, 156};
+static const int aout1b_dat4_muxvals[] = {1, 1};
+static const unsigned aout2_pins[] = {165, 157, 162, 158};
+static const int aout2_muxvals[] = {2, 2, 2, 1};
+static const unsigned aout2_dat2_pins[] = {159};
+static const int aout2_dat2_muxvals[] = {1};
+static const unsigned aout2_dat4_pins[] = {160, 161};
+static const int aout2_dat4_muxvals[] = {1, 1};
 static const unsigned aout3_pins[] = {166, 167, 168, 163};
 static const int aout3_muxvals[] = {2, 2, 2, 1};
 static const unsigned aout4_pins[] = {169, 170, 171, 164};
@@ -682,11 +702,21 @@ static const unsigned int gpio_range2_pins[] = {
 
 static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(ain1),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat4),
 	UNIPHIER_PINCTRL_GROUP(ain2),
+	UNIPHIER_PINCTRL_GROUP(ain2_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain2_dat4),
 	UNIPHIER_PINCTRL_GROUP(ain3),
 	UNIPHIER_PINCTRL_GROUP(aout1),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout1b),
+	UNIPHIER_PINCTRL_GROUP(aout1b_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout1b_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout2),
+	UNIPHIER_PINCTRL_GROUP(aout2_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout2_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout3),
 	UNIPHIER_PINCTRL_GROUP(aout4),
 	UNIPHIER_PINCTRL_GROUP(aoutiec1),
@@ -734,11 +764,17 @@ static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range2),
 };
 
-static const char * const ain1_groups[] = {"ain1"};
-static const char * const ain2_groups[] = {"ain2"};
+static const char * const ain1_groups[] = {"ain1", "ain1_dat2",
+					   "ain1_dat4"};
+static const char * const ain2_groups[] = {"ain2", "ain2_dat2",
+					   "ain2_dat4"};
 static const char * const ain3_groups[] = {"ain3"};
-static const char * const aout1_groups[] = {"aout1", "aout1b"};
-static const char * const aout2_groups[] = {"aout2"};
+static const char * const aout1_groups[] = {"aout1", "aout1_dat2",
+					    "aout1_dat4",
+					    "aout1b", "aout1b_dat2",
+					    "aout1b_dat4"};
+static const char * const aout2_groups[] = {"aout2", "aout2_dat2",
+					    "aout2_dat4"};
 static const char * const aout3_groups[] = {"aout3"};
 static const char * const aout4_groups[] = {"aout4"};
 static const char * const aoutiec1_groups[] = {"aoutiec1"};
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 6ef892543cb9..efeca8fd7c9f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -719,18 +719,34 @@ static const struct pinctrl_pin_desc uniphier_pxs2_pins[] = {
 			     234, UNIPHIER_PIN_PULL_DOWN),
 };
 
-static const unsigned ain1_pins[] = {161, 162, 173, 174, 127, 128, 129};
-static const int ain1_muxvals[] = {8, 8, 8, 8, 3, 3, 3};
-static const unsigned ain2_pins[] = {98, 99, 100, 101, 102, 103, 104};
-static const int ain2_muxvals[] = {8, 8, 8, 8, 8, 8, 8};
+static const unsigned ain1_pins[] = {161, 162, 173, 174};
+static const int ain1_muxvals[] = {8, 8, 8, 8};
+static const unsigned ain1_dat2_pins[] = {127};
+static const int ain1_dat2_muxvals[] = {3};
+static const unsigned ain1_dat4_pins[] = {128, 129};
+static const int ain1_dat4_muxvals[] = {3, 3};
+static const unsigned ain2_pins[] = {98, 99, 100, 101};
+static const int ain2_muxvals[] = {8, 8, 8, 8};
+static const unsigned ain2_dat2_pins[] = {102};
+static const int ain2_dat2_muxvals[] = {8};
+static const unsigned ain2_dat4_pins[] = {103, 104};
+static const int ain2_dat4_muxvals[] = {8, 8};
 static const unsigned ain3_pins[] = {132, 133, 134, 131};
 static const int ain3_muxvals[] = {5, 5, 5, 5};
 static const unsigned ainiec1_pins[] = {91};
 static const int ainiec1_muxvals[] = {11};
-static const unsigned aout1_pins[] = {87, 88, 89, 90, 92, 93, 94};
-static const int aout1_muxvals[] = {11, 11, 11, 11, 11, 11, 11};
-static const unsigned aout2_pins[] = {175, 176, 177, 178, 183, 184, 185};
-static const int aout2_muxvals[] = {8, 8, 8, 8, 9, 9, 9};
+static const unsigned aout1_pins[] = {87, 88, 89, 90};
+static const int aout1_muxvals[] = {11, 11, 11, 11};
+static const unsigned aout1_dat2_pins[] = {92};
+static const int aout1_dat2_muxvals[] = {11};
+static const unsigned aout1_dat4_pins[] = {93, 94};
+static const int aout1_dat4_muxvals[] = {11, 11};
+static const unsigned aout2_pins[] = {177, 178, 175, 176};
+static const int aout2_muxvals[] = {8, 8, 8, 8};
+static const unsigned aout2_dat2_pins[] = {183};
+static const int aout2_dat2_muxvals[] = {9};
+static const unsigned aout2_dat4_pins[] = {184, 185};
+static const int aout2_dat4_muxvals[] = {9, 9};
 static const unsigned aout3_pins[] = {105, 106, 107, 108};
 static const int aout3_muxvals[] = {8, 8, 8, 8};
 static const unsigned aoutiec1_pins[] = {95};
@@ -842,11 +858,19 @@ static const unsigned int gpio_range1_pins[] = {
 
 static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(ain1),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat4),
 	UNIPHIER_PINCTRL_GROUP(ain2),
+	UNIPHIER_PINCTRL_GROUP(ain2_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain2_dat4),
 	UNIPHIER_PINCTRL_GROUP(ain3),
 	UNIPHIER_PINCTRL_GROUP(ainiec1),
 	UNIPHIER_PINCTRL_GROUP(aout1),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout2),
+	UNIPHIER_PINCTRL_GROUP(aout2_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout2_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout3),
 	UNIPHIER_PINCTRL_GROUP(aoutiec1),
 	UNIPHIER_PINCTRL_GROUP(aoutiec2),
@@ -884,12 +908,16 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range1),
 };
 
-static const char * const ain1_groups[] = {"ain1"};
-static const char * const ain2_groups[] = {"ain2"};
+static const char * const ain1_groups[] = {"ain1", "ain1_dat2",
+					   "ain1_dat4"};
+static const char * const ain2_groups[] = {"ain2", "ain2_dat2",
+					   "ain2_dat4"};
 static const char * const ain3_groups[] = {"ain3"};
 static const char * const ainiec1_groups[] = {"ainiec1"};
-static const char * const aout1_groups[] = {"aout1"};
-static const char * const aout2_groups[] = {"aout2"};
+static const char * const aout1_groups[] = {"aout1", "aout1_dat2",
+					    "aout1_dat4"};
+static const char * const aout2_groups[] = {"aout2", "aout2_dat2",
+					    "aout2_dat4"};
 static const char * const aout3_groups[] = {"aout3"};
 static const char * const aoutiec1_groups[] = {"aoutiec1"};
 static const char * const aoutiec2_groups[] = {"aoutiec2"};
@@ -922,9 +950,12 @@ static const char * const usb3_groups[] = {"usb3"};
 static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(ain1),
 	UNIPHIER_PINMUX_FUNCTION(ain2),
+	UNIPHIER_PINMUX_FUNCTION(ain3),
 	UNIPHIER_PINMUX_FUNCTION(ainiec1),
+	UNIPHIER_PINMUX_FUNCTION(aout1),
 	UNIPHIER_PINMUX_FUNCTION(aout2),
 	UNIPHIER_PINMUX_FUNCTION(aout3),
+	UNIPHIER_PINMUX_FUNCTION(aout4),
 	UNIPHIER_PINMUX_FUNCTION(aoutiec1),
 	UNIPHIER_PINMUX_FUNCTION(aoutiec2),
 	UNIPHIER_PINMUX_FUNCTION(emmc),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index 4810db6c0ee8..eb3c9b55f6e3 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -767,14 +767,30 @@ static const struct pinctrl_pin_desc uniphier_pxs3_pins[] = {
 			     250, UNIPHIER_PIN_PULL_DOWN),
 };
 
-static const unsigned ain1_pins[] = {186, 187, 188, 189, 237, 238, 239};
-static const int ain1_muxvals[] = {0, 0, 0, 0, 1, 1, 1};
-static const unsigned ain2_pins[] = {243, 244, 245, 246, 247, 248, 249};
-static const int ain2_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
-static const unsigned aout1_pins[] = {226, 227, 228, 229, 230, 231, 232};
-static const int aout1_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
-static const unsigned aout2_pins[] = {192, 193, 194, 195, 196, 197, 198};
-static const int aout2_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
+static const unsigned ain1_pins[] = {186, 187, 188, 189};
+static const int ain1_muxvals[] = {0, 0, 0, 0};
+static const unsigned ain1_dat2_pins[] = {237};
+static const int ain1_dat2_muxvals[] = {1};
+static const unsigned ain1_dat4_pins[] = {238, 239};
+static const int ain1_dat4_muxvals[] = {1, 1};
+static const unsigned ain2_pins[] = {243, 244, 245, 246};
+static const int ain2_muxvals[] = {1, 1, 1, 1};
+static const unsigned ain2_dat2_pins[] = {247};
+static const int ain2_dat2_muxvals[] = {1};
+static const unsigned ain2_dat4_pins[] = {248, 249};
+static const int ain2_dat4_muxvals[] = {1, 1};
+static const unsigned aout1_pins[] = {226, 227, 228, 229};
+static const int aout1_muxvals[] = {1, 1, 1, 1};
+static const unsigned aout1_dat2_pins[] = {230};
+static const int aout1_dat2_muxvals[] = {1};
+static const unsigned aout1_dat4_pins[] = {231, 232};
+static const int aout1_dat4_muxvals[] = {1, 1};
+static const unsigned aout2_pins[] = {192, 193, 194, 195};
+static const int aout2_muxvals[] = {0, 0, 0, 0};
+static const unsigned aout2_dat2_pins[] = {196};
+static const int aout2_dat2_muxvals[] = {0};
+static const unsigned aout2_dat4_pins[] = {197, 198};
+static const int aout2_dat4_muxvals[] = {0, 0};
 static const unsigned aout3_pins[] = {199, 200, 201, 202};
 static const int aout3_muxvals[] = {0, 0, 0, 0};
 static const unsigned ainiec1_pins[] = {240};
@@ -888,9 +904,17 @@ static const unsigned int gpio_range2_pins[] = {
 
 static const struct uniphier_pinctrl_group uniphier_pxs3_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(ain1),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain1_dat4),
 	UNIPHIER_PINCTRL_GROUP(ain2),
+	UNIPHIER_PINCTRL_GROUP(ain2_dat2),
+	UNIPHIER_PINCTRL_GROUP(ain2_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout1),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout1_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout2),
+	UNIPHIER_PINCTRL_GROUP(aout2_dat2),
+	UNIPHIER_PINCTRL_GROUP(aout2_dat4),
 	UNIPHIER_PINCTRL_GROUP(aout3),
 	UNIPHIER_PINCTRL_GROUP(ainiec1),
 	UNIPHIER_PINCTRL_GROUP(aoutiec1),
@@ -926,10 +950,14 @@ static const struct uniphier_pinctrl_group uniphier_pxs3_groups[] = {
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range2),
 };
 
-static const char * const ain1_groups[] = {"ain1"};
-static const char * const ain2_groups[] = {"ain2"};
-static const char * const aout1_groups[] = {"aout1"};
-static const char * const aout2_groups[] = {"aout2"};
+static const char * const ain1_groups[] = {"ain1", "ain1_dat2",
+					   "ain1_dat4"};
+static const char * const ain2_groups[] = {"ain2", "ain2_dat2",
+					   "ain1_dat4"};
+static const char * const aout1_groups[] = {"aout1", "aout1_dat2",
+					    "aout1_dat4"};
+static const char * const aout2_groups[] = {"aout2", "aout2_dat2",
+					    "aout2_dat4"};
 static const char * const aout3_groups[] = {"aout3"};
 static const char * const ainiec1_groups[] = {"ainiec1"};
 static const char * const aoutiec1_groups[] = {"aoutiec1"};
-- 
2.7.4

