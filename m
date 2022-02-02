Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172614A754E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbiBBQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:01 -0500
Received: from foss.arm.com ([217.140.110.172]:39782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbiBBQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:02:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FA7411D4;
        Wed,  2 Feb 2022 08:02:59 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA9433F73B;
        Wed,  2 Feb 2022 08:02:57 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] coresight: Make ETM4x TRCCONFIGR register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:16 +0000
Message-Id: <20220202160226.37858-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220202160226.37858-1-james.clark@arm.com>
References: <20220202160226.37858-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on the
binary produced by gcc-11.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 10 ++--
 .../coresight/coresight-etm4x-sysfs.c         | 46 +++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index afb1b39e3a38..19469546f733 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -633,7 +633,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 
 	/* Go from generic option to ETMv4 specifics */
 	if (attr->config & BIT(ETM_OPT_CYCACC)) {
-		config->cfg |= BIT(4);
+		config->cfg |= TRCCONFIGR_CCI;
 		/* TRM: Must program this for cycacc to work */
 		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
 	}
@@ -653,12 +653,12 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			goto out;
 
 		/* bit[11], Global timestamp tracing bit */
-		config->cfg |= BIT(11);
+		config->cfg |= TRCCONFIGR_TS;
 	}
 
 	if (attr->config & BIT(ETM_OPT_CTXTID))
 		/* bit[6], Context ID tracing bit */
-		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
+		config->cfg |= TRCCONFIGR_CID;
 
 	/*
 	 * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
@@ -670,13 +670,13 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			ret = -EINVAL;
 			goto out;
 		}
-		config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
+		config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
 	}
 
 	/* return stack - enable if selected and supported */
 	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
 		/* bit[12], Return stack enable bit */
-		config->cfg |= BIT(12);
+		config->cfg |= TRCCONFIGR_RS;
 
 	/*
 	 * Set any selected configuration and preset.
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 57e94424a8d6..4c29ab4464a0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -180,12 +180,12 @@ static ssize_t reset_store(struct device *dev,
 
 	/* Disable data tracing: do not trace load and store data transfers */
 	config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
-	config->cfg &= ~(BIT(1) | BIT(2));
+	config->cfg &= ~(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE);
 
 	/* Disable data value and data address tracing */
 	config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
 			   ETM_MODE_DATA_TRACE_VAL);
-	config->cfg &= ~(BIT(16) | BIT(17));
+	config->cfg &= ~(TRCCONFIGR_DA | TRCCONFIGR_DV);
 
 	/* Disable all events tracing */
 	config->eventctrl0 = 0x0;
