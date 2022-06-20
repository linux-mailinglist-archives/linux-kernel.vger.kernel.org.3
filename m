Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127F551E85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351065AbiFTOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353031AbiFTN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:57:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632CA37AA6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4CE18CE12A1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B1C3411B;
        Mon, 20 Jun 2022 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730289;
        bh=UPF8dEluSGgTwiU8y0xT2wEIG9wst3hS4/cy3U6kZbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byW0Ldufi00UL+b+JrLQVVHcLCL1lqAmKNcTDFAOM4/IXogwL4Thgw9vOhlUTnwSn
         NS3A02uNdPP9ya/My/Y2FxyxFTKkeeHCxrItPeUw2joPoOAsZqG4Y8qPkl5wx3WM6Q
         B5fM6QTG/H/j30C4lv4x4uo5DRZ5ChtSDpum56Y9AsIWoHiREeY9DPTrekvmx3xL5X
         WQmlmZr2wkoN6oP4JHRIn2HETsaihuUCGyx3ywXgceMTGOgge2EjNcx/2a8uvElTMW
         +DurGYyRopNLxdLEurfPRo/YwrauSH/ezZi33eDwI+Z67D0YbGFyY/c5X0Gh/kA/fP
         qUakJKel2jiZg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 09/17] habanalabs/gaudi: fix shift out of bounds
Date:   Mon, 20 Jun 2022 16:04:24 +0300
Message-Id: <20220620130432.1180451-9-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

When validating NIC queues, queue offset calculation must be
performed only for NIC queues.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8b9ff7fa51ea..31e702846f7a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5692,15 +5692,17 @@ static int gaudi_parse_cb_no_ext_queue(struct hl_device *hdev,
 {
 	struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 nic_mask_q_id = 1 << (HW_CAP_NIC_SHIFT +
-		((parser->hw_queue_id - GAUDI_QUEUE_ID_NIC_0_0) >> 2));
+	u32 nic_queue_offset, nic_mask_q_id;
 
 	if ((parser->hw_queue_id >= GAUDI_QUEUE_ID_NIC_0_0) &&
-			(parser->hw_queue_id <= GAUDI_QUEUE_ID_NIC_9_3) &&
-			(!(gaudi->hw_cap_initialized & nic_mask_q_id))) {
-		dev_err(hdev->dev, "h/w queue %d is disabled\n",
-				parser->hw_queue_id);
-		return -EINVAL;
+			(parser->hw_queue_id <= GAUDI_QUEUE_ID_NIC_9_3)) {
+		nic_queue_offset = parser->hw_queue_id - GAUDI_QUEUE_ID_NIC_0_0;
+		nic_mask_q_id = 1 << (HW_CAP_NIC_SHIFT + (nic_queue_offset >> 2));
+
+		if (!(gaudi->hw_cap_initialized & nic_mask_q_id)) {
+			dev_err(hdev->dev, "h/w queue %d is disabled\n", parser->hw_queue_id);
+			return -EINVAL;
+		}
 	}
 
 	/* For internal queue jobs just check if CB address is valid */
-- 
2.25.1

