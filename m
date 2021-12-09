Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974D546E849
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhLIMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:22:58 -0500
Received: from m12-17.163.com ([220.181.12.17]:4592 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhLIMW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:22:56 -0500
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 07:22:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ta/wF
        WP7wx/GbOe/PU6XzVZ7kIW7mTON1PaHIqq+Y9o=; b=QDVtz7XQH8rtTewd/hglf
        GSrs/skJN6hBXnkvlGqatOUpkuN0uwHA6ALe9+Mrib3jHPWj8jujb33An1dkHvFH
        vdJuphWxI7f9yJF/pyzQ0xF70yMiWDg/IIS3gQ3rEGdlgIiBxkY06i8onyC+eD86
        7pf47uhKmP/a0J3gfJj8a4=
Received: from localhost.localdomain (unknown [120.243.48.4])
        by smtp13 (Coremail) with SMTP id EcCowAA3ITQ88LFh_EI5BQ--.21291S4;
        Thu, 09 Dec 2021 20:02:31 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     ulf.hansson@linaro.org, u.kleine-koenig@pengutronix.de,
        srinivas.pandruvada@linux.intel.com, pali@kernel.org,
        TheSven73@gmail.com, lznuaa@gmail.com, sensor1010@163.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/mmc/core/bus: Remove redundant driver match function
Date:   Thu,  9 Dec 2021 04:01:57 -0800
Message-Id: <20211209120157.9552-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAA3ITQ88LFh_EI5BQ--.21291S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWDCF48AFW7tw17JF1fWFg_yoW8JFW3pF
        ZxXFy2kryUKa13Z3s7CFWkuFySk3y8Kry0grW8K3sY9a17CrnrJFyvy34jyF98uFy5CF4S
        qryqvryrCFy8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uha9fUUUUU=
X-Originating-IP: [120.243.48.4]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiuBdkq1QHN7BxBgAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver match function, the driver core assumes
that each candidate pair (driver, device) matches. See function
driver_match_device().

Drop the mmc bus's match function that always returned 1 and
so implements the same behaviour as when there is no match
function.

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/mmc/core/bus.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index f6b7a9c5bbff..096ae624be9a 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -53,16 +53,6 @@ static struct attribute *mmc_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(mmc_dev);
 
-/*
- * This currently matches any MMC driver to any MMC card - drivers
- * themselves make the decision whether to drive this card in their
- * probe method.
- */
-static int mmc_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static int
 mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
@@ -226,7 +216,6 @@ static const struct dev_pm_ops mmc_bus_pm_ops = {
 static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_groups	= mmc_dev_groups,
-	.match		= mmc_bus_match,
 	.uevent		= mmc_bus_uevent,
 	.probe		= mmc_bus_probe,
 	.remove		= mmc_bus_remove,
-- 
2.25.1


