Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09476526BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384331AbiEMU4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiEMU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:56:26 -0400
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E314E004;
        Fri, 13 May 2022 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1898; q=dns/txt; s=iport;
  t=1652475384; x=1653684984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M7eUi4rugKzQW5rQyZA2HgaMKOcAHQUfdaskZoW+NRI=;
  b=N3fAtB1PCcYV/ou31YoQsAMp7BpCT7QbtkyeaDTm/2+C/Ig4tM9nnD3M
   IV3WjCZNuRI1+WJcwwd8HSgRbbtNPjmn0OPlR6HWKetsYP7IRfRQ1JHP0
   2Y2onSo/VK5QGZBuAovdSGNlNH5gMELpspCboSnptudc7KIopcUv8QahA
   Y=;
X-IronPort-AV: E=Sophos;i="5.91,223,1647302400"; 
   d="scan'208";a="759696194"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 13 May 2022 20:56:23 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 24DKu8Pc010787
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 May 2022 20:56:20 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        satishkh@cisco.com, gvaradar@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH] scsi: fnic: Replace DMA mask of 64 bits with 47 bits
Date:   Fri, 13 May 2022 13:56:05 -0700
Message-Id: <20220513205605.81788-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-6.cisco.com
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cisco VIC supports only 47 bits.
If the host sends DMA addresses that are greater than 47
bits, it causes work queue (WQ) errors in the VIC.

Co-developed-by: Dhanraj Jhawar <djhawar@cisco.com>
Signed-off-by: Dhanraj Jhawar <djhawar@cisco.com>
Co-developed-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      | 2 +-
 drivers/scsi/fnic/fnic_main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index aa07189fb5fb..85ec6163ddab 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -39,7 +39,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.53"
+#define DRV_VERSION		"1.6.0.54"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 460e03a55096..51e7c344ddc3 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -612,10 +612,10 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	/* Query PCI controller on system for DMA addressing
-	 * limitation for the device.  Try 64-bit first, and
-	 * fail to 32-bit.
+	 * limitation for the device.  Try 47-bit first, and
+	 * fail to 32-bit. Cisco VIC supports 47 bits only.
 	 */
-	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(47));
 	if (err) {
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
-- 
2.28.0

