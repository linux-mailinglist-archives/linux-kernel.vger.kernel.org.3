Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2764B1713
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbiBJUmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbiBJUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:42:38 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374F108D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:42:37 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,359,1635199200"; 
   d="scan'208";a="5603087"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 21:42:33 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     kernel-janitors@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] pata_mpc52xx: use GFP_KERNEL
Date:   Thu, 10 Feb 2022 21:42:19 +0100
Message-Id: <20220210204223.104181-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220210204223.104181-1-Julia.Lawall@inria.fr>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform_driver probe functions aren't called with locks held
and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.

Problem found with Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/ata/pata_mpc52xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index c1b138d24b05..a2a3a95c71ed 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -736,7 +736,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	}
 
 	/* Prepare our private structure */
-	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_ATOMIC);
+	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		rv = -ENOMEM;
 		goto err1;

