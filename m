Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F447509B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387158AbiDUJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387097AbiDUJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:02:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4D22BE1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650531543; x=1682067543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLw1mhSx4JnJWY7T9B+yYOnuF2rUPtAaGFAVz/XWDdQ=;
  b=Yz9QegByZsFAv3KQxThCVZUauaJcMKa9Rob39zF5Utvf11/OYCKvtuEb
   hlEqat1q71/j0zQKdtr86akmm6WE/O7TiEakX/SXcKIADNsXmR83wf6AB
   IkbaV14iZpN9g9NO4Dw6TszgZAPzs+EHyJcJDuqep14OuIbQRHBxsltop
   bxZSOhErsP6lMMMIO9IUtnl8TalJ4SOd/MXyGvTv/iBmxpWZ/5DfVCDP0
   pYPppCgtcc0hivDi4IT9bBMk8lJYAOetBeDK3ACsD/fjB9Spk4VprC5jO
   OcGkx2cAIJmYYhl2v5h6Hip2vQRH55NaUvQxdqCHyy2RNIteHnSyb8HPb
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="153338848"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 01:59:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 01:59:01 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Apr 2022 01:58:59 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/4] riscv: select vitesse phy driver for polarfire soc
Date:   Thu, 21 Apr 2022 09:58:05 +0100
Message-ID: <20220421085805.1220195-4-conor.dooley@microchip.com>
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

There is a Vitesse VSC8662 on the Icicle Kit, until a better option
exists, select it in Kconfig.socs for SOC_MICROCHIP_POLARFIRE.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

---
Palmer: You said to put in a comment, but I have no idea how Kconfig
expects a mid line comment to look. kbuild didn't seem to complain about
what I did, but lmk if that's not what you meant.
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 7f93c729d51c..ff2b8b90db19 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -8,6 +8,7 @@ config SOC_MICROCHIP_POLARFIRE
 	select HW_RANDOM_POLARFIRE_SOC if POLARFIRE_SOC_SYS_CTRL
 	select PCIE_MICROCHIP_HOST if PCI_MSI && OF
 	select SIFIVE_PLIC
+	select VITESSE_PHY # present on icicle kit
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
 
-- 
2.35.2

