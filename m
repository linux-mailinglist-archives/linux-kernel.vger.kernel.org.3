Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F5146A262
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhLFRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:11:24 -0500
Received: from m12-14.163.com ([220.181.12.14]:55071 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232440AbhLFRLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:11:10 -0500
X-Greylist: delayed 938 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 12:11:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ISpq1
        2h2tAgssCIwFhIXUVwxi3MwhuluNuOU4UTCL0w=; b=hhaSkzOHly3jPbErM4kgE
        W7JxsYp3Wd5XWZpQlQ0OjE0Lw/oAf/dd5a2G5ZjeO9fJwfoXAXnX+rR/dIAG2CtD
        OqTFHJqbLH37xH9W1t65XJo7pOjDEjy+J2WsHjy+/n3krICP7v6SDQh0KVur26TC
        BbNukDZXcLzXqW7HmGb4GE=
Received: from localhost.localdomain (unknown [120.243.49.111])
        by smtp10 (Coremail) with SMTP id DsCowABHFYpgP65hf6IbAw--.21815S4;
        Tue, 07 Dec 2021 00:51:14 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     ulf.hansson@linaro.org, u.kleine-koenig@pengutronix.de,
        srinivas.pandruvada@linux.intel.com, pali@kernel.org,
        TheSven73@gmail.com, lznuaa@gmail.com, sensor1010@163.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/mmc/core/bus: Delete redundant match function
Date:   Mon,  6 Dec 2021 08:50:38 -0800
Message-Id: <20211206165038.123107-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABHFYpgP65hf6IbAw--.21815S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF45Cr13Xw1kXw45Aw4fKrg_yoW8Xr4DpF
        43XFyIyFyqka15G3srCa1kuFya9w48K34kKrW8G3sY9a15uryDXFyvyw4Yy3s8uFy0kF4I
        y34qqryrCayUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U35rsUUUUU=
X-Originating-IP: [120.243.49.111]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiuANhq1QHN2B1XwAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	When the device and device driver are matching,
	if the device or the bus to which the device driver belongs
	does not provide a match function,
	then the device and device driver arae matched by default.

	function 'driver_match_device' illustrates this mechanism,
	because the return value of 'mmc_bus_match' is 1,
	even if this function is not provided, the function
	'driver_match_device' still returns 1,

	so function 'mmc_bus_match' is redundant.

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

