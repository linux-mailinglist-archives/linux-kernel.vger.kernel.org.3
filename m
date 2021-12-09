Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14FC46E2D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhLIHD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhLIHD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:03:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A20C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:59:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so3200832plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RW5/PiePPwGEbHeQax2XMoMOzVE/w5j3urPprFU4xj4=;
        b=JVbv4a01GSr23DKUbNzvViDTbkroOUJ87xix4b42EFQaiFa1zGzPOWqcwlrYW5vgLP
         2ZGiJfe62HN460Hg51yFQcDuPG0SWbo/67FO3eJ1vwNyPZ+OeUXlPuupEXJAtnsZj0dS
         i2BZGWKeJrHSy0RM0ZGyNLL+bi05qB3ChyceA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RW5/PiePPwGEbHeQax2XMoMOzVE/w5j3urPprFU4xj4=;
        b=egy8VRC8IVQchdGF408lY6ywTWoNUx3dL0+ytIpz/kDOojI+7AIn90mQGDwZoqBvvI
         keHMH8Ja6o7NFnVnUtPcgC9I74ehOIIIKL/5ULYUmi480+ypE+KSjeeEk0CGJTf4IovT
         5lg/OczLVUepfBseRGVwHsE+FvkSIrRhh9AnlY6jGkRdyfBifDk/Ti0kItiouRZLutxZ
         I5ySumw0XhhqiXY6X+9RtomUBGPpM3eSSSEVnsaCYEgrLoEymsiZlY65exu0pT+phknA
         s/jyIfYmMi8WotUKOmSNZGD79C6MswZXrXWKYNxoMZKAwVBMAy3HmtPooDSEyh9Lq5/G
         oJxQ==
X-Gm-Message-State: AOAM532wOpeQ8+4RAj5xgNl/hLWDW175tPaz8x/WrBCln8fcKp3/Ym8G
        LB91MKyak66v0I9EryapUhwgLkIiCsMExg==
X-Google-Smtp-Source: ABdhPJxslNIMXLet9RCsdKQS4VcDTdk1MoI3qUUFLzT/WUMx1UA0lI3LnVvI7Nvbp4pNWZtW8vIZ2w==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr13483577pjb.7.1639033192843;
        Wed, 08 Dec 2021 22:59:52 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:bc93:a930:2121:8bed])
        by smtp.gmail.com with ESMTPSA id j4sm4463519pgp.58.2021.12.08.22.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:59:52 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mailbox: mtk-cmdq: Silent EPROBE_DEFER errors for clks
Date:   Thu,  9 Dec 2021 14:59:48 +0800
Message-Id: <20211209065948.1796663-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silent the error if it's EPROBE_DEFER for clks.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index a8845b162dbf..087fb7334166 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -573,7 +573,10 @@ static int cmdq_probe(struct platform_device *pdev)
 				cmdq->clocks[alias_id].id = clk_names[alias_id];
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
 				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
-					dev_err(dev, "failed to get gce clk: %d\n", alias_id);
+					dev_err_probe(dev,
+						PTR_ERR(cmdq->clocks[alias_id].clk),
+						"failed to get gce clk: %d\n",
+						alias_id);
 					return PTR_ERR(cmdq->clocks[alias_id].clk);
 				}
 			}
@@ -582,7 +585,8 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->clocks[alias_id].id = clk_name;
 		cmdq->clocks[alias_id].clk = devm_clk_get(&pdev->dev, clk_name);
 		if (IS_ERR(cmdq->clocks[alias_id].clk)) {
-			dev_err(dev, "failed to get gce clk\n");
+			dev_err_probe(dev, PTR_ERR(cmdq->clocks[alias_id].clk),
+				"failed to get gce clk\n");
 			return PTR_ERR(cmdq->clocks[alias_id].clk);
 		}
 	}
-- 
2.34.1.400.ga245620fadb-goog

