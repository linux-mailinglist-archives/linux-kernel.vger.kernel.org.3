Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8AF4AAA69
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380555AbiBERLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:11:05 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:59562 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380548AbiBERLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:11:04 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id GOaSngReQxHdTGOaSnEh5w; Sat, 05 Feb 2022 18:11:02 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 05 Feb 2022 18:11:02 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
Date:   Sat,  5 Feb 2022 18:10:59 +0100
Message-Id: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_array()/kcalloc() should be used to avoid potential overflow when
a multiplication is needed to compute the size of the requested memory.

So turn a devm_kzalloc()+explicit size computation into an equivalent
devm_kcalloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is NOT compile tested.
I don't have the needed cross compiling tools.
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6dc6d8b6b368..14d06aad0726 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2981,10 +2981,10 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 {
 	unsigned int i;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	size_t size = sizeof(*cfg->l1_desc) * cfg->num_l1_ents;
 	void *strtab = smmu->strtab_cfg.strtab;
 
-	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
+	cfg->l1_desc = devm_kcalloc(smmu->dev, cfg->num_l1_ents,
+				    sizeof(*cfg->l1_desc), GFP_KERNEL);
 	if (!cfg->l1_desc)
 		return -ENOMEM;
 
-- 
2.32.0

