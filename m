Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37750496DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiAVT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40522 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiAVT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 514BCCE09FD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D765BC004E1;
        Sat, 22 Jan 2022 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881459;
        bh=YEsu479Ju5sKr+9zSTHVFhOpWucLf2lsIgvvBqJ7KMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCiM70bNJZSMNAoT3alW/u1FBxQMCYeGAkYGEIMwanHiY3TIKGmsO7nyGvtABvEU0
         ecOP3AL5Gyim14UEy41r9QBknGpzhNIS2wxV+1eJDuzMittP0rBLBE2eOi8BQH7rLF
         7xz3l1ynvmo0ys8MB/TyCBVVCs3JLerSvqTeSEgjfSlRSb3Cpau4HNBxflv4yojbuV
         YhtYagFa1Ubr6Ul9QPQv7qA5i1Xe4p0rekB+++IXrnraWU0nsmLU5wJhvA0cUB2EIV
         fTC87M3c+1ffpcXGwQmdOrAcH20DdUMP7JPkgRYlUA/AIHZEo8CszveU1OIaPyp19c
         vgZpVNngiOViA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 03/30] habanalabs: fix possible memory leak in MMU DR fini
Date:   Sat, 22 Jan 2022 21:57:04 +0200
Message-Id: <20220122195731.934494-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch fixes what seems to be copy paste error.

We will have a memory leak if the host-resident shadow is NULL (which
will likely happen as the DR and HR are not dependent).

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 6134b6ae7615..3cadef97817d 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -467,7 +467,7 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
 {
 	/* MMU H/W fini was already done in device hw_fini() */
 
-	if (!ZERO_OR_NULL_PTR(hdev->mmu_priv.hr.mmu_shadow_hop0)) {
+	if (!ZERO_OR_NULL_PTR(hdev->mmu_priv.dr.mmu_shadow_hop0)) {
 		kvfree(hdev->mmu_priv.dr.mmu_shadow_hop0);
 		gen_pool_destroy(hdev->mmu_priv.dr.mmu_pgt_pool);
 
-- 
2.25.1

