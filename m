Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9714B82B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiBPINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:13:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiBPIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:12:58 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB4C3360;
        Wed, 16 Feb 2022 00:12:44 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21G8CdIo020135;
        Wed, 16 Feb 2022 02:12:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644999159;
        bh=1uxKIrlR3nxNCN2O9vw+IziPeAS2FTNh/4SwRorGXSE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RKyUedxtCIfFB87Z8JY9HrSkELUrIFHyx01uG8Rc7o0Whr9JpcrL2uUYaGjUbA6qn
         /oJohU2Zdfxqstl5zuoA1NkG5+jUD2X2s5BP3S4n5o7LEv0wTYFVmbWPbePcH1h8OW
         MCy0D2RCsc9ESUNmJG4LGev3LTNBc9h+a7iG2X5k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21G8Cd2N052698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 02:12:39 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 02:12:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 02:12:38 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21G8Cbjw099139;
        Wed, 16 Feb 2022 02:12:37 -0600
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <kishon@ti.com>, <vigneshr@ti.com>, <s-anna@ti.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH v5 1/2] remoteproc: Introduce sysfs_read_only flag
Date:   Wed, 16 Feb 2022 13:42:23 +0530
Message-ID: <20220216081224.9956-2-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216081224.9956-1-p-mohan@ti.com>
References: <20220216081224.9956-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
through the sysfs files 'state' and 'firmware'. The 'coredump'
file is used to set the coredump configuration. The 'recovery'
sysfs file can also be used similarly to control the error recovery
state machine of a remoteproc. These interfaces are currently
allowed irrespective of how the remoteprocs were booted (like
remoteproc self auto-boot, remoteproc client-driven boot etc).
These interfaces can adversely affect a remoteproc and its clients
especially when a remoteproc is being controlled by a remoteproc
client driver(s). Also, not all remoteproc drivers may want to
support the sysfs interfaces by default.

Add support to make the remoteproc sysfs files read only by
introducing a state flag 'sysfs_read_only' that the individual
remoteproc drivers can set based on their usage needs. The default
behavior is to allow the sysfs operations as before.

Implement attribute_group->is_visible() to make the sysfs
entries read only when 'sysfs_read_only' flag is set.

Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
Changes in v4->v5:
Rename deny_sysfs_ops to sysfs_read_only.
Make coredump readonly with other files.

Changes in v3->v4:
Use mode = 0444 in rproc_is_visible() to make the sysfs entries
read-only when the deny_sysfs_ops flag is set.
---
 drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
 include/linux/remoteproc.h            |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index ea8b89f97d7b..abf0cd05d5e1 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -230,6 +230,22 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(name);
 
+static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct rproc *rproc = to_rproc(dev);
+	umode_t mode = attr->mode;
+
+	if (rproc->sysfs_read_only && (attr == &dev_attr_recovery.attr ||
+				       attr == &dev_attr_firmware.attr ||
+				       attr == &dev_attr_state.attr ||
+				       attr == &dev_attr_coredump.attr))
+		mode = 0444;
+
+	return mode;
+}
+
 static struct attribute *rproc_attrs[] = {
 	&dev_attr_coredump.attr,
 	&dev_attr_recovery.attr,
@@ -240,7 +256,8 @@ static struct attribute *rproc_attrs[] = {
 };
 
 static const struct attribute_group rproc_devgroup = {
-	.attrs = rproc_attrs
+	.attrs = rproc_attrs,
+	.is_visible = rproc_is_visible,
 };
 
 static const struct attribute_group *rproc_devgroups[] = {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e0600e1e5c17..93a1d0050fbc 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -523,6 +523,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @sysfs_read_only: flag to make remoteproc sysfs files read only
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  * @elf_class: firmware ELF class
@@ -562,6 +563,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool sysfs_read_only;
 	struct list_head dump_segments;
 	int nb_vdev;
 	u8 elf_class;
-- 
2.17.1

