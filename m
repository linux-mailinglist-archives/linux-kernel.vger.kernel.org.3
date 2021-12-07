Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0978746B80B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhLGJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:55:49 -0500
Received: from m12-18.163.com ([220.181.12.18]:10535 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232311AbhLGJzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ta/wF
        WP7wx/GbOe/PU6XzVZ7kIW7mTON1PaHIqq+Y9o=; b=CdgN2VC79T//s8mekft1l
        WUgscf6Ruhp2aQoHrh4KNo9DhFivzYYnL6GTGcytgmmP1uB/rfS0zGzjROEeks0E
        vmhgg8E8HK5B9CJnMeuwC1na6uDiR55UY3hnd6FkBvZE1y5DxyC22DbSkESHOUn7
        RE4vc8VXfYAuEVHHzYDt9o=
Received: from localhost.localdomain (unknown [120.243.49.111])
        by smtp14 (Coremail) with SMTP id EsCowADntPFnLq9hY61kAw--.50424S4;
        Tue, 07 Dec 2021 17:51:14 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     ulf.hansson@linaro.org, u.kleine-koenig@pengutronix.de,
        srinivas.pandruvada@linux.intel.com, pali@kernel.org,
        TheSven73@gmail.com, lznuaa@gmail.com, sensor1010@163.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/mmc/core/bus: Remove redundant driver match function
Date:   Tue,  7 Dec 2021 01:50:29 -0800
Message-Id: <20211207095029.96387-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADntPFnLq9hY61kAw--.50424S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWDCF48AFW7tw17JF1fWFg_yoW8JFW3pF
        ZxXFy2kryUKa13Z3s7CFWkuFySk3y8Kry0grW8K3sY9a17CrnrJFyvy34jyF98uFy5CF4S
        qryqvryrCFy8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uha9fUUUUU=
X-Originating-IP: [120.243.49.111]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhtiq1aD9jTE-gAAsh
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


