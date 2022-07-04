Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9B5650DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiGDJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiGDJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59D6332
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD0061359
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F2C341CA;
        Mon,  4 Jul 2022 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926997;
        bh=VEm2fFSFtwuAHmvg8D6zrlelTQXYNmEF09QCYxcujgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okIYeZnyEBXpBdKy+JVH8WmBgSbnsG6M+V39VFQOJXY2yzzuP2hc78sbwDfifMj7h
         rQ8FYh0iKpagk1Ir1lm0LE8izzfGptL7zH7ip8HousPDif1W+Lrry8eMo7qnv+oMWh
         wnFcVpr8N6hBGLL1/T5IayfH4CI/Bwj+D33nmwrl8nzVYRIKsxtkH+ksevgyK60FKk
         88S74++ZW+WYI+G7pSesiF/FT35PbFnuoiG1Pr+2lBi3MEIWvZlN5aTg5OIh+C8Y1A
         4GCeS8MS/ydMnaOnixVjm6l7HC6jRD6z/JASu07YHk+TyYoJ+0Y8R8fGNvBR9SC1jp
         2tXX53m5UyBBg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 09/12] habanalabs: do not set max power on a secured device
Date:   Mon,  4 Jul 2022 12:29:38 +0300
Message-Id: <20220704092941.2237683-9-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

Max power API is not supported in secured devices. Hence, we should
skip setting it during boot.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9f3778c82e54..99d84b46aeb6 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1545,7 +1545,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 			goto out_err;
 		}
 
-		hl_fw_set_max_power(hdev);
+		if (!hdev->asic_prop.fw_security_enabled)
+			hl_fw_set_max_power(hdev);
 	} else {
 		rc = hdev->asic_funcs->non_hard_reset_late_init(hdev);
 		if (rc) {
@@ -1914,7 +1915,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	/* Need to call this again because the max power might change,
 	 * depending on card type for certain ASICs
 	 */
-	if (hdev->asic_prop.set_max_power_on_device_init)
+	if (hdev->asic_prop.set_max_power_on_device_init &&
+			!hdev->asic_prop.fw_security_enabled)
 		hl_fw_set_max_power(hdev);
 
 	/*
-- 
2.25.1

