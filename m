Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F95655F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiGDMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiGDMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:52:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0910FDD;
        Mon,  4 Jul 2022 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656939128; x=1688475128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ohVPsZxj+uL/Ce5+TfyaWAhNK5BZ0yJWMoxA7PT9z6s=;
  b=W4+DQ71QpO2SCBO2AG3Xl5kUcvES03PHcfNwlRLPRMh0JBIeiDa+mOB1
   li9snWwExp5NgHu6UzICPIs0gTWyhMerymS25saCHEhEKdV1XJeuac8Xz
   cDosJAQu3nAHcDu015JaLP5V7phBLE0UnFUA3jEtJDyhlpeDyro7Kbfs0
   xckCA+26QaZfUk3cJ4pFY08y8PelXdCc5VErtnvwI1bnUASq+1KejB82e
   8+Z5G6M5I3aVQRSed7wf51tqh7IWJKe/XI5vBeir0W4EIb6rOhSQBEQ5t
   jJOCJVvfcChCiKKRTAjmtn73IcKp8XrF6y6/NMsXxpo5uT2+RtyV3pbUt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263546124"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="263546124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 05:52:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649591127"
Received: from bclindho-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 05:52:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH tty-next] MIPS: ath79: Remove one of the identical args in early_printk
Date:   Mon,  4 Jul 2022 15:51:51 +0300
Message-Id: <20220704125151.59231-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prom_putchar_wait() inputs both mask and val but the callers always set
them to the same value. Thus pass only val.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
This patch applies only to tty-next that has another change this work is
based on.

 arch/mips/ath79/early_printk.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index f6d02b425a10..34c4dfdf46b4 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -19,13 +19,13 @@
 
 static void (*_prom_putchar)(char);
 
-static inline void prom_putchar_wait(void __iomem *reg, u32 mask, u32 val)
+static inline void prom_putchar_wait(void __iomem *reg, u32 val)
 {
 	u32 t;
 
 	do {
 		t = __raw_readl(reg);
-		if ((t & mask) == val)
+		if ((t & val) == val)
 			break;
 	} while (1);
 }
@@ -34,23 +34,19 @@ static void prom_putchar_ar71xx(char ch)
 {
 	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
 
-	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
-			  UART_LSR_BOTH_EMPTY);
+	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY);
 	__raw_writel((unsigned char)ch, base + UART_TX * 4);
-	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
-			  UART_LSR_BOTH_EMPTY);
+	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY);
 }
 
 static void prom_putchar_ar933x(char ch)
 {
 	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR933X_UART_BASE));
 
-	prom_putchar_wait(base + AR933X_UART_DATA_REG, AR933X_UART_DATA_TX_CSR,
-			  AR933X_UART_DATA_TX_CSR);
+	prom_putchar_wait(base + AR933X_UART_DATA_REG, AR933X_UART_DATA_TX_CSR);
 	__raw_writel(AR933X_UART_DATA_TX_CSR | (unsigned char)ch,
 		     base + AR933X_UART_DATA_REG);
-	prom_putchar_wait(base + AR933X_UART_DATA_REG, AR933X_UART_DATA_TX_CSR,
-			  AR933X_UART_DATA_TX_CSR);
+	prom_putchar_wait(base + AR933X_UART_DATA_REG, AR933X_UART_DATA_TX_CSR);
 }
 
 static void prom_putchar_dummy(char ch)

-- 
tg: (899e836bddb3..) cleanup/ath79-early-params (depends on: tty-next)
