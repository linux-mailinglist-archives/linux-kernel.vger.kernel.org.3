Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37D44C1A79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiBWSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbiBWSAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:00:44 -0500
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC54199C;
        Wed, 23 Feb 2022 10:00:14 -0800 (PST)
Received: from [77.244.183.192] (port=62116 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nMvvw-00039p-MB; Wed, 23 Feb 2022 19:00:12 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 7/8] watchdog: max77620: add comment to clarify set_timeout procedure
Date:   Wed, 23 Feb 2022 18:59:07 +0100
Message-Id: <20220223175908.191618-8-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223175908.191618-1-luca@lucaceresoli.net>
References: <20220223175908.191618-1-luca@lucaceresoli.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify why we need to ping the watchdog before changing the timeout by
quoting the MAX77714 datasheet.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---

Changes in v6: none

Changes in v5:
 - improve comment to remove misleading ambiguous interpretation
   (Guenter Roeck)

This patch is new in v4. It adds a clarification comment to the max77620
driver taken from v3 patch 7.
---
 drivers/watchdog/max77620_wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index cd321c7e0d59..b76ad6ba0915 100644
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

