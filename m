Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA1509B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387170AbiDUJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387155AbiDUJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:02:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBC522BD8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650531538; x=1682067538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpQn21lfBJqxHASJ0XDepMTCjpzWE4fmKlR+6b/wZig=;
  b=jUbo1VQkr7KB1l19W1LvvsTCUv/vztv2iFtIYRsDMg1W9OVKInJQ0yWm
   fT8haUbwJauLSYMxMiC7aHEUNdsJ2aSKse6cSbChhA3NHxucMnYHempXy
   Te4Da8HTCpJiHSLMGrj6MAQPfCAm8R6qMrMjesEp2wNY83yz9oLOHf4ml
   8yYy7DmIfI/g3iqCMB9DntRGNtCPzhOdBSEkxqpeGOLMIyx7XnJKpX4Qj
   x2F/GjiuRQ0XUfDb3xwkLVGo/gmg0GIvjFpuO66zCK+z3weWQs741t81W
   J6KPMay0Enf2QP5X1ttmzlnRpYI0gTOV7HekmB4/JitUAtM3hjEQ07p2n
   g==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="93073109"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 01:58:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 01:58:57 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Apr 2022 01:58:55 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/4] riscv: select peripheral drivers for polarfire soc
Date:   Thu, 21 Apr 2022 09:58:03 +0100
Message-ID: <20220421085805.1220195-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421085805.1220195-1-conor.dooley@microchip.com>
References: <20220421085805.1220195-1-conor.dooley@microchip.com>
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

