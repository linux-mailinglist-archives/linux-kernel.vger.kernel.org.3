Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC348D9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiAMOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:47:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19844 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiAMOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085276; x=1673621276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TLoVJGu9GzlLqKVezijYXBP2bSWqSRzeqtsZirqCtfY=;
  b=E25WB7AiudMMNmayLU7gctQZQjxreBvRsPoqsc4Oq4E/zG5HWiDU4qyT
   mwBiqAkd2R41lOHGdzQsLsde4vipGPFxEv36f8n34Pnw7vCcnKgwds4Un
   uBPhPiAcVipkBsdPLHmJxEYgPDhstkQmf9cPEIVZ/68Aa25A8SH6lcy/5
   sX4awTwa/g40w7cAt0sGegEQ0uoQ/JAHQ2Uti3GLQDrDfAfrOwau/Eqyd
   YkKlB+lxydYMLixdLea9GzYK+I9DGlnfH/7pRpBE4h4bcXsdrdl6EMlbz
   41MvezxXiclq8OHTXp4qTA2pN7ObscCmJlIlbayc3qA8zN/2ZdLIfQNBE
   w==;
IronPort-SDR: QFiaa1iUfXWBgE8mciayo9eSGbKgzyb6pAieAOJ+r3KJmW/KO3mwJJBmoRDJfb5iXQo09Rshn/
 NW1+qdydp8KeuqQ7GDmp7B3EJF7B6NJJZCgFECErKPELyQZkqnWABfZkNoT7dvsfgp9ADaRX37
 I3Jq4XNenOhk2WZeCQ1TWT9wgQJa39J+szRb8oQ4OTNlD7CRXLvp8pV5MG3kaHxlFFVMW9FSvR
 /n4B4DwhMFZJ10sDs2xS3RREswHv8nRxuccRvCRg9D9dfbgiPyfcCo4VxPjKDDkF1p7pAkJTqp
 R4e+sGbO+EevflI6StxxbRzI
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="150108148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:47:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:47:55 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:47:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 00/10] ARM: at91: add cpu idle and cpufreq opps for sama7g5
Date:   Thu, 13 Jan 2022 16:48:50 +0200
Message-ID: <20220113144900.906370-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This series adds CPU idle support for SAMA7G5. Along with this the
CPUFreq OPPs for SAMA7G5 and proper config has been added.

Thank you,
Claudiu Beznea

Changes in v2:
- collected tags
- add "opp-suspend" to 600MHz OPP on patch "ARM: dts: at91: sama7g5: add opps"
- add patches:
	ARM: dts: at91: fix low limit for CPU regulator
	ARM: dts: at91: sama7g5ek: set regulator voltages for standby state

Claudiu Beznea (10):
  ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
  ARM: at91: ddr: align macro definitions
  ARM: at91: ddr: fix typo to align with datasheet naming
  ARM: at91: PM: add cpu idle support for sama7g5
  ARM: at91: Kconfig: select PM_OPP
  ARM: dts: at91: fix low limit for CPU regulator
  ARM: dts: at91: sama7g5ek: set regulator voltages for standby state
  ARM: dts: at91: sama7g5: add opps
  ARM: configs: at91: sama7: enable cpu idle
  ARM: configs: at91: sama7: add config for cpufreq

 arch/arm/boot/dts/at91-sama7g5ek.dts |  7 ++++-
 arch/arm/boot/dts/sama7g5.dtsi       | 38 ++++++++++++++++++++++++++++
 arch/arm/configs/sama7_defconfig     |  9 ++++++-
 arch/arm/mach-at91/Kconfig           |  1 +
 arch/arm/mach-at91/pm.c              | 27 +++++++++++++++++++-
 arch/arm/mach-at91/pm_suspend.S      |  4 +--
 include/linux/clk/at91_pmc.h         |  4 +++
 include/soc/at91/sama7-ddr.h         | 15 +++++------
 8 files changed, 91 insertions(+), 14 deletions(-)

-- 
2.32.0

