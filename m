Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9A4F7FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbiDGNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbiDGNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:02:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215233EB7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336433; x=1680872433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKB4wsXeTTixnZhNl+XO4dlT40sWJ18dZLXVtPn+i/c=;
  b=FfGC6tLNliw4jD4IYJhhBY+KURYQdnnBqUyCtJgMg981xt/bgVXviVVf
   nc1m2W/4d3tbjToDMZcy+X9uC+owL+ecGPX1SDpJnCMQBLO0oG4v4DNbc
   yMzELvtroyh10c9xa/INWPGYHcl5JbJfwVO1XevwLTzNVK3O3UAmQvFNl
   VYtzSYFes9bC6nuW7lpqTd39lev7rwgROb9dWztEtXFNwLrpBEMszEkCV
   T5aoRf0QZ26vQUisUdk0rfeFWA3iPOfWgr38jhxOzp8AdI8FQd6fm+/pi
   55wWQONgrf8laAR0C3dga2APghwYAyEKAxPrZwzgh/zfHWZGbfZQJEm5B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="286293642"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="286293642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571041229"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:21 -0700
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
Subject: [PATCH 15/20] mei: bus: export common mkhi definitions into a separate header
Date:   Thu,  7 Apr 2022 15:58:34 +0300
Message-Id: <20220407125839.1479249-16-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407125839.1479249-1-alexander.usyskin@intel.com>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
2.32.0

