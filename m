Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034AF54C38B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbiFOIbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346051AbiFOI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:29:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32D33890;
        Wed, 15 Jun 2022 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655281774; x=1686817774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/GW/lXKpR6TmmSVXUJ9+ZueanAvikeiMgT1O9er88U=;
  b=uIdqJ3tASw+Ve3aMjtPMs23rW0qwPUe5R7H52BdxSASvZ8o/gY8/Jl2M
   1dsVfoakRclW5D73YCNBe9Cum5xO62mHS/Qqq8mCVqIKk186y7uQcBN/P
   WeLeKpv7HM07Mbpe7b8BVCU3WcjB+ova4kh8AahIlVU5B95fQpTnrmNuF
   ZwK3tzd2nF3q6JFWR1VcKUCGWi8b8gXZN7ERAitSKJoMHxVM3gmccV5rM
   RzNrOTOeSF8drM8Sn8kMY5Xsx8gSzD/yw3r+kRQz+/se7MEARrIckeKyv
   9tYJoraEb9PlQ6pd/2jf6RlMQ9Zemp6CfxJ2Rknw57N3ly9r/mGkdeglF
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="178025240"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:29:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:29:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 01:29:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/4] serial: st-asc: remove include of pm_runtime.h
Date:   Wed, 15 Jun 2022 11:31:44 +0300
Message-ID: <20220615083144.1882142-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220615083144.1882142-1-claudiu.beznea@microchip.com>
References: <20220615083144.1882142-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
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

