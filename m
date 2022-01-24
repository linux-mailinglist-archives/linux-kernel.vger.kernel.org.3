Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE1497CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiAXKEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:04:39 -0500
Received: from foss.arm.com ([217.140.110.172]:56042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236992AbiAXKEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:04:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE2FD6E;
        Mon, 24 Jan 2022 02:04:14 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CFE13F73B;
        Mon, 24 Jan 2022 02:04:12 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 4/6] firmware: arm_scmi: Add atomic support to clock protocol
Date:   Mon, 24 Jan 2022 10:03:39 +0000
Message-Id: <20220124100341.41191-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124100341.41191-1-cristian.marussi@arm.com>
References: <20220124100341.41191-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new _atomic variant for SCMI clock protocol operations related
to enable disable operations: when an atomic operation is required the xfer
poll_completion flag is set for that transaction.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 22 +++++++++++++++++++---
 include/linux/scmi_protocol.h     |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 35b56c8ba0c0..72f930c0e3e2 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -273,7 +273,7 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
-		      u32 config)
+		      u32 config, bool atomic)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -284,6 +284,8 @@ scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 	if (ret)
 		return ret;
 
+	t->hdr.poll_completion = atomic;
+
 	cfg = t->tx.buf;
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->attributes = cpu_to_le32(config);
@@ -296,12 +298,24 @@ scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 
 static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE);
+	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE, false);
 }
 
 static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	return scmi_clock_config_set(ph, clk_id, 0);
+	return scmi_clock_config_set(ph, clk_id, 0, false);
+}
+
+static int scmi_clock_enable_atomic(const struct scmi_protocol_handle *ph,
+				    u32 clk_id)
+{
+	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE, true);
+}
+
+static int scmi_clock_disable_atomic(const struct scmi_protocol_handle *ph,
+				     u32 clk_id)
+{
+	return scmi_clock_config_set(ph, clk_id, 0, true);
 }
 
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
@@ -330,6 +344,8 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.rate_set = scmi_clock_rate_set,
 	.enable = scmi_clock_enable,
 	.disable = scmi_clock_disable,
+	.enable_atomic = scmi_clock_enable_atomic,
+	.disable_atomic = scmi_clock_disable_atomic,
 };
 
 static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index fdf6bd83cc59..b87551f41f9f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -42,6 +42,7 @@ struct scmi_revision_info {
 
 struct scmi_clock_info {
 	char name[SCMI_MAX_STR_SIZE];
+	unsigned int enable_latency;
 	bool rate_discrete;
 	union {
 		struct {
@@ -82,6 +83,9 @@ struct scmi_clk_proto_ops {
 			u64 rate);
 	int (*enable)(const struct scmi_protocol_handle *ph, u32 clk_id);
 	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id);
+	int (*enable_atomic)(const struct scmi_protocol_handle *ph, u32 clk_id);
+	int (*disable_atomic)(const struct scmi_protocol_handle *ph,
+			      u32 clk_id);
 };
 
 /**
-- 
2.17.1

