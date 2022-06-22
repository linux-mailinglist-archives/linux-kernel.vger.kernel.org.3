Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C495D554DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358600AbiFVOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358775AbiFVOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:49:34 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50107.outbound.protection.outlook.com [40.107.5.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3C3E5C6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTi7sfkXHLXqSpc+4Wp09epE/pPMjj1/8SKMuKD9o229PhVL5YX2oI3GYMzLDNhrCYApW/l58vYyG1/Oso2TlFBJliBzFfOOwI7z4apFCNE7BLMuT5CCYRv5dES5epqUXRqVZsgw0KMU12UmFlGLtOAFiSWWHwqf1KsqYnKYNUbFVP7z074vrG0SsMd2aFIUtvQ06pQL1D2Snw6mZdqXu3RbjHP6TCSUjYpY45SsyOzTN+0WZBAsQ2YQyw8xBqDcYbh87E3kK1IdQFZAGH5DUCRSho4VYO3KZK2yBKQq29HBvajVJRZYMhCzoMneo0rVy/2w1Hum9SvLB00aMQQcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8OzlpzFHYKiG29ow9tar4xUHsLqxUPNZYw6ztbXhGQ=;
 b=e4a5Cxmj1zTzABHH9ucAdcuwK3RSYBoGEBFne6KTw1VLiqQ0hzvP6t1sB7yO0J+fBSPLmnrN78CsNCiJdkp0GH4uq3Wh9k58eS84njChj4PLMVMKAqdTkxAIRtN0hA69BS4VauYxHTfVdro5bSoen+vYTUqaa5tOXEadBmzcnVijQAUzIRNZq+evKFGXAs6MLtJlX4k4NWLr21QiYa3V2noJAhWC7OG92uzIEwdNxYyxTs2C7tc4Xj6rpRQzFFiQHLCt1f7Nd0yZuTHAuLQIR+1DlWw+PFLuC29DZUx16xFSFQR7Q1MPbS5Q+DdAuNFoP+4Sv0p9bsWcpcPvBHrwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8OzlpzFHYKiG29ow9tar4xUHsLqxUPNZYw6ztbXhGQ=;
 b=DRC8iINYPWWhhDbLAafM2yfWjhpjchND3Pi3DWFD+UkEJ8/kGcgXdG7/2Yi5Twsw5WkQZSi6u49EpFXfLovkmt/onqUm1NOmKii7B7RiuVsW+Whi2dI2SjUpyQJvc0FpjDGfvYfozQ1lIxynsjnvWAixAqI9Xx/V5Se6m1WrdSI=
Received: from OL1P279CA0028.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::15)
 by AM7P122MB0232.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 14:49:14 +0000
Received: from HE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::11) by OL1P279CA0028.outlook.office365.com
 (2603:10a6:e10:13::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Wed, 22 Jun 2022 14:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 HE1EUR01FT091.mail.protection.outlook.com (10.152.0.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 14:49:13 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by ext-eur1.smtp.philips.com with ESMTP
        id 3pGkoYU1Nl9Zi41fNoHJ85; Wed, 22 Jun 2022 16:49:13 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
        by smtprelay-eur1.philips.com with ESMTP
        id 41fNoElZZK1kB41fNoyNj0; Wed, 22 Jun 2022 16:49:13 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.222.238])
        by mail.bbl.ms.philips.com (Postfix) with ESMTP id 67C631832D3;
        Wed, 22 Jun 2022 16:49:13 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
        id 6154A2A0010; Wed, 22 Jun 2022 16:49:13 +0200 (CEST)
