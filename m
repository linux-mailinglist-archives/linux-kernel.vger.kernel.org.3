Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7E47F854
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhLZQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 11:56:14 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:56381 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLZQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 11:56:13 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1WoWnyraJ3ptZ1WoXnZEua; Sun, 26 Dec 2021 17:56:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Dec 2021 17:56:12 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au, gregkh@linuxfoundation.org
Cc:     linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] fsi: Aspeed: Fix a potential double free
Date:   Sun, 26 Dec 2021 17:56:02 +0100
Message-Id: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
there will be a double free().

Remove the 'release' function that is wrong and unneeded.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely theoretical. It looks good to me, but there is a
little too much indirections for me. I'm also not that familiar with
fixing issue related to 'release' function...

... So review with care :)
---
 drivers/fsi/fsi-master-aspeed.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 8606e55c1721..4a745ccb60cf 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -373,14 +373,6 @@ static int aspeed_master_break(struct fsi_master *master, int link)
 	return aspeed_master_write(master, link, 0, addr, &cmd, 4);
 }
 
-static void aspeed_master_release(struct device *dev)
-{
-	struct fsi_master_aspeed *aspeed =
-		to_fsi_master_aspeed(dev_to_fsi_master(dev));
-
-	kfree(aspeed);
-}
-
 /* mmode encoders */
 static inline u32 fsi_mmode_crs0(u32 x)
 {
@@ -603,7 +595,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "hub version %08x (%d links)\n", reg, links);
 
 	aspeed->master.dev.parent = &pdev->dev;
-	aspeed->master.dev.release = aspeed_master_release;
 	aspeed->master.dev.of_node = of_node_get(dev_of_node(&pdev->dev));
 
 	aspeed->master.n_links = links;
-- 
2.32.0

