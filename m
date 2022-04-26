Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41C510977
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354425AbiDZUH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354381AbiDZUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:07:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8A3E1CC6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651003452; x=1682539452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n5ylGb3p0YPh5mhHSfFv+5xjLhjthFufxOacMcTLwW4=;
  b=WK52W1ndhN2lVjH4CAJTGNYY7iR6hlRE+dMGu/7oSp5+dcUTYZaq879v
   54CKam+x4X/R+bU6oDpfuB0JQUaX7pfJ8R+bNixiUxIp1ZXoBHWuE/37T
   TrlB+3R7E3BspFnJcVhPKH9JWB2TnNovZ+TSSevNXhnI7pRm6r4SohbiN
   MlttTeB9UBYZaWyWClK5U8qk5dVIg88yPyOHtNP7lX2luwNc0REhM0fUu
   j2nxzvdK0aCxGNnKqw59l1B+Y+KjaNtPkMedOgjgWALhfPkGyJoEaxKJZ
   kuzgpaB3DDsj1yL+QjWKEELqxJMO1Vp9w495xWvIfhMAo2O6Z0vLJeFOV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253082445"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="253082445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:03:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="580129123"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.180.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:03:58 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 2/2] firmware_loader: Move definitions from sysfs_upload.h to sysfs.h
Date:   Tue, 26 Apr 2022 13:03:56 -0700
Message-Id: <20220426200356.126085-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426200356.126085-1-russell.h.weight@intel.com>
References: <20220426200356.126085-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move definitions required by sysfs.c from sysfs_upload.h to sysfs.h so
that sysfs.c does not need to include sysfs_upload.h.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/base/firmware_loader/sysfs.c        |  1 -
 drivers/base/firmware_loader/sysfs.h        | 15 ++++++++++++++
 drivers/base/firmware_loader/sysfs_upload.c |  1 -
 drivers/base/firmware_loader/sysfs_upload.h | 23 +++++----------------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index eb7d9322a56e..5b0b85b70b6f 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -7,7 +7,6 @@
 #include <linux/types.h>
 
 #include "sysfs.h"
-#include "sysfs_upload.h"
 
 /*
  * sysfs support for firmware loader
diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
index e6c487937817..5d8ff1675c79 100644
--- a/drivers/base/firmware_loader/sysfs.h
+++ b/drivers/base/firmware_loader/sysfs.h
@@ -99,4 +99,19 @@ struct fw_sysfs *
 fw_create_instance(struct firmware *firmware, const char *fw_name,
 		   struct device *device, u32 opt_flags);
 
+#ifdef CONFIG_FW_UPLOAD
+extern struct device_attribute dev_attr_status;
+extern struct device_attribute dev_attr_error;
+extern struct device_attribute dev_attr_cancel;
+extern struct device_attribute dev_attr_remaining_size;
+
+int fw_upload_start(struct fw_sysfs *fw_sysfs);
+umode_t fw_upload_is_visible(struct kobject *kobj, struct attribute *attr, int n);
+#else
+static inline int fw_upload_start(struct fw_sysfs *fw_sysfs)
+{
+	return 0;
+}
+#endif
+
 #endif /* __FIRMWARE_SYSFS_H */
diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index c504dae00dbe..8cdcf3516c7e 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -4,7 +4,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include "sysfs.h"
 #include "sysfs_upload.h"
 
 /*
diff --git a/drivers/base/firmware_loader/sysfs_upload.h b/drivers/base/firmware_loader/sysfs_upload.h
index 9edd47d3f36a..31931ff7808a 100644
--- a/drivers/base/firmware_loader/sysfs_upload.h
+++ b/drivers/base/firmware_loader/sysfs_upload.h
@@ -1,9 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __FIRMWARE_UPLOAD_H
-#define __FIRMWARE_UPLOAD_H
+#ifndef __SYSFS_UPLOAD_H
+#define __SYSFS_UPLOAD_H
 
 #include <linux/device.h>
 
+#include "sysfs.h"
+
 /**
  * enum fw_upload_prog - firmware upload progress codes
  * @FW_UPLOAD_PROG_IDLE: there is no firmware upload in progress
@@ -36,19 +38,4 @@ struct fw_upload_priv {
 	enum fw_upload_err err_code;	  /* security manager error code */
 };
 
-#ifdef CONFIG_FW_UPLOAD
-extern struct device_attribute dev_attr_status;
-extern struct device_attribute dev_attr_error;
-extern struct device_attribute dev_attr_cancel;
-extern struct device_attribute dev_attr_remaining_size;
-
-int fw_upload_start(struct fw_sysfs *fw_sysfs);
-umode_t fw_upload_is_visible(struct kobject *kobj, struct attribute *attr, int n);
-#else
-static inline int fw_upload_start(struct fw_sysfs *fw_sysfs)
-{
-	return 0;
-}
-#endif
-
-#endif /* __FIRMWARE_UPLOAD_H */
+#endif /* __SYSFS_UPLOAD_H */
-- 
2.25.1

