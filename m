Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B71953DAC9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiFEH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbiFEH63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:58:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2028.outbound.protection.outlook.com [40.92.99.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A63818A;
        Sun,  5 Jun 2022 00:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlLb3vOoEmIBqDxltU9hRoemT6YdVUiBF76gDGTWdbVL5ycecRf4rpcfQ0+uu5CBsRZcs6YU2sJIOr7IIdV+qXq9X4g7ICMm+V+10m4RiBPxlcQMXSap30rQR7sT3ZpZSK4y+sgTzX1Kk1vx/P/TFFlLy6PpwdV85BAlCQuM8xvKUHDysDkGTSwCV6OPZ8WMOUbJOlGgOyn5e0HVDO18h/vJWGcdFNX7UNxr2zmjavG3B5zAuAOFqyaDJpZdeB5xtFFZCkRh3J2xmVFxCHUgfRQ3Sa6VWpoEkEXsk83aig/IRPt1MNOjxs+VB+uqWTVXMKNv896WVV7wSFRsfUGcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCcK68eYMF48JcPunfCn7rwrTCYKjnB88/9GSsmeuW4=;
 b=VqAzLF50WnXcRN3zNIpU1n+Pct5tYXiU3ti7TRrMi7i70kEKlRuV3d+2iB+zThXOyD9FnL9hSuLni1CVLYHp3GqSRsRlxpao+6KUP463hw7n8XbN514K89jZMB4oexytD7PF6Q+SfY1XyjjtQfWNg6jFarj32BSBYZlGU+wWFcDmiunrk/CNzzGv6LjWkyHPbZr7opjPp6MPCghup6lJ341bJjetNgYOYlCIuQYgHKhpuI3T7orlA3n5uyyueH/OSKNcuYGQSpcJc6zkpQyBXfIhXyhvRD1qaw5k1RUIk4b6L1sPohFSp8vRApMgxmdIg1ca8UuV0BF6IhA3ozWsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcK68eYMF48JcPunfCn7rwrTCYKjnB88/9GSsmeuW4=;
 b=SHpjYPvdE6z/6ZEV8LtGw9O9BRE9K9hO/2CLRLIU8q73eXjmhx7FDlDJKAVucwV4iUZKtXpUiUx9koejZgXwe0+BrgapZ0lTYhYebRKoo05B9n/UL1k2L+s37ySTD4Co3k6dA/NLBjVplBjg4HIftRjumQPxpz14ublTleTwso5G1+4WhtPlaAv/ZvhbSWBMA953b5AsDC2OtW6go0zmRez8wn71Yl+I3MJEv5WzpZxr9oMoIvxVCe3Tu5xXjczKrU3kqxCPrP0NrD7jIrw9FvX9Jbg89o5P3qr1/7BfUHRp0Ot4z8pHKWBMh+kB0CP5gL6DObe1NTgPK7iAgH/2zw==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by TYCP286MB0832.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Sun, 5 Jun
 2022 07:58:25 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 07:58:25 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, Riwen Lu <luriwen@kylinos.com>
Subject: [PATCH v1] ACPI: Split out processor thermal register from ACPI PSS
Date:   Sun,  5 Jun 2022 15:58:14 +0800
Message-ID: <TYWP286MB26019A5110491AC2C0157082B1A39@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cWMIWANSCxBr9943Pff9M7VyY1CjpjFrNDP5JZCvpyc=]
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220605075814.2176503-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3411a6e1-8a72-4f8b-3998-08da46c92b02
X-MS-TrafficTypeDiagnostic: TYCP286MB0832:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjexvVMI3EqS1P+3qbIvTG/RC3+hkKpxdsAisSV5KIxhGt+DTGRt5yMwayV7BwxVTT34VzVxqFuZPwjN4Z4zwRR7u/sCGidkZIkMRVElwZXPL4NmvpgRY40nLFxskgchtU64wmY9b8Ma7eFwDhin6qBBT6PlwGzOyuFmJQaR8cgAeSTu7voJbxylu0j3wfEn3zeT3SMBvpkkAxMvHK90XqXvq5ck7uyC+zO0zYngG1/YOvqt+rVTl/saUT6Moq6Gwcv+VRqqLS3rANspV8jC91gnfDeRM8X3ptXrzP3rjEsNlqEbLJC3wSwbdNq6873sidHEMzRaXuLFmzvygLwiU8se0Y8OMDghOJ5f8WJKPWh4f3TNSF41MtUO2mwjor2XoCOcJtMwtLSQUsfeescGflAb81cNG3MKi0388CfF2A5FzWkfIB49FjTp8kA+bI8gMkdPxeHh9NoUkSJ6bjVfiEwhKiuY3DUScUs6Ce9Fj/cTn+DjOs71HA57L6q1wQ7ihgFph0X6PZdNDhed32j+T5t8f/pfIh5XubhnbJJvKGhYyxT1WScRXHaCVhyn8Y/ca9uu/JtII4FDAph9aES9dA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?505KLPtlKsTHIEjaY5hSJ08mo1zyKpodYQBMbIHcecZ6WNLlyxTK6yObpuTI?=
 =?us-ascii?Q?pn9gR94trEqvA7oX2XhV0+D2/FnOMR9tc1iVl76yc2V9sFGd0CwkepP0XNTE?=
 =?us-ascii?Q?HQpkjY3bGhYU8URxKoCRUkUNv9wiytadLpxPzrhL+y/1NrVJcXxaq0Ioke2K?=
 =?us-ascii?Q?v3NrKHq5WI3nYE1e8jnE5WzaiVPLqepf7kISXJHtBkoQURHMwkcjvsAdo2Ed?=
 =?us-ascii?Q?4kEjWZwWeYuSFawiEzK7Ts2Ah7ofkJ4NHrq63J5zlBmpZhc2k/iL2OXmk3bi?=
 =?us-ascii?Q?zV370vpqiinmzd8kFn5/chDFdb4mpPSrLFzUfubTWywIrQc3p/sJVkyrglGQ?=
 =?us-ascii?Q?ahXgDnuVj3BohX8528drUvEqAThamR5KYDiWzP1QDF4tBrN8fYQOIQ7poD5n?=
 =?us-ascii?Q?hK/i/ndYBVEY3a8GBU6mwT8B0+CpHCkB5zcATnDGvERm3YEaozdca9v1Yfmx?=
 =?us-ascii?Q?cz82QlUFQ75tb/FLFOG+WMgT8To7ToiP+sTZ0sjbrbnI4WdYbxRLnXWo+Bvu?=
 =?us-ascii?Q?p4vHgyMiweE7JA9pNbvaz02LnCfHDjxQKqTHgfgxiNVp+P8y/bz8o+duXFnx?=
 =?us-ascii?Q?m3ohSSISFmm7Lgjmdj2p13Z/l+LBjifglDz0W3Gfbd3BZRggE1U/K3CguRKA?=
 =?us-ascii?Q?wbKV3Sa8flhgMJshASaxv2TxyHaIn1l4oN7iMhwdEmHBeaOtCttDg4BLdzsJ?=
 =?us-ascii?Q?+xNK/guUVtdCQJw3MCwYoJq1vQx0PXXzrnxKxJk6SZIgLDbBPq89R7sFKg/8?=
 =?us-ascii?Q?/FdwsyYl9TfiUfJf89V5QoFK+Dca+0EsEeNRBI6brbTqB7ygSipytBoJORAc?=
 =?us-ascii?Q?i3Y7CWfpYzZvEcwCNJBu3coCQ46vDzLb7hPrH7hIynB8v2pZQjLdp8kcqdCl?=
 =?us-ascii?Q?WHKGTEljlWXiYtDmztP8fnygMNzMozLVrTdsuLtGLP3vEqb/qNzn70pJ5tv9?=
 =?us-ascii?Q?ITGEuml+Mir61piANGfGWKnY1/BEy1Kh1ENfG28gASh5u6iZ6+WwdFxYkVTe?=
 =?us-ascii?Q?tmngLoXQ0LClercgRNXKjHsiybeMFAdHIvBRB7aPU+ivvw4dMll8H15SVGMl?=
 =?us-ascii?Q?ZNI9bQnWbiBwtNvVgtMfJHry1xwcWMs8xDPG35IBeUssqlZhL+HH/FiCkD1N?=
 =?us-ascii?Q?Nfl0PbrT4gOnSBvEGOZle4DIWHIO6t2rVjPusoVVzIsQ6EZHfMTiyvnZtTYf?=
 =?us-ascii?Q?WiWfV4m5yE6ZTeV5TZrdsaMIU2LI0/PWsGV+ccrLzg2b2jf2N1WfNwjFM+AV?=
 =?us-ascii?Q?0GMc1khizdx+UuolcwT41twaKRuk50DB+qytSpXmCOBSVTmMfmT0gNIT00U1?=
 =?us-ascii?Q?wZxi2lol+li+p1Ut9la/gUxSXfsGaJMBDF03EWgfr2teMGe+2nDfc9v0SgyW?=
 =?us-ascii?Q?rSY3yTTbf3HC5gFDzjIS7PL1RL8T5VlDK8Bj25O3yfQcFgZKXVy0klSWRSL1?=
 =?us-ascii?Q?Op5xWl+JSp4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3411a6e1-8a72-4f8b-3998-08da46c92b02
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 07:58:25.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.com>

