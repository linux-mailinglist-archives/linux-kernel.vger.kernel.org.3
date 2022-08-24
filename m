Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799B59FC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiHXOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiHXOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF879A62
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE83617D1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F958C4347C;
        Wed, 24 Aug 2022 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661349606;
        bh=6nZCzCUxqrkYMxJzTx9llPnlQoj8N2W8hF2t7ybajCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFzO7h+TWQh1k4tW2UsPRKxHtfH/AozcAm6+GAzzCP9bNMiOn34rzwlFH/XeuUKmD
         /zqJyekqcJHgWvWagvxMCqTghN5PJrHcLk+caCpsdXoWNFwfY3JG494JH4qg7w5KGv
         HjzROzhfjNdyxL7uTf3UOkhwE/rJxcNcnSLmI6ZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] soundwire: sysfs: have the driver core handle the creation of the device groups
Date:   Wed, 24 Aug 2022 15:59:49 +0200
Message-Id: <20220824135951.3604059-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=gregkh@linuxfoundation.org; h=from:subject; bh=6nZCzCUxqrkYMxJzTx9llPnlQoj8N2W8hF2t7ybajCc=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlsetc3zbNNcH33c353u4+W4q00Do2PnAv3L9k+zc9VtLc5 /B1nRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyEx49hvlvjtyfxP2uXNbmfW7fTdu oms6DIEwzz0x8KuR3V2qd79KSLyr1fTOdvzFrwDQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner.  Take advantage of
that by converting this driver to use this by moving the sysfs
attributes into a group and assigning the dev_groups pointer to it.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased on 6.0-rc1

 drivers/soundwire/bus_type.c    | 1 +
 drivers/soundwire/sysfs_local.h | 3 +++
 drivers/soundwire/sysfs_slave.c | 6 +-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 04b3529f8929..397fe9179369 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -215,6 +215,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 	drv->driver.probe = sdw_drv_probe;
 	drv->driver.remove = sdw_drv_remove;
 	drv->driver.shutdown = sdw_drv_shutdown;
+	drv->driver.dev_groups = sdw_attr_groups;
 
 	return driver_register(&drv->driver);
 }
diff --git a/drivers/soundwire/sysfs_local.h b/drivers/soundwire/sysfs_local.h
index 7268bc24c538..3ab8658a7782 100644
--- a/drivers/soundwire/sysfs_local.h
+++ b/drivers/soundwire/sysfs_local.h
@@ -11,6 +11,9 @@
 /* basic attributes to report status of Slave (attachment, dev_num) */
 extern const struct attribute_group *sdw_slave_status_attr_groups[];
 
+/* attributes for all soundwire devices */
+extern const struct attribute_group *sdw_attr_groups[];
+
 /* additional device-managed properties reported after driver probe */
 int sdw_slave_sysfs_init(struct sdw_slave *slave);
 int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave);
diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 3723333a5c2b..4c716c167493 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -204,7 +204,7 @@ static const struct attribute_group dp0_group = {
 	.name = "dp0",
 };
 
-static const struct attribute_group *slave_groups[] = {
+const struct attribute_group *sdw_attr_groups[] = {
 	&slave_attr_group,
 	&sdw_slave_dev_attr_group,
 	&dp0_group,
@@ -215,10 +215,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 {
 	int ret;
 
-	ret = devm_device_add_groups(&slave->dev, slave_groups);
-	if (ret < 0)
-		return ret;
-
 	if (slave->prop.source_ports || slave->prop.sink_ports) {
 		ret = sdw_slave_sysfs_dpn_init(slave);
 		if (ret < 0)
-- 
2.37.2

