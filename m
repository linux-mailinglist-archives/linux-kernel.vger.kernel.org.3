Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0708047DBAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbhLWAWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345454AbhLWAWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8628DC061401;
        Wed, 22 Dec 2021 16:22:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v16so3603550pjn.1;
        Wed, 22 Dec 2021 16:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DknGyPcGjNy3srT0IigmczMVpbDaJUX0db4clA7nVyE=;
        b=QxfW+YUo9bh17Swjkq0zfV9nRzqa+6MeWsmnb00FFEZs5uI2lLJ3EkzIrANj6bcSUl
         c5+jLzpvHhIxlOWm0akQNmgBAmTIio5TXxTf3XGidCVA6qAA3IjUilqlbdrrxzUuWkUv
         PmZsW9jvdLZJ2PZrg7CbyXIWCAQskyUTO6rHDvTUbi9v7fi7nBeDNtxgKcsePdo6Dc7J
         T0lnyiO9padNcOdNawQqcKEOLZO2EZ8xG7D9CI0M4FFpWeHC9BwetVt5Us2H4MXxe7z7
         6deM+2JSNcPSW/IN4Gy1+b9nIPz4JcGzqvKOt7RjqIPawe6xyeUATroXMcFD8Ra42/d0
         UkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DknGyPcGjNy3srT0IigmczMVpbDaJUX0db4clA7nVyE=;
        b=5v4vYNNobgSNcAjntM3NdpLQG76hp8Tzh6phVJs9vEwnbc5YxsVsYenIx6FTcQSnzJ
         4SlU1hAn/1ZnreW+lEp7yNLJfC53ITX4nVC4ZDtXRBahW2NMI6oUiC0iviu08dBCgFlT
         ah9TpOs1Uz362FEVNCY23j6l0bgzi5JnmKTu4Sj7u3twteUaB+XqIHpUQJQV6HfLNU2d
         Mni/T2ZTEc7XcnVkt43odMubf/RPxJxSExmo9Syl2NdNNrcwrCxT87qSVhJkYFcuRJaE
         1AVw7ji5kmIqkQDX6Aoj29A/4hCr3TaEoXeoQTpc6IBa4jvvPhfY+W5RkeAYJb3gKo1P
         wJzg==
X-Gm-Message-State: AOAM530KGZPm0KmYbcI+U0cDIA6NI42zJgBMMgymzhW6g057xuOCoSDi
        5wtlz7ZfWYl5t3dgNozJQgA=
X-Google-Smtp-Source: ABdhPJyWP5a3vUVMkg6PgbOpBWjwpnAx/lSUHLsZXUV83dbGPFKmgEnhKi29+REeORMYHIDI8QR2og==
X-Received: by 2002:a17:902:d682:b0:148:c928:1fa1 with SMTP id v2-20020a170902d68200b00148c9281fa1mr4949461ply.155.1640218955024;
        Wed, 22 Dec 2021 16:22:35 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:34 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: [PATCH 2/9] mtd: rawnand: brcmnand: Assign soc as early as possible
Date:   Wed, 22 Dec 2021 16:22:18 -0800
Message-Id: <20211223002225.3738385-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to key off the brcmnand_probe() code in subsequent changes
depending upon ctlr->soc, assign that variable as early as possible,
instead of much later when we have checked that it is non-NULL.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 7a1673b1b1af..fcea5a7443e8 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -3008,6 +3008,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 	dev_set_drvdata(dev, ctrl);
 	ctrl->dev = dev;
+	ctrl->soc = soc;
 
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
@@ -3148,8 +3149,6 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	 * interesting ways
 	 */
 	if (soc) {
-		ctrl->soc = soc;
-
 		ret = devm_request_irq(dev, ctrl->irq, brcmnand_irq, 0,
 				       DRV_NAME, ctrl);
 
-- 
2.25.1

