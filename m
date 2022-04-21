Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF132509CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387908AbiDUJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387890AbiDUJsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:48:35 -0400
Received: from ZXBJCAS.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C810D19023;
        Thu, 21 Apr 2022 02:45:45 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXBJCAS.zhaoxin.com
 (10.29.252.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Apr
 2022 17:43:37 +0800
Received: from zx-HX001EM1.zhaoxin.com (10.29.8.9) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Apr
 2022 17:43:37 +0800
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
To:     <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM capability
Date:   Thu, 21 Apr 2022 17:43:36 +0800
Message-ID: <1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platform, when OS enables LPM by default (eg, min_power),
then, PhyRdy Change cannot be detected if ahci supports no LPM.

In ahci spec, PhyRdy Change cannot coexist with LPM.

Adds support to control this case on actual LPM capability.

Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
---
 drivers/ata/ahci.c      | 9 +++++++++
 drivers/ata/libata-eh.c | 4 ++++
 include/linux/libata.h  | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 397dfd2..03f0cb3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1870,6 +1870,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else
 		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
 
+	if (hpriv->cap & HOST_CAP_PART)
+		host->flags |= ATA_HOST_PART;
+
+	if (hpriv->cap & HOST_CAP_SSC)
+		host->flags |= ATA_HOST_SSC;
+
+	if (hpriv->cap2 & HOST_CAP2_SDS)
+		host->flags |= ATA_HOST_DEVSLP;
+
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3307ed4..05b1043 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3246,6 +3246,10 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	unsigned int err_mask;
 	int rc;
 
+	/* if controller does not support lpm, then sets no LPM flags*/
+	if (!(ap->host->flags & (ATA_HOST_PART | ATA_HOST_SSC | ATA_HOST_DEVSLP)))
+		link->flags |= ATA_LFLAG_NO_LPM;
+
 	/* if the link or host doesn't do LPM, noop */
 	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
 	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 732de90..7a243f4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -216,6 +216,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_PART		= (1 << 4), /* Host support partial.*/
+	ATA_HOST_SSC		= (1 << 5), /* Host support slumber.*/
+	ATA_HOST_DEVSLP		= (1 << 6), /* Host support devslp.*/
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
-- 
2.7.4

