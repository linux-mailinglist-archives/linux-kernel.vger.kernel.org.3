Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF2488993
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiAINVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:21:49 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:54338 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiAINVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:21:48 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6Y8inCULaUujj6Y8inIUhA; Sun, 09 Jan 2022 14:21:46 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 09 Jan 2022 14:21:46 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Guenter Roeck <linux@roeck-us.net>, linux-fsi@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2] fsi: Aspeed: Fix a potential double free
Date:   Sun,  9 Jan 2022 14:20:35 +0100
Message-Id: <3b5c9b693749a956b525c54bed0eeac9f958b8e8.1641734402.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A struct device can never be devm_alloc()'ed.
Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
embedded in "struct fsi_master_aspeed".

Since "struct device" is embedded, the data structure embedding it must be
released with the release function, as is already done here.

So use kzalloc() instead of devm_kzalloc() when allocating "aspeed".
This prevent a potential double free().

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Keep the release function which is correct
    s/devm_kzalloc()/kzalloc()/ instead
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 8606e55c1721..ae6319818b14 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -542,7 +542,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	aspeed = devm_kzalloc(&pdev->dev, sizeof(*aspeed), GFP_KERNEL);
+	aspeed = kzalloc(sizeof(*aspeed), GFP_KERNEL);
 	if (!aspeed)
 		return -ENOMEM;
 
-- 
2.32.0

