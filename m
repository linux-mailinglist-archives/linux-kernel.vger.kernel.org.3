Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4547F756
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhLZOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 09:46:25 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:56414 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhLZOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:46:24 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1UmzniXWu1UGB1UmznOQIQ; Sun, 26 Dec 2021 15:46:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Dec 2021 15:46:22 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de,
        maz@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] irqchip/loongson-pch-ms: Use bitmap_free() to free bitmap
Date:   Sun, 26 Dec 2021 15:46:21 +0100
Message-Id: <0b982ab54844803049c217b2899baa59602faacd.1640529916.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() and bitmap_free() are the same. But using the latter is more
consistent when freeing memory allocated with bitmap_zalloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 32562b7e681b..e3801c4a77ed 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -241,7 +241,7 @@ static int pch_msi_init(struct device_node *node,
 	return 0;
 
 err_map:
-	kfree(priv->msi_map);
+	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
 	return ret;
-- 
2.32.0

