Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CE533DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiEYNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244416AbiEYNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:35:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467360B94;
        Wed, 25 May 2022 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653485716; x=1685021716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jkBj8ysM/XsQcxMgdKHTqDMJDz4jqO5aSUJT7CWKlFg=;
  b=d2Wexmgd2XtDcWpCtFBnRoT5G5K6hA2nzCva7aSqwXjsw+0x4toDC1mW
   EvRvE6/h6xQx/zyfukTHOp2KW8LragmnjZvyIOaN7il93bKSWtz0OU6uJ
   RC1cPRLcXQhoVT21PQ6LSSgCRtbUtwADfI7V3wZI7g1gQiu1FpJW6WLHX
   CnP4tvnCbKt9486iWW1VYhObGsiGypHTrjHU7vIHfHvkngIOaUmbyUMfm
   ZQDMH8zqOHUU8SwMtpXyU1t+gg4y0AUZnZhoG3eKHMV/BET4dW2AHsUDp
   2XEQ9lLYZLY/aOu7Ax5GDwYVd33XQAQxVPFbaRyB8HrSGGS+p35WSSgIh
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="97276335"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2022 06:35:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 25 May 2022 06:35:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 25 May 2022 06:35:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] serial: st-asc: remove include of pm_runtime.h
Date:   Wed, 25 May 2022 16:37:33 +0300
Message-ID: <20220525133733.1051714-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st-asc driver doesn't use helpers from pm_runtime.h thus remove its
include.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/tty/serial/st-asc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 1b0da603ab54..cce42f4c9bc2 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -17,7 +17,6 @@
 #include <linux/tty_flip.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
-#include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
-- 
2.34.1

