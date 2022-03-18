Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0174DDF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiCRQbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiCRQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3872197AF4;
        Fri, 18 Mar 2022 09:29:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ICwIRB029747;
        Fri, 18 Mar 2022 11:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Hmp+e3L+kAYgJdvoCWrLD7ONmV9DbgAsNAh58tdvRMw=;
 b=R1t1xPl0Hzih01vTatT/cMt5BOgywEkq9kPR06DjXwDsSVc3iOYdHveMfrWKF1zq4QXf
 4wOJq+snGqTzvwf7aymZN5Gr8y43Z2FWV2PiEr94z9kTQtJwiEN2knf1vI2cNUu5kc61
 cKfIyHcVWmm4f2dlPDl0PjZ3dRlXmbKx7V2oJMTg5w5Ci1uUTOLrN9VblwymeD4q3npC
 0cadY15HPPIISZyf/ChVEfajR2AR7WVDuvipU4h+GkfthfU1dCFlj04MSsEXKXut3FNC
 5YBPB0rg7VcVkhU981/ab/Jr3F9wMsk7tCjKbvtT/+7Mm+g3f9aUwNJ3HMYxd2namjQM dA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp677a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 11:29:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 16:29:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 16:29:44 +0000
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 786A411D1;
        Fri, 18 Mar 2022 16:29:44 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: soc-utils: Add kunit test for snd_soc_tdm_params_to_bclk()
Date:   Fri, 18 Mar 2022 16:29:41 +0000
Message-ID: <20220318162943.1578102-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318162943.1578102-1-rf@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XGw-lCCx2IB54sRX3b7jkw8u0KfRZa45
X-Proofpoint-GUID: XGw-lCCx2IB54sRX3b7jkw8u0KfRZa45
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new kunit test for soc-utils and use it to test
snd_soc_tdm_params_to_bclk().

The test uses a table of values to avoid the possibility that an
on-the-fly generator contains the same algorithmic error as the
function-under-test and so fails to detect a bug.

There is no need to test every possible combination of values.
Enough test cases are included to give confidence that the function
is producing the correct results.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/Kconfig          |   9 +-
 sound/soc/Makefile         |   5 +
 sound/soc/soc-utils-test.c | 186 +++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/soc-utils-test.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 5dcf77af07af..7d4747b6bab2 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -14,7 +14,7 @@ menuconfig SND_SOC
 
 	  If you want ASoC support, you should say Y here and also to the
 	  specific driver for your SoC platform below.
-	  
+
 	  ASoC provides power efficient ALSA support for embedded battery powered
 	  SoC based systems like PDA's, Phones and Personal Media Players.
 
@@ -55,6 +55,13 @@ config SND_SOC_TOPOLOGY_KUNIT_TEST
 	  userspace applications such as pulseaudio, to prevent unnecessary
 	  problems.
 
+config SND_SOC_UTILS_KUNIT_TEST
+	tristate "KUnit tests for SoC utils"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  If you want to perform tests on ALSA SoC utils library say Y here.
+
 config SND_SOC_ACPI
 	tristate
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index a7b37c06dc43..d4528962ac34 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -12,6 +12,11 @@ ifneq ($(CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST),)
 obj-$(CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST) := soc-topology-test.o
 endif
 
+ifneq ($(CONFIG_SND_SOC_UTILS_KUNIT_TEST),)
+# snd-soc-test-objs := soc-utils-test.o
+obj-$(CONFIG_SND_SOC_UTILS_KUNIT_TEST) := soc-utils-test.o
+endif
+
 ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
 snd-soc-core-objs += soc-generic-dmaengine-pcm.o
 endif
