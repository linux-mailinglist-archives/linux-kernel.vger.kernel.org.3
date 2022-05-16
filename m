Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEC527FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiEPIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiEPIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:30:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB1E014;
        Mon, 16 May 2022 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652689830; x=1684225830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VvJjr690n6NIuV5mJlZ/HRr9WDfpHhSY6OIBTkSDkfI=;
  b=mJha5llA+zRjSYdUkVkVWA903KV++fRfQZejJ2z6EX2MQ+g+H9VX0Q4e
   GXh0HBGtsKmPIxYPWKxZWlO3gICXgy29kQCK2FzZ1pDX4cU68BPivw/gS
   r8vgRlKLJSpFFJxBOy1zeJH9u7oTvkUfYQjOMxYDGG21/L5FhCCx+UOxO
   e3Ccquky3+n6MtWZIjxInjzpbeppckhf81ellZgzTZM3hR4NGwK6GZbXs
   Za3CBlhvhZ7RrSqQJJn7rOgtVq8aIwZM7uLWKRLa/dI0xDH+/BkLMpG5g
   r6XDXkOgb8qE9qdDLR5jMPxchdQ8F8aNZ8DFJve8L9Zbt+8IZD6HpjcyA
   A==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="164190089"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2022 01:30:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 16 May 2022 01:30:28 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 16 May 2022 01:30:27 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <conor.dooley@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 0/2] rtc: microchip: Add driver for PolarFire SoC
Date:   Mon, 16 May 2022 09:28:37 +0100
Message-ID: <20220516082838.3717982-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
This is technically a v3 of [0], although a fair bit of time has
passed since then. In the meantime I upstreamed the dt-binding, which
was in the v1, and this patch depends on the fixes to the dt-binding
and device tree etc which landed in v5.18-rc5.

The driver is quite substantially rewritten from the v1, as you wanted
it to be switched to "binary" rather than calendar mode - so hopefully I
have satisfied your concerns with the original driver. Specifically you
had an significant issue with the counter being reset on startup & that
is no longer the case.

Thanks,
Conor.

Changes from v2:
- move prescaler out of mpfs_rtc_dev & into probe

Changes from v1:
- remove duplicate and unused defines
- remove oneline mpfs_rtc_set_prescaler function
- dont unconditionally turn off the rtc in the init function
- dont reset the rtc when init is run.
- dont disable the alarm when we boot
- use binary, not calendar mode
- delete mpfs_rtc_init & set prescale in probe
- use dev_pm_set_wake_irq rather than writing suspend/resume functions
- delete calendar mode only register defines
- since using binary mode, set range min to zero
- set range max to max alarm value (is this acceptable?)
- added a MAINTAINERS entry: when v1 was submitted there was nothing to
  add to, but there is now.

[0] https://lore.kernel.org/linux-rtc/20210512111133.1650740-1-daire.mcnamara@microchip.com/


Conor Dooley (2):
  rtc: Add driver for Microchip PolarFire SoC
  MAINTAINERS: add PolarFire SoC's RTC

 MAINTAINERS            |   1 +
 drivers/rtc/Kconfig    |  10 ++
 drivers/rtc/Makefile   |   1 +
 drivers/rtc/rtc-mpfs.c | 328 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 drivers/rtc/rtc-mpfs.c

-- 
2.36.1

