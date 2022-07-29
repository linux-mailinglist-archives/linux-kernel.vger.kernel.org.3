Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E158511B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiG2NvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiG2NvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442651A0C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7742161F59
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49381C433C1;
        Fri, 29 Jul 2022 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102653;
        bh=Xi/suYWq5yRzsGd5eqkdgLrr3CqV7gd+MC6h1EUQO6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW/P9BcvxuXQG/nj4vKXKn27AqgRPEXH+PyQL/1e9uxxEihUmwncXHzB4uGPKDpaN
         eihpB0EsgHA0As6n36gcGWBmB3tPeASifzER7qSjrwJ35U+C+WRAjU6BhVA7HZOihS
         ShBvUvhsJNwXQkmR0BHFKJIJj5Z/qslXTQUJRDrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] soundwire: sysfs: have the driver core handle the creation of the device groups
Date:   Fri, 29 Jul 2022 15:50:39 +0200
Message-Id: <20220729135041.2285908-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=gregkh@linuxfoundation.org; h=from:subject; bh=Xi/suYWq5yRzsGd5eqkdgLrr3CqV7gd+MC6h1EUQO6c=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPn274xhL0prnw/j+zp17aHMu6MsJadO7lfVg1/UKfdXrq tCD+jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIxVSG+aHnu3Wdv5unsKiH3V3TFN e/bsfiSQyzWTwPz8heoLCvMoKzro7163fPuKvuAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/soundwire/bus_type.c    | 1 +
 drivers/soundwire/sysfs_local.h | 3 +++
 drivers/soundwire/sysfs_slave.c | 6 +-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 893296f3fe39..81c77e6ddbad 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -193,6 +193,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 
 	drv->driver.owner = owner;
 	drv->driver.probe = sdw_drv_probe;
+	drv->driver.dev_groups = sdw_attr_groups;
 
 	if (drv->remove)
 		drv->driver.remove = sdw_drv_remove;
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
2.37.1

