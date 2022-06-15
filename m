Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BB54BEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiFOALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiFOAKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:10:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065736176;
        Tue, 14 Jun 2022 17:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655251854; x=1686787854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmwqOoory/BhG+mzzDYl/irO2wGnfPfD8xSW1RR8boc=;
  b=WfuUk4EhdSwZLQ7jdTQiG9I/IPtcn81sX09oqnTKKYgH5jkMWEICy4y+
   xxLT3wEp6s4zwYWTolnviBRJx2y0PNDJmvQ9y2LqlwaRDKQKwoDaw+PyX
   O5bNDkpGJ1+CqZvfMTEWnn57Re3CCy8dse+yPA2pkKCParg3KWp999MAh
   GV3l2eAa2ty3wVZKFa53iuN/GAic+A5z/T5onO3mS112Py96/uauoD/EC
   v7HO412OvWP3Cw5G48pSLlWnDfNOD2Ix2j7wVecrL/RNhTlCViVub7FPF
   MQPW7qC4lKzDm8bSc+9tfiUPSyzoRWsqJf2BNRhQnpMs+IhkgYqD4Js92
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278825457"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278825457"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640662914"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:53 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list retrieval
Date:   Tue, 14 Jun 2022 17:10:28 -0700
Message-Id: <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The sysfs attribute, get_poison, allows user space to request the
retrieval of a CXL devices poison list for its persistent memory.

From Documentation/ABI/.../sysfs-bus-cxl
        (WO) When a '1' is written to this attribute the memdev
        driver retrieves the poison list from the device. The list
        includes addresses that are poisoned or would result in
        poison if accessed, and the source of the poison. This
        attribute is only visible for devices supporting the
        capability. The retrieved errors are logged as kernel
        trace events with the label: cxl_poison_list.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 13 ++++++++++
 drivers/cxl/core/memdev.c               | 32 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7c2b846521f3..9d0c3988fdd2 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -163,3 +163,16 @@ Description:
 		memory (type-3). The 'target_type' attribute indicates the
 		current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/memX/get_poison
+Date:		June, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a '1' is written to this attribute the memdev
+		driver retrieves the poison list from the device. The list
+		includes addresses that are poisoned or would result in
+		poison if accessed, and the source of the poison. This
+		attribute is only visible for devices supporting the
+		capability. The retrieved errors are logged as kernel
+		trace events with the label: cxl_poison_list.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f7cdcd33504a..5ef9ffaa934a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,12 +106,34 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t get_poison_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+
+{
+	int rc;
+
+	if (!sysfs_streq(buf, "1")) {
+		dev_err(dev, "%s: unknown value: %s\n", attr->attr.name, buf);
+		return -EINVAL;
+	}
+
+	rc = cxl_mem_get_poison_list(dev);
+	if (rc) {
+		dev_err(dev, "Failed to retrieve poison list %d\n", rc);
+		return rc;
+	}
+	return len;
+}
+static DEVICE_ATTR_WO(get_poison);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_get_poison.attr,
 	NULL,
 };
 
@@ -130,6 +152,16 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 {
 	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
 		return 0;
+
+	if (a == &dev_attr_get_poison.attr) {
+		struct device *dev = container_of(kobj, struct device, kobj);
+		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
+			      cxlds->enabled_cmds))
+			return 0;
+	}
 	return a->mode;
 }
 
-- 
2.31.1

