Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6E46F25E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhLIRq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbhLIRqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:46:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E384C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:42:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso4694182wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqWJya3SDVpVN32LUNzQ9Fq3bSZ9N3SlFqE6pDKhDDA=;
        b=hxqcPbm+gyqnYGcO24u37W1ydoIMbW2jza/PvvDGGqrmABjiIzz+v0jgVUMtx4OLfC
         KcYKg1hfg7LAggGTm0NJ3fdW09EpcCd7wLZ3KEHJ42JiJ0O522W+lSFBCg4QRI+2QR8R
         2M8oW4rcsz5LhKHqtI60VZr888X7LXeGMJkMHhCnqUzugXlIi3f7hWv0wUo+QszAEija
         2aDT7UJOW5vKkF/z0XKWiF+4HY2+RCpaY4BUUKOFRB/VKKG0pCVCeCbS1ST/Xp9r+7t6
         gStT16zZgDtPHCJbnmWryK3lV5k0hin29uCmMSEBD2WVPK6/9zwzMewGbRlNGv0SpE/q
         AC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqWJya3SDVpVN32LUNzQ9Fq3bSZ9N3SlFqE6pDKhDDA=;
        b=SFCtokHdkv0fdcJIWoGwEvwnrlaEZVSJAGewARZHK68R+KGbW40NxWnPCdpAsD4ZZk
         CHGGp+4odQPeORz4A5a1AFewJnNZGY8hdrLL5ebkK15uh8uK6jOXvJtGquu6R9f72NNW
         TEAaQMgrpB5r+voqY4Sg+Cm/Bd0gFv9+SAtvWupLNsf2xWI3hM9/YJa8b1WPGDe9ukS3
         U5GPnYQ1u7P8NVqeOrxwg3nnyFfrm7QgkBT+1lMmWAoEU+YPj7UnEa2M9OVFdVIifYXy
         cDzaHzZJoxUSSk//vPF1/e4YQMYJ59T5Qod64kHhWDA9QGAuahyiCaWueR7OhK9WibCd
         ruCg==
X-Gm-Message-State: AOAM5314DCOBYih7LqXGfGSPPv7Pa/LAJ3KzStR/J9nKNQ5m2Bzwt8A2
        M4YfufP/uRnj2ABc24HCYpkpLg==
X-Google-Smtp-Source: ABdhPJxk1M63/7OOt1pvU2BnD2KEO7MCWz57OB2IgBbBSReC+AQj4SppqONrRzKvx0yUVXchO0ME7Q==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr9154291wmq.109.1639071769036;
        Thu, 09 Dec 2021 09:42:49 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id w4sm308666wrs.88.2021.12.09.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:42:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] nvmem: mtk-efuse: support minimum one byte access stride and granularity
Date:   Thu,  9 Dec 2021 17:42:34 +0000
Message-Id: <20211209174235.14049-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
References: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

In order to support nvmem bits property, should support minimum 1 byte
read stride and minimum 1 byte read granularity at the same time.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 6a537d959f14..e9a375dd84af 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -19,11 +19,12 @@ static int mtk_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
 	struct mtk_efuse_priv *priv = context;
-	u32 *val = _val;
-	int i = 0, words = bytes / 4;
+	void __iomem *addr = priv->base + reg;
+	u8 *val = _val;
+	int i;
 
-	while (words--)
-		*val++ = readl(priv->base + reg + (i++ * 4));
+	for (i = 0; i < bytes; i++, val++)
+		*val = readb(addr + i);
 
 	return 0;
 }
@@ -45,8 +46,8 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	econfig.stride = 4;
-	econfig.word_size = 4;
+	econfig.stride = 1;
+	econfig.word_size = 1;
 	econfig.reg_read = mtk_reg_read;
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
-- 
2.21.0

