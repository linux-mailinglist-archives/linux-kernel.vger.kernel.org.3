Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475A5685D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiGFKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiGFKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:40:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD7275FC;
        Wed,  6 Jul 2022 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657104042; x=1688640042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zAK50Spisa7GeZXKP48r6TLqhRoJiitehih9FHycgQ=;
  b=UTHxCpw6V6NgWvh0t/0rhJymG4gJJWBNTbU7WyfTRxIAVmqoNtopNUmx
   hdqlix6xmxmiQLbAqdhhV5u2KnYA2RODpBl/h6DGTmoITblhlxrUNI0DA
   ASRa4b7EUwVdw4b3rJYpl+owiQ4Gcw7SHwLSa1Bq9ta5ahktpVUUMKTP2
   FS2k+kfn+G1Tc2Gar14h3w+2lFt5ybo3QCxwLOhUzxqSVgIQmcOVeiztg
   2HogvKpp9F8WXWA1qq68yBMX2Ows63mQTxVkkrdps4xmlnuLdt71zC5Yz
   jjsrxynLO8S53A+jDhOcFDdIEyH9vRPfW59n77dCBdDBxizB6Zl0LbJlG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="264127913"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="264127913"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:40:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="597621185"
Received: from gklab-106a-125.igk.intel.com (HELO localhost) ([10.211.106.125])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:40:40 -0700
From:   "Kallas, Pawel" <pawel.kallas@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     iwona.winiarska@intel.com, pawel.kallas@intel.com
Subject: [PATCH 2/3] hwmon: (pmbus) refactor sensor initialization
Date:   Wed,  6 Jul 2022 12:40:23 +0200
Message-Id: <20220706104024.3118590-3-pawel.kallas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706104024.3118590-1-pawel.kallas@intel.com>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce separate function to initialize pmbus sensor attributes.
It can be used to initialize different sensor types.

Signed-off-by: Kallas, Pawel <pawel.kallas@intel.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 37 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 4bcb70ab9b598..6e3ec6a223b92 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1168,6 +1168,26 @@ static int pmbus_add_boolean(struct pmbus_data *data,
 	return pmbus_add_attribute(data, &a->dev_attr.attr);
 }
 
+static void pmbus_sensor_init(struct pmbus_sensor *sensor, const char *name, const char *type,
+			      int seq, int page, int phase, int reg,
+			      enum pmbus_sensor_classes class, bool update, bool convert)
+{
+	if (type)
+		snprintf(sensor->name, sizeof(sensor->name), "%s%d_%s",
+			 name, seq, type);
+	else
+		snprintf(sensor->name, sizeof(sensor->name), "%s%d",
+			 name, seq);
+
+	sensor->page = page;
+	sensor->phase = phase;
+	sensor->reg = reg;
+	sensor->class = class;
+	sensor->update = update;
+	sensor->convert = convert;
+	sensor->data = -ENODATA;
+}
+
 static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 					     const char *name, const char *type,
 					     int seq, int page, int phase,
@@ -1182,25 +1202,14 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	sensor = devm_kzalloc(data->dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
 		return NULL;
-	a = &sensor->attribute;
 
-	if (type)
-		snprintf(sensor->name, sizeof(sensor->name), "%s%d_%s",
-			 name, seq, type);
-	else
-		snprintf(sensor->name, sizeof(sensor->name), "%s%d",
-			 name, seq);
+	pmbus_sensor_init(sensor, name, type, seq, page, phase, reg, class, update, convert);
 
 	if (data->flags & PMBUS_WRITE_PROTECTED)
 		readonly = true;
 
-	sensor->page = page;
-	sensor->phase = phase;
-	sensor->reg = reg;
-	sensor->class = class;
-	sensor->update = update;
-	sensor->convert = convert;
-	sensor->data = -ENODATA;
+	a = &sensor->attribute;
+
 	pmbus_dev_attr_init(a, sensor->name,
 			    readonly ? 0444 : 0644,
 			    pmbus_show_sensor, pmbus_set_sensor);
