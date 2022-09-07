Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E305B037C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiIGL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIGL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:56:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D77FE40;
        Wed,  7 Sep 2022 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662551782; x=1694087782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3n8tdgr/41V9HMQjef7gsGonwwy/i4gJxjnLqt2rlU=;
  b=cOIQNhuwTtYUo1nM/EHDaKnxfxQZCaVzfTxtrQL0Qe7d5mhf1vBj3rf5
   P4MTtSOOunIeAqT3ifuEbv8ybMsmRB0797LgOSvGSxD2OXmnxsmismuRw
   0Fgz7IV6XJNk14/nqycHUE5wqd1QYkctRuU2/N62mb3UP5+nj12EO88ag
   DP/PAQboaYEEczpQuJjB5GvEarzjVwK67f7mw0pNvoMfTbjcthDtazB/Z
   5ny7Y9QeIw/TMiyfugE+dY7IC+oFBYNljMf9ig9ErsY+gerpeJXAfXakG
   9JpQ32zfCH2WszdYoSyGuqZCRq/cj/F56pjt0X+w57X2R6U4VZN5jyYxO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296851231"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="296851231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="756742687"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 04:56:18 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, grzegorz.alibozek@gmail.com,
        bastian@rieck.me, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: [RFC PATCH 2/2] usb: typec: ucsi: acpi: Add PM hooks
Date:   Wed,  7 Sep 2022 14:56:26 +0300
Message-Id: <20220907115626.21976-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
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

Some systems notify the driver separately after resume if
the state of the connection changed during suspend, but
there is no way we can rely on that.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=210425
Fixes: a94ecde41f7e ("usb: typec: ucsi: ccg: enable runtime pm support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 8873c1644a295..8c7008cc9942e 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -185,6 +185,20 @@ static int ucsi_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ucsi_acpi_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int ucsi_acpi_resume(struct device *dev)
+{
+	struct ucsi_acpi *ua = dev_get_drvdata(dev);
+
+	return ucsi_resume(ua->ucsi);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_acpi_pm_ops, ucsi_acpi_suspend, ucsi_acpi_resume);
+
 static const struct acpi_device_id ucsi_acpi_match[] = {
 	{ "PNP0CA0", 0 },
 	{ },
@@ -194,6 +208,7 @@ MODULE_DEVICE_TABLE(acpi, ucsi_acpi_match);
 static struct platform_driver ucsi_acpi_platform_driver = {
 	.driver = {
 		.name = "ucsi_acpi",
+		.pm = pm_ptr(&ucsi_acpi_pm_ops),
 		.acpi_match_table = ACPI_PTR(ucsi_acpi_match),
 	},
 	.probe = ucsi_acpi_probe,
-- 
2.35.1

