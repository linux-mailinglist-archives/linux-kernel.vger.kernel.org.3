Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8154620B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349142AbiFJJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349695AbiFJJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:24:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2026.outbound.protection.outlook.com [40.92.99.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B0144BDE;
        Fri, 10 Jun 2022 02:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEV3MhWXCTOSQ3XH5Dy+TG5wE5eV8m3SGBgOp/aJKbmfmiXq5o1xksVciuVPYRS3gyqLO9R5KsUjxnA/Dk+GnfiSjTGq057v5Sj85kSNWu+It8KoHPxkiCckin0Gsj7J0Qa3CtO4E9eBNF60Vvds5pOu9hRYhqz9buzQ/FifRVXKWj0IvVuIkcVLKvANRI00gmHWm8Rl1d65JokPRrzi0r/Y8w9HnIDjbk4DCyqi2s8eyjrbMcRGW+YXxrrCl/d6xrx1QuG7xpPibshx2ML1jnHHZNGUzK3+6Qa+mZNgSgzvPPGZdqNv6Ev53P90vWfTLSpJQUcoWCic69y3J0fouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5Gndf3R9jznFS2JrOJtn/j19XkA5i2rvR3FDaQRvOM=;
 b=FbxE9NWTNRRpH2s7T1kcDogYbkQDy8LHv2uJJaLk0vhBXbwNiuzUjvK6Rm9NUjwaMm3lYpSsIUUK8hBj51CVMBw/s5zs+jNuPNwKgXvVMcKw0vdCdRRCpmd5U1Pwuy8Qt1FHG55ryg3JelrTDSN2TXuN3bLxHwGDCGJRSvRqNk1i4VCyUS5O1UxhyYYzgELXlfHCJJMvx+7ts5cr608vzvUU/bnx0+ZFjBLC+JyeRR8rg/RorYCv5i8N8du4Pv41KQDCKuxfomU20NQb62mtvapkB7yt5063cP/yv89iwMInEzdjeXgHEjSMySOKjP1p5x4d+ba4gDO6DUbd5iCeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5Gndf3R9jznFS2JrOJtn/j19XkA5i2rvR3FDaQRvOM=;
 b=R48ZKTyxxdveTAPCqCSa0CsThSGSuRZmSU1+Ul6iG2B0N0oTfQRQJjsSYpJ3r4172ObC7bQwfZeoK4v8pxSeOHYPNePe3lnG51ptF0mNvAyUjXRESD6iS1QW8/qQdw3wDvnXj1gwOhr6xU+WxsLYNAHUVl/WSCsy2uNlyRUtutNnqqVmPVJ2h89KoeHPK+Ti+IaPrNHFBCfwck+h3ElVCyUsUWJXvnf8hsgBZ6VR8DrqkKlGVl83TlNzqHfqY5QZPIkX2D5jpHldesIjLzL+tRb+Z0DHkba1vnu0O6fpMuK7Sb0tmeQhDRmeNwLPtJUNUD5aI4uRJ27qPJMNRXQ4tA==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by OS0P286MB0548.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 09:22:32 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 09:22:32 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v2] ACPI: Split out processor thermal register from ACPI PSS
