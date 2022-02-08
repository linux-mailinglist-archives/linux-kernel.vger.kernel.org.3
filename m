Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783134ADD4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381641AbiBHPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381716AbiBHPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:45:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7C8BC03FEE4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:45:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 664E12B;
        Tue,  8 Feb 2022 07:45:19 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C79F53F73B;
        Tue,  8 Feb 2022 07:45:17 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v3 6/8] firmware: arm_scmi: Add atomic support to clock protocol
Date:   Tue,  8 Feb 2022 15:44:50 +0000
Message-Id: <20220208154452.39428-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208154452.39428-1-cristian.marussi@arm.com>
References: <20220208154452.39428-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new _atomic variant for SCMI clock protocol operations related
to enable disable operations: when an atomic operation is required the xfer
poll_completion flag is set for that transaction.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- removed enable_latency flag in clock_info since it does not belong to
  this commit really
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
index fdf6bd83cc59..306e576835f8 100644
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

