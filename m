Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3150340A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiDPDBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDPDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5C5A5A0;
        Fri, 15 Apr 2022 19:58:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc2so18110799ejb.12;
        Fri, 15 Apr 2022 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSHfVR0/c9IxnG+fPlU+V/7D4hahUwWehPxXpuEq5Bs=;
        b=JEciVRxdNDD/wYyPZuYjqaTvYxj7Xz4rCmd0HOVUGIU8qdXip7WdGjGpzZS60kErLO
         HfQeDeBfDVP0KiGKRZn+wi6mNvCDCFEdeeblrv+uxA5SCzOj3lzuqR2S5BLyeMOqFZpK
         ETRJuDr2vdqCNQdsp+H4arykPDe+SXfa37l5KzuPZYxSm23F4xHshT3jE8jJFFPtcUuA
         KPbAJdAUepcKQmX6A5IP71QBkng1g1GleT0gKYkm1EoEwBCen65GN3M7ByEhLm81LsgL
         XJUnCzl7OH8GLDjWTDDNq2tKDTEiBZ7j1SBB8G85c4+nzVq7EZstrm2pCISMixyfNQhO
         FWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSHfVR0/c9IxnG+fPlU+V/7D4hahUwWehPxXpuEq5Bs=;
        b=RkBnUSqBERgG21Gzhe33OrmF0yf+jXwV9PiMASDPXZsMPm5yISMDydlWiKG47YO3Mk
         sa1uATkz50sQofnIfpdvSUh9LignHhlkVvKHtHGPJn3lkheUK0/oiTZ65dawIOGtxqBF
         z6eUcdMsPLXxMs7nBEBsdHe5RxshFva9dh9/H5mGJ2KWXoTUWRQDpRk5/YuCCpLoH7lr
         aCJ4qtvTMNCqVDMLQNBqQNfdj95AKXB8Lxs/PPR4xqc/CUUKLajg2Zs/XE6WHaBANN3J
         xNxA2cX6ai8Pj6Au0WgyBd17WAa3X5LJSHH6/4Hm5TCaiSXslnH8keqOGDjekUQ1azhh
         77TQ==
X-Gm-Message-State: AOAM5303/7TPFd4+e3kEte+bJE7E1cOBY2iN9zJu06+fzMfxVZ4JrIpM
        DR2PK46mwLMM7Z44jWgRQDc=
X-Google-Smtp-Source: ABdhPJxAHQeQwu7wGUTVMw8zbXfzilVbmE/1s1cSTH4870BdqYAbNsWmmDA/X0Kp71BBdcU5DQ4gsA==
X-Received: by 2002:a17:907:c13:b0:6e8:c1be:3979 with SMTP id ga19-20020a1709070c1300b006e8c1be3979mr1368051ejc.266.1650077933109;
        Fri, 15 Apr 2022 19:58:53 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:58:52 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 4/9] cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo speedbin
Date:   Sat, 16 Apr 2022 06:56:32 +0400
Message-Id: <20220416025637.83484-5-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8996 and MSM8996 Pro have different OPPs with different dependencies on
CPR and CBF levels. Sharing the same OPP tables will make implementing CPR
and CBF scaling quite difficult, as it will become necessary to use
opp-supported-hw not only to choose CPU OPPs, but to also choose their
required CPR and CBF OPPs which are different on the same CPU OPP between
MSM8996 and MSM8996 Pro. The best solution would be to make a new device
tree for MSM8996 Pro which would override the OPP tables from the existing
MSM8996 device tree.

In preparation for adding a separate device tree for MSM8996 Pro, skip
reading msm-id from smem and just read the speedbin efuse.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/cpufreq/Kconfig.arm          |  1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 75 +++-------------------------
 2 files changed, 6 insertions(+), 70 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 954749afb5fe..7d9798bc5753 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -154,7 +154,6 @@ config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
 	depends on ARCH_QCOM
 	depends on QCOM_QFPROM
-	depends on QCOM_SMEM
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6dfa86971a75..a2b895a930cb 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -9,8 +9,8 @@
  * based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
  * defines the voltage and frequency value based on the msm-id in SMEM
  * and speedbin blown in the efuse combination.
- * The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
- * to provide the OPP framework with required information.
+ * The qcom-cpufreq-nvmem driver reads efuse value from the SoC to provide the
+ * OPP framework with required information.
  * This is used to determine the voltage and frequency value for each OPP of
  * operating-points-v2 table when it is parsed by the OPP framework.
  */
@@ -27,22 +27,6 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
-#include <linux/soc/qcom/smem.h>
-
-#define MSM_ID_SMEM	137
-
-enum _msm_id {
-	MSM8996V3 = 0xF6ul,
-	APQ8096V3 = 0x123ul,
-	MSM8996SG = 0x131ul,
-	APQ8096SG = 0x138ul,
-};
-
-enum _msm8996_version {
-	MSM8996_V3,
-	MSM8996_SG,
-	NUM_OF_MSM8996_VERSIONS,
-};
 
 struct qcom_cpufreq_drv;
 
@@ -142,35 +126,6 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
 	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
 }
 
-static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
-{
-	size_t len;
-	u32 *msm_id;
-	enum _msm8996_version version;
-
-	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
-	if (IS_ERR(msm_id))
-		return NUM_OF_MSM8996_VERSIONS;
-
-	/* The first 4 bytes are format, next to them is the actual msm-id */
-	msm_id++;
-
-	switch ((enum _msm_id)*msm_id) {
-	case MSM8996V3:
-	case APQ8096V3:
-		version = MSM8996_V3;
-		break;
-	case MSM8996SG:
-	case APQ8096SG:
-		version = MSM8996_SG;
-		break;
-	default:
-		version = NUM_OF_MSM8996_VERSIONS;
-	}
-
-	return version;
-}
-
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  char **pvs_name,
@@ -178,30 +133,13 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 {
 	size_t len;
 	u8 *speedbin;
-	enum _msm8996_version msm8996_version;
 	*pvs_name = NULL;
 
-	msm8996_version = qcom_cpufreq_get_msm_id();
-	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
-		dev_err(cpu_dev, "Not Snapdragon 820/821!");
-		return -ENODEV;
-	}
-
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
-	switch (msm8996_version) {
-	case MSM8996_V3:
-		drv->versions = 1 << (unsigned int)(*speedbin);
-		break;
-	case MSM8996_SG:
-		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
-		break;
-	default:
-		BUG();
-		break;
-	}
+	drv->versions = 1 << (unsigned int)(*speedbin);
 
 	kfree(speedbin);
 	return 0;
@@ -464,10 +402,9 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
 
 /*
- * Since the driver depends on smem and nvmem drivers, which may
- * return EPROBE_DEFER, all the real activity is done in the probe,
- * which may be defered as well. The init here is only registering
- * the driver and the platform device.
+ * Since the driver depends on the nvmem driver, which may return EPROBE_DEFER,
+ * all the real activity is done in the probe, which may be defered as well.
+ * The init here is only registering the driver and the platform device.
  */
 static int __init qcom_cpufreq_init(void)
 {
-- 
2.35.1

