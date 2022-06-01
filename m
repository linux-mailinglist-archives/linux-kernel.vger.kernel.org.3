Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7C53A520
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352929AbiFAMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350780AbiFAMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:35:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693829CC99;
        Wed,  1 Jun 2022 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654086903; x=1685622903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KaYR/blB8zGHDSr0CLcv5ju+jN5gMeOimUNbfTUhUQs=;
  b=t2K1cmbde8WFTmUjbX5P3kIpIjExv3+73VlfBMTmz9XZMDYmjfA6jbIP
   bKwXui2aQWbNmkRGPOS+UojGbK/SVuL3d47+4lpDiFqWKp2Ac3p3YYtxG
   lBBdO+7J23BeKk4Uxkh1BiM/oFEEmmoEN1Ko+RkLJmYAyWFDadc+d/H4V
   AwC91eK/WpYdNNWXdqzB42iFAYHUF/wMfbZ93Z5Bu5i+TVH+Ezy0jMqYm
   tn31tGtVKTmwcZHLLzETili86RSVK+74+v8hYGYNHtjXOIwEYg4+vtRKz
   1cocTeFsOyVeYLLSiNM0EvADLHyriKiASGAasGrLkhzvSu8O7IP2PgyCz
   w==;
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="176039617"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jun 2022 05:35:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 1 Jun 2022 05:35:02 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 1 Jun 2022 05:35:00 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <conor.dooley@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 0/2] rtc: microchip: Add driver for PolarFire SoC
Date:   Wed, 1 Jun 2022 13:33:19 +0100
Message-ID: <20220601123320.2861043-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
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

Hey all,
This is technically a v5 of [0], although a fair bit of time has
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

Changes since v4:
- replace duplicate define of BIT(6) with the missing BIT(7) define
- remove duplicate read of the mode register in mpfs_rtc_readalarm()
- simplify if (mode & MODE_WAKE_EN) to an assignment
- replace (potentially) infinite wait with read_poll_timeout

Changes since v3:
- invert read order of datetime registers so that they are properly
  aligned. reads of the upper register are aligned to the last read
  of the lower register
- move wakeup_irq out of mpfs_rtc_dev & into probe
- removed range_min since it is not set & implicity zero anyway
- rewrote the remove function to not call mpfs_rtc_alarm_irq_enable(,0)

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
 drivers/rtc/rtc-mpfs.c | 326 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 338 insertions(+)
 create mode 100644 drivers/rtc/rtc-mpfs.c


base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.36.1

