Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380E4F60E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiDFOG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiDFOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:06:09 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27E2398880;
        Wed,  6 Apr 2022 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649237796;
  x=1680773796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sKttvewg13jPI0W2V5bQyh9PjPvGiCcvTJm9/+nsTOw=;
  b=FVSGDEeByy6YZrQAJDkMgNa7hVyMMtb+zcdSqQEFHzm6hmQkaRMDJH9u
   R3UAoa0EIXmg+I33VRrJiLiOj7nVifpSqQ0L6TMiKsRj5RtwHzjskeBAL
   WIbm/KEBKKTzD1q3VaMTugPAn4SlRfQTu3++jHfSQyRmbAg/4d/LBc/us
   q0gBpwGMYkRf3Jsaz6Tv38h7pebWZLwgvyyX4FvOX/UAr4jxt/9UyszNd
   loiXUY5H/4+PBqK9u6PFIhMm5VnTC63c0EDcaoHhO6aCpHl8T7Bhb4WWE
   HfgWihd6UL76ZMWxd0Qvn0dShedXkT3RvNt4dxqdmlmzi7oGUxycDeYK3
   w==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (tmp401) Support extended temperature range
Date:   Wed, 6 Apr 2022 11:29:01 +0200
Message-ID: <20220406092901.408861-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

This patch only applies to tmp431 and devicetree configuration.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 Documentation/hwmon/tmp401.rst | 13 +++++++++++++
 drivers/hwmon/tmp401.c         |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/hwmon/tmp401.rst b/Documentation/hwmon/tmp401.rst
index 3aacf3d3bdf3..d12e9c9ba40f 100644
--- a/Documentation/hwmon/tmp401.rst
+++ b/Documentation/hwmon/tmp401.rst
@@ -78,3 +78,16 @@ some additional features.
 
 TMP432 is compatible with TMP401 and TMP431. It supports two external
 temperature sensors.
+
+Device tree
+-----------
+TMP431 has support for the device tree parameter "extended-range" which enables
+the extended range in the chip.
+
+Example:
+
+main-temp@4c {
+  compatible = "ti,tmp431";
+  reg = <0x4c>;
+  extended-range;
+};
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index b86d9df7105d..6efd2475ffda 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -557,6 +557,11 @@ static int tmp401_init_client(struct tmp401_data *data)
 	config_orig = config;
 	config &= ~TMP401_CONFIG_SHUTDOWN;
 
+	if (of_property_read_bool(data->client->dev.of_node, "extended-range")) {
+		/* Enable extended range */
+		config |= TMP401_CONFIG_RANGE;
+	}
+
 	data->extended_range = !!(config & TMP401_CONFIG_RANGE);
 
 	if (config != config_orig)
-- 
2.30.2

