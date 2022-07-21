Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E132C57C1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiGUAfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiGUAfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8A56272
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658363708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YUjwNdRUT99ASZIZYsMJwCcledX4/RDVaQ7w44xnB7Y=;
        b=T9Nv9aBGucqXbRbfpsxw8ICKtdARG2Sl51SEFmEhNB1w0HYfgBfN/gZwbiM1xbsJk1/yPh
        OLEn3vKoq2fJkDa7LiP6UwjuhR+eVMi0qbWRMDAVaHyWcA//BuVkTMVk8KnR5nAFjeCdNS
        VF2XfWoNSoX+RbURHpjky3UadaZOrnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-EJHkHy_0MJmNKSAqYJkZpA-1; Wed, 20 Jul 2022 20:34:56 -0400
X-MC-Unique: EJHkHy_0MJmNKSAqYJkZpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10365811E76;
        Thu, 21 Jul 2022 00:34:56 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C2C7400DFD7;
        Thu, 21 Jul 2022 00:34:55 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Disable guest vapic logging during early kdump init
Date:   Wed, 20 Jul 2022 17:34:39 -0700
Message-Id: <20220721003439.403435-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit a8d4a37d1bb9 ("iommu/amd: Restore GA log/tail pointer on
host resume"), there now is a WARN_ON in iommu_ga_log_enable that
triggers if the GALOG_RUN bit is set in the MMIO status register, and
this warning has been reported when a kdump kernel is booting.

We probably don't really care about guest vapic logging during kdump,
but the proper thing seems to be disabling the GALOG_EN bit in the
MMIO control register in the kdump code path of
early_enable_iommus(). The iommu pci init code is going to set the ga
log address pointers to new values in the amd_iommu struct, and these
aren't pushed to the iommu until after the warning and return in
iommu_ga_log_enable(). So worst case, the GALOG bits are set and the
iommu has stale pointers to the ga log addresses. So disable GALOG_EN
in early_enable_iommus() and allow iommu_ga_log_enable() to set it up
properly and enable again.

Without the fix you will see the following warning when the kdump
kernel boots:

[    7.731955] ------------[ cut here ]------------
[    7.736575] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd/init.c:829 iommu_ga_log_enable.isra.0+0x16f/0x190
[    7.746135] Modules linked in:
[    7.749193] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc7.53.eln120.x86_64 #1
[    7.759706] Hardware name: Dell Inc. PowerEdge R7525/04D5GJ, BIOS 2.1.6 03/09/2021
[    7.767274] RIP: 0010:iommu_ga_log_enable.isra.0+0x16f/0x190
[    7.772931] Code: 20 20 00 00 8b 00 f6 c4 01 74 da 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 75 13 48 83 c4 10 5b 5d e9 f5 00 72 00 0f 0b eb e1 <0f> 0b eb dd e8 f8 66 42 00 48 8b 15 f1 85 53 01 e9 29 ff ff ff 48
[    7.791679] RSP: 0018:ffffc90000107d20 EFLAGS: 00010206
[    7.796905] RAX: ffffc90000780000 RBX: 0000000000000100 RCX: ffffc90000780000
[    7.804038] RDX: 0000000000000001 RSI: ffffc90000780000 RDI: ffff8880451f9800
[    7.811170] RBP: ffff8880451f9800 R08: ffffffffffffffff R09: 0000000000000000
[    7.818303] R10: 0000000000000000 R11: 0000000000000000 R12: 0008000000000000
[    7.825435] R13: ffff8880462ea900 R14: 0000000000000021 R15: 0000000000000000
[    7.832572] FS:  0000000000000000(0000) GS:ffff888054a00000(0000) knlGS:0000000000000000
[    7.840657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.846400] CR2: ffff888054dff000 CR3: 0000000053210000 CR4: 0000000000350eb0
[    7.853533] Call Trace:
[    7.855979]  <TASK>
[    7.858085]  amd_iommu_enable_interrupts+0x180/0x270
[    7.863051]  ? iommu_setup+0x271/0x271
[    7.866803]  state_next+0x197/0x2c0
[    7.870295]  ? iommu_setup+0x271/0x271
[    7.874049]  iommu_go_to_state+0x24/0x2c
[    7.877976]  amd_iommu_init+0xf/0x29
[    7.881554]  pci_iommu_init+0xe/0x36
[    7.885133]  do_one_initcall+0x44/0x200
[    7.888975]  do_initcalls+0xc8/0xe1
[    7.892466]  kernel_init_freeable+0x14c/0x199
[    7.896826]  ? rest_init+0xd0/0xd0
[    7.900231]  kernel_init+0x16/0x130
[    7.903723]  ret_from_fork+0x22/0x30
[    7.907306]  </TASK>
[    7.909497] ---[ end trace 0000000000000000 ]---

Fixes: 3ac3e5ee5ed5 ("iommu/amd: Copy old trans table from old kernel")
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org> (maintainer:IOMMU DRIVERS)
Cc: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1d08f87e734b..2b00d7f28df7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -815,6 +815,11 @@ static void free_ga_log(struct amd_iommu *iommu)
 #endif
 }
 
+static void iommu_ga_log_disable(struct amd_iommu *iommu)
+{
+	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
+}
+
 static int iommu_ga_log_enable(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
@@ -2504,6 +2509,7 @@ static void early_enable_iommus(void)
 		for_each_iommu(iommu) {
 			iommu_disable_command_buffer(iommu);
 			iommu_disable_event_buffer(iommu);
+			iommu_ga_log_disable(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);

base-commit: ca85855bdcae8f84f1512e88b4c75009ea17ea2f
-- 
2.36.1

