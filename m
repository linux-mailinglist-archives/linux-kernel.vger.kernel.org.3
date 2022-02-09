Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994044AF126
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiBIMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiBIMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:13:45 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D5E01A22A;
        Wed,  9 Feb 2022 03:58:30 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21996C76083007;
        Wed, 9 Feb 2022 03:06:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644397572;
        bh=Fn0tXBQRpBz/aFWd0LHh4mdtpypyY2LI48sKNyRaWbs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LgumQn26hUfrJRqhpE74LR89hwQXUutNLELMIwHTpgtIAQJPE65MZF8coAZy4Fybz
         685grtGdv/LvWxwSA19Bi/OUrcEEDZOMoEPkpaOFfBaSX1UZs/Po2/Z3fQROoVTO+n
         MP0qsxbJYl3k+H2Rcx4dqex6FMB4O1f212+D6Hvs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21996CjP045827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 03:06:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 03:06:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 03:06:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21996A0b040498;
        Wed, 9 Feb 2022 03:06:11 -0600
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <puranjay12@gmail.com>, <kishon@ti.com>, <vigneshr@ti.com>,
        <s-anna@ti.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH v4 1/2] remoteproc: Introduce deny_sysfs_ops flag
Date:   Wed, 9 Feb 2022 14:33:41 +0530
Message-ID: <20220209090342.13220-2-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209090342.13220-1-p-mohan@ti.com>
References: <20220209090342.13220-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remoteproc framework provides sysfs interfaces for changing
the firmware name and for starting/stopping a remote processor
through the sysfs files 'state' and 'firmware'. The 'recovery'
sysfs file can also be used similarly to control the error recovery
state machine of a remoteproc. These interfaces are currently
allowed irrespective of how the remoteprocs were booted (like
remoteproc self auto-boot, remoteproc client-driven boot etc).
These interfaces can adversely affect a remoteproc and its clients
especially when a remoteproc is being controlled by a remoteproc
client driver(s). Also, not all remoteproc drivers may want to
support the sysfs interfaces by default.

Add support to deny the sysfs state/firmware/recovery change by
introducing a state flag 'deny_sysfs_ops' that the individual
remoteproc drivers can set based on their usage needs. The default
behavior is to allow the sysfs operations as before.

Implement attribute_group->is_visible() to hide the sysfs
state/firmware/recovery entries when deny_sysfs_ops flag is set.

Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
---
Changes in v3->v4:
Use mode = 0444 in rproc_is_visible() to make the sysfs entries
read-only when the deny_sysfs_ops flag is set.
---
 drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
 include/linux/remoteproc.h            |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index ea8b89f97d7b..da2d0eecfa44 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(name);
 
+static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct rproc *rproc = to_rproc(dev);
+	umode_t mode = attr->mode;
+
+	if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
+				      attr == &dev_attr_firmware.attr ||
+				      attr == &dev_attr_state.attr))
+		mode = 0444;
+
+	return mode;
+}
+
 static struct attribute *rproc_attrs[] = {
 	&dev_attr_coredump.attr,
 	&dev_attr_recovery.attr,
@@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
 };
 
 static const struct attribute_group rproc_devgroup = {
-	.attrs = rproc_attrs
+	.attrs = rproc_attrs,
+	.is_visible = rproc_is_visible,
 };
 
 static const struct attribute_group *rproc_devgroups[] = {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e0600e1e5c17..3849c66ce38f 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -523,6 +523,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  * @elf_class: firmware ELF class
@@ -562,6 +563,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool deny_sysfs_ops;
 	struct list_head dump_segments;
 	int nb_vdev;
 	u8 elf_class;
-- 
2.17.1

