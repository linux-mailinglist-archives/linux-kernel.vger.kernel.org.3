Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B247DFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhLWHy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:54:59 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:58467 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbhLWHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:54:44 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0IvynZt01wEZf0Ivyn1UuC; Thu, 23 Dec 2021 08:54:42 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 23 Dec 2021 08:54:42 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] soc: qcom: llcc: Use devm_bitmap_zalloc() when applicable
Date:   Thu, 23 Dec 2021 08:54:41 +0100
Message-Id: <3ee83f75afa8754fade4fff6a03b57f0ae3ccc28.1640245993.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'drv_data->bitmap' is a bitmap. So use 'devm_bitmap_zalloc()' to simplify
code, improve the semantic.

This also fixes a spurious indentation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/qcom/llcc-qcom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index ec52f29c8867..00274a93406b 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -632,9 +632,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_banks; i++)
 		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
 
-	drv_data->bitmap = devm_kcalloc(dev,
-	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
-						GFP_KERNEL);
+	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
+					      GFP_KERNEL);
 	if (!drv_data->bitmap) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.32.0

