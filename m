Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2F507EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358956AbiDTCfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358945AbiDTCfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:35:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212C1839A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650421981; x=1681957981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0eWwMl+ObBY5gfMXyIhi98beSo6eDTBnlE0TeJeZonY=;
  b=URmYQrr9Dkg6mvXqmzRBTJ4kZmVziYP3HTOyVnZW808CN1c5C4LRv6ne
   UR0TRYECz6ObIM2Ch8s2SC0YMAd5KgeN1DnBkk69+x5a0PPz4ZvP3LfoN
   fex6DKPOolUL1kFdn7FVSXKHeZW+kVQo7Svsj/MbNJeiuGLFYUwvRE+9x
   h8N6tCNsfESk1BgVmPFVdNjU1Q0nP6yNfBdzcC9NzbRk+bjsqccKUOWqN
   GmDcM4ihtFIOHET+XcfOyc8PZS4AnvcAkZSowP9uczLFFYR6bF8ePWxeP
   jcOtJxsa0ZG8o6LCQPLAOAWQb5T7el3vPNdw3DoVun+szWoNL4LXmMrDU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261522438"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="261522438"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:33:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529554562"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:32:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: intel: prevent pm_runtime resume prior to system suspend
Date:   Wed, 20 Apr 2022 10:32:39 +0800
Message-Id: <20220420023241.14335-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
References: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit e38f9ff63e6d ("ACPI: scan: Do not add device IDs from _CID if _HID is not valid")
exposes a race condition on a TGL RVP device leading to a timeout.

The detailed analysis shows the RT711 codec driver scheduling a jack
detection workqueue while attaching during a spurious pm_runtime
resume, and the work function happens to be scheduled after the
manager device is suspended.

The direct link between this ACPI patch and a spurious pm_runtime
resume is not obvious; the most likely explanation is that a change in
the ACPI device linked list management modifies the order in which the
pm_runtime device status is checked and exposes a race condition that
was probably present for a very long time, but was not identified.

We already have a check in the .prepare stage, where we will resume to
full power from specific clock-stop modes. In all other cases, we
don't need to resume to full power by default. Adding the
SMART_SUSPEND flag prevents the spurious resume from happening.

BugLink: https://github.com/thesofproject/linux/issues/3459
Fixes: 029bfd1cd53cd ("soundwire: intel: conditionally exit clock stop mode on system suspend")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 63101f1ba271..32e5fdb823c4 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1293,6 +1293,9 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	/* use generic bandwidth allocation algorithm */
 	sdw->cdns.bus.compute_params = sdw_compute_params;
 
+	/* avoid resuming from pm_runtime suspend if it's not required */
+	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+
 	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
-- 
2.17.1

