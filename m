Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61A471906
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhLLHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhLLHNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:13:06 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54271C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:13:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so12428305pja.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qdg39eHfEjgfTHjVmWVrh1tDLpzFxy2xokCMGc3PcsM=;
        b=k3gIJKUwy6PhPyYIRiAOoO+2QlhuxvSstook8wMpjAFqsxJzN3Iaf/XhqG1zMP/b2v
         wK7z78hvfA9rSAjcsjd0wyi2apj6XnmEcPkKLXwkSgPYnpROwaK/OIp0R06TXT7y6AEE
         4FDx438DBGnNqU5r7uVNnXZcTB+YowFfJrvbcFVERYUooFp0HjjT3Xg5AnULrrm4Hc0y
         5mZklh9GiAtNLE5b2rwTr+BPB5UXXCcWlPGr8MraTic71t8lM7q0TnsV6yJKw0a/6naI
         v54bXnCuXPMsHxyfE2QoHAgEV+tKdrHj1uTTHtpt7s/XmgcLzmNeqA1+v0PhWX3tIokH
         dMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qdg39eHfEjgfTHjVmWVrh1tDLpzFxy2xokCMGc3PcsM=;
        b=W/LNQbzSAoNIy7hpVk0eQXaPnAdf9RZ5WyotEcV/H8FlWNa4ZBtWZfqeuo2JZlIWWy
         HVQGUTSFcqajvdaMjik1xbnolb+M388kFJQNrqgjqnxbGnhb1/P3g0qiPNGRMCfX7x8r
         inQrvsBF172UnOJj4zeeTR6HjVTOQy3CEuP0J//Gt8LsdL+1FijhLLSsrvtWufT6mrd1
         uQvoUl88GovvfIvKuTDuo/j5VSOmdbzvKgEugI8UraQh47EUdXFqtsAqfLEpsWVGRiWA
         nEJN57GHwz/+rMfBdgh6X4ckkL8YUj8gqeUpkvEqRDJd6ZhSHs32cf5W26hJCF3aK2S+
         Pumw==
X-Gm-Message-State: AOAM533Xml/mryWNll69Q1HV/JQRArZan95fOKLAfUV8ryGdmqtg9Pvd
        F9rmC6wlVRuyAd74GUpv27L6dbU2lhA45pcV+Wc=
X-Google-Smtp-Source: ABdhPJwMdHCo8kdfDCPsid7zLYY1GMC/QkpaujbeCrKtcCFxp3LBdGprlYeoUVeNjzVTR6Bj7s9P9A==
X-Received: by 2002:a17:903:2291:b0:142:b53:6e08 with SMTP id b17-20020a170903229100b001420b536e08mr87208497plh.10.1639293185825;
        Sat, 11 Dec 2021 23:13:05 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g1sm7740572pfu.73.2021.12.11.23.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 23:13:05 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: Fix NULL vs IS_ERR() checking in dma_init
Date:   Sun, 12 Dec 2021 07:13:01 +0000
Message-Id: <20211212071301.3011-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_ioremap_resource() function return error pointers.
The pktdma_get_regs() function does not return NULL, It return error
pointers too. Using IS_ERR() to check the return value to fix this.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/ti/knav_dma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 591d14ebcb11..9f82cf906949 100644
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
+	if (IS_ERR(dma->reg_tx_cha))
+		return PTR_ERR(dma->reg_tx_cha);
 
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