From:   Julian Haller <jhaller@bbl.ms.philips.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Haller <julian.haller@philips.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 5.4 1/2] hwmon: Introduce hwmon_device_register_for_thermal
Date:   Wed, 22 Jun 2022 16:49:01 +0200
Message-Id: <20220622144902.2954712-1-jhaller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
Reply-To: Julian Haller <julian.haller@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d6ebff47-8e4b-499c-f76f-08da545e5fe1
X-MS-TrafficTypeDiagnostic: AM7P122MB0232:EE_
X-Microsoft-Antispam-PRVS: <AM7P122MB02320431F778C153B710BB85C4B29@AM7P122MB0232.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KLBCTKGeLWAK62EWP0gs4hgmqkwkK2s+Lv9bYbpXDz9hi8i/KZUXuycofpX/mL6AdyDGzFavRlYtOjurGO4sf1RwnSf8vMKNcuTQrG1GOjtVlEP2Ioa7jgYqKLvdNHJm3DKH6CFXgG9a/YA2Qh5nbmVQc2L4oG5jCwAHajJ5lMCIkl4kbM4BB9IyHRzV+iaVLeYIRlsiNzxWflNO9H0pO+GhX91TmchS2o38bRbnuSkTfIqE/7QLe6uXERijPssZ8Ds7oO3+mNqmmXKm1JVtxmuQXuc3dTmyQVqhpC/uNyijfWsvSgjxfqZiILeCY2/NXCP0hqr3mbRv4SRzvzhC3yKIbNbAXiTaQSPMHxYRSfzx+LR84ldaIuA6wu3JKRfAYFmSztpFYGv2Nulin4I3VCsDM+P2CP7/X+d1YXUU0u5lAOBCmpnFvEEKL3iQH7KTURbZcUHR/yNnzDfZA3Lf3PHTOKISjxiJ5IafDRI52ONFhW7Z1FApQTPZrOJpJD49Zb9CL94KlIXnrN8mnR0hTFlZqZfWLqOP6K7Cnb26iLxgDmrEnJnxhmTPPfpMGw6tXhex+HKc/AfJ9XKVy4X0qpNui25JGq6jJT6FMAbTogjwAPdfRkflA1jgKvdyfeFcxDIkNbKAkjbIZPf2qk6f1sf+nI9eGVr7Ry+BI5K52uuJCo/wo4K6X3ApcGx2XHSU1bMgqIxsUSAH3IpCtLbrIQasJTIiD24bzMed9JRycgx1JgDRfHgGCm29lRiGgVgpSjRnZA9g1UgFNNREH9fGg==
X-Forefront-Antispam-Report: CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(5660300002)(4326008)(2906002)(42186006)(8936002)(54906003)(86362001)(70206006)(40460700003)(6666004)(478600001)(26005)(6266002)(8676002)(70586007)(316002)(40480700001)(7596003)(41300700001)(82310400005)(7636003)(47076005)(186003)(2616005)(1076003)(356005)(426003)(336012)(120186005)(82960400001)(36860700001)(82740400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 14:49:13.7712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ebff47-8e4b-499c-f76f-08da545e5fe1
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P122MB0232
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ upstream commit e5d21072054fbadf41cd56062a3a14e447e8c22b ]

The thermal subsystem registers a hwmon driver without providing
chip or sysfs group information. This is for legacy reasons and
would be difficult to change. At the same time, we want to enforce
that chip information is provided when registering a hwmon device
using hwmon_device_register_with_info(). To enable this, introduce
a special API for use only by the thermal subsystem.

Acked-by: Rafael J . Wysocki <rafael@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 25 +++++++++++++++++++++++++
 include/linux/hwmon.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c73b93b9bb87..e8a9955e3683 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -743,6 +743,31 @@ hwmon_device_register_with_info(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
 
+/**
+ * hwmon_device_register_for_thermal - register hwmon device for thermal subsystem
+ * @dev: the parent device
+ * @name: hwmon name attribute
+ * @drvdata: driver data to attach to created device
+ *
+ * The use of this function is restricted. It is provided for legacy reasons
+ * and must only be called from the thermal subsystem.
+ *
+ * hwmon_device_unregister() must be called when the device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new device.
+ */
+struct device *
+hwmon_device_register_for_thermal(struct device *dev, const char *name,
+				  void *drvdata)
+{
+	if (!name || !dev)
+		return ERR_PTR(-EINVAL);
+
+	return __hwmon_device_register(dev, name, drvdata, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(hwmon_device_register_for_thermal);
+
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 72579168189d..104c492959b9 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -408,6 +408,9 @@ hwmon_device_register_with_info(struct device *dev,
 				const struct hwmon_chip_info *info,
 				const struct attribute_group **extra_groups);
 struct device *
+hwmon_device_register_for_thermal(struct device *dev, const char *name,
+				  void *drvdata);
+struct device *
 devm_hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,
 				const struct hwmon_chip_info *info,
-- 
2.25.1

