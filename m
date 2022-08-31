Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F05A760E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiHaF6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaF6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:58:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120EBA9C0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:58:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oTGjv-0001xa-Gs; Wed, 31 Aug 2022 07:58:15 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oTGju-0030ae-2G; Wed, 31 Aug 2022 07:58:14 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oTGjt-0087og-AZ; Wed, 31 Aug 2022 07:58:13 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/2] gpio: Add gpio-latch driver
Date:   Wed, 31 Aug 2022 07:58:09 +0200
Message-Id: <20220831055811.1936613-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a gpio-driver which multiplexes existing GPIOs using latches.
Uwe asked [1] if that would be accectable as a new gpio driver, and here
is the result. For a better description what this is all about have a
look at the drawings in the patches.

Sascha

[1] https://lore.kernel.org/all/CACRpkdaBO=JzokGUF6uXZc7ASVD7LjqBxTLGwX-FShM=A9gw9A@mail.gmail.com/t/

Changes since v1:
    - Use gpiod_set_value_cansleep when the underlying GPIOs might sleep
    - Move MODULE_DEVICE_TABLE near to the end
    - Add license to binding file
    - remove trailing whitespaces


Sascha Hauer (2):
  gpio: Add gpio latch driver
  dt-bindings: gpio: Add gpio-latch binding document

 .../devicetree/bindings/gpio/gpio-latch.yaml  |  84 ++++++++
 drivers/gpio/Kconfig                          |   6 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-latch.c                     | 190 ++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
 create mode 100644 drivers/gpio/gpio-latch.c

-- 
2.30.2

