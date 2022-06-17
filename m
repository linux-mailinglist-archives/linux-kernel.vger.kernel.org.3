Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66654EFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379842AbiFQCwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiFQCw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:52:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2028.outbound.protection.outlook.com [40.92.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07265D07;
        Thu, 16 Jun 2022 19:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAxvzVQbHEtv2RITRsmbTAug63kxvsHgC84LIgVS+wdArz5BO2WzHD9tPUF8Nim/rUMU8MCVBsXS89cWCBiGP6A96I2GIggurP/DPAQhdbwJ1Q3PFlbr+3CjKXAr5u30euRB5ruU/qhef7bk7XafSHZQ/rg7G/ujzXgWtD+lipPIg6pFn1CtOHv1PX4Fp2rXIE7jBrcTkbGu7wfY2WhoR2BHy4AZ5IL+8lX+8w2a1mX7JmKffX3c/3azAmI16pWjYsQZQsg66OwH7hyugdyiRhPn0N9UP9KJZ+SCQR+H3U4ikad6ivyTFbwg5TARjo1xF5FKNM0CNUIjjLKJogpcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhAK52IRMPRb2lwe0E+NjOmer60K5Gm8hNJd+mC7mcI=;
 b=RAZvZa8fAWQNFTLlN1bxdx+v+j+BSEC81JVBG+9q1ASkcaldSh5cOiY6AfLfqqNhXuooZqin5TKvOdNPXozPvvLKH8RIZxRxLtlTR8iQV96m9T9CbDQubr4OwjERomED5N0Xc8R8fwnIFcxijzoKyweKCZX47nvSEtNU078kvjiz0FHqgXQUNhBFe5M5gakpC2N10FveAjr6+6huJ93WmyRvKFdPa02cnW0btYL3YCQjFAcEXOR6DZgU52y28V2A5jyJSItUtLyQM1enPcNJgyCfR5yKlKqegw2IlZijlqN16XgucegI3pIGbK+A3wzqprqHaazMYM1t2kgoRzPiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhAK52IRMPRb2lwe0E+NjOmer60K5Gm8hNJd+mC7mcI=;
 b=hqIGS76WvG6Lbs3Xt0dMz8ctcIF7yV/LRGXmxEKQX3UZH3ileFkhyNMAy1teIbqKjpzl4RkQ1ZbDD/f0s5/Wz+OcZyxA4wgXsn+/vM3PmBtXUuZK1I5CF/eDpB+JeV1+d82vx9BvMZFhtzEoBreGuPYQpl8wo8d8KlWpY02BA4A/kHzffth8hIDjAgVx+6AXSZ/OxTBxBRoAsH9yczezg9q4J0LYt6rQoRmvTXzbJ27i869RxlLmhYtsDiNa1wlV1Wk+WrcIcLE/S/fvWcxtfAmAT0DP2Xrb0vmAdEoJCZHm53nc7Yth7uwAoV4Afw8klgkTWd4Lte6+Dqo8j+zsoA==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by TY3P286MB2787.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 17 Jun
 2022 02:52:23 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 02:52:23 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, punit.agrawal@bytedance.com,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v3] ACPI: Split out processor thermal register from ACPI PSS
