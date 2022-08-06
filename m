Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1E58B577
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiHFM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiHFM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:27:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB11402A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788867; x=1691324867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q60lqOYoK0CC5fpK0MwwQkf5wpLEltQV3Cdq2brHiBM=;
  b=hWj+GPReSYKsieO6gek2EZMgp3QdTCAs7fT6oS6vg6Q894K6QMxPjD7r
   NXnG9+DIne1LrUqx1jHHlq938NH83UDrzdc1O4XAqB+r/x31Kk8clbuvl
   qA6nDrFZFts3IGFSC6y6vW0j8Pxl7/F6rRIobPIcTsTFMQifUqPu3aZ4b
   /BVtqJ9DfXyhEXTkJ7BYLFXGlAd/r3NobqBJ496bnLW1mZd9dxsR0h6ET
   UgbH8bqZyDGqclTrMI+DovrT0TK4xUaemc8nGIkFrJKTeTDz7DEDzejGl
   SQTTzaQEsyNCjCruqjzQDIWF2A7gLFM/GqDs2hmJ9XSz2/YlTEKDHxnYz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289121902"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289121902"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632329116"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:44 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v7 10/15] mei: mkhi: add memory ready command
Date:   Sat,  6 Aug 2022 15:26:31 +0300
Message-Id: <20220806122636.43068-11-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122636.43068-1-tomas.winkler@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GSC memory ready command.
The command indicates to the firmware that extend operation
memory was setup and the firmware may enter PXP mode.

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/mkhi.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
index 27a9b476904e..056b76e73d40 100644
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
+	u32    flags;
+} __packed;
+
 #endif /* _MEI_MKHI_H_ */
-- 
2.37.1

