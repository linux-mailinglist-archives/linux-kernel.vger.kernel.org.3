Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673BF49E13E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiA0LgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:36:09 -0500
Received: from mx.socionext.com ([202.248.49.38]:8908 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240535AbiA0LgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:36:04 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Jan 2022 20:36:03 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 4EF6E205D901;
        Thu, 27 Jan 2022 20:36:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Jan 2022 20:36:03 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 10632C1E22;
        Thu, 27 Jan 2022 20:36:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] pinctrl: uniphier: Add USB device pinmux settings
Date:   Thu, 27 Jan 2022 20:35:44 +0900
Message-Id: <1643283344-24911-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB device pinmux settings for PXs2 and PXs3 SoCs. Only pins for
ports 0 and 1 support USB device mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 10 ++++++++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index efeca8fd7c9f..80ea30f5952d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -817,8 +817,12 @@ static const unsigned uart3b_pins[] = {181, 182};
 static const int uart3b_muxvals[] = {10, 10};
 static const unsigned usb0_pins[] = {56, 57};
 static const int usb0_muxvals[] = {8, 8};
+static const unsigned usb0_device_pins[] = {213};
+static const int usb0_device_muxvals[] = {9};
 static const unsigned usb1_pins[] = {58, 59};
 static const int usb1_muxvals[] = {8, 8};
+static const unsigned usb1_device_pins[] = {214};
+static const int usb1_device_muxvals[] = {9};
 static const unsigned usb2_pins[] = {60, 61};
 static const int usb2_muxvals[] = {8, 8};
 static const unsigned usb3_pins[] = {62, 63};
@@ -901,7 +905,9 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(uart3),
 	UNIPHIER_PINCTRL_GROUP(uart3b),
 	UNIPHIER_PINCTRL_GROUP(usb0),
+	UNIPHIER_PINCTRL_GROUP(usb0_device),
 	UNIPHIER_PINCTRL_GROUP(usb1),
+	UNIPHIER_PINCTRL_GROUP(usb1_device),
 	UNIPHIER_PINCTRL_GROUP(usb2),
 	UNIPHIER_PINCTRL_GROUP(usb3),
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range0),
@@ -942,8 +948,8 @@ static const char * const uart0_groups[] = {"uart0", "uart0b",
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
 static const char * const uart3_groups[] = {"uart3", "uart3b"};
-static const char * const usb0_groups[] = {"usb0"};
-static const char * const usb1_groups[] = {"usb1"};
+static const char * const usb0_groups[] = {"usb0", "usb0_device"};
+static const char * const usb1_groups[] = {"usb1", "usb1_device"};
 static const char * const usb2_groups[] = {"usb2"};
 static const char * const usb3_groups[] = {"usb3"};
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index eb3c9b55f6e3..ab3bd2d9c6c7 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -855,8 +855,12 @@ static const unsigned int uart3_pins[] = {98, 99};
 static const int uart3_muxvals[] = {0, 0};
 static const unsigned int usb0_pins[] = {84, 85};
 static const int usb0_muxvals[] = {0, 0};
+static const unsigned int usb0_device_pins[] = {110};
+static const int usb0_device_muxvals[] = {2};
 static const unsigned int usb1_pins[] = {86, 87};
 static const int usb1_muxvals[] = {0, 0};
+static const unsigned int usb1_device_pins[] = {111};
+static const int usb1_device_muxvals[] = {2};
 static const unsigned int usb2_pins[] = {88, 89};
 static const int usb2_muxvals[] = {0, 0};
 static const unsigned int usb3_pins[] = {90, 91};
@@ -942,7 +946,9 @@ static const struct uniphier_pinctrl_group uniphier_pxs3_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(uart2),
 	UNIPHIER_PINCTRL_GROUP(uart3),
 	UNIPHIER_PINCTRL_GROUP(usb0),
+	UNIPHIER_PINCTRL_GROUP(usb0_device),
 	UNIPHIER_PINCTRL_GROUP(usb1),
+	UNIPHIER_PINCTRL_GROUP(usb1_device),
 	UNIPHIER_PINCTRL_GROUP(usb2),
 	UNIPHIER_PINCTRL_GROUP(usb3),
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range0),
@@ -982,8 +988,8 @@ static const char * const uart0_groups[] = {"uart0", "uart0_ctsrts",
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
 static const char * const uart3_groups[] = {"uart3"};
-static const char * const usb0_groups[] = {"usb0"};
-static const char * const usb1_groups[] = {"usb1"};
+static const char * const usb0_groups[] = {"usb0", "usb0_device"};
+static const char * const usb1_groups[] = {"usb1", "usb1_device"};
 static const char * const usb2_groups[] = {"usb2"};
 static const char * const usb3_groups[] = {"usb3"};
 
-- 
2.7.4