@@ -304,82 +304,82 @@ static ssize_t mode_store(struct device *dev,
 
 	if (drvdata->instrp0 == true) {
 		/* start by clearing instruction P0 field */
-		config->cfg  &= ~(BIT(1) | BIT(2));
+		config->cfg  &= ~TRCCONFIGR_INSTP0_LOAD_STORE;
 		if (config->mode & ETM_MODE_LOAD)
 			/* 0b01 Trace load instructions as P0 instructions */
-			config->cfg  |= BIT(1);
+			config->cfg  |= TRCCONFIGR_INSTP0_LOAD;
 		if (config->mode & ETM_MODE_STORE)
 			/* 0b10 Trace store instructions as P0 instructions */
-			config->cfg  |= BIT(2);
+			config->cfg  |= TRCCONFIGR_INSTP0_STORE;
 		if (config->mode & ETM_MODE_LOAD_STORE)
 			/*
 			 * 0b11 Trace load and store instructions
 			 * as P0 instructions
 			 */
-			config->cfg  |= BIT(1) | BIT(2);
+			config->cfg  |= TRCCONFIGR_INSTP0_LOAD_STORE;
 	}
 
 	/* bit[3], Branch broadcast mode */
 	if ((config->mode & ETM_MODE_BB) && (drvdata->trcbb == true))
-		config->cfg |= BIT(3);
+		config->cfg |= TRCCONFIGR_BB;
 	else
-		config->cfg &= ~BIT(3);
+		config->cfg &= ~TRCCONFIGR_BB;
 
 	/* bit[4], Cycle counting instruction trace bit */
 	if ((config->mode & ETMv4_MODE_CYCACC) &&
 		(drvdata->trccci == true))
-		config->cfg |= BIT(4);
+		config->cfg |= TRCCONFIGR_CCI;
 	else
-		config->cfg &= ~BIT(4);
+		config->cfg &= ~TRCCONFIGR_CCI;
 
 	/* bit[6], Context ID tracing bit */
 	if ((config->mode & ETMv4_MODE_CTXID) && (drvdata->ctxid_size))
-		config->cfg |= BIT(6);
+		config->cfg |= TRCCONFIGR_CID;
 	else
-		config->cfg &= ~BIT(6);
+		config->cfg &= ~TRCCONFIGR_CID;
 
 	if ((config->mode & ETM_MODE_VMID) && (drvdata->vmid_size))
-		config->cfg |= BIT(7);
+		config->cfg |= TRCCONFIGR_VMID;
 	else
-		config->cfg &= ~BIT(7);
+		config->cfg &= ~TRCCONFIGR_VMID;
 
 	/* bits[10:8], Conditional instruction tracing bit */
 	mode = ETM_MODE_COND(config->mode);
 	if (drvdata->trccond == true) {
-		config->cfg &= ~(BIT(8) | BIT(9) | BIT(10));
-		config->cfg |= mode << 8;
+		config->cfg &= ~(TRCCONFIGR_COND_MASK << TRCCONFIGR_COND_SHIFT);
+		config->cfg |= mode << TRCCONFIGR_COND_SHIFT;
 	}
 
 	/* bit[11], Global timestamp tracing bit */
 	if ((config->mode & ETMv4_MODE_TIMESTAMP) && (drvdata->ts_size))
-		config->cfg |= BIT(11);
+		config->cfg |= TRCCONFIGR_TS;
 	else
-		config->cfg &= ~BIT(11);
+		config->cfg &= ~TRCCONFIGR_TS;
 
 	/* bit[12], Return stack enable bit */
 	if ((config->mode & ETM_MODE_RETURNSTACK) &&
 					(drvdata->retstack == true))
-		config->cfg |= BIT(12);
+		config->cfg |= TRCCONFIGR_RS;
 	else
-		config->cfg &= ~BIT(12);
+		config->cfg &= ~TRCCONFIGR_RS;
 
 	/* bits[14:13], Q element enable field */
 	mode = ETM_MODE_QELEM(config->mode);
 	/* start by clearing QE bits */
-	config->cfg &= ~(BIT(13) | BIT(14));
+	config->cfg &= ~(TRCCONFIGR_QE_W_COUNTS | TRCCONFIGR_QE_WO_COUNTS);
 	/*
 	 * if supported, Q elements with instruction counts are enabled.
 	 * Always set the low bit for any requested mode. Valid combos are
 	 * 0b00, 0b01 and 0b11.
 	 */
 	if (mode && drvdata->q_support)
-		config->cfg |= BIT(13);
+		config->cfg |= TRCCONFIGR_QE_W_COUNTS;
 	/*
 	 * if supported, Q elements with and without instruction
 	 * counts are enabled
 	 */
 	if ((mode & BIT(1)) && (drvdata->q_support & BIT(1)))
-		config->cfg |= BIT(14);
+		config->cfg |= TRCCONFIGR_QE_WO_COUNTS;
 
 	/* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
 	if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ca6ed39ceaf7..55e756020a94 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -194,6 +194,23 @@
 #define TRCIDR5_NUMCNTR_SHIFT			28
 #define TRCIDR5_NUMCNTR_MASK			GENMASK(2, 0)
 
+#define TRCCONFIGR_INSTP0_LOAD			BIT(1)
+#define TRCCONFIGR_INSTP0_STORE			BIT(2)
+#define TRCCONFIGR_INSTP0_LOAD_STORE		(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE)
+#define TRCCONFIGR_BB				BIT(3)
+#define TRCCONFIGR_CCI				BIT(4)
+#define TRCCONFIGR_CID				BIT(6)
+#define TRCCONFIGR_VMID				BIT(7)
+#define TRCCONFIGR_COND_SHIFT			8
+#define TRCCONFIGR_COND_MASK			GENMASK(2, 0)
+#define TRCCONFIGR_TS				BIT(11)
+#define TRCCONFIGR_RS				BIT(12)
+#define TRCCONFIGR_QE_W_COUNTS			BIT(13)
+#define TRCCONFIGR_QE_WO_COUNTS			BIT(14)
+#define TRCCONFIGR_VMIDOPT			BIT(15)
+#define TRCCONFIGR_DA				BIT(16)
+#define TRCCONFIGR_DV				BIT(17)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

