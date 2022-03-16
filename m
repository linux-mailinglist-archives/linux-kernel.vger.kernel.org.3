Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066024DAF01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355375AbiCPLmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCPLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB446179
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE27615B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74198C340E9;
        Wed, 16 Mar 2022 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430894;
        bh=ENBc8WTtXbr8r/snDIo4ymrZa0U/Y7BedNlcQvKSvS0=;
        h=From:To:Cc:Subject:Date:From;
        b=aKcGE3dusB+JGRfOxiD9cbSDmfcRkid3zqeVcrczvid+JwkJu0/CtbGDK7rxfC0fQ
         b7ZnOHNnZV+HZvoDKt8Wazrc7q7e1jHV7laR3752xVDnr4GGBg50Svz7RKBGwZcjRr
         ScHEdWSAxAxO5ltyZ/T/yVTaqPXcW2eTB0oyQ3Y0xfzopuMbDdm4cKwJEaxaZLqQXF
         heGNqkBhkPMXQxmff8IcdP2Mi4BYuQLtCVaaDxADtuCDlWAxCdouTYt7ty8M1iVuRi
         0fHX3UYGgisEJzElGgEaA5Ws5dwpeh3z7dEuBSsBNUJRqfJJEKDpYXkoMaxZZp0ET1
         Ahkf79pz1mRKg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 01/11] habanalabs: set non-0 value in dram default page size
Date:   Wed, 16 Mar 2022 13:41:19 +0200
Message-Id: <20220316114129.2520107-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Looking forward we will need to report to the user what is the default
page size used.

This will be done more conveniently by explicitly updating the property
rather than to rely on a "0 meaning default" value.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 5 +++++
 drivers/misc/habanalabs/common/memory.c     | 2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c       | 1 +
 drivers/misc/habanalabs/goya/goya.c         | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1edaf6ab67bd..af47accd4a56 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -528,6 +528,10 @@ struct hl_hints_range {
  * @fw_app_cpu_boot_dev_sts1: bitmap representation of application security
  *                            status reported by FW, bit description can be
  *                            found in CPU_BOOT_DEV_STS1
+ * @device_mem_alloc_default_page_size: may be different than dram_page_size only for ASICs for
+ *                                      which the property supports_user_set_page_size is true
+ *                                      (i.e. the DRAM supports multiple page sizes), otherwise
+ *                                      it will shall  be equal to dram_page_size.
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
@@ -626,6 +630,7 @@ struct asic_fixed_properties {
 	u32				fw_bootfit_cpu_boot_dev_sts1;
 	u32				fw_app_cpu_boot_dev_sts0;
 	u32				fw_app_cpu_boot_dev_sts1;
+	u32				device_mem_alloc_default_page_size;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e008d82e4ba3..671633414504 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -41,7 +41,7 @@ static int set_alloc_page_size(struct hl_device *hdev, struct hl_mem_in *args, u
 			return -EINVAL;
 		}
 	} else {
-		psize = hdev->asic_prop.dram_page_size;
+		psize = prop->device_mem_alloc_default_page_size;
 	}
 
 	*page_size = psize;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 21c2b678ff72..feb1323a8f4a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -595,6 +595,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
 	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
+	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
 	prop->dram_supports_virtual_memory = false;
 
 	prop->pmmu.hop0_shift = MMU_V1_1_HOP0_SHIFT;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ec9358bcbf0b..5bd665188ea6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -413,6 +413,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
 	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
+	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
 	prop->dram_supports_virtual_memory = true;
 
 	prop->dmmu.hop0_shift = MMU_V1_0_HOP0_SHIFT;
-- 
2.25.1

