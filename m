Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4386471625
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 21:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhLKUfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 15:35:38 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:42723 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhLKUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 15:35:37 -0500
Received: from [77.244.183.192] (port=65056 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mw95j-0003Xg-9l; Sat, 11 Dec 2021 21:35:35 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 8/9] watchdog: max77620: add comment to clarify set_timeout procedure
Date:   Sat, 11 Dec 2021 21:34:31 +0100
Message-Id: <20211211203432.32446-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211211203432.32446-1-luca@lucaceresoli.net>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <20211211203432.32446-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify why we need to ping the watchdog before changing the timeout by
quoting the MAX77714 datasheet.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v5:
 - improve comment to remove misleading ambiguous interpretation
   (Guenter Roeck)

This patch is new in v4. It adds a clarification comment to the max77620
driver taken from v3 patch 7.
---
 drivers/watchdog/max77620_wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 85ade3c16476..97c12c6167e3 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -123,6 +123,11 @@ static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
 		break;
 	}
 
+	/*
+	 * "If the value of TWD needs to be changed, clear the system
+	 * watchdog timer first [...], then change the value of TWD."
+	 * (MAX77714 datasheet but applies to MAX77620 too)
+	 */
 	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl3,
 				 wdt->drv_data->wdtc_mask, 0x1);
 	if (ret < 0)
-- 
2.25.1

