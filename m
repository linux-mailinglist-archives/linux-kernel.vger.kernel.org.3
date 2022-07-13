Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE315734D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiGMK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiGMK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:59:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C0F788C;
        Wed, 13 Jul 2022 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657709971; x=1689245971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rHJ8pfgSYGoRDUoZjLb9byAvTc/xy4lLBNG8ZQycNYM=;
  b=b36RPMLgXneMQVaOvIPtEeB7fjGt72ypQzSO3f8t55QQmvoNXt7Mvrgo
   RzG3bGi5OI4+4Owxhqo5gmOTS8LioyVJ3qrm/aPuT84sq1dLoBijVwjyw
   scLrrtFwW4jBhj3IlT1IQJX5y6SHcxyHeuojCFae/xsbAy7s3b2LsGLCl
   DBV6XsJ2UaeIJLBiDYxsXOE6Uz7QlySPCVtJha+bpoNjBzjMEkSihRnqC
   o+YpAlxmD8ZK7rdtCdL+o6SSkbnFhtRedq7A4apJws8Uy1lId4a2A/RYA
   vodhARs7yNqVovCWxBQQAPAaeMKU54ePUerx9xGGmNguHdy0Um1NFojqJ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="181936814"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 03:59:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 03:59:30 -0700
Received: from dev-powerhorse.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 03:59:28 -0700
From:   <lewis.hanly@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <lewis.hanly@microchip.com>
Subject: [PATCH v2 0/1] Add Polarfire SoC GPIO support
Date:   Wed, 13 Jul 2022 11:59:09 +0100
Message-ID: <20220713105910.931983-1-lewis.hanly@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Tested with 5.19-rc5

MPFS gpio interrupts can be configured as direct or
non direct connections to the PLIC (Platform Level Interrupt Controller).
GPIO_INTERRUPT_FAB_CR(31:0) system register will enable GPIO2(31:0)
corresponding interrupt on PLIC. e.g. If GPIO_INTERRUPT_FAB_CR bit0 is set
then GPIO2 bit0 interrupt is available on the direct input pin on the PLIC.


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
 drivers/gpio/gpio-mpfs.c | 379 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 389 insertions(+)
 create mode 100644 drivers/gpio/gpio-mpfs.c

-- 
2.25.1

