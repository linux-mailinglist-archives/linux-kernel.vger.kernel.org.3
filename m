Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DB551C28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbiFTNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbiFTNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBA1CB03
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766A5614B7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52581C3411C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730297;
        bh=Qnd30xLbHWpEXnWs2RaAiS2lqOyRh7RqX9ddq1Osy94=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f6x4bW8PVl7fu80D6/apXBCFKvQyBUcm2A9SMvaqEWiusIAhGGNs3XiigQnl/vLYZ
         TaKHnEovZ5cTSYzP8++5bErfF9EappWv0PS9BU/wYYWDp9BxAGh7z0QM3KEWT+Sy2F
         wkq+4xc9oJVX09/8OUyRbejssl5z1YntEDGtR3WPr1wxxqBLctXr8H4TbIxM1qjvbS
         HU3YkzwXUR/MyRLxfTUOivSS9j7aGgl8qnejBRUJ1Kim5g46ivVvJoMVmNKzsnhzMp
         q9MNFJcGO7NBkZ6AFPMV1eUw1HUEoV+rHt45Nfw8jySH9kFEkYP2O9sjYYeAx5JJCO
         mrNaDgPTWiLJQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] habanalabs: use kvcalloc when possible
Date:   Mon, 20 Jun 2022 16:04:31 +0300
Message-Id: <20220620130432.1180451-16-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvcalloc is same as kvmalloc_array with GFP_ZERO.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index ad4b49281cd7..8a40de4a4761 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -393,9 +393,8 @@ static int hl_mmu_v1_init(struct hl_device *hdev)
 		goto err_pool_add;
 	}
 
-	hdev->mmu_priv.dr.mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
-						prop->mmu_hop_table_size,
-						GFP_KERNEL | __GFP_ZERO);
+	hdev->mmu_priv.dr.mmu_shadow_hop0 = kvcalloc(prop->max_asid, prop->mmu_hop_table_size,
+										GFP_KERNEL);
 	if (ZERO_OR_NULL_PTR(hdev->mmu_priv.dr.mmu_shadow_hop0)) {
 		rc = -ENOMEM;
 		goto err_pool_add;
-- 
2.25.1

