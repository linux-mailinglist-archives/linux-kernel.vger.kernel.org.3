Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D762D48F494
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiAODgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 22:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiAODgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 22:36:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D46C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 19:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Fu5lCP7cfb3jzNS+tHM0CX5vdOqpUOAzIehnFh+7FXk=; b=vDUl20GmP5zdKQfkx4fAjQ9AvG
        8yr/CkvhklE03qaM6lRNxyUKwNHzYtej4+j7dtwWAT/OK1H4R8ULNW4nYywp5up1QAiN2rldLlE9j
        YE3rKlxHd9TC5blqjMNdEu+GW5TL1ilp17z3IeKulOA7gx8bCiV9f1tjYLkCVVZz8ODcCHHbD6jM9
        s+RJawYKiVbhtwPB4Hbuq7Y0pmy7JytDcEzul8n+S0Xd4YKFyMJd5g8+TOij+G/lfXesNFelYewUA
        7ipyhJQZ3+I8mdCr1e2rFPYIVTspfu3oUXyEcKyAkiEt+MPJfgQ3AGbYjjpRkXCuUxlIh/WiAblFR
        beDW6YEQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8ZrI-00AbwC-MI; Sat, 15 Jan 2022 03:36:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Watson Chow <watson.chow@avnet.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] regulator: MAX20086: add gpio/consumer.h
Date:   Fri, 14 Jan 2022 19:36:03 -0800
Message-Id: <20220115033603.24473-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max20086-regulator.c needs <linux/gpio/consumer.h> for an enum, some
macros, and a function prototype. (seen on ARCH=m68k)

Adding this header file fixes multiple build errors:

../drivers/regulator/max20086-regulator.c: In function 'max20086_i2c_probe':
../drivers/regulator/max20086-regulator.c:217:26: error: storage size of 'flags' isn't known
  217 |         enum gpiod_flags flags;
../drivers/regulator/max20086-regulator.c:261:27: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
  261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
      |                           ^~~~~~~~~~~~~~
../drivers/regulator/max20086-regulator.c:261:44: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
  261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
../drivers/regulator/max20086-regulator.c:262:27: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
  262 |         chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
../drivers/regulator/max20086-regulator.c:217:26: warning: unused variable 'flags' [-Wunused-variable]
  217 |         enum gpiod_flags flags;

Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Watson Chow <watson.chow@avnet.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/regulator/max20086-regulator.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220114.orig/drivers/regulator/max20086-regulator.c
+++ linux-next-20220114/drivers/regulator/max20086-regulator.c
@@ -7,6 +7,7 @@
 
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
