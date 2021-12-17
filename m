Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8404785AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhLQHlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:41:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:20314 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhLQHlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639726872; x=1671262872;
  h=from:to:cc:subject:date:message-id;
  bh=1dLPK95x3eU2yzo1L8SF2MlB2t5nsUGwVoHTt5tWHBA=;
  b=i/cPL8FYNv22vF+Y8z4Mpv3yOF9KXIHLxgDlBAP+Aad+BSGt5Rl5sw38
   uYmsCprwnYxX87eL/CRTWw1I/LbPKd4cXLxMuiTCAYgGhr/ibVzrHaHFO
   faJznsvx5mVOOVThSAfurQJ8wFo8+VLTt5q9Vqfm6N0dEh/su7/hC7/wG
   6EjTaG66256NREZDZfWgpobfVuUXMia5qoA6cpNFd39AIwKTgxBX7Dter
   UuRlCFjsANpxN8cq4BpB6ABdIZvNSszsbV4tgOylXaBbxIjVNwh5Jsygm
   A61B5KqOemvE1TDSVfEPOfsctxhy3q0QkdxUfuYIbNpxAnH823GBURisM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263872883"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="263872883"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="506669099"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 23:41:09 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH] HID: intel-ish-hid: ipc: Specify no cache snooping on TGL and ADL
Date:   Fri, 17 Dec 2021 15:45:41 +0800
Message-Id: <20211217074541.4705-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify that both TGL and ADL don't support DMA cache snooping.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 45e0c7b1c9ec..8ccb246b0114 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -909,7 +909,11 @@ static uint32_t ish_ipc_get_header(struct ishtp_device *dev, int length,
  */
 static bool _dma_no_cache_snooping(struct ishtp_device *dev)
 {
-	return dev->pdev->device == EHL_Ax_DEVICE_ID;
+	return (dev->pdev->device == EHL_Ax_DEVICE_ID ||
+		dev->pdev->device == TGL_LP_DEVICE_ID ||
+		dev->pdev->device == TGL_H_DEVICE_ID ||
+		dev->pdev->device == ADL_S_DEVICE_ID ||
+		dev->pdev->device == ADL_P_DEVICE_ID);
 }
 
 static const struct ishtp_hw_ops ish_hw_ops = {
-- 
2.17.1

