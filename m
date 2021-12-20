Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8647B416
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhLTT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:58:14 -0500
Received: from foss.arm.com ([217.140.110.172]:34682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233497AbhLTT5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD372D6E;
        Mon, 20 Dec 2021 11:57:46 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82CCB3F718;
        Mon, 20 Dec 2021 11:57:45 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v8 10/11] firmware: arm_scmi: Add atomic support to clock protocol
Date:   Mon, 20 Dec 2021 19:56:45 +0000
Message-Id: <20211220195646.44498-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new _atomic variant for SCMI clock protocol operations related
to enable disable operations: when an atomic operation is required the xfer
poll_completion flag is set for that transaction.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 22 +++++++++++++++++++---
 include/linux/scmi_protocol.h     |  3 +++
 2 files changed, 22 insertions(+), 3 deletions(-)

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
index 9f895cb81818..d4971c991963 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -82,6 +82,9 @@ struct scmi_clk_proto_ops {
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

