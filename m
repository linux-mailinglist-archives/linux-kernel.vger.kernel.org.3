Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DB5650CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiGDJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiGDJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E6B1D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3718B80909
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A1C341CE;
        Mon,  4 Jul 2022 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926996;
        bh=PiB1yiOb6uD50kf78WB83Rn4y8CnbZvwkOqq/61eq5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gG8DfnURxzBo0WjnoZ9MkS3VXYP7lzKDTpQEcHY6nTnUF3KfDAfDSaJ1Z3ffQJW9q
         0dRufYoZ6mXDtMRMUqfpLLRpUMvCVfL505uOYNS47gaGRcmOeeJgdrhnF7/y/dT4VN
         Cdp4Cv0/wXCiDhgaSm+GMJTWhUyKAvnuATXsrDOwfxQ9IGyjshKGi49dZvtGRs9WmX
         G7bns6zlieOvaUPoH8HUV6WIH3R3D4pffdMIeScyumkszhoAVgnpAHjXy2Wl47LzQA
         dPZaKmMBlPaI2KzFNohAX72dcfAFqx09NWIz0AXK4m+DURVKEe9nYk6pQCy+0bGWfm
         H2e9vRyk1X9nw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 08/12] habanalabs/gaudi2: SM mask can only be 8-bit
Date:   Mon,  4 Jul 2022 12:29:37 +0300
Message-Id: <20220704092941.2237683-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, due to how we calculate it, we might fail in FIELD_PREP
checks.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 6911b42e52e1..dbf273d96b00 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -5751,8 +5751,9 @@ static void gaudi2_kdma_set_mmbp_asid(struct hl_device *hdev,
 static void gaudi2_arm_cq_monitor(struct hl_device *hdev, u32 index, u32 cq_id,
 						u32 mon_payload, u32 sync_value)
 {
+	u32 sync_group_id, mode, mon_arm;
 	int offset = index * 4;
-	u32 sync_group_id, mask, mode, mon_arm;
+	u8 mask;
 
 	/* Reset the SOB value */
 	WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset, 0);
-- 
2.25.1

