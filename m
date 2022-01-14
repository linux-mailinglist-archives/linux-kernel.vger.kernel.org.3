Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA37048E43F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiANG2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiANG2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:28:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB62CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:28:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m13so12557826pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=NHdX/Idy0KSD2nLQQy9QrFMUow7MTGBG5BMRWRzqKuQ=;
        b=pezoYFhDt474cgpvwzLmfLq36Go0YbSUqzB51UNhKvFun3Y9jKS9NcpnB6Q/RtSDeE
         K6COUJUvl2OfMbc2SWx6Mmys/6sP5A+m5mqXlvCTOg/epVYuoYEPYW/w66KP22U+m5rL
         8rkOq4R7zE16I9nFwGl38p09fDxZRHNzQTKJsBN2Us7FTkrK6MgUuVUHfsXEMrUD/zR7
         CKWIVwbRR33NGPSjln4HtgkNivJ8bbiT9KMsVCPCUjCULXCnJLdBt/DwcxklMzdxgXXZ
         dy7gImPjDMuS362wQF7Vo3zgxdJQmyinjOWAawjh5l0BPTpfenJlvDlTtl9Ug07Dn7pO
         2XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NHdX/Idy0KSD2nLQQy9QrFMUow7MTGBG5BMRWRzqKuQ=;
        b=r1aMA3lqngHxrC5wXHQjcFItDnJ6uRYueB7Ob0M0CGBqatR1aVLVBJGYcxUf3xQG2m
         zFj6ZWM9LT9LJdCl3UvpTaPym1CGAuMUMokyZiSskYJ+Bhf8wS3wIZfGu72nAo3k8Vfj
         qq6OvnLUgLVxIC+MDP9oxWSY0Sf/QuuG3vyw+/mXePE1s+1bLVp7cPJ+vQloxJEjIbeu
         4er0TenZ2ks1BndbrBgdcBphssBTEu4OazzB3Ca1efgQhR9G9SdjCw9gNhCvTvEUVlfL
         xCQFWIKoADNHeXsUUnDSThoKSgV+riklwe/6w5PdTblLEqa/KN8JAF/jShwvIQOVrGXY
         RyIA==
X-Gm-Message-State: AOAM5312/OlfTmm8tRDilCuukJGDXJ0pa+4i2xHih6GwLNTKaMbUMxLt
        d30g1K27vV8u7UviU5TaE5E=
X-Google-Smtp-Source: ABdhPJzTCERieBADXgI0ocsue7F2NLdXSjQ9ctZymjodYFfhCh9umta1NfjscP6PU8LRgGVxF8SXwA==
X-Received: by 2002:a17:90b:1c91:: with SMTP id oo17mr18602407pjb.58.1642141725333;
        Thu, 13 Jan 2022 22:28:45 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ng7sm4612262pjb.41.2022.01.13.22.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:28:45 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
Date:   Fri, 14 Jan 2022 06:28:40 +0000
Message-Id: <20220114062840.16620-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: cdd5de500b2c ("soc: ti: Add wkup_m3_ipc driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 72386bd393fe..2f03ced0f411 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -450,9 +450,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		return PTR_ERR(m3_ipc->ipc_mem_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource\n");
-		return -ENXIO;
+		return irq;
 	}
 
 	ret = devm_request_irq(dev, irq, wkup_m3_txev_handler,
-- 
2.17.1

