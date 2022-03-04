Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30B4CDA05
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbiCDRUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbiCDRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1062C1516B4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFDE81424;
        Fri,  4 Mar 2022 09:19:37 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28AC93F73D;
        Fri,  4 Mar 2022 09:19:36 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] coresight: etm4x: Cleanup TRCCONFIGR register accesses
Date:   Fri,  4 Mar 2022 17:19:03 +0000
Message-Id: <20220304171913.2292458-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220304171913.2292458-1-james.clark@arm.com>
References: <20220304171913.2292458-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on
the binary output by the compiler. In sysreg.h fields are defined as
the register name followed by the field name and then _MASK. This
allows for grepping for fields by name rather than using magic numbers.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 12 ++---
 .../coresight/coresight-etm4x-sysfs.c         | 46 +++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h | 16 +++++++
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3f4263117570..445e2057d5ed 100644
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
@@ -653,14 +653,14 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			goto out;
 
 		/* bit[11], Global timestamp tracing bit */
-		config->cfg |= BIT(11);
+		config->cfg |= TRCCONFIGR_TS;
 	}
 
 	/* Only trace contextID when runs in root PID namespace */
 	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
 	    task_is_in_init_pid_ns(current))
 		/* bit[6], Context ID tracing bit */
-		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
+		config->cfg |= TRCCONFIGR_CID;
 
 	/*
 	 * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
@@ -672,17 +672,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			ret = -EINVAL;
 			goto out;
 		}
-
 		/* Only trace virtual contextID when runs in root PID namespace */
 		if (task_is_in_init_pid_ns(current))
-			config->cfg |= BIT(ETM4_CFG_BIT_VMID) |
-				       BIT(ETM4_CFG_BIT_VMID_OPT);
+			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
 	}
 
 	/* return stack - enable if selected and supported */
 	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
 		/* bit[12], Return stack enable bit */
-		config->cfg |= BIT(12);
+		config->cfg |= TRCCONFIGR_RS;
 
 	/*
 	 * Set any selected configuration and preset.
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 21687cc1e4e2..53f84da3fe44 100644
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
+		config->cfg &= ~TRCCONFIGR_COND_MASK;
+		config->cfg |= mode << __bf_shf(TRCCONFIGR_COND_MASK);
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
index 3b604cde668b..4c8d7be3c159 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -172,6 +172,22 @@
 #define TRCIDR5_NUMSEQSTATE_MASK		GENMASK(27, 25)
 #define TRCIDR5_NUMCNTR_MASK			GENMASK(30, 28)
 
+#define TRCCONFIGR_INSTP0_LOAD			BIT(1)
+#define TRCCONFIGR_INSTP0_STORE			BIT(2)
+#define TRCCONFIGR_INSTP0_LOAD_STORE		(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE)
+#define TRCCONFIGR_BB				BIT(3)
+#define TRCCONFIGR_CCI				BIT(4)
+#define TRCCONFIGR_CID				BIT(6)
+#define TRCCONFIGR_VMID				BIT(7)
+#define TRCCONFIGR_COND_MASK			GENMASK(10, 8)
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

