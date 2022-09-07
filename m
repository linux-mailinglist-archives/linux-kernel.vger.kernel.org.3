Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EFB5B0978
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIGQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIGQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:00:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577B3248DD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566386; x=1694102386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8WXuqM2Btnztwxu+hZDAOvoXEutBVbE7ajm9wvLA1E=;
  b=jWAMiCFJm9y7W/Hrm40wosgZ+Xvbf+LhqpCFTUejjPSo36kOj5lrGudr
   nMOH9eu2pOeYjoAk6aBezhs+erYRNxVRLaisiB+4DD/2Q/isfDK2M1/ac
   x894zuhAPKU3z6MmWxRVFgh7l1PmePrYakdsCvCLED2Zvhn1Orsq8a6m+
   tqmhJ0RtLiKER4EnYlSQRgXYSiEpJIUF0Wr41xcWFzkguvjcWkjs9qWSa
   zetOob5YFxzduS1jBWpS15SbqqguRsFtMV+dSenR0mqLnZIkoNkJIdv4n
   tJz1U8lB1FV3mJK0oRANpjsqJRzPR5TJG660YNCBepK4TvK9EvG+p9sMi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297701444"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="297701444"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676248078"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:18 -0700
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
Subject: [PATCH v8 10/16] mei: mkhi: add memory ready command
Date:   Wed,  7 Sep 2022 18:58:07 +0300
Message-Id: <20220907155813.1427526-11-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907155813.1427526-1-tomas.winkler@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/misc/mei/mkhi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
index 43cadfb1b990..c9d0b2b9dfa0 100644
--- a/drivers/misc/mei/mkhi.h
+++ b/drivers/misc/mei/mkhi.h
@@ -30,6 +30,13 @@
 /* Allow transition to PXP mode without approval */
 #define MKHI_GFX_MEM_READY_PXP_ALLOWED  0x1
 
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
@@ -54,4 +61,9 @@ struct mkhi_msg {
 	u8 data[];
 } __packed;
 
+struct mkhi_gfx_mem_ready {
+	struct mkhi_msg_hdr hdr;
+	u32    flags;
+} __packed;
+
 #endif /* _MEI_MKHI_H_ */
-- 
2.37.2