Date:   Fri, 17 Jun 2022 10:51:51 +0800
Message-ID: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [w9vjkFQxBPK2tHOW9PdXJVld6Q2xouKqY4awsqHZvYM=]
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220617025152.1908638-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d00ed65-c09b-4145-51d0-08da500c675d
X-MS-TrafficTypeDiagnostic: TY3P286MB2787:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sd++05s8pOut3blN6V5dB6hfqQWEYp8JsBS7EQiMRqCb/Z2JFifLElKZwz+nhIznQtvNeuY3pqTRDGq5Ivk00ozq8Wpn2jrRL89OhpN29TT+FeNgVqlfwEmnxUOEEKiVWsDCXs9lGQ2yvt/lD1PqgGDuFWNklwA7s6WFshlbq6rLfwHedLN3FmL6RsXx8AttB/xpea3F8Lgy5OCRAnM3ksvYrVA5eTnQLbxJYLYuBOxudAn3tYshcKTwOHPcMD9c37G88ZJ2QZI+xPx3jftXR1rSw+i9t2uOljc5dZUPW4eQywjFKdnZpzJQkklYSKRhisY3m1DHUwHFvCJffXF9i6KOjWxgxQJV8Rawa3ebalHkBw2ixf2WOO9N0gHpaRMCWJJhYtUobs28XJ3cgeHk4MXjo9CehmSGD246KuUd4S1SpUfpq6lniQJ2P/JhMC17hoch9kN9MdLLwOnpBeqNq1gRIedS5LoIzKUoNILTBxajpBfex2BJ6q/uf/xE2Ws8ej2OOFds1pNd5KFzEUJ+vX1xNK7w3STLM1jcTzCvASf26bnu82b/Pv2JXaVKkpT/6L2oKh4kzBR2qCUWi+XLCA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXt7857kMmbu3j4IKMaopjhEZQIfzWTKnVUH+1wSMygzM7TGnS0sf3NdT869?=
 =?us-ascii?Q?4ARG3ejmpkAjQV5sedlKLQMywCeAjPXC0uxhRcKBFcmM7BhN2Dp/E+mvhN6y?=
 =?us-ascii?Q?92/9yLJB2EK2lUB4UdLHRKQIfeD4lN5M9VIzfyztlwFB5YsN6h3zHVaoOjwL?=
 =?us-ascii?Q?kEkqcFtYSzSjgJi9BwrKm8FMoQhAat2F+5COfwnnh6twNF6Or1bHVDcO9iWk?=
 =?us-ascii?Q?7SFVoe2XDR0nWEI9haOKFzpKh7UyDKSky47nx36qM3E3yuXmB1TVzE16dFTb?=
 =?us-ascii?Q?Bbm48YDJ/cyGlQzvgUl+z5vbnWr1GDE4B7mBZWBWIM5CliUjWsVGMtFGchOH?=
 =?us-ascii?Q?/BjFbIaYdxLtAS2VxTsLOQVVQv7+tM8ggv3Kq6vlwWIaTiSH/txGVNUVk7kp?=
 =?us-ascii?Q?L9m4FnVwAP4GS0FKEDg0Fc3OQUY5CoVuWgwuSsV0rTJnJ9vk7rLar5VUTLFv?=
 =?us-ascii?Q?99rys67Ob7fgvTeVxgFQihD2VrliVeXv8OA8iyYpbhfFAwFER1sJSkGJQCFN?=
 =?us-ascii?Q?LDJixQh9enYt8ZJromFhbB5+vWcSbTvsYGN4kjosDT9E5I0JpjRRrLgJyDpm?=
 =?us-ascii?Q?kahD1wibY2A4J0o+syRmQ5Zm+CUGd8t65sJzxeMsldSatg1blONbHezQzC+8?=
 =?us-ascii?Q?V2j0vW/JKrDmR1NQshPqdJk2BU5NVqnw4TE1KLH46cJImDrjUj94q1Lp/g/a?=
 =?us-ascii?Q?0xnbzEBl42Wkuu3S4RohU3ka9hP+yG9FOfyhhFH1vl9su8NoeiRlVuLHXvr1?=
 =?us-ascii?Q?uygbCFcS7YpIPJsKRhWcjJsXmf7Ew3spX0DXPWxiJWZsUUQs9tubGrGDq+YD?=
 =?us-ascii?Q?yPBw805thEtkelvBJOIgEW+dhw0VeKxGv+Bt8n1FwoM9MZnzWwWqChRo+ac9?=
 =?us-ascii?Q?NLJUgL9fhSyriQB9vHm6ULUyTVjE/pGt8N9YCH+mP4ZhdIBfrQQ8F7GAx25q?=
 =?us-ascii?Q?umF2x2aJdnADEGntfzbpufWO6vMR0YUUEvyj+bcgzJf6zKyhZbdExQKmdsJm?=
 =?us-ascii?Q?+JMW20kWbqFb+11peWvWg+pUdmxzZ9f7FVxO4ZEbdEE29EFYN8N0984ZgtmG?=
 =?us-ascii?Q?mz17F4aBTbYkq+haAA6sm/BSUf9vcaSzIRyETewfp8aOdUu1qDtFNdhFFLzf?=
 =?us-ascii?Q?p+K1x2EJAeYtwuP7tKbqJ67eQWPrhGXp3lW1mdVU+YkWdmCSJvd4n9jpEFML?=
 =?us-ascii?Q?HcQUdNbBATIDeywzC/T1S4l2TfC2ZyqnPj0ZQMNYVRvXjU5d5OQrUSn+cifA?=
 =?us-ascii?Q?MEtxbPK5OdZduQHiX+8h/EzmjMEsvIN2spb7E5Rgv02xcw7BiWfAlnQLt9fJ?=
 =?us-ascii?Q?2mhhrx+dTxbXom0TB5u1Qe1t4eGwRpUfYKFCElsJuVXucRDuHhbYF3KXpKPg?=
 =?us-ascii?Q?YeKeTF4Zu3MQ4X0NDjeD/Qve9yMLB7LDpBkWZj22EkT1m4zNsbFIGwdaJerR?=
 =?us-ascii?Q?0JlJHoRG/t4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d00ed65-c09b-4145-51d0-08da500c675d
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 02:52:23.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2787
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
v1 -> v2:
 - Reword the commit message.
 - Update the signature of acpi_pss_perf_init() to void, and remove the
   acpi_device parameter.
 - Move the processor thermal register/remove into a separate function in
   processor_thermal.c.

