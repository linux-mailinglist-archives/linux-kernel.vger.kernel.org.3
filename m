Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA747ED11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351952AbhLXIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhLXIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:21:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262CC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:21:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l10so7090414pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=a8eS3YXB3+KjJDuEPWQLcX+HJOufYQaI4qZVeMqQu9o=;
        b=gVjzFGHhAzx0/FUF5skx3OxxeTTS/L9yKIQQQDnqhIZGkFRxiGa2wyabresrry4kWd
         CtI69HZxWPmRaSHjtcwKk6Q6EKwjGrBTWXcEBu7c+OD7pypxBMyH2FkmQJKmxZCnOSuj
         eK7RW2qAdPtabB5ZdSMiFKaEcqG/oWTd8+JvDszUPszMDGWYQA6OAytx6VjAFNeBaXxz
         PD2oQBN9J3LadXx+/u64o+X6GN3J4URkZvhWk6TnncvA4t2MCcJ4FceeY6M+6MhalsIN
         H6LP6F423xptsq7JxCfcXYRXeZSbg7NbKnnzeEIoi2K6Ccaoj53kqriC3g++RDnH0AhF
         yH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a8eS3YXB3+KjJDuEPWQLcX+HJOufYQaI4qZVeMqQu9o=;
        b=BSi8tLyqyEYIrHWppgmETtHm0xXE+mjIFRygTuiljaPgDB6r1WwrKEuwyF35nLEJmD
         wAL+1l45ibwvPnpYLNwO+nXvXZyNatjajOJ5T1if4tQXkfQD3OqvypdKWgQzSHjPSVUk
         eytgW0GMG7m1Lwn2IbMVCWV7rq/rdqvaAZIBqt33ci8EjqeJQOKbYrBwCVHwGE65uTAt
         p5fE2bCK5NHMAzuC+IKkPBg7Fddef0kGBPW3XerKK/pybxZtasmGMXPRzYXZ1ZlUtPgY
         TsPtG+ofhSO7ODuwUkpt97/GkYoAKXz8kupVF7A6TZJqQkeyFffICgxdaLThLrj6SbMR
         Yx8g==
X-Gm-Message-State: AOAM5314VFf73ibHDHqCkolN0UA3mks2tX6vhDhKg5ziYAmKpCfaYXxF
        XECj2ggG23gXlL/5EsfUiRk=
X-Google-Smtp-Source: ABdhPJwk6yXFazpg9bTL+8Bh6befkkI7lDWa9g9PRfY4jgrlEDehk1AK7OvGeVwPxLtA85dPiIStRA==
X-Received: by 2002:a63:920b:: with SMTP id o11mr5316856pgd.314.1640334069362;
        Fri, 24 Dec 2021 00:21:09 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a11sm6587453pgd.87.2021.12.24.00.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 00:21:09 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mediatek: Fix missing check in mtk_mipi_tx_probe
Date:   Fri, 24 Dec 2021 08:21:03 +0000
Message-Id: <20211224082103.7658-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_get_match_data() function may return NULL.
Add check to prevent potential null dereference.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 28ad9403c441..67b005d5b9e3 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -146,6 +146,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mipi_tx->driver_data = of_device_get_match_data(dev);
+	if (!mipi_tx->driver_data)
+		return -ENODEV;
 
 	mipi_tx->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mipi_tx->regs))
-- 
2.17.1

