Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF69498506
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiAXQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:40:49 -0500
Received: from foss.arm.com ([217.140.110.172]:40084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243804AbiAXQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:40:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864DAD6E;
        Mon, 24 Jan 2022 08:40:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 984B63F793;
        Mon, 24 Jan 2022 08:40:25 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tientzu@chromium.org, guozhengkui@vivo.com
Subject: [PATCH 3/3] swiotlb: Simplify array allocation
Date:   Mon, 24 Jan 2022 16:40:19 +0000
Message-Id: <432f572de793ec5085a048a51fdd977cba6a5f51.1643028164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer kcalloc() to kzalloc(array_size()) for allocating an array.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/swiotlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f56d6504903c..44c49c3616fe 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -820,8 +820,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		if (!mem)
 			return -ENOMEM;
 
-		mem->slots = kzalloc(array_size(sizeof(*mem->slots), nslabs),
-				     GFP_KERNEL);
+		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
 		if (!mem->slots) {
 			kfree(mem);
 			return -ENOMEM;
-- 
2.28.0.dirty

