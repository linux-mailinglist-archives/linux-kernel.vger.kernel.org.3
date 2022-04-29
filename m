Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED06514962
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359177AbiD2Mem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359269AbiD2Meb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:34:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B731C8BD5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:31:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3ED711FB;
        Fri, 29 Apr 2022 05:31:12 -0700 (PDT)
Received: from e127744.arm.com (unknown [10.57.46.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D40B3F73B;
        Fri, 29 Apr 2022 05:31:10 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com
Cc:     james.clark@arm.com, leo.yan@linaro.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        German Gomez <german.gomez@arm.com>
Subject: [PATCH 1/2] coresight: etm4x: Expose default timestamp source in sysfs
Date:   Fri, 29 Apr 2022 13:30:59 +0100
Message-Id: <20220429123100.268059-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429123100.268059-1-german.gomez@arm.com>
References: <20220429123100.268059-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysfs interface in /sys/bus/coresight/devices/etm<N>/ts_source
indicating the configured timestamp source when the ETM device driver
was probed.

The perf tool will use this information to detect if the trace data
timestamp matches the kernel time, enabling correlation of CoreSight
trace with perf events.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 arch/arm64/include/asm/sysreg.h               |  1 +
 .../coresight/coresight-etm4x-sysfs.c         | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 38508e507d73a..263a7bee06f9a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1146,6 +1146,7 @@
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
 #define TRFCR_ELx_TS_SHIFT		5
+#define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0640fa5c55bd..c0c375c0cfde2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2264,6 +2264,39 @@ static ssize_t cpu_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cpu);
 
+static int etmv4_to_ts_source(struct etmv4_drvdata *drvdata)
+{
+	int val;
+
+	if (!drvdata->trfcr)
+		return -1;
+
+	switch (drvdata->trfcr & TRFCR_ELx_TS_MASK) {
+	case TRFCR_ELx_TS_VIRTUAL:
+	case TRFCR_ELx_TS_GUEST_PHYSICAL:
+	case TRFCR_ELx_TS_PHYSICAL:
+		val = FIELD_GET(TRFCR_ELx_TS_MASK, drvdata->trfcr);
+		break;
+	default:
+		val = -1;
+		break;
+	}
+
+	return val;
+}
+
+static ssize_t ts_source_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	int val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	val = etmv4_to_ts_source(drvdata);
+	return sysfs_emit(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(ts_source);
+
 static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_nr_pe_cmp.attr,
 	&dev_attr_nr_addr_cmp.attr,
@@ -2318,6 +2351,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_vmid_val.attr,
 	&dev_attr_vmid_masks.attr,
 	&dev_attr_cpu.attr,
+	&dev_attr_ts_source.attr,
 	NULL,
 };
 
-- 
2.25.1

