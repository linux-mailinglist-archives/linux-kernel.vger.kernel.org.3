Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09FB48DA19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiAMOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49512 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiAMOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085307; x=1673621307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEArm4L3rzKNYcbWHVsHPV1Ug//Fk01TwtXeWoxZlLg=;
  b=FF6Pnt6+wsEPhuGxHBukvVkYhiRMDDHV9pl8mpsz1g/oTkAV35yqhiK4
   9SaUdu7aByQeQgRm9SdLA5ekoRsXITpHr2Imv8Uhxbdexl5Q4EmOWDF2T
   eCcOf0HGjFBAnfn9K4uxl+nKXsZRA0Yga0fwPDyyG+bKh7D48iyhRb3ld
   FYvqrcHSdJX8s9NT955l6mwkf3mg0YX9KigM8KWoSnEKhlJm2xAofZW5z
   ziJDncXFeiVz4FB6w97RgCNTyoEgYRft1oh2dAbCgKFwjS408Qvypkjrj
   plNBA2yoPgurQ1BpfWi4hN2rocp/DilxOvtPa/X47bT+JdhdkWIFSBSyJ
   Q==;
IronPort-SDR: YGM0nHaHAI2bAtgvwl598GXQEWbb0V/t6ql6Z3K500t0G2iBrkapz6toIuhG+cjg1sycrPDeQV
 vmo5XpNUfwNJZSW6qvn6aoYvO7Teujk3G+3rOVCBmZAd2N2HYkCGSo9wmHBbbfaoxB3OurRgZU
 KwCM2hMyRwi3J7BotMHLOgS6t+BPrMwoNbyS8gtPibbdVRqWFp9pe73uBld207toyxk6Q3VsO/
 hp4YFDfGsTFqOwxXydzW9nLYzGSVBvDqWGveKjnMgAaHG/o1PjYfP9z6QPxr3FAIQvwuDkrOsT
 LnON+71vVuRFPAOiGVyihvOv
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="149554035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 10/10] ARM: configs: at91: sama7: add config for cpufreq
Date:   Thu, 13 Jan 2022 16:49:00 +0200
Message-ID: <20220113144900.906370-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add config flags for CPUFreq. This includes enabling CPUFreq support,
CPUFreq DT driver and governors, default one being the conservative
governor.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 95c2a7ed4816..689e9afcb5b2 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -26,6 +26,12 @@ CONFIG_FORCE_MAX_ZONEORDER=15
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.32.0

