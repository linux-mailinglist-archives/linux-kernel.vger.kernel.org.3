Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFF5738C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiGMOZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiGMOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:25:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F5033416
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657722344; x=1689258344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYwVi73XEXhFXoO6kNb2ZMDbR48obx7haFf1QGVKu6o=;
  b=ZslnfeYPEwocF4EmwNl6q6AzIqIndRrRlGWYJNabL24lcn2Z2gbuwSvi
   m7QxuQwyCI7ggqcHPC3inXCeSSXbqMI75HGJtZXgMGLKpgjLy/FIDt5LP
   lM7MzGEQWoLh4rwWOrSRJ66i+qflduevJ/9RKLWMxTeE2pSHIT6hihQtg
   UUoJyS857fJhXMVjfdBW1wjwFWahvbctlzDynTWmoJ1O9AgD6ywmy2PH8
   ikSmy3UtGcUggWanTjoqXunpBOstE9r3Mlb7DNU+1NuVOYfSj6MtAPDMf
   Y/mTkic2u0yH22cloq8nFvU3w2yy9wxRn/AmmqXfVwi4uaN8HQiLDW2yV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285968200"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285968200"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:25:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570643761"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:25:42 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: intel: set dev_num_ida_min
Date:   Wed, 13 Jul 2022 22:25:29 +0800
Message-Id: <20220713142529.17323-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
References: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The allowed values for SoundWire device numbers are between 1 and 11
(inclusive). HDaudio/iDISP codecs typically use SDI values 0..3
(inclusive). To allow for a unique peripheral SDI/dev_number across
HDaudio and SoundWire buses, we set the minimum base to 4. This still
allows for 8 SoundWire peripherals in the system, currently more than
needed in actual products.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 95ce292994cc..85d4268eea65 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -22,6 +22,9 @@
 #include "bus.h"
 #include "intel.h"
 
+/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
+#define INTEL_DEV_NUM_IDA_MIN           4
+
 #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
 #define INTEL_MASTER_RESET_ITERATIONS	10
 
@@ -1297,6 +1300,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->msg_count = 0;
 
 	bus->link_id = auxdev->id;
+	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
 
 	sdw_cdns_probe(cdns);
 
-- 
2.25.1

