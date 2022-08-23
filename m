Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5292B59D046
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiHWE6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiHWE6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:58:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759B5A155
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661230684; x=1692766684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+A6ixbjMYao4eit3+mRKLLFN97auJ3zXE3KZtIv1l4=;
  b=Rb79lyWvWPu8zjcRebC39OtdMac9HI1zpckPO+4t0sQbEE219kB9QIfZ
   kUZtGGqlZKrWldScrn82s6U0OqcVlZtx29YZrYD1V2VzymLfTpmZbAYJE
   lNlOhebVA+K2TBKBJ7s36tSuuXbZceYIdUWBhAXzlR8vGZv/uhGW+1yry
   blKTKabcmdE0FNwP7n48APK5WPuDQUxsmWN4ahkbR6mebsUfGS9FFZSDX
   90K2SNJAJcfpPiRFOoyd3yALimCCyCihRLbYPvob/8Kswj4k7SlIRb+t/
   eVkQClUOyGDJ41iGK9Ki3pz1NGjPw4VGVap//Gli+IcA+4OIdfcrKE7+K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291148300"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291148300"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:58:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="605536645"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:58:02 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: bus: remove use of __func__ in dev_dbg
Date:   Tue, 23 Aug 2022 13:01:57 +0800
Message-Id: <20220823050158.2671245-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
References: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The module and function information can be added with
'modprobe foo dyndbg=+pmf'

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8970f8560766..2772973eebb1 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -827,13 +827,13 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	mutex_lock(&bus->bus_lock);
 
 	dev_vdbg(bus->dev,
-		 "%s: changing status slave %d status %d new status %d\n",
-		 __func__, slave->dev_num, slave->status, status);
+		 "changing status slave %d status %d new status %d\n",
+		 slave->dev_num, slave->status, status);
 
 	if (status == SDW_SLAVE_UNATTACHED) {
 		dev_dbg(&slave->dev,
-			"%s: initializing enumeration and init completion for Slave %d\n",
-			__func__, slave->dev_num);
+			"initializing enumeration and init completion for Slave %d\n",
+			slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
 		init_completion(&slave->initialization_complete);
@@ -841,8 +841,8 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
 		dev_dbg(&slave->dev,
-			"%s: signaling enumeration completion for Slave %d\n",
-			__func__, slave->dev_num);
+			"signaling enumeration completion for Slave %d\n",
+			slave->dev_num);
 
 		complete(&slave->enumeration_complete);
 	}
@@ -1849,8 +1849,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 				"Update Slave status failed:%d\n", ret);
 		if (attached_initializing) {
 			dev_dbg(&slave->dev,
-				"%s: signaling initialization completion for Slave %d\n",
-				__func__, slave->dev_num);
+				"signaling initialization completion for Slave %d\n",
+				slave->dev_num);
 
 			complete(&slave->initialization_complete);
 
-- 
2.25.1

