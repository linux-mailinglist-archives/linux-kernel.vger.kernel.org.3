Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE95553EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354965AbiFUW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353867AbiFUW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:57:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21713206F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655852224; x=1687388224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=govaHQk7YyG0eUsVlD5BABnVJzMY8uw730DimVkT0HA=;
  b=OGiuNAg//dHZNaUhI/c2Y+KlfrMS/cq3Xq5nwBQY61VqktY5n/JTrUxc
   FZwqCh8aRpPRFe4kyrxuedGroLXhtrckrO7kna7ia95MjRydMUHLEe5G/
   WP228yeDGd1r9IhQZaAwC1vAwYzYHLvZKdRCJZfyDp9jOQXsOrp2iS0DF
   BOqM5zkSc4IDHZKhaXkXpwmVWYX+d+NDuTSTYiZuOEui5duNIfny3FfLe
   54ro5mBmkQ+5EPBKQMBKIeuGtBpmjFEb6jrwEWUcsQVnrMLi/INjs16iA
   2TEMe7EhvLDne85au6pxiLAeIhKZA2NYndC1AQeH5ojY501oRNA4APtVb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344250732"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344250732"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:57:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="914354241"
Received: from dpasupul-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.178.35])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:57:02 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] soundwire: peripheral: remove useless ops pointer
Date:   Tue, 21 Jun 2022 17:56:39 -0500
Message-Id: <20220621225641.221170-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621225641.221170-1-pierre-louis.bossart@linux.intel.com>
References: <20220621225641.221170-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are using the ops structure directly from the driver,
there are no users left of this ops pointer.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index bf6f0decb3f6d..39058c841469f 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -637,7 +637,6 @@ struct sdw_slave_ops {
  * @dev: Linux device
  * @status: Status reported by the Slave
  * @bus: Bus handle
- * @ops: Slave callback ops
  * @prop: Slave properties
  * @debugfs: Slave debugfs
  * @node: node for bus list
@@ -667,7 +666,6 @@ struct sdw_slave {
 	struct device dev;
 	enum sdw_slave_status status;
 	struct sdw_bus *bus;
-	const struct sdw_slave_ops *ops;
 	struct sdw_slave_prop prop;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
-- 
2.34.1

