Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417A04DAC12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353811AbiCPHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiCPHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:54:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB42649
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647417172; x=1678953172;
  h=from:to:cc:subject:date:message-id;
  bh=Je2ZWX3edA1Czz6ssXci3qY6Mhod4o9JMVkDWJhNKPQ=;
  b=FholFiSUsZKEcbzMy34SUollSJ7d2l1n/rUyCCTzEY2wmpau+OsgRpcz
   3uQKF+zo1MaJbueIh/K4N+A7ZhKoWod/TdOZPDxYzON54Tm7NqsRcPFtx
   6bMsIecFaRQfk4HN07omnJEma1+fu0VVSGk3ObroNvpR1zOleR4ttZM65
   15iafUrrxyNt/nE3ZMmXDEr7906dbe8bcRlWtOFUuRWE2EP+9ASdtkwxR
   7DjMQOAMUavpI9zGA3DYOMeAwqdA29LaHdSg7XeBPTX121VbsNU8Y/5eW
   39BOBuLXL63ap24DVkhMcqyGsr3JTeMA7BU0qGqv97/CjC684/J4QOU4a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319734626"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="319734626"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:52:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="690484275"
Received: from basccgtest09.gar.corp.intel.com (HELO localhost.localdomain) ([10.223.165.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:52:49 -0700
From:   monish.kumar.r@intel.com
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     abhijeet.rao@intel.com, monish.kumar.r@intel.com
Subject: [PATCH] nvme-pci: Add quirk changes for Samsung X5 SSDs
Date:   Wed, 16 Mar 2022 13:24:49 +0530
Message-Id: <20220316075449.18906-1-monish.kumar.r@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monish Kumar R <monish.kumar.r@intel.com>

Add quirks to not fail the initialization and to
have quick resume latency after cold/warm reboot.

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..c1150e01394c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,7 +3463,10 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-
+	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
+		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
+				NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.17.1

