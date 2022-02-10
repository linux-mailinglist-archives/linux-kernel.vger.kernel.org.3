Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461034B1714
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbiBJUmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:42:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbiBJUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:42:38 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A55F109B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:42:38 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,359,1635199200"; 
   d="scan'208";a="5603089"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 21:42:33 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] media: fsl-viu: use GFP_KERNEL
Date:   Thu, 10 Feb 2022 21:42:20 +0100
Message-Id: <20220210204223.104181-7-Julia.Lawall@inria.fr>
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
 drivers/media/platform/fsl-viu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index a4bfa70b49b2..afc96f6db2a1 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1407,7 +1407,7 @@ static int viu_of_probe(struct platform_device *op)
 	}
 
 	/* Prepare our private structure */
-	viu_dev = devm_kzalloc(&op->dev, sizeof(struct viu_dev), GFP_ATOMIC);
+	viu_dev = devm_kzalloc(&op->dev, sizeof(struct viu_dev), GFP_KERNEL);
 	if (!viu_dev) {
 		dev_err(&op->dev, "Can't allocate private structure\n");
 		ret = -ENOMEM;