Date:   Fri, 10 Jun 2022 17:22:05 +0800
Message-ID: <TYWP286MB2601DDBB0F472C876D36FBCCB1A69@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hJH9DDkDDkbr6d0vQhTB1TpIckErRADeexymWBJ5vVQ=]
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220610092205.2078989-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c556db5f-cedc-475e-7833-08da4ac2bf3a
X-MS-TrafficTypeDiagnostic: OS0P286MB0548:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuxNgBSAjKhYvnChFEkXzLgCHd0bjKDESGx2HctlZRJX3hakFsetc3MhHl5ZBoXf8jDAK9YxRyzu3M0rXBUi6mxpPPu+3AxpO/3xvN9hhpxAHOzv0t+66icHkamq7fKJTxVA505K+jchcu2qNWhtmGa7x/az0r7Ju9DA0SzxTW0hIoA5VjfccGB8RHRf3qN3qI1153kdb12F2scacty07PR7DgCdsNxU2lldEIWa4Kqh7W19Q/UaOSykXjKC8hq/6hlU9QwX3Z1kLcq9JGo3mXE/jVuoTjNDOr3+nUAnCRNZjGbTzieJKebnpLliZMkmKKhwbEyL6JEkp/gWdEnUBWrwAMV6mtkRBUZQujhdhwryLXwZ54PTcrolME9DfazEGpJcNkUS0+KMtaWvIVlb7R8yr/pKoNp3xSde81/KHG+0UTjDfKB7msjb+7ovqu5rOX5UgYUsm1Xtyt0zZ/cHkn26IVkccN0weLH/Uvc8oewg9skkuyq8hVCb7nnvixQ+He5AMwqxBeJyiNWjpeb5vo2PaU5TDPYRfQFjDqtGvx4dB9775+QgoMyV14dOb0ZZtmWH6/Qmfb3F7akjPHRiPA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mr2Y6bVTf2dj2c5gOTxIngmjt/p2RFqKA8RWLjpYSdVktDU5pffDW+kCOsqI?=
 =?us-ascii?Q?Ampe416dLNp2YYFgqzod2j93lFrBkwkZOJnNsD/FNqG0UqZHeiBsuE2hvHY5?=
 =?us-ascii?Q?LG7JZth5BrV7N2gZEQkBJjU4dfwFieQQ+FVCRM+QHeky/XDC/02DcjzJ0cZz?=
 =?us-ascii?Q?CL3HM3bbh83CbYGVEVyPMfyDbDZXxTHrqTG1IiXraeISQC4DtjRY+oJDlqYB?=
 =?us-ascii?Q?d54GLRYsMKo1bF5oPbSXp7w189v5BzFMA/lNxetzBex6tlwxz4avgldJJ/rw?=
 =?us-ascii?Q?cZ+seCOmNzRNTq9fD5IZbyT+A5fMqHeq+GDV3iSN9X2DTGJsLAAZE7Tq3pqi?=
 =?us-ascii?Q?qKpvmEzfl/2IIt4Pu4CgOK6lOwPnLrgbe6GwitjguDY7kfyZ0Sp3SGGwQhtB?=
 =?us-ascii?Q?CqX4RVXfw2IWdWrnDdpSt5tV3opBlWHw17LJekiwa3OJB2mY7fDDOLJcaTBY?=
 =?us-ascii?Q?tWk93PikA9qkZnnxx0xk4KaKdh4AgenlcIFJMoYgu3lGqAEr36+lv4OZSRnp?=
 =?us-ascii?Q?v/Ph3Cwn8a4iScc1SBC9PVOKS4QOlAEmSqIClwz+Hu6+DYNrszKrkkYp7QPa?=
 =?us-ascii?Q?vTkA9GIyUfzpyA86M351ltWkj+BD/PS4ZtZRThQEaEP4ft4o4/6gnx8B8z80?=
 =?us-ascii?Q?7uuaROaXmV9fVKq2QCRChFW+VJx1jYGoDNZO1YkkrKIijCc+MUkLYnuNFAkx?=
 =?us-ascii?Q?7ZSVe+BnN5AeMDOMd43u85qJRrsaPzy3bt3Y3OF906N3cuAs+6MBkAbiNh6q?=
 =?us-ascii?Q?XV5bF3A/IyYy3kZq1TsJc8VNjS+bhYudsuWOXhSrkmXRjN0n6haXeO8TM0zJ?=
 =?us-ascii?Q?yITGOt6sfWsfJLujU8q8k38RNSezRRFIFoRSdq40Hpba/M35c4Q+JM8DbtpF?=
 =?us-ascii?Q?Ifb/x71e2dzJpyglH4r4z1Y8m3vf5OQcLylSrxikca9eo7edNqx9w1tzkb0E?=
 =?us-ascii?Q?a09b8+qfgwMuoOg+Dy5eUBSxkOjASqj3gqVQm4S1ZMriGMuUDlAYsd5U3ECn?=
 =?us-ascii?Q?zzKiJG4bwnBBV2cwJcywJgA80JH9DaJX6B1j3HPxeSoVYTrOdCNlWCrgLr7s?=
 =?us-ascii?Q?mczp8k/CV8TaR+eIcI74WTYNLQdqm+nRal6s/KQIJ6EBKd7dzku5R1R77UKQ?=
 =?us-ascii?Q?jZOO9tl3l9ZyggpcfojqSNtAjzs3abKTHZ7xxZt6FMFFnWskEPAh8J7ynnnn?=
 =?us-ascii?Q?YHCLPh/SpZ8Pl4sQXcWQdUZ96ic4Cp5wuLpeS+v8vxfxRCU/xovuhljaNiXO?=
 =?us-ascii?Q?mdHMxQ9x8HWWWpnxf67pbt3Ip/CqVup2phc7ddmL2BQLfVOLmLtYJiXblCGB?=
 =?us-ascii?Q?z1VBhf+0599zpGVQj5x+tMIw8I7hV7AHo8a1zpFQcqpNtDrZVhXEMJimNtsD?=
 =?us-ascii?Q?7u7oiNL42tLBJ9Zt+9NaJSGaHXZnmQXLCa1hSNilSdNSnooBhC3tsC5IVS5O?=
 =?us-ascii?Q?nNwcx4TYlX4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c556db5f-cedc-475e-7833-08da4ac2bf3a
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 09:22:32.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0P286MB0548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
driver"), moves processor thermal registration to acpi_pss_perf_init(),
which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.

