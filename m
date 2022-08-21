Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FF59B2C4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiHUI2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHUI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:28:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47612D11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B622B80BA7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B60C433C1;
        Sun, 21 Aug 2022 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661070510;
        bh=GRaLVWQmFrTUjDgibZ+O3NZz+X6pZ7tTDAWYF24bdB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/0g4X5OcYPJ3ZXzp1/8U987cBd+gK3pgeV1ub0z5ldvuIRGBXsCBmmuLX9gXWb+t
         MLpGujeXVEbkHtJrkPbcDOUTXGsR8eWvd0xe1cmGct8c7tpqCfcHiuy2FvYKp8eQOm
         3dyES0VK9fG/xyfDMNHe9aDrhmrh5s/5UKPWC0gX7ngjX3+bI70MQyPPVHrp3Qf9bL
         QOrlpeoVKH6fzehkMAH+mdI4V0807uCECNk3yCBm+7PqMsLctxq4IWVKcQp0PtZEdr
         ICH0rkNA2H7hB3ZFav9Hkt650jDjecS332MXO4Neh22wYelgo6IApKTWQAszrD7OVf
         K3TqE853MwFKQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 3/5] habanalabs: if map page fails don't try to unmap it
Date:   Sun, 21 Aug 2022 11:28:21 +0300
Message-Id: <20220821082823.62846-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821082823.62846-1-ogabbay@kernel.org>
References: <20220821082823.62846-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

The original code tried to unmap a page that was not mapped as part of
the map page error path.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 60740de47b34..4153aec55594 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -403,6 +403,8 @@ int hl_mmu_map_contiguous(struct hl_ctx *ctx, u64 virt_addr,
 			dev_err(hdev->dev,
 				"Map failed for va 0x%llx to pa 0x%llx\n",
 				curr_va, curr_pa);
+			/* last mapping failed so don't try to unmap it - reduce off by page_size */
+			off -= page_size;
 			goto unmap;
 		}
 	}
-- 
2.25.1

