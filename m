Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA805459AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiFJBvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiFJBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:51:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C4D22077A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654825877; x=1686361877;
  h=from:to:cc:subject:date:message-id;
  bh=oSdC3O+POFF40bTteE4J5n5uoo0yRjFF5UGT4T/X844=;
  b=DPV8gFumGyWYkk9TItwkHih5Fw1C51CG9Qf+erfttM1zb41ZwKjrcxPn
   KoRtQpd7DeZUvvluvek8JoKoh3w2FxkuJegCWwl6XpLcSdD/c9++M9jc1
   ndHNBT0HQW/26fzm/vTYX7jS3oZANIwN+JKgFfewxidikddJeG0l/2BG8
   n8kZGVkaNHsZTPDBfDvRuCcEHpzpJ/CPZ8nOtTl0TNVNo/tzRSNqT77iw
   9cNTM8Hlv99NDbLFrROPCrWpkz+dOL8Y3P2V+N/9eBN/7gsklJIM9X6aK
   a/+AWSxhvjLlAcrnF3yFztpQXX9J6zm01sC++rdPsA4voGx+ANJ/o6VmI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276251809"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276251809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:51:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="724715862"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:51:15 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: bus_type: fix remove and shutdown support
Date:   Fri, 10 Jun 2022 09:51:05 +0800
Message-Id: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The bus sdw_drv_remove() and sdw_drv_shutdown() helpers are used
conditionally, if the driver provides these routines.

These helpers already test if the driver provides a .remove or
.shutdown callback, so there's no harm in invoking the
sdw_drv_remove() and sdw_drv_shutdown() unconditionally.

In addition, the current code is imbalanced with
dev_pm_domain_attach() called from sdw_drv_probe(), but
dev_pm_domain_detach() called from sdw_drv_remove() only if the driver
provides a .remove callback.

Fixes: 9251345dca24b ("soundwire: Add SoundWire bus type")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus_type.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 893296f3fe39..b81e04dd3a9f 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -193,12 +193,8 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 
 	drv->driver.owner = owner;
 	drv->driver.probe = sdw_drv_probe;
-
-	if (drv->remove)
-		drv->driver.remove = sdw_drv_remove;
-
-	if (drv->shutdown)
-		drv->driver.shutdown = sdw_drv_shutdown;
+	drv->driver.remove = sdw_drv_remove;
+	drv->driver.shutdown = sdw_drv_shutdown;
 
 	return driver_register(&drv->driver);
 }
-- 
2.17.1

