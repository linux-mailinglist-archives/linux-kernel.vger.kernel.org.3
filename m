Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32DA4745F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhLNPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40668 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhLNPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F29D61513
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE1C34601;
        Tue, 14 Dec 2021 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494364;
        bh=YPdsy0CCnzzsrfv824dM3Dv846GWF5si6p2hvjiOZWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+1ZOK2+lgbPU25RwOi+T7F/gcy5I2R9+U1QXuvFwB0pum6wDwsHftv2z1gpzSK2K
         om2mUc9RQvoWYTMfOyGS8+/NzeZTQFwWagZ+3kWfL5cld0XF3wUtvh6vQyYEU2CfmH
         WXOIzWFwCHUJj6UO+YiUlbcUT9xlLND05P6FUdX00A1PXPHwqfyepTzXiF95u0ZJup
         /h91M9T2OYVp/m7qW2zPOcO5XGP20+P72aSW24HLfc4YxCQAoJXnKgoWBp00fMk1S3
         8VMGnpLE3xCPfnkcXdwNJzsgvuJxPPBXczoSvofDqD4+12hy9RYC9pyHrySbn/95t5
         +39UsZFVgl5Iw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 07/11] habanalabs: expose soft reset sysfs nodes for inference ASIC
Date:   Tue, 14 Dec 2021 17:05:47 +0200
Message-Id: <20211214150551.1568192-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As we allow soft-reset to be performed only on inference devices,
having the sysfs nodes may cause a confusion. Hence, we remove those
nodes on training ASICs.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/sysfs.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 39d449c712b6..8ce9884efe76 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -424,8 +424,6 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_max_power.attr,
 	&dev_attr_pci_addr.attr,
 	&dev_attr_preboot_btl_ver.attr,
-	&dev_attr_soft_reset.attr,
-	&dev_attr_soft_reset_cnt.attr,
 	&dev_attr_status.attr,
 	&dev_attr_thermal_ver.attr,
 	&dev_attr_uboot_ver.attr,
@@ -450,6 +448,21 @@ static const struct attribute_group *hl_dev_attr_groups[] = {
 	NULL,
 };
 
+static struct attribute *hl_dev_inference_attrs[] = {
+	&dev_attr_soft_reset.attr,
+	&dev_attr_soft_reset_cnt.attr,
+	NULL,
+};
+
+static struct attribute_group hl_dev_inference_attr_group = {
+	.attrs = hl_dev_inference_attrs,
+};
+
+static const struct attribute_group *hl_dev_inference_attr_groups[] = {
+	&hl_dev_inference_attr_group,
+	NULL,
+};
+
 int hl_sysfs_init(struct hl_device *hdev)
 {
 	int rc;
@@ -465,10 +478,25 @@ int hl_sysfs_init(struct hl_device *hdev)
 		return rc;
 	}
 
+	if (!hdev->allow_inference_soft_reset)
+		return 0;
+
+	rc = device_add_groups(hdev->dev, hl_dev_inference_attr_groups);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to add groups to device, error %d\n", rc);
+		return rc;
+	}
+
 	return 0;
 }
 
 void hl_sysfs_fini(struct hl_device *hdev)
 {
 	device_remove_groups(hdev->dev, hl_dev_attr_groups);
+
+	if (!hdev->allow_inference_soft_reset)
+		return;
+
+	device_remove_groups(hdev->dev, hl_dev_inference_attr_groups);
 }
-- 
2.25.1

