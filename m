Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A23481A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhL3H16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhL3H15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:27:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A243C061574;
        Wed, 29 Dec 2021 23:27:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id l10so20787148pgm.7;
        Wed, 29 Dec 2021 23:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RKI4ET+iCqJlA6R62xSNDJorzIrtHu2cmC4OCM8LiWw=;
        b=NDpX5ELcjr1P9wcmuoV6GhzJFItimAOMX1lisYxg3e34EwvBr2khPJ3CMxYU0/ZfH7
         d4qv0WfoUlfwjamMLZY29u9rUrkkibqm8NmO6geAFZ7aWw5FPD9CoSy2ck9tUOh0Tsz/
         iS/FdJS/2U7/8IfDI4fn0SnCh8feZM/yzSsPAs+QQqJ+nHWmr8uIC/14IpGKczPHoJ8k
         C4Zjn1MTPygXKHVbUbYdVmRwl5t2Gq6tRspTtxITsVZO11p5DdEjexK+5Ww+WdcMaOiR
         oViQYxxNY2ISYHIYKR53+oaytrGGlBt7k8/BTjJFDfXzb/J1Nxvh2Vd2CZe4uTRH9hX7
         hubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RKI4ET+iCqJlA6R62xSNDJorzIrtHu2cmC4OCM8LiWw=;
        b=Vc5A9mIIgZ4L536rFXTaTX3bITIaCkD0DlCffHjGyP2GKdbnUTKH1otQPH1+9w6H11
         u8s2uOcnWG79PAYMhS0F4M02bmWd7XGBrTl1MFPfrh0sJlbzxr9ac3pq2N2YZAQ7OoHx
         7Jm3u56ZmP9mcRaPevBHBo2vpN6V+GamZ9jWRRdSpD+fyYEG7jW5kNQwKypT69cp8GkU
         MW5RB4+XGEi1JqaoXgvu6OjayGvhZ0KGQYJBxzNgpDv3Uj0H6xIFBrl5bLSp3clNthN5
         N8pLpo8Ks3s7OYcefVi7bIO/nmdGI530W5g6UUOv5/SelbFL2ob5yVzBcjvsA9tLwwlK
         6gsw==
X-Gm-Message-State: AOAM530RDc5fmpo7DXGlX0U9L7X4V9QaH/JxVWSM1Rpxl2s9D0V7UYQy
        cU2/tTMPzxpfrhNMd4ZmJvk=
X-Google-Smtp-Source: ABdhPJxbUBHp+gZYhLfCCG6ZTBRD2ffqyoCqNOtymjfmXL2VINZ0mDSsUZgwsx1JYKCNkmbZGl8EkQ==
X-Received: by 2002:a63:330a:: with SMTP id z10mr4950887pgz.350.1640849276683;
        Wed, 29 Dec 2021 23:27:56 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id e24sm27176161pjt.45.2021.12.29.23.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 23:27:56 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: ingenic: Fix missing put_device in ingenic_ecc_get
Date:   Thu, 30 Dec 2021 07:27:51 +0000
Message-Id: <20211230072751.21622-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node() succeeds, ingenic_ecc_get() doesn't have
a corresponding put_device(). Thus add put_device() to fix the exception
handling.

Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index efe0ffe4f1ab..9054559e52dd 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -68,9 +68,14 @@ static struct ingenic_ecc *ingenic_ecc_get(struct device_node *np)
 	struct ingenic_ecc *ecc;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
 	ecc = platform_get_drvdata(pdev);
 	clk_prepare_enable(ecc->clk);
 
-- 
2.17.1

