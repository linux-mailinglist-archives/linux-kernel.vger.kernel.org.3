Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E363A5AEEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiIFPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiIFPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4ED9D107
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8615F6153F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0DAC433D6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475412;
        bh=8DxNAlI7YGG2pd2bhx8IwFkBbpQpFzkeXI3q6NTArmE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sq6PA6gajgONcEFHZAlJ44+IeZfldqtM6UKb7P4PDI+cWyFVJsdGe60nziK05Kggs
         dHVKxuwiM3b2bv4yypMnSqqzwPE0C0DD8jQoofrgG4E2AC95uuVGC/u6PhD9iwy2xC
         4GzvVy+WxUDnOrE5F/73wCUKxxf5U2QBDPmBi5tItV1xQK87X6jq1pFCNytvTGO+74
         jpaJy2L86oXqVU153jZ2ZRiPijbjsu9/i+IZkzI3lgB5HMK3/o95liD3EmyESnCvnV
         8ZCiFMH2iNSkHfhbw82N315bNwYfkErLQj3J2rjwP+Mw8YsgrighqoWhwNAAq2Y2Ii
         VSdrhbNCgGz3A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] habanalabs/gaudi2: free event irq if init fails
Date:   Tue,  6 Sep 2022 17:43:16 +0300
Message-Id: <20220906144318.1890416-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
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

In case initialization fails after event irq was requested, we need to
release that irq.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index db18e066509c..60694b8ed6fe 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -3581,7 +3581,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 	rc = gaudi2_dec_enable_msix(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable decoder IRQ");
-		goto free_completion_irq;
+		goto free_event_irq;
 	}
 
 	for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count, user_irq_init_cnt = 0;
@@ -3612,6 +3612,10 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 
 	gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM + 1);
 
+free_event_irq:
+	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
+	free_irq(irq, cq);
+
 free_completion_irq:
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
 	free_irq(irq, cq);
-- 
2.25.1

