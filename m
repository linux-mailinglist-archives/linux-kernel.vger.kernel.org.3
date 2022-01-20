Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943DB49509C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357711AbiATOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:54:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:9944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356917AbiATOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642690471; x=1674226471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZ/6QRCbXKz2uPbny7BLUdY7VrneEb9rP+jgHoalIWo=;
  b=cTTVbNtzKdLz2BZNP7aa7Q1mMeexx1iWef5feBiMCDvVMIDKvFiUYF8v
   Wyv0cU/0Mg0YQ42XdxBDDKLZwaZZgEWP4DfNEQisCDhMZzifjVQvnxH6G
   8Z+X7L2QoFf2cMJG39vtnCGH6Gx4hLWOGCNobq5H1cuVvoUqN0o3o/Fee
   4McnuLvHBR2REwp2MyzVT2pndCE4OR/SBr3jciGzT0MkPjDjBSzreZBgH
   MyViKJ4YRqJXNsQdbMKcU+n37PNXBJoH82iPuFF0Pw2jOMTHrRVGcePHm
   eGBmMW57/u32QXhjkDzlitA0q6MCCXweF9IrmSqw0i7gOZlV++6n0djhn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="226043299"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="226043299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 06:54:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="532797640"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 06:54:24 -0800
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
Subject: [PATCH v3 5/5] mei: gsc: retrieve the firmware version
Date:   Thu, 20 Jan 2022 16:53:51 +0200
Message-Id: <20220120145351.520555-6-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220120145351.520555-1-alexander.usyskin@intel.com>
References: <20220120145351.520555-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

