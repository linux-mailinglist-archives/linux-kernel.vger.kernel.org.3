Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485684B3A83
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 10:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiBMJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 04:15:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiBMJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 04:15:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A5B5C85F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 01:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644743732; x=1676279732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0+9h4gdneAFI8HU9XMkkmHHDEOYNHZ9uOwtlenAKakw=;
  b=igvTovlYnyEzMH4iUAPIgwkQJeYJYCRb2q1+BP7JenvNXQEUKtotEMMp
   HKv+/siRQDqShdfuouuQKdfEoov32pCNDw3Kutr1088Aie+OIjHGXO2Dd
   vtDmwAjRpNluB2gEeZv8QzanM0VQiJPUsrSItotBxP66GQXHRvJgjdH6V
   PaEdULoEEX3hp0Zk9snA1e8J3ImeIZAIaP0ocSxdl/l/1zPOMW4vRhdIy
   8+TwFeKhUPXVhpr9FWCetm8/SWnYO2Ax1J4meox8JFAbLa0L3cP6HDN1y
   TCq1sXk0jSlFbVcDJ0ayZ3+3pvsUDBlA/rAT8XN1by+CGZ9QKSv2jicC6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="233486491"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="233486491"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 01:15:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="702569010"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 01:15:29 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v6 5/5] mei: gsc: retrieve the firmware version
Date:   Sun, 13 Feb 2022 11:14:58 +0200
Message-Id: <20220213091458.2364014-6-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213091458.2364014-1-alexander.usyskin@intel.com>
References: <20220213091458.2364014-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hook to retrieve the firmware version of the
GSC devices to bus-fixup.
GSC has a different MKHI clients GUIDs but the same message structure
to retrieve the firmware version as MEI so mei_fwver() can be reused.

CC: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V5: Rebase
V6: Rebase
---
 drivers/misc/mei/bus-fixup.c | 25 +++++++++++++++++++++++++
 drivers/misc/mei/hw-me.c     |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 67844089db21..59506ba6fc48 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -30,6 +30,12 @@ static const uuid_le mei_nfc_info_guid = MEI_UUID_NFC_INFO;
 #define MEI_UUID_MKHIF_FIX UUID_LE(0x55213584, 0x9a29, 0x4916, \
 			0xba, 0xdf, 0xf, 0xb7, 0xed, 0x68, 0x2a, 0xeb)
 
+#define MEI_UUID_IGSC_MKHI UUID_LE(0xE2C2AFA2, 0x3817, 0x4D19, \
+			0x9D, 0x95, 0x06, 0xB1, 0x6B, 0x58, 0x8A, 0x5D)
+
+#define MEI_UUID_IGSC_MKHI_FIX UUID_LE(0x46E0C1FB, 0xA546, 0x414F, \
+			0x91, 0x70, 0xB7, 0xF4, 0x6D, 0x57, 0xB4, 0xAD)
+
 #define MEI_UUID_HDCP UUID_LE(0xB638AB7E, 0x94E2, 0x4EA2, \
 			      0xA5, 0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
 
@@ -241,6 +247,23 @@ static void mei_mkhi_fix(struct mei_cl_device *cldev)
 	mei_cldev_disable(cldev);
 }
 
+static void mei_gsc_mkhi_ver(struct mei_cl_device *cldev)
+{
+	int ret;
+
+	/* No need to enable the client if nothing is needed from it */
+	if (!cldev->bus->fw_f_fw_ver_supported)
+		return;
+
+	ret = mei_cldev_enable(cldev);
+	if (ret)
+		return;
+
+	ret = mei_fwver(cldev);
+	if (ret < 0)
+		dev_err(&cldev->dev, "FW version command failed %d\n", ret);
+	mei_cldev_disable(cldev);
+}
 /**
  * mei_wd - wd client on the bus, change protocol version
  *   as the API has changed.
@@ -492,6 +515,8 @@ static struct mei_fixup {
 	MEI_FIXUP(MEI_UUID_NFC_HCI, mei_nfc),
 	MEI_FIXUP(MEI_UUID_WD, mei_wd),
 	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
+	MEI_FIXUP(MEI_UUID_IGSC_MKHI, mei_gsc_mkhi_ver),
+	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_ver),
 	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
 	MEI_FIXUP(MEI_UUID_ANY, vt_support),
 	MEI_FIXUP(MEI_UUID_PAVP, whitelist),
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 9748d14849a1..7e77328142ff 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1577,12 +1577,14 @@ static const struct mei_cfg mei_me_pch15_sps_cfg = {
 static const struct mei_cfg mei_me_gsc_cfg = {
 	MEI_CFG_TYPE_GSC,
 	MEI_CFG_PCH8_HFS,
+	MEI_CFG_FW_VER_SUPP,
 };
 
 /* Graphics System Controller Firmware Interface */
 static const struct mei_cfg mei_me_gscfi_cfg = {
 	MEI_CFG_TYPE_GSCFI,
 	MEI_CFG_PCH8_HFS,
+	MEI_CFG_FW_VER_SUPP,
 };
 
 /*
-- 
2.32.0