diff --git a/sound/soc/soc-utils-test.c b/sound/soc/soc-utils-test.c
new file mode 100644
index 000000000000..5ad8e23af49a
--- /dev/null
+++ b/sound/soc/soc-utils-test.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <uapi/sound/asound.h>
+
+static const struct {
+	u32 rate;
+	snd_pcm_format_t fmt;
+	u8 channels;
+	u8 tdm_width;
+	u8 tdm_slots;
+	u8 slot_multiple;
+	u32 bclk;
+} tdm_params_to_bclk_cases[] = {
+	/* rate		fmt	   channels tdm_width tdm_slots slot_multiple bclk */
+
+	/* From params only */
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	0,	0,	  128000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	0,	0,	  256000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 1,	0,	0,	0,	  192000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 2,	0,	0,	0,	  384000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	0,	0,	  256000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	0,	0,	  512000 },
+	{  44100,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	0,	0,	  705600 },
+	{  44100,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	0,	0,	 1411200 },
+	{  44100,  SNDRV_PCM_FORMAT_S24_LE, 1,	0,	0,	0,	 1058400 },
+	{  44100,  SNDRV_PCM_FORMAT_S24_LE, 2,	0,	0,	0,	 2116800 },
+	{  44100,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	0,	0,	 1411200 },
+	{  44100,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	0,	0,	 2822400 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	0,	0,	 6144000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	0,	0,	12288000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S24_LE, 1,	0,	0,	0,	 9216000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S24_LE, 2,	0,	0,	0,	18432000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	0,	0,	12288000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	0,	0,	24576000 },
+
+	/* I2S from params */
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	0,	2,	  256000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	0,	2,	  256000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 1,	0,	0,	2,	  384000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 2,	0,	0,	2,	  384000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	0,	2,	  512000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	0,	2,	  512000 },
+	{  44100,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	0,	2,	 1411200 },
+	{  44100,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	0,	2,	 1411200 },
+	{  44100,  SNDRV_PCM_FORMAT_S24_LE, 1,	0,	0,	2,	 2116800 },
+	{  44100,  SNDRV_PCM_FORMAT_S24_LE, 2,	0,	0,	2,	 2116800 },
+	{  44100,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	0,	2,	 2822400 },
+	{  44100,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	0,	2,	 2822400 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	0,	2,	12288000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	0,	2,	12288000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S24_LE, 1,	0,	0,	2,	18432000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S24_LE, 2,	0,	0,	2,	18432000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	0,	2,	24576000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	0,	2,	24576000 },
+
+	/* Fixed 8-slot TDM, other values from params */
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	8,	0,	 1024000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	8,	0,	 1024000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 3,	0,	8,	0,	 1024000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 4,	0,	8,	0,	 1024000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	8,	0,	 2048000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	8,	0,	 2048000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 3,	0,	8,	0,	 2048000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 4,	0,	8,	0,	 2048000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 1,	0,	8,	0,	49152000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 2,	0,	8,	0,	49152000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 3,	0,	8,	0,	49152000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 4,	0,	8,	0,	49152000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 1,	0,	8,	0,	98304000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 2,	0,	8,	0,	98304000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 3,	0,	8,	0,	98304000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 4,	0,	8,	0,	98304000 },
+
+	/* Fixed 32-bit TDM, other values from params */
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 1,	32,	0,	0,	  256000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 2,	32,	0,	0,	  512000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 3,	32,	0,	0,	  768000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 4,	32,	0,	0,	 1024000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 1,	32,	0,	0,	  256000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 2,	32,	0,	0,	  512000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 3,	32,	0,	0,	  768000 },
+	{   8000,  SNDRV_PCM_FORMAT_S32_LE, 4,	32,	0,	0,	 1024000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 1,	32,	0,	0,	12288000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 2,	32,	0,	0,	24576000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 3,	32,	0,	0,	36864000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S16_LE, 4,	32,	0,	0,	49152000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 1,	32,	0,	0,	12288000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 2,	32,	0,	0,	24576000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 3,	32,	0,	0,	36864000 },
+	{ 384000,  SNDRV_PCM_FORMAT_S32_LE, 4,	32,	0,	0,	49152000 },
+
+	/* Fixed 6-slot 24-bit TDM, other values from params */
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 1,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 2,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 3,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S16_LE, 4,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 1,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 2,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 3,	24,	6,	0,	 1152000 },
+	{   8000,  SNDRV_PCM_FORMAT_S24_LE, 4,	24,	6,	0,	 1152000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S16_LE, 1,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S16_LE, 2,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S16_LE, 3,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S16_LE, 4,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S24_LE, 1,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S24_LE, 2,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S24_LE, 3,	24,	6,	0,	27648000 },
+	{ 192000,  SNDRV_PCM_FORMAT_S24_LE, 4,	24,	6,	0,	27648000 },
+};
+
+static void test_tdm_params_to_bclk_one(struct kunit *test,
+					unsigned int rate, snd_pcm_format_t fmt,
+					unsigned int channels,
+					unsigned int tdm_width, unsigned int tdm_slots,
+					unsigned int slot_multiple,
+					unsigned int expected_bclk)
+{
+	struct snd_pcm_hw_params params;
+	int got_bclk;
+
+	_snd_pcm_hw_params_any(&params);
+	snd_mask_none(hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT));
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->min = rate;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->max = rate;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->min = channels;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->max = channels;
+	params_set_format(&params, fmt);
+
+	got_bclk = snd_soc_tdm_params_to_bclk(&params, tdm_width, tdm_slots, slot_multiple);
+	pr_debug("%s: r=%u sb=%u ch=%u tw=%u ts=%u sm=%u expected=%u got=%d\n",
+		 __func__,
+		 rate, params_width(&params), channels, tdm_width, tdm_slots, slot_multiple,
+		 expected_bclk, got_bclk);
+	KUNIT_ASSERT_EQ(test, expected_bclk, (unsigned int)got_bclk);
+}
+
+static void test_tdm_params_to_bclk(struct kunit *test)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tdm_params_to_bclk_cases); ++i) {
+		test_tdm_params_to_bclk_one(test,
+					    tdm_params_to_bclk_cases[i].rate,
+					    tdm_params_to_bclk_cases[i].fmt,
+					    tdm_params_to_bclk_cases[i].channels,
+					    tdm_params_to_bclk_cases[i].tdm_width,
+					    tdm_params_to_bclk_cases[i].tdm_slots,
+					    tdm_params_to_bclk_cases[i].slot_multiple,
+					    tdm_params_to_bclk_cases[i].bclk);
+
+		if (tdm_params_to_bclk_cases[i].slot_multiple > 0)
+			continue;
+
+		/* Slot multiple 1 should have the same effect as multiple 0 */
+		test_tdm_params_to_bclk_one(test,
+					    tdm_params_to_bclk_cases[i].rate,
+					    tdm_params_to_bclk_cases[i].fmt,
+					    tdm_params_to_bclk_cases[i].channels,
+					    tdm_params_to_bclk_cases[i].tdm_width,
+					    tdm_params_to_bclk_cases[i].tdm_slots,
+					    1,
+					    tdm_params_to_bclk_cases[i].bclk);
+	}
+}
+
+static struct kunit_case soc_utils_test_cases[] = {
+	KUNIT_CASE(test_tdm_params_to_bclk),
+	{}
+};
+
+static struct kunit_suite soc_utils_test_suite = {
+	.name = "soc-utils",
+	.test_cases = soc_utils_test_cases,
+};
+
+kunit_test_suites(&soc_utils_test_suite);
+
+MODULE_DESCRIPTION("ASoC soc-utils kunit test");
+MODULE_LICENSE("GPL");
-- 
2.30.2

