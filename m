Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1237502A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353530AbiDOM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiDOM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:56:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199CBF95F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650027235; x=1681563235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpQn21lfBJqxHASJ0XDepMTCjpzWE4fmKlR+6b/wZig=;
  b=0IFbNZH8WDXswEaNpK/Lr3rmE3jfbrE5rem4vgEu7YOYU2X9L5t75K+V
   wNTXpl7kVc/LSswIMBtsRKpoL3fS37EVq0AVzgAiroAnE5IcmlMgB3C71
   i+KGfXyZcXB2dnuYMuqQUrivYBM3vxVNlDJwtiP+mruukN5Up1h6SEyxd
   +yEN2gkXnjHHGxF6iz2MuQB7jITdRkTz9g7JWCCsvEdKJbh6Hseq/dZw4
   4l19NUOP6KeoXT6+F4qUYFganQj3w6tVCV3WK6kIHoo3CWqSMsQROIAA4
   enaOqKtPM+0W6tR74zXnh3En2eQ8cOfi/jO4Gmr+oF9adflX8x7B+bRur
   w==;
X-IronPort-AV: E=Sophos;i="5.90,262,1643698800"; 
   d="scan'208";a="160220612"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2022 05:53:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Apr 2022 05:53:54 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 15 Apr 2022 05:53:53 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 1/4] riscv: select peripheral drivers for polarfire soc
Date:   Fri, 15 Apr 2022 13:52:19 +0100
Message-ID: <20220415125221.2871991-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415125221.2871991-1-conor.dooley@microchip.com>
References: <20220415125221.2871991-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

