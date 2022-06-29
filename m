Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB88E55FE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiF2LaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiF2L36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:29:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACB3EA8E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502197; x=1688038197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9ut9z/fZxKjjiQooTok4xMtiOCkI3kVzTpzryb8gCQ=;
  b=AmLMVNzpL+JBASa+dKBcBErZMJeGdaqBJHwEZ1h6i9wfbMwZ0XVNybkJ
   xHKKO9nhNcnBhKynEVFwoliyp+Bkw1NxHy6stwVlEo4VWYogZIkIPiK7A
   asnsp8h+MA9on3ff4PV8DgM0sqTZ+LpYG+FVYMuIYsBvmnwgYzp3Q6iHn
   khMODVQxdbST/QCtd7iwL9T2K8EzK5wuTBbYNDrzyr+8Q5eNmeXxUPmhp
   ulTIr94WxeNauvG6tG0qt/hyUBzUD3OtgNeU5uPeiur/xT/Ub70/J4z4C
   gK96x9AOkOytAgjthqkU7lT4lqXOxC7Ycr94Ddp1V2tnKVocNYzLVuFIV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368319306"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="368319306"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:29:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647353178"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:29:54 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/14] mei: bus: export common mkhi definitions into a separate header
Date:   Wed, 29 Jun 2022 14:29:08 +0300
Message-Id: <20220629112913.1210933-10-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629112913.1210933-1-alexander.usyskin@intel.com>
References: <20220629112913.1210933-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Exported common mkhi definitions from bus-fixup.c into a separate
header file mkhi.h for other driver usage.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 32 ++-----------------------
 drivers/misc/mei/mkhi.h      | 45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 30 deletions(-)
 create mode 100644 drivers/misc/mei/mkhi.h

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 24e91a9ea558..190691abddc9 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -15,6 +15,7 @@
 
 #include "mei_dev.h"
 #include "client.h"
+#include "mkhi.h"
 
 #define MEI_UUID_NFC_INFO UUID_LE(0xd2de1625, 0x382d, 0x417d, \
 			0x48, 0xa4, 0xef, 0xab, 0xba, 0x8a, 0x12, 0x06)
@@ -80,6 +81,7 @@ static void whitelist(struct mei_cl_device *cldev)
 }
 
 #define OSTYPE_LINUX    2
+
 struct mei_os_ver {
 	__le16 build;
 	__le16 reserved1;
@@ -89,20 +91,6 @@ struct mei_os_ver {
 	u8  reserved2;
 } __packed;
 
-#define MKHI_FEATURE_PTT 0x10
-
-struct mkhi_rule_id {
-	__le16 rule_type;
-	u8 feature_id;
-	u8 reserved;
-} __packed;
-
-struct mkhi_fwcaps {
-	struct mkhi_rule_id id;
-	u8 len;
-	u8 data[];
-} __packed;
-
 struct mkhi_fw_ver_block {
 	u16 minor;
 	u8 major;
@@ -115,22 +103,6 @@ struct mkhi_fw_ver {
 	struct mkhi_fw_ver_block ver[MEI_MAX_FW_VER_BLOCKS];
 } __packed;
 
-#define MKHI_FWCAPS_GROUP_ID 0x3
-#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
-#define MKHI_GEN_GROUP_ID 0xFF
-#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
-struct mkhi_msg_hdr {
-	u8  group_id;
-	u8  command;
-	u8  reserved;
-	u8  result;
-} __packed;
-
-struct mkhi_msg {
-	struct mkhi_msg_hdr hdr;
-	u8 data[];
-} __packed;
-
 #define MKHI_OSVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
 			    sizeof(struct mkhi_fwcaps) + \
 			    sizeof(struct mei_os_ver))
diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
new file mode 100644
index 000000000000..27a9b476904e
--- /dev/null
+++ b/drivers/misc/mei/mkhi.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
+ * Intel Management Engine Interface (Intel MEI) Linux driver
+ */
+
+#ifndef _MEI_MKHI_H_
+#define _MEI_MKHI_H_
+
+#include "mei_dev.h"
+
+#define MKHI_FEATURE_PTT 0x10
+
+#define MKHI_FWCAPS_GROUP_ID 0x3
+#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
+#define MKHI_GEN_GROUP_ID 0xFF
+#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
+
+#define MCHI_GROUP_ID  0xA
+
+struct mkhi_rule_id {
+	__le16 rule_type;
+	u8 feature_id;
+	u8 reserved;
+} __packed;
+
+struct mkhi_fwcaps {
+	struct mkhi_rule_id id;
+	u8 len;
+	u8 data[];
+} __packed;
+
+struct mkhi_msg_hdr {
+	u8  group_id;
+	u8  command;
+	u8  reserved;
+	u8  result;
+} __packed;
+
+struct mkhi_msg {
+	struct mkhi_msg_hdr hdr;
+	u8 data[];
+} __packed;
+
+#endif /* _MEI_MKHI_H_ */
-- 
2.34.1

