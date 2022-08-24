Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644659FC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiHXOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiHXOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2967435C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB716617D5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01517C433C1;
        Wed, 24 Aug 2022 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661349603;
        bh=dUTwXXFu5PCz/IzkEcwjndg31DOpffH9A3ry/4de9h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wW9jIJcIUdQlKMtLr5BuYINEhp9PaZ1EQFI3HuwI5xviVxoM9YPCjYmlb8AxWeQar
         VEFCI1SrVjZPW/1jCuhMc5dvmVoYT7sulJIqZ+cdWvEmeOeRFNc+dO7wzeFZhXIFcl
         ejij0boP1PLor8nBHb2/4WlfvOEN1qKNiCbzPY50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] soundwire: sysfs: cleanup the logic for creating the dp0 sysfs attributes
Date:   Wed, 24 Aug 2022 15:59:48 +0200
Message-Id: <20220824135951.3604059-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=gregkh@linuxfoundation.org; h=from:subject; bh=dUTwXXFu5PCz/IzkEcwjndg31DOpffH9A3ry/4de9h8=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlseteef/mh/zH/b9e7visGKimyzaIfutadlrgbIrRVbulC yY1NHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRt6YMC9ZHOc5U8ObLOvxx/sRp+0 +L5HhkLGKYn9Yf7dNVz5my54TV3Y0iD+1YL3WrAwA=
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
v2: rebased on 6.0-rc1

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
2.37.2

