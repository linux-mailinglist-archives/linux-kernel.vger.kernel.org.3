Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0375738D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiGMO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGMO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:29:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66A275ED
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657722587; x=1689258587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c+A6ixbjMYao4eit3+mRKLLFN97auJ3zXE3KZtIv1l4=;
  b=KecE5e7xJM5TOnKayl4Lm6sNfyFcqjmWHpG2EH3tqo15ZPA2pxPg0e3s
   2LvtyxZsQS/sl/U2DRLu310SplXKqg5EJgRMkY0YA5JnM82dPPlBATS4m
   jO3997J2Tsy6r9NJCNZF0GxMvEXFePKNfxDZ6c3P0hj98sYTEsdhpaLtc
   HxZTiNSHbEFf5rCg5dHFsaylyyZW4/XaTgwVjpmrWcqtEk6StHfSxRFQg
   wpS7SwMoPQ/MWE2Y1sU4vyWwsExtwltIHyTVfTfTbj0uADQ6zHoxdVr4N
   it+lNw8E+iy5hbLYoEYxZIng4pLjT0WuROxg2g82CUF4Ini6OwcRmrmXv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285251385"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285251385"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:29:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="622966715"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:29:44 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        gregkh@linuxfoundation.org
Subject: [PATCH 1/2] soundwire: bus: remove use of __func__ in dev_dbg
Date:   Wed, 13 Jul 2022 22:29:36 +0800
Message-Id: <20220713142937.17562-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

