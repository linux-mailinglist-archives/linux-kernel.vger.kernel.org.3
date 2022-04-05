Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53284F4897
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiDEVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383908AbiDEPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:14:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EB9B176D23
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:27:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D57D6E;
        Tue,  5 Apr 2022 06:27:58 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24DE73F5A1;
        Tue,  5 Apr 2022 06:27:58 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     iommu@lists.linux-foundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: emu10k1: Stop using iommu_present()
Date:   Tue,  5 Apr 2022 14:27:54 +0100
Message-Id: <9b506b4a4fe8a7f40aa8bad1aafc82426cf3dd92.1649165210.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_get_domain_for_dev() is already perfectly happy to return NULL
if the given device has no IOMMU. Drop the unnecessary check in favour
of just handling that condition appropriately.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Get "!domain" condition right

 sound/pci/emu10k1/emu10k1_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 86cc1ca025e4..3880f359e688 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1751,11 +1751,8 @@ static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
 
 	emu->iommu_workaround = false;
 
-	if (!iommu_present(emu->card->dev->bus))
-		return;
-
 	domain = iommu_get_domain_for_dev(emu->card->dev);
-	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
 	dev_notice(emu->card->dev,
-- 
2.28.0.dirty

