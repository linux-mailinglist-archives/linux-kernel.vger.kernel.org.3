Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD625A6B97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiH3SBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiH3SBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:01:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDABF83F0F;
        Tue, 30 Aug 2022 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661882481; x=1693418481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S+0sT1gSA5uP8yZcYX5e+6AIBTfIqLir8Zo9XeEUKpM=;
  b=E//fKxXC4SIvpXisNuwLpN0VcET07GI+UFPINmFX6Tbid+oE5yrfs4OW
   WVpAzTDENNDnnB+oUPV12Kelr2E39tpLjsh3Iq+xyzhNJQIUKmsn6vEBW
   oN9dfgpPXfTerhk25iKQR0x4IBSiy6hHns2Jx3e9ykKbjGKTUvxrNF9R+
   p/B7xMdfpfIg2dAK0Sexyac8kQpPl/KOTPerG5f1yqM0IaoQhbRhWYQk4
   fCXRY3KHK4RlQysmLW2xa7ajMLKhva2mk+bq0yZk11BfYVDQS88vie1sf
   26YwUVD6Hxv9NFmEPIX8qbN4QaR3tcsY0sVfz1VEQeWGF1qdlNeTbd+Fp
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="178360180"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 11:01:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 11:01:15 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 11:01:09 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 tty-next 0/2] 8250: microchip: pci1xxxx: Add driver for the pci1xxxx's quad-uart function.
Date:   Tue, 30 Aug 2022 23:30:52 +0530
Message-ID: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. Quad-uart is one of the functions in the multi-function
endpoint. This patch adds device driver for the quad-uart function and
enumerates between 1 to 4 instances of uarts based on the PCIe subsystem
device ID.

Kumaravel Thiagarajan (2):
  8250: microchip: pci1xxxx: Add driver for the quad-uart function in
    the  multi-function endpoint of pci1xxxx device.
  8250: microchip: pci1xxxx: Add power management functions to
    pci1xxxx's  quad-uart driver.

 MAINTAINERS                             |   6 +
 drivers/tty/serial/8250/8250_pci1xxxx.c | 585 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |   9 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   3 +
 6 files changed, 612 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c

-- 
2.25.1

