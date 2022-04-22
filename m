Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596F950B161
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444776AbiDVH3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiDVH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:28:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190FE5046E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650612362; x=1682148362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpQn21lfBJqxHASJ0XDepMTCjpzWE4fmKlR+6b/wZig=;
  b=10qTgIFbzQ7mFqf/h/ywmagDrPTdoIO7RFj7+p6qFtLKAuOMjk0xUDKR
   k3aUxhsNtOU/qLnNx/GMUe629hFuviZR7/mmkHmgnkiWehXvixWuaXAYr
   IFhGe1JQSOXBSrO7Sd89SjdqKrPAXYkGaBxhH/XGLCgxL8mD7oag+ix0e
   uhGHZEsnQN3ucn5LN+WniLY5n2XzI4CrK9ePnYun0cRO3/ikFNOwHfr1Z
   N6XfuRcBBOPM3eaRJSJ1qf1dx8lVvCPP5uK7r1taH3lSYNku9cPIqVpcN
   xF/zf+VqMplQhQyHX0YaSCrCxxbcCQRJekJvcalMKJMIjhH9bmf+/jJKu
   g==;
X-IronPort-AV: E=Sophos;i="5.90,281,1643698800"; 
   d="scan'208";a="153462798"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Apr 2022 00:26:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Apr 2022 00:26:00 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 22 Apr 2022 00:25:58 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/4] riscv: select peripheral drivers for polarfire soc
Date:   Fri, 22 Apr 2022 08:25:30 +0100
Message-ID: <20220422072533.2582084-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220422072533.2582084-1-conor.dooley@microchip.com>
References: <20220422072533.2582084-1-conor.dooley@microchip.com>
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

Update the SOC_MICROCHIP_POLARFIRE kconfig entry to select, where
applicable, the supported drivers for the SoC.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 34592d00dde8..7f93c729d51c 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -3,6 +3,10 @@ menu "SoC selection"
 config SOC_MICROCHIP_POLARFIRE
 	bool "Microchip PolarFire SoCs"
 	select MCHP_CLK_MPFS
+	select POLARFIRE_SOC_MAILBOX if MAILBOX
+	select POLARFIRE_SOC_SYS_CTRL if MAILBOX
+	select HW_RANDOM_POLARFIRE_SOC if POLARFIRE_SOC_SYS_CTRL
+	select PCIE_MICROCHIP_HOST if PCI_MSI && OF
 	select SIFIVE_PLIC
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
-- 
2.35.2