v2 -> v3:
 - Remove the "pr" NULL check in processor thermal init/exit fuction.
 - Pass the acpi_device into processor thermal init/exit, and remove the
   convert in it.
---
 drivers/acpi/Kconfig             |  2 +-
 drivers/acpi/Makefile            |  5 +--
 drivers/acpi/processor_driver.c  | 72 ++++----------------------------
 drivers/acpi/processor_thermal.c | 54 ++++++++++++++++++++++++
 include/acpi/processor.h         |  8 +++-
 5 files changed, 71 insertions(+), 70 deletions(-)

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
index 368a9edefd0c..1278969eec1f 100644
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
+	result = acpi_processor_thermal_init(pr, device);
 	if (result)
 		goto err_power_exit;
 
@@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 		return 0;
 
 	result = -ENODEV;
-	acpi_pss_perf_exit(pr, device);
+	acpi_processor_thermal_exit(pr, device);
 
 err_power_exit:
 	acpi_processor_power_exit(pr);
@@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
 		return 0;
 	acpi_processor_power_exit(pr);
 
-	acpi_pss_perf_exit(pr, device);
-
 	acpi_cppc_processor_exit(pr);
 
+	acpi_processor_thermal_exit(pr, device);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index d8b2dfcd59b5..db6ac540e924 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -266,3 +266,57 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
 	.get_cur_state = processor_get_cur_state,
 	.set_cur_state = processor_set_cur_state,
 };
+
+int acpi_processor_thermal_init(struct acpi_processor *pr,
+				struct acpi_device *device)
+{
+	int result = 0;
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
+void acpi_processor_thermal_exit(struct acpi_processor *pr,
+				 struct acpi_device *device)
+{
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev = NULL;
+	}
+}
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 194027371928..ba1e3ed98d3d 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -442,8 +442,12 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
+int acpi_processor_thermal_init(struct acpi_processor *pr,
+				struct acpi_device *device);
+void acpi_processor_thermal_exit(struct acpi_processor *pr,
+				 struct acpi_device *device);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
-#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
+#ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
 void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
 #else
@@ -455,6 +459,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
-#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
+#endif	/* CONFIG_CPU_FREQ */
 
 #endif
-- 
2.25.1

