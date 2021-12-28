Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAAB480D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhL1Una (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:43:30 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:63325 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhL1Un2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:43:28 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 2JJbn9APaw2Xx2JJbnvI6T; Tue, 28 Dec 2021 21:43:24 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 28 Dec 2021 21:43:24 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sre@kernel.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] power: supply: ab8500: Fix the error handling path of ab8500_charger_probe()
Date:   Tue, 28 Dec 2021 21:43:22 +0100
Message-Id: <24a8b7e7b7b8f9f4b8eaad6707f420d55fd10aac.1640722789.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit below, ab8500_bm_of_remove() needs to be called after a
successful ab8500_bm_of_probe() call.
This commit has only updated the remove function.

Fix the error handling path of the probe the same way.

Fixes: 6252c706cdb0 ("power: supply: ab8500: Standardize operating temperature")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
For a better understanding, maybe, the ab8500_bm_of_remove() call in the
remove function should be moved at the bottom of the function, so that
resources are freed in reverse order than allocation.
I've not looked in details if the position of this call was important or
not, though.
---
 drivers/power/supply/ab8500_charger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index db7457064a17..ce074c018dcb 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3665,11 +3665,13 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 	if (!match) {
 		dev_err(dev, "no matching components\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto remove_ab8500_bm;
 	}
 	if (IS_ERR(match)) {
 		dev_err(dev, "could not create component match\n");
-		return PTR_ERR(match);
+		ret = PTR_ERR(match);
+		goto remove_ab8500_bm;
 	}
 
 	/* Notifier for external charger enabling */
@@ -3710,6 +3712,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	if (!di->ac_chg.enabled)
 		blocking_notifier_chain_unregister(
 			&charger_notifier_list, &charger_nb);
+remove_ab8500_bm:
+	ab8500_bm_of_remove(di->usb_chg.psy, di->bm);
 	return ret;
 }
 
-- 
2.32.0

