Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0909585118
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiG2Nu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiG2Nu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:50:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BCA4D14E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02123B827C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E0EC433D6;
        Fri, 29 Jul 2022 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102645;
        bh=EP6Yu3dCPvwyTA4MaOkILpl77d2Wl68YPVt+IAE/yX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUwCS+jctbLKighaJvxZGtBxHAWr9YA6UQ0DzapxLFd762XQvhyosSWYc0bad7ic9
         tA7eynlL3DjsTcUPbCrFYRm8xPnzYUbnjesMIrOaGrGB0za0QDASpTG4Xj3xqEKWD/
         +jIFL0ZsvVy8YTeQFGpcreYBYX/iZEdIuHNg23UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the dp0 sysfs attributes
Date:   Fri, 29 Jul 2022 15:50:38 +0200
Message-Id: <20220729135041.2285908-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; i=gregkh@linuxfoundation.org; h=from:subject; bh=EP6Yu3dCPvwyTA4MaOkILpl77d2Wl68YPVt+IAE/yX8=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPn25Y2nKgevpxoUhnD0nvr7UR/lwfEld+eaWj5ve+8ed+ lUtZHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRvK8MC3ZLmxnt0LvLlbL4pj2b0Y N/X05de8IwV0pbcEuZvsX8w3u0lPM2LLG5Jy29FAA=
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

There's no need to special-case the dp0 sysfs attributes, the
is_visible() callback in the attribute group can handle that for us, so
add that and add it to the attribute group list making the logic simpler
overall.

This is a step on the way to moving all of the sysfs attribute handling
into the default driver core attribute group logic so that the soundwire
core does not have to do any of it manually.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/sysfs_slave.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 83e3f6cc3250..3723333a5c2b 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(words);
 
+static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
+			      int n)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
+
+	if (slave->prop.dp0_prop)
+		return attr->mode;
+	return 0;
+}
+
 static struct attribute *dp0_attrs[] = {
 	&dev_attr_max_word.attr,
 	&dev_attr_min_word.attr,
@@ -190,12 +200,14 @@ static struct attribute *dp0_attrs[] = {
  */
 static const struct attribute_group dp0_group = {
 	.attrs = dp0_attrs,
+	.is_visible = dp0_is_visible,
 	.name = "dp0",
 };
 
 static const struct attribute_group *slave_groups[] = {
 	&slave_attr_group,
 	&sdw_slave_dev_attr_group,
+	&dp0_group,
 	NULL,
 };
 
@@ -207,12 +219,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
-	if (slave->prop.dp0_prop) {
-		ret = devm_device_add_group(&slave->dev, &dp0_group);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (slave->prop.source_ports || slave->prop.sink_ports) {
 		ret = sdw_slave_sysfs_dpn_init(slave);
 		if (ret < 0)
-- 
2.37.1

