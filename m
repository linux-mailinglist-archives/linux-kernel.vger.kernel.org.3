Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58A5664F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiGEIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGEIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299851E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9BA617A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C95CC341C7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657009435;
        bh=0Rmmu+JbjIJslVhPebozlGhFTNEIWYiFUVIZ5q25ETU=;
        h=From:To:Subject:Date:From;
        b=TNSrmEiB23WKTNoa0OyTr5SONo66RhU7uR03JxX2EzGd4XkIJDibkAtdwxsSa52Yx
         bfFUvQVl0c7zVsJfm9n7hDnkViJ9cEbIpCtI+Co/3iS6bhKHDO5aJQqvLr7LnVCe/s
         AzmrT8cK0Jtp585ckY81F0nRm3SU3phzTWLC+zw6VUhp/njdVwxwMg2fs2cgfheKDX
         l4UstZR6RVrHEFX2KSxNTVtvW4+ekZSjWDN2FolCkOAdZ1uuwU/UFzDNfPJa/WXbBl
         wxMjeWQsIg7sxERm7p26D+ihmOBhdW669th/KJLf0TVtTryM63JXaxhJN/zpxn2gJd
         1loqTzqapghPA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: initialize variable explicitly
Date:   Tue,  5 Jul 2022 11:23:51 +0300
Message-Id: <20220705082351.2713945-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix warning of
"warning: ‘old_base’ may be used uninitialized in this function"

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 99d84b46aeb6..5a76d7689abe 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -52,7 +52,7 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 	enum debugfs_access_type acc_type, enum pci_region region_type)
 {
 	struct pci_mem_region *region = &hdev->pci_mem_region[region_type];
-	u64 old_base, rc;
+	u64 old_base = 0, rc;
 
 	if (region_type == PCI_REGION_DRAM) {
 		old_base = hl_set_dram_bar(hdev, addr);
-- 
2.25.1

