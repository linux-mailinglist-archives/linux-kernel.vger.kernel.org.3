Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B796484A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiADVnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:43:21 -0500
Received: from aposti.net ([89.234.176.197]:52182 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234965AbiADVnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:43:19 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 7/8] mmc: jz4740: Make dev_pm_ops struct static
Date:   Tue,  4 Jan 2022 21:42:13 +0000
Message-Id: <20220104214214.198843-8-paul@crapouillou.net>
In-Reply-To: <20220104214214.198843-1-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new DEFINE_SIMPLE_DEV_PM_OPS() macro does not set the "static"
qualifier anymore, so we can add it here, as the underlying dev_pm_ops
struct is only used in this file.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 7693236c946f..7ab1b38a7be5 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1128,8 +1128,8 @@ static int jz4740_mmc_resume(struct device *dev)
 	return pinctrl_select_default_state(dev);
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
-	jz4740_mmc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
+				jz4740_mmc_resume);
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
-- 
2.34.1

