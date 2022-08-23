Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF859D02D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiHWEqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbiHWEqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:46:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D654C8E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661229980; x=1692765980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aOGj0K2ETS0PToUhNjSmBRGkI427Kgkon4oqhCsUotM=;
  b=Kxw90btpNoYxDcI1EoWUYwvxb8KAc6FsCo7s9uJYky7ASlYFtvNeF3bm
   hdKWinzraT5ok+I/VDNpHaKpTVDSgtWh517ZvuvHfjN9Psj01BL90IF1l
   qeY5muJXFK3XIIQ+Alc+xhH683zQF2QXQQdekjCSABjfyLTxVgLw6U/Jh
   NeON7SL9s32zQAJ7ZnAzziEOGRipyonQOacApu/xG7+Yya/CukP7gT+oH
   RLQKAkucQ3Jkk2QGYUr4HTRhduKA9Br1GukLmMdEObmS5TvW8gfWAurCe
   4HeYohuhuNxiUjHdlVnUQa6yA6/qdUXqYyD/9k7ESJkvRjzph+FaRXVUk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291146804"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291146804"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="669855112"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: intel: set dev_num_ida_min
Date:   Tue, 23 Aug 2022 12:50:04 +0800
Message-Id: <20220823045004.2670658-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
References: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 89d1d0d021fc..3e372599a8c3 100644
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
 
@@ -1307,6 +1310,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->msg_count = 0;
 
 	bus->link_id = auxdev->id;
+	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
 
 	sdw_cdns_probe(cdns);
 
-- 
2.25.1

