Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD935AEDF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiIFOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbiIFOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:38:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D49A6A8;
        Tue,  6 Sep 2022 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662472848; x=1694008848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/ar3dqdTBAXl4yVl+JbHybkXPhhp+6FzbNlV23f2H0=;
  b=TumRLoQuuJJGOSgu5XUdHvbxCU81El62UYukzwZ2RD3Y0VARXe7cy5au
   mXzwgzoFaOq2PHoHcq1PlTl/d8WMNx5kSU63gfn3ivP+jMw32GlKf723i
   9tRE9y0YUTNRwA5ORFUzLOEaFKQxw9NnwHmcFvPr+ObHC834rwh8GKeNT
   pB+rj8yr5Xmck3lgTETTVLRduny4QbdBytBtdwd4nbQ/nP2ALsu2J0WQT
   SU7Mp3IxeexXEcK4zV9UTW4j4J5sbyQD6EFyrQgi9Xy/OXvsXhdyAqDNj
   LFkit6NuAab6TWe5xitAPo+PU6eoZ5LBYabT/1Ht26WsjcnIm9YaBXLG6
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="175830153"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:57:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:57:21 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:57:16 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 09/13] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
Date:   Tue, 6 Sep 2022 16:55:08 +0300
Message-ID: <20220906135511.144725-10-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
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

Add definitions for the Baud Rate Source Clock bitmask of the
Mode Register of UART IP's and its bitfields.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---



v1 -> v2:
- Nothing, this patch was not here before



 drivers/tty/serial/atmel_serial.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index 70d0611e56fd..ed64035ba6c3 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -68,6 +68,9 @@
 #define		ATMEL_US_NBSTOP_1		(0 << 12)
 #define		ATMEL_US_NBSTOP_1_5		(1 << 12)
 #define		ATMEL_US_NBSTOP_2		(2 << 12)
+#define	ATMEL_UA_BRSRCCK	GENMASK(13, 12)	/* Clock Selection for UART */
+#define		ATMEL_UA_BRSRCCK_PERIPH_CLK	(0 << 12)
+#define		ATMEL_UA_BRSRCCK_GCLK		(1 << 12)
 #define	ATMEL_US_CHMODE		GENMASK(15, 14)	/* Channel Mode */
 #define		ATMEL_US_CHMODE_NORMAL		(0 << 14)
 #define		ATMEL_US_CHMODE_ECHO		(1 << 14)
-- 
2.25.1

