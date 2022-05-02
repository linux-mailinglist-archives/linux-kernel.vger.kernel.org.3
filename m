Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6B516D48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiEBJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiEBJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:26:37 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1814090
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:23:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 46C81419BC;
        Mon,  2 May 2022 09:23:04 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] iommu: dart: Add missing module owner to ops structure
Date:   Mon,  2 May 2022 18:22:38 +0900
Message-Id: <20220502092238.30486-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to make loading this as a module work.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad08..a10a73282014 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -773,6 +773,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.get_resv_regions = apple_dart_get_resv_regions,
 	.put_resv_regions = generic_iommu_put_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
+	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev,
 		.detach_dev	= apple_dart_detach_dev,
-- 
2.35.1