As ARM64 supports P-states using CPPC, it should be possible to also
support processor passive cooling even if PSS is not enabled. Split
out the processor thermal cooling register from ACPI PSS to support
this, and move it into a separate function in processor_thermal.c.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/acpi/Kconfig             |  2 +-
 drivers/acpi/Makefile            |  5 +--
 drivers/acpi/processor_driver.c  | 72 ++++----------------------------
 drivers/acpi/processor_thermal.c | 69 ++++++++++++++++++++++++++++++
 include/acpi/processor.h         |  6 ++-
 5 files changed, 84 insertions(+), 70 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1e34f846508f..2457ade3f82d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -255,7 +255,6 @@ config ACPI_DOCK
 
 config ACPI_CPU_FREQ_PSS
 	bool
-	select THERMAL
 
 config ACPI_PROCESSOR_CSTATE
 	def_bool y
@@ -287,6 +286,7 @@ config ACPI_PROCESSOR
 	depends on X86 || IA64 || ARM64 || LOONGARCH
 	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
+	select THERMAL
 	default y
 	help
 	  This driver adds support for the ACPI Processor package. It is required
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b5a8d3e00a52..0002eecbf870 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -109,10 +109,9 @@ obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
 
 # processor has its own "processor." module_param namespace
-processor-y			:= processor_driver.o
+processor-y			:= processor_driver.o processor_thermal.o
 processor-$(CONFIG_ACPI_PROCESSOR_IDLE) += processor_idle.o
-processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_throttling.o	\
-	processor_thermal.o
+processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_throttling.o
 processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
 
 obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 368a9edefd0c..a99ff1634665 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -139,75 +139,17 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
 }
 
 #ifdef CONFIG_ACPI_CPU_FREQ_PSS
-static int acpi_pss_perf_init(struct acpi_processor *pr,
-		struct acpi_device *device)
+static void acpi_pss_perf_init(struct acpi_processor *pr)
 {
-	int result = 0;
-
 	acpi_processor_ppc_has_changed(pr, 0);
 
 	acpi_processor_get_throttling_info(pr);
 
 	if (pr->flags.throttling)
 		pr->flags.limit = 1;
-
-	pr->cdev = thermal_cooling_device_register("Processor", device,
-						   &processor_cooling_ops);
-	if (IS_ERR(pr->cdev)) {
-		result = PTR_ERR(pr->cdev);
-		return result;
-	}
-
-	dev_dbg(&device->dev, "registered as cooling_device%d\n",
-		pr->cdev->id);
-
-	result = sysfs_create_link(&device->dev.kobj,
-				   &pr->cdev->device.kobj,
-				   "thermal_cooling");
-	if (result) {
-		dev_err(&device->dev,
-			"Failed to create sysfs link 'thermal_cooling'\n");
-		goto err_thermal_unregister;
-	}
-
-	result = sysfs_create_link(&pr->cdev->device.kobj,
-				   &device->dev.kobj,
-				   "device");
-	if (result) {
-		dev_err(&pr->cdev->device,
-			"Failed to create sysfs link 'device'\n");
-		goto err_remove_sysfs_thermal;
-	}
-
-	return 0;
-
- err_remove_sysfs_thermal:
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
- err_thermal_unregister:
-	thermal_cooling_device_unregister(pr->cdev);
-
-	return result;
-}
-
-static void acpi_pss_perf_exit(struct acpi_processor *pr,
-		struct acpi_device *device)
-{
-	if (pr->cdev) {
-		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-		sysfs_remove_link(&pr->cdev->device.kobj, "device");
-		thermal_cooling_device_unregister(pr->cdev);
-		pr->cdev = NULL;
-	}
 }
 #else