In prior commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
driver"), move processor thermal register to acpi_pss_perf_init(), and it
won't excute if ACPI_CPU_FREQ_PSS not enabled.

Since ARM64 support P states by CPPC, it should also support processor
passive cooling. So split out the processor thermal cooling register from
ACPI PSS.

Signed-off-by: Riwen Lu <luriwen@kylinos.com>
---
 drivers/acpi/Kconfig            |  2 +-
 drivers/acpi/Makefile           |  5 +-
 drivers/acpi/processor_driver.c | 97 ++++++++++++++-------------------
 include/acpi/processor.h        |  4 +-
 4 files changed, 45 insertions(+), 63 deletions(-)

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
index 368a9edefd0c..c84738a24eca 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -142,8 +142,6 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
 static int acpi_pss_perf_init(struct acpi_processor *pr,
 		struct acpi_device *device)
 {
-	int result = 0;
-
 	acpi_processor_ppc_has_changed(pr, 0);
 
 	acpi_processor_get_throttling_info(pr);
@@ -151,53 +149,7 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
 	if (pr->flags.throttling)
 		pr->flags.limit = 1;
 
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
 	return 0;
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
 static inline int acpi_pss_perf_init(struct acpi_processor *pr,
@@ -205,9 +157,6 @@ static inline int acpi_pss_perf_init(struct acpi_processor *pr,
 {
 	return 0;
 }
-
-static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
-		struct acpi_device *device) {}
 #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
 
 static int __acpi_processor_start(struct acpi_device *device)
@@ -229,9 +178,35 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
-	result = acpi_pss_perf_init(pr, device);
-	if (result)
+	acpi_pss_perf_init(pr, device);
+
+	pr->cdev = thermal_cooling_device_register("Processor", device,
+						   &processor_cooling_ops);
+	if (IS_ERR(pr->cdev)) {
+		result = PTR_ERR(pr->cdev);
 		goto err_power_exit;
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
 
 	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, device);
@@ -239,8 +214,11 @@ static int __acpi_processor_start(struct acpi_device *device)
 		return 0;
 
 	result = -ENODEV;
-	acpi_pss_perf_exit(pr, device);
-
+	sysfs_remove_link(&pr->cdev->device.kobj, "device");
+err_remove_sysfs_thermal:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+err_thermal_unregister:
+	thermal_cooling_device_unregister(pr->cdev);
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
@@ -277,10 +255,15 @@ static int acpi_processor_stop(struct device *dev)
 		return 0;
 	acpi_processor_power_exit(pr);
 
-	acpi_pss_perf_exit(pr, device);
-
 	acpi_cppc_processor_exit(pr);
 
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev = NULL;
+	}
+
 	return 0;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 194027371928..f2d8f0cd1736 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -443,7 +443,7 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
-#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
+#ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
 void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
 #else
@@ -455,6 +455,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
-#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
+#endif /* CONFIG_CPU_FREQ */
 
 #endif
-- 
2.25.1

