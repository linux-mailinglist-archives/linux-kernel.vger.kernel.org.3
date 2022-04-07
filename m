Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19734F7FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiDGNEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbiDGNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:02:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851511AF7C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336436; x=1680872436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqQD8V1tZDNnF7Zs/RsGtMzs5YtWuA1/y2GnU/ZA+R8=;
  b=dnOncD7KhXsH1cr9w8ke8iAuC+R3x15z2VGwwyuCK5CWW4y8ekdxxjt8
   Qlz6gvhlB/ZYldDm0WFOKFGqHEePhHHgzopzvIWQR2ny8wKuC2hJstT6x
   izrQsBH/uW9JAPzWqXZQrNGbvTXZY0S30drxLblJQ5QdUI9jHud6cK/nE
   cz8F4q20NiQc/Y+LryneWVMopUXiCGKcaVrQI0ogr2rYCHBVlItThCLz2
   sF8mHAEJdij/3lw3Ua0hSFIy6fdn5Pkqhta8pzsaxh96Q2DDspAaYRz3y
   321WKsQXjDdtUPoJwNEovGVccrUunC3eLl3DELFpDbQGQtyrnJg9jTD0J
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="286293651"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="286293651"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571041242"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:25 -0700
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
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH 16/20] mei: mkhi: add memory ready command
Date:   Thu,  7 Apr 2022 15:58:35 +0300
Message-Id: <20220407125839.1479249-17-alexander.usyskin@intel.com>
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

From: Tomas Winkler <tomas.winkler@intel.com>

Add GSC memory ready command.
The command indicates to the firmware that
extend operation memory was setup and
the firmware may enter PXP mode.

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/mkhi.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
index 27a9b476904e..ea9fe487cb0f 100644
--- a/drivers/misc/mei/mkhi.h
+++ b/drivers/misc/mei/mkhi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2021, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -18,6 +18,13 @@
 
 #define MCHI_GROUP_ID  0xA
 
+#define MKHI_GROUP_ID_GFX              0x30
+#define MKHI_GFX_RESET_WARN_CMD_REQ    0x0
+#define MKHI_GFX_MEMORY_READY_CMD_REQ  0x1
+
+/* Allow transition to PXP mode without approval */
+#define MKHI_GFX_MEM_READY_PXP_ALLOWED  0x1
+
 struct mkhi_rule_id {
 	__le16 rule_type;
 	u8 feature_id;
@@ -42,4 +49,9 @@ struct mkhi_msg {
 	u8 data[];
 } __packed;
 
+struct mkhi_gfx_mem_ready {
+	struct mkhi_msg_hdr hdr;
+	uint32_t flags;
+} __packed;
+
 #endif /* _MEI_MKHI_H_ */
-- 
2.32.0

