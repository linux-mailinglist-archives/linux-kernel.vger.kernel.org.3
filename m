Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278C3467B99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382099AbhLCQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352818AbhLCQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:41:46 -0500
X-Greylist: delayed 89445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Dec 2021 08:38:22 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5D98C061751;
        Fri,  3 Dec 2021 08:38:21 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id E70125DD16;
        Fri,  3 Dec 2021 17:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1638549453;
        bh=EWGgfdTrxQHtOQ9XgCk8+mx7RHRdPzCWWWuYARSdwak=;
        h=From:To:CC:Subject:Date:From;
        b=F/NkNAunOITjnXwU4+kw1fWmci4k7a2LNgxv6ldsJvutLc4WUrlNFKa0FnAgGDFa6
         id9mS7m4zjVzmnE2CI25Gaa18lY1xijub6R+uXC8CWpOVGosgz7wuL3SvQFYCfkwuw
         lnIA2TxugRdyV01HUSOosewGY8plc8p/jl/fBUY3lEiuWkn+BldgGORNSkcKwaCeMq
         XyfopXMcnQ9ZI8Kshnq0LfhcxefJ3sFQDrLslfVqFnKm/fpNr40cPCfkC41Zv0poXd
         7NqSGNXj/FGeneKmjA3wa4lrRPtfhUnhxSH2Fza7QPyuVr4Xr7bj0Ix49thZEBK7YJ
         0ZzGPHa0iRalA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 3 Dec 2021 17:37:26 +0100
Received: from localhost.localdomain (172.16.51.18) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14
 via Frontend Transport; Fri, 3 Dec 2021 17:37:25 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrej Picej <andrej.picej@norik.com>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] watchdog: da9062: Correct the timeout values
Date:   Fri, 3 Dec 2021 17:35:39 +0100
Message-ID: <20211203163539.91870-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I measured the timeout values of my DA9061 chip. According to the
information in the data sheet the formula should be:

timeout = 2.048 * 2^(regval - 1)

But my measured values differ from that.
Accoring to my measured values the formula must be:

timeout = 3.2 * 2^(regval - 1)

Is there something wrong with my chip, or has anyone else noticed this as well?

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Andrej Picej <andrej.picej@norik.com>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/watchdog/da9062_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index f02cbd530538..d2576aba9ca5 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -20,7 +20,8 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 
-static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
+static const unsigned int wdt_timeout[] = { 0, 3, 6, 12, 25, 51, 102, 204 };
+
 #define DA9062_TWDSCALE_DISABLE		0
 #define DA9062_TWDSCALE_MIN		1
 #define DA9062_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
-- 
2.11.0

