Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3494FB6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiDKJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344173AbiDKJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42F3EF39
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD63F60B6F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8E6C385A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668091;
        bh=VTuVyQ9Hek52nBomPsSuOUu1r3gvK53kDTMnO838nEU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eIXUv9/NuHqzcNK+Z8l/whTbuPIYk7gy/aFuknM3DNTcibMIbyvP3dHhVBDrdooyw
         k4AYedEnJ9rIHIRJL9i2f/WyW08fFrabiX5bXDZ1l6S7TVcyJzYYwir7ND7mSSUdqO
         7MQVgYp66OK4oPRmWnE0/FpAC7+V5aKHH/0uUbvM0rbF4NAZGLONOA6KpCXj6bOWFN
         lmtg/eKm6+WVdgbrIYsi98rQqKBP9U9e/8E8dEFTaJ8rwrjyVlpZeUBtxx+2C27WBn
         3WqBJc5rMXs+ZHsXBCv2MBzaabkJbHgBKWWpaK0ZgkcQAnDQVvtFyKLjKMJitV1P2Z
         3MhiAJJnOQAaw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] habanalabs: remove user interrupt debug print
Date:   Mon, 11 Apr 2022 12:08:00 +0300
Message-Id: <20220411090805.1617112-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090805.1617112-1-ogabbay@kernel.org>
References: <20220411090805.1617112-1-ogabbay@kernel.org>
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

As user interrupts are a common use case, this dump pollutes the
dmesg log, hence removing it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 5b5a992460c9..8500e15ef743 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -282,10 +282,6 @@ irqreturn_t hl_irq_handler_user_cq(int irq, void *arg)
 	struct hl_user_interrupt *user_cq = arg;
 	struct hl_device *hdev = user_cq->hdev;
 
-	dev_dbg(hdev->dev,
-		"got user completion interrupt id %u",
-		user_cq->interrupt_id);
-
 	/* Handle user cq interrupts registered on all interrupts */
 	handle_user_cq(hdev, &hdev->common_user_interrupt);
 
-- 
2.25.1

