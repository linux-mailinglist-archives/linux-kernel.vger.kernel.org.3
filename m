Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB1547933
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 09:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiFLHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFLHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 03:33:35 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4005539811;
        Sun, 12 Jun 2022 00:33:31 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A63431E80D89;
        Sun, 12 Jun 2022 15:32:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D6JU9v0rtj7Y; Sun, 12 Jun 2022 15:32:27 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 56DFD1E80C8B;
        Sun, 12 Jun 2022 15:32:26 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        hukun@nfschina.com, qixu@nfschina.com, yuzhe@nfschina.com,
        renyu@nfschina.com, Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] ata: handle failure of devm_ioremap()
Date:   Sun, 12 Jun 2022 15:32:22 +0800
Message-Id: <20220612073222.18974-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the devm_ioremap(), the return value
could be NULL. Therefore it should be better to check it and
print error message, return '-ENOMEM' error code.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/ata/pata_pxa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 985f42c4fd70..cd1a8f37f920 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -228,6 +228,11 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
 
+	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr || !ap->ioaddr.bmdma_addr) {
+		dev_err(&pdev->dev, "failed to map ap->ioaddr\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * Adjust register offsets
 	 */
-- 
2.11.0

