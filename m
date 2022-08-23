Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFED59EA76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiHWSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHWSBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:01:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD5DADCFCA;
        Tue, 23 Aug 2022 09:07:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB94411FB;
        Tue, 23 Aug 2022 09:07:13 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.14.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE3553F718;
        Tue, 23 Aug 2022 09:07:07 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 1/2] coresight: etm4x: Expose default timestamp source in sysfs
Date:   Tue, 23 Aug 2022 17:06:49 +0100
Message-Id: <20220823160650.455823-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220823160650.455823-1-james.clark@arm.com>
References: <20220823160650.455823-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: German Gomez <german.gomez@arm.com>

Add a new sysfs interface in /sys/bus/coresight/devices/etm<N>/ts_source
indicating the configured timestamp source when the ETM device driver
was probed.

The perf tool will use this information to detect if the trace data
timestamp matches the kernel time, enabling correlation of CoreSight
trace with perf events.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/sysreg.h               |  1 +
 .../coresight/coresight-etm4x-sysfs.c         | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7c71358d44c4..7a518a011669 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1021,6 +1021,7 @@
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
 #define TRFCR_ELx_TS_SHIFT		5
+#define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 6ea8181816fc..9cac848cffaf 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2306,6 +2306,34 @@ static ssize_t cpu_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cpu);
 
+static ssize_t ts_source_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	int val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!drvdata->trfcr) {
+		val = -1;
+		goto out;
+	}
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
+out:
+	return sysfs_emit(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(ts_source);
+
 static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_nr_pe_cmp.attr,
 	&dev_attr_nr_addr_cmp.attr,
@@ -2360,6 +2388,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_vmid_val.attr,
 	&dev_attr_vmid_masks.attr,
 	&dev_attr_cpu.attr,
+	&dev_attr_ts_source.attr,
 	NULL,
 };
 
-- 
2.28.0

