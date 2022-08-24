Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC8459FC78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiHXOAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHXN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAF10FE8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6814B617D0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F440C433D6;
        Wed, 24 Aug 2022 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661349595;
        bh=24DO39uVA59fhWMiW4WyrPflQTYFQ4KqBhlx29/uJp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2T2JmI0z0fv+ODoHwI1oQFEI2OwvNRKK8g84LuADy3UKW8QWNDP7WNQUVIOPFBpJh
         FtFoGrrFpKt+Dv6L/+AJwpbeW7hqgigdS7mBNVMZAxDtEJC7tcr3lqiyFIxUlTU9ri
         9z5YgUP8y1NmXSHYebJVExKR5RQqXBwrRnV86zd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] soundwire: sysfs: move sdw_slave_dev_attr_group into the existing list of groups
Date:   Wed, 24 Aug 2022 15:59:47 +0200
Message-Id: <20220824135951.3604059-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=gregkh@linuxfoundation.org; h=from:subject; bh=24DO39uVA59fhWMiW4WyrPflQTYFQ4KqBhlx29/uJp4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlsetfCHyy783/1utsBHi5e17/fSjMsZ/ngMPWIZsvcc+zd D0IcOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi2/YyLJi+b9UNS7471xatk7y6IN pSb7/Q0v8M84wO3aj+8Ha6SY2no5uHQ23KBtXnuQA=
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

The sysfs logic already creates a list of groups for the device, so add
the sdw_slave_dev_attr_group group to that list instead of having to do
a two-step process of adding a group list and then an individual group.

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

 drivers/soundwire/sysfs_slave.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 3210359cd944..83e3f6cc3250 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -105,7 +105,10 @@ static struct attribute *slave_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(slave);
+
+static const struct attribute_group slave_attr_group = {
+	.attrs = slave_attrs,
+};
 
 static struct attribute *slave_dev_attrs[] = {
 	&dev_attr_mipi_revision.attr,
@@ -190,6 +193,12 @@ static const struct attribute_group dp0_group = {
 	.name = "dp0",
 };
 
+static const struct attribute_group *slave_groups[] = {
+	&slave_attr_group,
+	&sdw_slave_dev_attr_group,
+	NULL,
+};
+
 int sdw_slave_sysfs_init(struct sdw_slave *slave)
 {
 	int ret;
@@ -198,10 +207,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_device_add_group(&slave->dev, &sdw_slave_dev_attr_group);
-	if (ret < 0)
-		return ret;
-
 	if (slave->prop.dp0_prop) {
 		ret = devm_device_add_group(&slave->dev, &dp0_group);
 		if (ret < 0)
-- 
2.37.2

