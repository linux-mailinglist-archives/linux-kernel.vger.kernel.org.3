Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32641558A52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiFWUmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiFWUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12962733
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD2FAB8253A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E74C341C0;
        Thu, 23 Jun 2022 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016947;
        bh=AClH1QZ6meGj2gblOsiDQvKd5x+lhv9MT+RlCyMP5pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyudBLX487KUgN9ZizDdpg9HQ8m/lH3GRv8+t5koosoQpiP5XBFgeHb3Jx5Zq0YSx
         w5u6ezTYSHzm16R9wh8sbIax4S21dwKIwDT7ABYyxyipT2b98pV568aUr/3eoy3OCH
         7UinPcl4BtiiLozgMOq2VLy/MwxZnpnkOH5FKcnPmJsRwnnHjO9OXf1vXe/g3CMl2X
         XLDBDuY82bRu57tHpWs9OKwEGCMEWPolpJNmovYJf0TkMWnn5GX4lA7DfYuo6kJOd7
         U+fYk4gGTtNAKsbrEtpk8h3TxUvDFVZk+jo2d712D5ftZTcM24AQLiwlk5LJAvU4Vy
         5bEXImdDztVqw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 9/9] habanalabs: set default value for memory_scrub
Date:   Thu, 23 Jun 2022 23:42:12 +0300
Message-Id: <20220623204212.1628709-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

Set a default value for memory scrubbing

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 1a4f3eb941a9..34ba521e2d1a 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -15,6 +15,8 @@
 
 #define HL_RESET_DELAY_USEC		10000	/* 10ms */
 
+#define MEM_SCRUB_DEFAULT_VAL 0x1122334455667788
+
 /*
  * hl_set_dram_bar- sets the bar to allow later access to address
  *
@@ -1727,6 +1729,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hdev->asic_funcs->state_dump_init(hdev);
 
+	hdev->memory_scrub_val = MEM_SCRUB_DEFAULT_VAL;
 	hl_debugfs_add_device(hdev);
 
 	/* debugfs nodes are created in hl_ctx_init so it must be called after
-- 
2.25.1

