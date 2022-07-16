Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4534576C52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 09:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGPHL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 03:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 03:11:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18220658A;
        Sat, 16 Jul 2022 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657955483; x=1689491483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YVU5qJLCsSc6SFHbZNFSgBEov8vHAhENYn8Xttvn/x8=;
  b=Y6zoS3wqPakWHm4wgEO1aYJZyE+aP/bszXRBYCdXWX4Bfpimimbqr2Kk
   ASL1BE2Xkyl+1pESZ8pgkwEvjYLNLd5Muy8DVUUCORtlGiLM2MHpEt9XO
   kLZQf4KB7hbXPiFJMX3P7CCAcHMhrs7CJv5lEhRlGdDneXQeizDGYleM2
   SfegVsx9dIRW0+k+PhRyZ3yIZzVwT8DhOlwc+vNkbAMA4UsUSatREgR/f
   E4dSMHk97H/7xF1lY2N6NQMr7iv0aDPGZnZvHyza5R0JJVF9ft28iJMp7
   8g/1EhW4hwMXVWbHDtIPsdMKvCbEOgkhcFLsWhBKb+CMUq4D6UawXeNgv
   g==;
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="104740574"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 00:11:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 00:11:19 -0700
Received: from dev-powerhorse.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sat, 16 Jul 2022 00:11:17 -0700
From:   <lewis.hanly@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <lewis.hanly@microchip.com>
Subject: [PATCH v3 0/1] Add Polarfire SoC GPIO support
Date:   Sat, 16 Jul 2022 08:11:12 +0100
Message-ID: <20220716071113.1646887-1-lewis.hanly@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lewis Hanly <lewis.hanly@microchip.com>

Add a driver to support the Polarfire SoC gpio controller.
Tested with 5.19-rc5

MPFS gpio interrupts can be configured as direct or
non direct connections to the PLIC (Platform Level Interrupt Controller).
GPIO_INTERRUPT_FAB_CR(31:0) system register will enable GPIO2(31:0)
corresponding interrupt on PLIC. e.g. If GPIO_INTERRUPT_FAB_CR bit0 is set
then GPIO2 bit0 interrupt is available on the direct input pin on the PLIC.

Changes in v3:
Changed order in kconfig.
Removed blank lines in driver header/source file.
Removed BYTE_BOUNDARY variable and use macro to do *4.
mpfs_gpio_assign_bit parameter uses macro instead of (i * BYTE_BOUNDARY).
Add correct definitions for direction.
Change order of variables in mpfs_gpio_irq_set_type function.
Return dev_err_probe instead of dev_err.
Remove noise of dev_inf.
Avoid using of_match_ptr.
use devm_gpiochip_add_data(..)
Update mpfs_gpio_remove. 

Changes in v2:
Use raw_spinlock.
Use __assign_bit() to assign bit, added a bool variable for value.
Remove unnecessary checking gpio_index.
Remove default from switch statement.
Use const for irq_chip, name updated and use mask/unmask.
Use latest kernel api irq set_chip.
Implemented hierarchical interrupt chip support, although
suggested to use chained interrupt flow I believe this fits better.

Lewis Hanly (1):
  gpio: mpfs: add polarfire soc gpio support

 drivers/gpio/Kconfig     |   9 +
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-mpfs.c | 361 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/gpio/gpio-mpfs.c

-- 
2.25.1

