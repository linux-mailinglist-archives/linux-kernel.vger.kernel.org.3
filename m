Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C576585E85
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiGaKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiGaKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE6E11821
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45B73B80D19
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322CAC433D6;
        Sun, 31 Jul 2022 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264649;
        bh=V4/CA1HUSBbDe2/OLn0gPt0gXcO9xOZzqmN4gevEPQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3tRfpA6U1OoFuZ8WAYjOcjn8uN6Rh77bILuNexzvN59pl3OeODOdCQblgegB7+M7
         aJuTckELEN+Rv0YBTKht69m6VkulcXd9nX1/sfZagPy+xCgJmpsmqfd33FsvfZh6eI
         lbkwslLUO7N+MqPancAv3R1s6Kt0ER1wqveSdjJY9iWomvsK0x8tLwbblzRRme1ZzH
         8hvzppTjY7yVwQw6uqSH9iwaVHBgPmhyQgivx1kcR9Uv3y/mj5Np02NjYppxE51Keo
         K9ZCLi0sgbyIzSKVkQyZiNHkQPhF6v6/8xmoypemLRrk5HZ6bwzpTDpYiN2zKFtqqI
         QNTh6AVhaWz3Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 6/8] habanalabs: add a missing lock for in_reset indication
Date:   Sun, 31 Jul 2022 13:50:35 +0300
Message-Id: <20220731105037.545106-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731105037.545106-1-ogabbay@kernel.org>
References: <20220731105037.545106-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add a missing lock in hl_device_resume() when it assigns a value to the
'in_reset' indication.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 90e346727a7c..6a98aae90f49 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1091,7 +1091,9 @@ int hl_device_resume(struct hl_device *hdev)
 	/* 'in_reset' was set to true during suspend, now we must clear it in order
 	 * for hard reset to be performed
 	 */
+	spin_lock(&hdev->reset_info.lock);
 	hdev->reset_info.in_reset = 0;
+	spin_unlock(&hdev->reset_info.lock);
 
 	rc = hl_device_reset(hdev, HL_DRV_RESET_HARD);
 	if (rc) {
-- 
2.25.1

