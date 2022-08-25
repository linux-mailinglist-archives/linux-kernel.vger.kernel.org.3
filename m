Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46CB5A1860
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbiHYSIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbiHYSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:08:12 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E48BD13C;
        Thu, 25 Aug 2022 11:08:10 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id u14so24257586oie.2;
        Thu, 25 Aug 2022 11:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc;
        bh=tbWJaf7Z6/yVPqCl4RIYma3ZVXVVKCcb3R/w2pBaROw=;
        b=VeCWyV4KqsUupFjRIdnXTmVL9GyVxfKHiWymaRnHyaywvHGq96A7I8FmliGpIF+VQo
         +HsO2DXbxDJwoN2jReBEQ3ogFDAtginWrmE5nLcMXVIQSz6DbJzXqCA/DOei1hvvwV3Y
         gedjgnFWHRugJFLGEIa/J6QlaSK1OJe4YGwO1P5m5OFmy9GIs8pGAr8Apa+6TC/zllAR
         idhpLRWrHeMjL/vGECEqcQBX8PmTb/iGDKsomw9Kz6woElOUVlS9Yz9LknzxTBhKaELj
         kczI/DobYc7Yo0ZQJZZdn22QsRxXo4AT9C3Y3SOKwhiheOv+B5kLTUrZO+H3+wa2eNcT
         WrXg==
X-Gm-Message-State: ACgBeo3Lt0JjWgssWj6g2M0lyDanAPoXub1Pbb+o7ioojwN6QrO/0HOp
        HXnMfyPTecduG+kOWZbhEA==
X-Google-Smtp-Source: AA6agR4Puawz6qVua1NOff23UmBZoicECZLLKq/OJ94mLKhSzLt9JdmYy6nz0D2wj92tYXLExuzQRg==
X-Received: by 2002:a05:6808:11cf:b0:344:f75e:6716 with SMTP id p15-20020a05680811cf00b00344f75e6716mr75808oiv.285.1661450889613;
        Thu, 25 Aug 2022 11:08:09 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t26-20020a0568080b3a00b003434b221a17sm5000231oij.52.2022.08.25.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:08:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 13:08:02 -0500
Subject: [PATCH RFC v1 3/3] perf: arm_spe: Add support for SPEv1.2 inverted event
 filtering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v1-3-c75b8d92e692@kernel.org>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
Filter which excludes samples matching the event filter. The feature
mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
PMSNEVFR_EL1, which has the same event bit assignments.

Signed-off-by: Rob Herring <robh@kernel.org>

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 57904c11aece..9744da888818 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -258,6 +258,7 @@
 #define SYS_PMSIDR_EL1_ARCHINST_SHIFT	3
 #define SYS_PMSIDR_EL1_LDS_SHIFT	4
 #define SYS_PMSIDR_EL1_ERND_SHIFT	5
+#define SYS_PMSIDR_EL1_FNE_SHIFT	6
 #define SYS_PMSIDR_EL1_INTERVAL_SHIFT	8
 #define SYS_PMSIDR_EL1_INTERVAL_MASK	0xfUL
 #define SYS_PMSIDR_EL1_MAXSIZE_SHIFT	12
@@ -302,6 +303,7 @@
 #define SYS_PMSFCR_EL1_FE_SHIFT		0
 #define SYS_PMSFCR_EL1_FT_SHIFT		1
 #define SYS_PMSFCR_EL1_FL_SHIFT		2
+#define SYS_PMSFCR_EL1_FNE_SHIFT	3
 #define SYS_PMSFCR_EL1_B_SHIFT		16
 #define SYS_PMSFCR_EL1_LD_SHIFT		17
 #define SYS_PMSFCR_EL1_ST_SHIFT		18
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index a75b03b5c8f9..724409a88423 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -82,6 +82,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_ARCH_INST			(1UL << 3)
 #define SPE_PMU_FEAT_LDS			(1UL << 4)
 #define SPE_PMU_FEAT_ERND			(1UL << 5)
+#define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -199,6 +200,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_min_latency_LO		0
 #define ATTR_CFG_FLD_min_latency_HI		11
 
+#define ATTR_CFG_FLD_inv_event_filter_CFG	config3	/* PMSNEVFR_EL1 */
+#define ATTR_CFG_FLD_inv_event_filter_LO	0
+#define ATTR_CFG_FLD_inv_event_filter_HI	63
+
 /* Why does everything I do descend into this? */
 #define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
 	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
@@ -229,6 +234,7 @@ GEN_PMU_FORMAT_ATTR(branch_filter);
 GEN_PMU_FORMAT_ATTR(load_filter);
 GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
+GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
@@ -240,12 +246,27 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_load_filter.attr,
 	&format_attr_store_filter.attr,
 	&format_attr_event_filter.attr,
+	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
 	NULL,
 };
 
+static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
+						  struct attribute *attr,
+						  int unused)
+	{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+
+	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group arm_spe_pmu_format_group = {
 	.name	= "format",
+	.is_visible = arm_spe_pmu_format_attr_is_visible,
 	.attrs	= arm_spe_pmu_formats_attr,
 };
 
@@ -341,6 +362,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, event_filter))
 		reg |= BIT(SYS_PMSFCR_EL1_FE_SHIFT);
 
+	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
+		reg |= BIT(SYS_PMSFCR_EL1_FNE_SHIFT);
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= BIT(SYS_PMSFCR_EL1_FL_SHIFT);
 
@@ -353,6 +377,12 @@ static u64 arm_spe_event_to_pmsevfr(struct perf_event *event)
 	return ATTR_CFG_GET_FLD(attr, event_filter);
 }
 
+static u64 arm_spe_event_to_pmsnevfr(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	return ATTR_CFG_GET_FLD(attr, inv_event_filter);
+}
+
 static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
@@ -703,6 +733,9 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -721,6 +754,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
 		return -EOPNOTSUPP;
 
+	if ((reg & BIT(SYS_PMSFCR_EL1_FNE_SHIFT)) &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
+		return -EOPNOTSUPP;
+
 	if ((reg & BIT(SYS_PMSFCR_EL1_FT_SHIFT)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
 		return -EOPNOTSUPP;
@@ -757,6 +794,9 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 	reg = arm_spe_event_to_pmsevfr(event);
 	write_sysreg_s(reg, SYS_PMSEVFR_EL1);
 
+	reg = arm_spe_event_to_pmsnevfr(event);
+	write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -991,6 +1031,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (reg & BIT(SYS_PMSIDR_EL1_FE_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_EVT;
 
+	if (reg & BIT(SYS_PMSIDR_EL1_FNE_SHIFT))
+		spe_pmu->features |= SPE_PMU_FEAT_INV_FILT_EVT;
+
 	if (reg & BIT(SYS_PMSIDR_EL1_FT_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_TYP;
 

-- 
b4 0.10.0-dev
