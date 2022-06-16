Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E854E2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiFPN7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377285AbiFPN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:58:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A126132;
        Thu, 16 Jun 2022 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655387890; x=1686923890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/GW/lXKpR6TmmSVXUJ9+ZueanAvikeiMgT1O9er88U=;
  b=IiZKzGYVXd8/CF7JtP0hWT0f0GiqzvrDIgXL/3I1m9HAd7iASuGeOKQV
   mnZ+LjMa9cZfky2Z/C+kYJMjvCqJXKQbY6NQq1R14XsVMejaocgonnnGs
   xfsyZDp/6MYdYJY0lvFmbW0L7DuZaVYTr0T0sJx4I4GHgVoqq5AKiOj1m
   LmxkM7aV+ozUC6opIqL23+W22RyAmV6LDipDq332XZet+/tgJDQTeknht
   dccXNb5IbegN7ueqgoPbYtIUJsypTGVEe2g79HYlOhV/n7xGstydWUyGY
   +16ElDZvG5bQX0rLkXYQ8J/IxjZDl1lbj+LwVNN2DTeX6MBIPV4fKERyP
   A==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="168685559"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 06:58:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 06:58:09 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 06:58:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 4/4] serial: st-asc: remove include of pm_runtime.h
Date:   Thu, 16 Jun 2022 17:00:24 +0300
Message-ID: <20220616140024.2081238-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
References: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