-static inline int acpi_pss_perf_init(struct acpi_processor *pr,
-		struct acpi_device *device)
-{
-	return 0;
-}
-
-static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
-		struct acpi_device *device) {}
+static inline void acpi_pss_perf_init(struct acpi_processor *pr) {}
 #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
 
 static int __acpi_processor_start(struct acpi_device *device)
@@ -229,7 +171,9 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
-	result = acpi_pss_perf_init(pr, device);
+	acpi_pss_perf_init(pr);
+
+	result = acpi_processor_thermal_init(pr);
 	if (result)
 		goto err_power_exit;
 
@@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 		return 0;
 
 	result = -ENODEV;
-	acpi_pss_perf_exit(pr, device);
+	acpi_processor_thermal_exit(pr);
 
 err_power_exit:
 	acpi_processor_power_exit(pr);
@@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
 		return 0;
 	acpi_processor_power_exit(pr);
 
-	acpi_pss_perf_exit(pr, device);
-
 	acpi_cppc_processor_exit(pr);
 
+	acpi_processor_thermal_exit(pr);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index d8b2dfcd59b5..93928db2ae5f 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -266,3 +266,72 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
 	.get_cur_state = processor_get_cur_state,
 	.set_cur_state = processor_set_cur_state,
 };
+
+int acpi_processor_thermal_init(struct acpi_processor *pr)
+{
+	struct acpi_device *device;
+	int result = 0;
+
+	if (!pr)
+		return -ENODEV;
+
+	device = acpi_fetch_acpi_dev(pr->handle);
+	if (!device)
+		return -ENODEV;
+
+	pr->cdev = thermal_cooling_device_register("Processor", device,
+						   &processor_cooling_ops);
+	if (IS_ERR(pr->cdev)) {
+		result = PTR_ERR(pr->cdev);
+		return result;
+	}
+
+	dev_dbg(&device->dev, "registered as cooling_device%d\n",
+		pr->cdev->id);
+
+	result = sysfs_create_link(&device->dev.kobj,
+				   &pr->cdev->device.kobj,
+				   "thermal_cooling");
+	if (result) {
+		dev_err(&device->dev,
+			"Failed to create sysfs link 'thermal_cooling'\n");
+		goto err_thermal_unregister;
+	}
+
+	result = sysfs_create_link(&pr->cdev->device.kobj,
+				   &device->dev.kobj,
+				   "device");
+	if (result) {
+		dev_err(&pr->cdev->device,
+			"Failed to create sysfs link 'device'\n");
+		goto err_remove_sysfs_thermal;
+	}
+
+	return 0;
+
+err_remove_sysfs_thermal:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+err_thermal_unregister:
+	thermal_cooling_device_unregister(pr->cdev);
+
+	return result;
+}
+
+void acpi_processor_thermal_exit(struct acpi_processor *pr)
+{
+	struct acpi_device *device;
+
+	if (!pr)
+		return;
+
+	device = acpi_fetch_acpi_dev(pr->handle);
+	if (!device)
+		return;
+
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev = NULL;
+	}
+}
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 194027371928..5746ac206219 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -442,8 +442,10 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
+int acpi_processor_thermal_init(struct acpi_processor *pr);
+void acpi_processor_thermal_exit(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
-#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
+#ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
 void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
 #else
@@ -455,6 +457,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
-#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
+#endif	/* CONFIG_CPU_FREQ */
 
 #endif
-- 
2.25.1

