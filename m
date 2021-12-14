Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6827E473A81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbhLNB4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbhLNB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:56:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42BEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 17:56:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so12492458plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 17:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qd49u8wZsRuwLaXyCJuNAMzGQxG0yqJmrsLKRB+38eQ=;
        b=hyAocIG8TqYW+LyROpSx3OS+R3VKabbtaVBhPL6RMHb+2J5l9dpsYLu4/gvvtBODTq
         R9u12IrAh7st+x+iqTPpefzkqKfeLDwxU7/dxDaroXSIWiB+W+LUDHL/5V6Gt/jYe3O/
         rHOYgKtpDpVP6GEcZpVNDe2U2TpoEEf+HW4yNREEc14tHXvLWv4z9hh698tDEsDazvkJ
         iVQARizsD1JFZRVQtfAtvTRwtgP6C+dcUMKpJ+PAI/Y1cPMaviZSuEqNqf6trpw2QbPW
         0JR/EtOQza2UY8WvDHzjUJhgssTOjUBpVvwM5HhB1mgZZtFSDt8/mwcFM7JrwGwiEhSx
         7q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qd49u8wZsRuwLaXyCJuNAMzGQxG0yqJmrsLKRB+38eQ=;
        b=GgN/5q3WkFWamQ7GVFz3N5CzLd0WP2/CEMWyFLTXVQidI/xjXtXqOVjbA99CqYdk0n
         hQtK5EEsPNshhUC5UdhuFTmtLO2iEYvnsTx0WEoCKLbr9qhLQoh4WmZjpSzxDiS8pTs3
         MiEni8+qxR6MgdCGs0Nj2aoIgDulZ6hKTUwU6mfX/cz9BpYVRSPlnNkPwr91ngC1bXoR
         77inCn4jAOHnqFJVnxKcurnBJvlj7tim2qHlAL7l8p4Wtap7/jSpNSaDpxrUvSFHF6ZR
         iWr2FfOgc+VOt91PRIQBz2FAvnrSxRNSnRK4wuYubVMXBt7kXNMpLzVcfGQUO1nzFpCJ
         mdxA==
X-Gm-Message-State: AOAM5303NMC9/L7gKdwRyE6R/JxNXxkjKInoRC9QO3WqUJI0wh905/G4
        RhuiyThyopHJqOsqV9dIo3heBH09M4qYVzXWz74=
X-Google-Smtp-Source: ABdhPJzIiabpGW2GfeqGi2N6EBXjHWbYQi37VWQIxET8e8I08a4riu7TZlH6x0UE2OO3RAmRej+XtQ==
X-Received: by 2002:a17:90b:4c8d:: with SMTP id my13mr2208298pjb.107.1639446960391;
        Mon, 13 Dec 2021 17:56:00 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x1sm11136063pgh.1.2021.12.13.17.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:56:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     nm@ti.com
Cc:     linmq006@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ssantosh@kernel.org
Subject: [PATCH v2] soc: ti: Fix NULL vs IS_ERR() checking in dma_init
Date:   Tue, 14 Dec 2021 01:55:44 +0000
Message-Id: <20211214015544.7270-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211213155930.mcxlc5m3niqh77xi@annotate>
References: <20211213155930.mcxlc5m3niqh77xi@annotate>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_ioremap_resource() function return error pointers.
The pktdma_get_regs() function does not return NULL, It return error
pointers too. Using IS_ERR() to check the return value to fix this.
---
Changes in v2:
fix wrong variable name.
---
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/ti/knav_dma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 591d14ebcb11..700d8eecd8c4 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -646,31 +646,31 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	}
 
 	dma->reg_global	 = pktdma_get_regs(dma, node, 0, &size);
-	if (!dma->reg_global)
-		return -ENODEV;
+	if (IS_ERR(dma->reg_global))
+		return PTR_ERR(dma->reg_global);
 	if (size < sizeof(struct reg_global)) {
 		dev_err(kdev->dev, "bad size %pa for global regs\n", &size);
 		return -ENODEV;
 	}
 
 	dma->reg_tx_chan = pktdma_get_regs(dma, node, 1, &size);
-	if (!dma->reg_tx_chan)
-		return -ENODEV;
+	if (IS_ERR(dma->reg_tx_chan))
+		return PTR_ERR(dma->reg_tx_chan);
 
 	max_tx_chan = size / sizeof(struct reg_chan);
 	dma->reg_rx_chan = pktdma_get_regs(dma, node, 2, &size);
-	if (!dma->reg_rx_chan)
-		return -ENODEV;
+	if (IS_ERR(dma->reg_rx_chan))
+		return PTR_ERR(dma->reg_rx_chan);
 
 	max_rx_chan = size / sizeof(struct reg_chan);
 	dma->reg_tx_sched = pktdma_get_regs(dma, node, 3, &size);
-	if (!dma->reg_tx_sched)
-		return -ENODEV;
+	if (IS_ERR(dma->reg_tx_sched))
+		return PTR_ERR(dma->reg_tx_sched);
 
 	max_tx_sched = size / sizeof(struct reg_tx_sched);
 	dma->reg_rx_flow = pktdma_get_regs(dma, node, 4, &size);
-	if (!dma->reg_rx_flow)
-		return -ENODEV;
+	if (IS_ERR(dma->reg_rx_flow))
+		return PTR_ERR(dma->reg_rx_flow);
 
 	max_rx_flow = size / sizeof(struct reg_rx_flow);
 	dma->rx_priority = DMA_PRIO_DEFAULT;
-- 
2.17.1

