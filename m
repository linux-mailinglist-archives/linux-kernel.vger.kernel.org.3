Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEAB59FC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiHXOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiHXOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF5F804A5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB68FB82543
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F9C433C1;
        Wed, 24 Aug 2022 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661349609;
        bh=laXM6lyBiYvs+XzB8BFEK5j81iYzsKzZFFBxOwJyqwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEgVk8kKEceE2CWXuFKiYOQH/RZ2cjiIBL4YyzW7FyvQMhhjcf+Kgwzm41FXyWt8b
         yVqRWtDnaUn8YTjvo07Tn6Os7B3z2JrGnD7GNrKlhVRUWibUtaBrKteL9n637kC9am
         4WemvuuILboR6VieSnCAmmzhzwLQ0+8300gPwDak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] soundwire: sysfs: remove sdw_slave_sysfs_init()
Date:   Wed, 24 Aug 2022 15:59:50 +0200
Message-Id: <20220824135951.3604059-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=gregkh@linuxfoundation.org; h=from:subject; bh=laXM6lyBiYvs+XzB8BFEK5j81iYzsKzZFFBxOwJyqwE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlsetfbZtb5vM9Oy9M9rv91x5OwOVM7eC9JOWf96Sys6Pln 9HhdRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkNYJhDrc/788lyn1bpXaaLJDeW+ cy+ZC+BsOCCVZfTs90+iy8/7dfhvL7Tcx7Nmd5AgA=
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

Now that sdw_slave_sysfs_init() only calls sdw_slave_sysfs_dpn_init(),
just do that instead and remove sdw_slave_sysfs_init() to get it out of
the way to save a bit of logic and code size.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased on 6.0-rc1

 drivers/soundwire/bus_type.c        |  4 ++--
 drivers/soundwire/sysfs_local.h     |  1 -
 drivers/soundwire/sysfs_slave.c     | 13 -------------
 drivers/soundwire/sysfs_slave_dpn.c |  3 +++
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 397fe9179369..5e488dd64724 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -123,8 +123,8 @@ static int sdw_drv_probe(struct device *dev)
 	if (drv->ops && drv->ops->read_prop)
 		drv->ops->read_prop(slave);
 
-	/* init the sysfs as we have properties now */
-	ret = sdw_slave_sysfs_init(slave);
+	/* init the dynamic sysfs attributes we need */
+	ret = sdw_slave_sysfs_dpn_init(slave);
 	if (ret < 0)
 		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
 
diff --git a/drivers/soundwire/sysfs_local.h b/drivers/soundwire/sysfs_local.h
index 3ab8658a7782..fa048e112629 100644
--- a/drivers/soundwire/sysfs_local.h
+++ b/drivers/soundwire/sysfs_local.h
@@ -15,7 +15,6 @@ extern const struct attribute_group *sdw_slave_status_attr_groups[];
 extern const struct attribute_group *sdw_attr_groups[];
 
 /* additional device-managed properties reported after driver probe */
-int sdw_slave_sysfs_init(struct sdw_slave *slave);
 int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave);
 
 #endif /* __SDW_SYSFS_LOCAL_H */
diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 4c716c167493..070e0d84be94 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -211,19 +211,6 @@ const struct attribute_group *sdw_attr_groups[] = {
 	NULL,
 };
 
-int sdw_slave_sysfs_init(struct sdw_slave *slave)
-{
-	int ret;
-
-	if (slave->prop.source_ports || slave->prop.sink_ports) {
-		ret = sdw_slave_sysfs_dpn_init(slave);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
 /*
  * the status is shown in capital letters for UNATTACHED and RESERVED
  * on purpose, to highligh users to the fact that these status values
diff --git a/drivers/soundwire/sysfs_slave_dpn.c b/drivers/soundwire/sysfs_slave_dpn.c
index c4b6543c09fd..a3fb380ee519 100644
--- a/drivers/soundwire/sysfs_slave_dpn.c
+++ b/drivers/soundwire/sysfs_slave_dpn.c
@@ -283,6 +283,9 @@ int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave)
 	int ret;
 	int i;
 
+	if (!slave->prop.source_ports && !slave->prop.sink_ports)
+		return 0;
+
 	mask = slave->prop.source_ports;
 	for_each_set_bit(i, &mask, 32) {
 		ret = add_all_attributes(&slave->dev, i, 1);
-- 
2.37.2

