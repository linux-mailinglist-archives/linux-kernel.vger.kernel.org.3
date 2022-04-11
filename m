Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB624FB6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbiDKJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbiDKJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076E3F309
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F93960B1E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2301BC385A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668089;
        bh=4QlvMfrzKUGGaSgZIyLNsiPjRreetUGEdrCk5t4kD8A=;
        h=From:To:Subject:Date:From;
        b=Gljnh7SpcCT6h+J/8FcnaFIy+QBMC4b7YvpczYDZ533Xn0wfGRyhxTegOafefFHOb
         DIkItZ4CBfcfPasBJEZkCmyNHJoxmgWbcw+H/BL+avDYMxvzxpl/Wdqi9n6jCzuGF9
         rC45hTtYiKjDqNoDcqG0Q3/cEJMFJ0JU5trNBJaDrN/a2m3NzMF9NKBqUBcpPa4IaG
         fcbXmRpE2umC/bVgj55toxgO3kR896PU28PRnJF6uINUG7yt01ZK/K1zURPKoEfzWV
         fsGv6iiJbE8NJbJBSW4Nv6AzQJYzN74CVl0vUgUj1jLLzRyxZ1srbKrczckglxafwW
         IOi8gCgNvakjg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] habanalabs: don't print normal reset operations
Date:   Mon, 11 Apr 2022 12:07:59 +0300
Message-Id: <20220411090805.1617112-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Only a hard-reset is an unexpected event which should be notify in
the kernel log. Other resets are normal operations and therefore
we should not pollute the log with them.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9a71737fc804..a8c1d35cf1e7 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1198,9 +1198,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		if (hard_reset)
 			dev_info(hdev->dev, "Going to reset device\n");
 		else if (reset_upon_device_release)
-			dev_info(hdev->dev, "Going to reset device after release by user\n");
+			dev_dbg(hdev->dev, "Going to reset device after release by user\n");
 		else
-			dev_info(hdev->dev, "Going to reset engines of inference device\n");
+			dev_dbg(hdev->dev, "Going to reset engines of inference device\n");
 	}
 
 again:
@@ -1406,7 +1406,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 	hdev->reset_info.needs_reset = false;
 
-	dev_notice(hdev->dev, "Successfully finished resetting the device\n");
+	if (hard_reset)
+		dev_info(hdev->dev, "Successfully finished resetting the device\n");
 
 	if (hard_reset) {
 		hdev->reset_info.hard_reset_cnt++;
-- 
2.25.1

