Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB36592A12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbiHOHGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiHOHGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:06:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A161DDFB5;
        Mon, 15 Aug 2022 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660547175; x=1692083175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HzdfhF2vvfRvRGRdUuhLHsxJf9Ap6uG8/K381pIKVxc=;
  b=XKM4ZGHPBpeT7yXCtn3SD09ombW1iXSVNRDwo0NInUEgSboQBgYkoDSx
   PvIRE7kEm/0Q86fVXo46bHPP5DRbQBFsyRI6NspnHt5URPP90SJaZFbnw
   kBpxRNCIbd/BPMZ0qoQhs83x3lbaqB1Q70ZHgjATP9QWkqZPHnQNlIQBe
   XHDuqbl3mc1eM4b+HcfbW+6w3JAr/uHkn9pQvP0KFGQ+fkr9ih+1LoPn/
   J7nTvrd4/GubHEZqLFDeSqAnUYjycAuREd4s11wzCMtbmVk3uHh2xsXxg
   DadbNk/fLbQYDqddM/+dACjC0/5r8kFysah+rZGWxNE0XWIaMV0rCA9QW
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="169265719"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 00:06:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 00:06:13 -0700
Received: from dev-powerhorse.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 00:06:11 -0700
From:   <lewis.hanly@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <lewis.hanly@microchip.com>
Subject: [PATCH v5 0/1] Add Polarfire SoC GPIO support
Date:   Mon, 15 Aug 2022 08:06:05 +0100
Message-ID: <20220815070606.1298421-1-lewis.hanly@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lewis Hanly <lewis.hanly@microchip.com>

Add a driver to support the Polarfire SoC gpio controller.
Tested with latest 5.19 kernel.

MPFS gpio interrupts are connected to IOMUX configured by system 
register GPIO_INTERRUPT_FAB_CR(31:0). Interrupt connection for
some GPIO's to the PLIC (Platform Level Interrupt Controller) can be 
shared (not directly connected) or direct if connection is available.

previously upstreamed dt-bindings: gpio: microchip,mpfs-gpio.yaml

Changes in v5
Added the const for the irqchip, removed in error from v2.

Changes in v4
Changed the interrupt handling from Hierarchical flow to chained interrupt
flow. The reason for the change was with hierarchical flow we requried
a interrupt number mapping array to work with our HW and this was not acceptable.
On reviewing the architecture the chained interrupt flow works better
for our hardware and configurations which are not fixed in Silicon.
Added support to read the optional DT property ngpios.

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

 drivers/gpio/Kconfig     |   7 +
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-mpfs.c | 318 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 326 insertions(+)
 create mode 100644 drivers/gpio/gpio-mpfs.c

-- 
2.25.1

