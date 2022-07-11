Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36956D4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiGKGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiGKGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF766167CD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50850B80D75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6D8C3411C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521023;
        bh=smE+HNFtlrp5RqiIa9EDwhFWCfXGk85QRo4NNIBdMhU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CNrMM4jRnf9vkmbWF6PBKUmezEFU69Jo2Y+Y8Ul/X5ISJYnJFqJ/GhGWgXVOe2CSW
         D/kAKXHu1sY10VQb3v9XWJpc2AvNPgO9Eq2XSIcQVKrj7xtoRnrVsmcMTq4xa+gbr1
         YrVlFMuQeh+OYUYe+wYTH1q0NhLwpRKfx6iLxzLmSqTCegmiDmApD0vO7NFbX0KoCJ
         N/Zq/TZYY+QQiIoPH+CBudVAZcZNR9Uc9p6bRYUvZFlue43VRN7d524zFypD+I4gxd
         Si1mypJyyUFxG91Pp82VzwG08+1uZE2EoVyvX5K0spaIS0qoUnZ6vRaUo+fHcenp66
         +nIFDpwgIE0zw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] habanalabs: move h/w dirty message to debug
Date:   Mon, 11 Jul 2022 09:30:03 +0300
Message-Id: <20220711063003.3182795-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
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

H/W being dirty during initialization is completely expected in case
f/w tools are used before loading the driver. As it is not an error,
and as it doesn't give any meaningful information to the user,
no point of printing it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c   | 3 +--
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 2 +-
 drivers/misc/habanalabs/goya/goya.c     | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8c1b1824d1a9..cb2988e2c7a8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -870,8 +870,7 @@ static int gaudi_early_init(struct hl_device *hdev)
 	}
 
 	if (gaudi_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
-		dev_info(hdev->dev,
-			"H/W state is dirty, must reset before initializing\n");
+		dev_dbg(hdev->dev, "H/W state is dirty, must reset before initializing\n");
 		hdev->asic_funcs->hw_fini(hdev, true, false);
 	}
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 2ce1fed8ef26..1dfd923543d0 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2536,7 +2536,7 @@ static int gaudi2_early_init(struct hl_device *hdev)
 	}
 
 	if (gaudi2_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
-		dev_info(hdev->dev, "H/W state is dirty, must reset before initializing\n");
+		dev_dbg(hdev->dev, "H/W state is dirty, must reset before initializing\n");
 		hdev->asic_funcs->hw_fini(hdev, true, false);
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 573f8f7df976..db4487c33582 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -673,8 +673,7 @@ static int goya_early_init(struct hl_device *hdev)
 	}
 
 	if (goya_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
-		dev_info(hdev->dev,
-			"H/W state is dirty, must reset before initializing\n");
+		dev_dbg(hdev->dev, "H/W state is dirty, must reset before initializing\n");
 		hdev->asic_funcs->hw_fini(hdev, true, false);
 	}
 
-- 
2.25.1

