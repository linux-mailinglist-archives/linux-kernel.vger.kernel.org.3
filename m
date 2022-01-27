Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8149E138
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbiA0LgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:36:02 -0500
Received: from mx.socionext.com ([202.248.49.38]:9862 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240291AbiA0LgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:36:01 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jan 2022 20:36:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id A12C02006F56;
        Thu, 27 Jan 2022 20:36:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Jan 2022 20:36:00 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 75B89C1E22;
        Thu, 27 Jan 2022 20:36:00 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/3] pinctrl: uniphier: Add missing audio pinmux settings for PXs2 SoC
Date:   Thu, 27 Jan 2022 20:35:42 +0900
Message-Id: <1643283344-24911-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing audio I/O pinmux settings for PXs2 SoC.
This adds ain1 4ch pins, ain3 and aout1.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index e52e65a24048..6ef892543cb9 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -719,12 +719,16 @@ static const struct pinctrl_pin_desc uniphier_pxs2_pins[] = {
 			     234, UNIPHIER_PIN_PULL_DOWN),
 };
 
-static const unsigned ain1_pins[] = {161, 162, 173, 174};
-static const int ain1_muxvals[] = {8, 8, 8, 8};
+static const unsigned ain1_pins[] = {161, 162, 173, 174, 127, 128, 129};
+static const int ain1_muxvals[] = {8, 8, 8, 8, 3, 3, 3};
 static const unsigned ain2_pins[] = {98, 99, 100, 101, 102, 103, 104};
 static const int ain2_muxvals[] = {8, 8, 8, 8, 8, 8, 8};
+static const unsigned ain3_pins[] = {132, 133, 134, 131};
+static const int ain3_muxvals[] = {5, 5, 5, 5};
 static const unsigned ainiec1_pins[] = {91};
 static const int ainiec1_muxvals[] = {11};
+static const unsigned aout1_pins[] = {87, 88, 89, 90, 92, 93, 94};
+static const int aout1_muxvals[] = {11, 11, 11, 11, 11, 11, 11};
 static const unsigned aout2_pins[] = {175, 176, 177, 178, 183, 184, 185};
 static const int aout2_muxvals[] = {8, 8, 8, 8, 9, 9, 9};
 static const unsigned aout3_pins[] = {105, 106, 107, 108};
@@ -839,7 +843,9 @@ static const unsigned int gpio_range1_pins[] = {
 static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(ain1),
 	UNIPHIER_PINCTRL_GROUP(ain2),
+	UNIPHIER_PINCTRL_GROUP(ain3),
 	UNIPHIER_PINCTRL_GROUP(ainiec1),
+	UNIPHIER_PINCTRL_GROUP(aout1),
 	UNIPHIER_PINCTRL_GROUP(aout2),
 	UNIPHIER_PINCTRL_GROUP(aout3),
 	UNIPHIER_PINCTRL_GROUP(aoutiec1),
@@ -880,7 +886,9 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 
 static const char * const ain1_groups[] = {"ain1"};
 static const char * const ain2_groups[] = {"ain2"};
+static const char * const ain3_groups[] = {"ain3"};
 static const char * const ainiec1_groups[] = {"ainiec1"};
+static const char * const aout1_groups[] = {"aout1"};
 static const char * const aout2_groups[] = {"aout2"};
 static const char * const aout3_groups[] = {"aout3"};
 static const char * const aoutiec1_groups[] = {"aoutiec1"};
-- 
2.7.4

