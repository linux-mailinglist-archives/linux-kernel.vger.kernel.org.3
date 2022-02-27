Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC334C5EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiB0U5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiB0U5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 811482FFE7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D90811FB;
        Sun, 27 Feb 2022 12:56:25 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4B5D3F66F;
        Sun, 27 Feb 2022 12:56:23 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 02/16] firmware: arm_scmi: Make protocols init fail on basic errors
Date:   Sun, 27 Feb 2022 20:55:54 +0000
Message-Id: <20220227205608.30812-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bail out of protocol initialization routine early when basic information
about protocol version and attributes could not be retrieved: failing to
act this way can lead to a successfully initialized SCMI protocol which
is in fact not functional.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  5 ++++-
 drivers/firmware/arm_scmi/clock.c   |  8 ++++++--
 drivers/firmware/arm_scmi/perf.c    | 10 +++++++---
 drivers/firmware/arm_scmi/power.c   | 10 +++++++---
 drivers/firmware/arm_scmi/reset.c   | 10 +++++++---
 drivers/firmware/arm_scmi/sensors.c |  4 +++-
 drivers/firmware/arm_scmi/system.c  |  5 ++++-
 7 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index f5219334fd3a..ebaef5d320af 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -359,7 +359,10 @@ static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 	rev->minor_ver = PROTOCOL_REV_MINOR(version);
 	ph->set_priv(ph, rev);
 
-	scmi_base_attributes_get(ph);
+	ret = scmi_base_attributes_get(ph);
+	if (ret)
+		return ret;
+
 	scmi_base_vendor_id_get(ph, false);
 	scmi_base_vendor_id_get(ph, true);
 	scmi_base_implementation_version_get(ph);
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index cf6fed6dec77..e2059d2025a2 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -360,7 +360,9 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	int clkid, ret;
 	struct clock_info *cinfo;
 
-	ph->xops->version_get(ph, &version);
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
 
 	dev_dbg(ph->dev, "Clock Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -369,7 +371,9 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!cinfo)
 		return -ENOMEM;
 
-	scmi_clock_protocol_attributes_get(ph, cinfo);
+	ret = scmi_clock_protocol_attributes_get(ph, cinfo);
+	if (ret)
+		return ret;
 
 	cinfo->clk = devm_kcalloc(ph->dev, cinfo->num_clocks,
 				  sizeof(*cinfo->clk), GFP_KERNEL);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index f4cd5193b961..e9f68b91580c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -873,11 +873,13 @@ static const struct scmi_protocol_events perf_protocol_events = {
 
 static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 {
-	int domain;
+	int domain, ret;
 	u32 version;
 	struct scmi_perf_info *pinfo;
 
-	ph->xops->version_get(ph, &version);
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
 
 	dev_dbg(ph->dev, "Performance Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -886,7 +888,9 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_perf_attributes_get(ph, pinfo);
+	ret = scmi_perf_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
 
 	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index ad2ab080f344..0f0b94f0b624 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -280,11 +280,13 @@ static const struct scmi_protocol_events power_protocol_events = {
 
 static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 {
-	int domain;
+	int domain, ret;
 	u32 version;
 	struct scmi_power_info *pinfo;
 
-	ph->xops->version_get(ph, &version);
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
 
 	dev_dbg(ph->dev, "Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -293,7 +295,9 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_power_attributes_get(ph, pinfo);
+	ret = scmi_power_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
 
 	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 9bf2478ec6d1..9cdbd133db10 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -293,11 +293,13 @@ static const struct scmi_protocol_events reset_protocol_events = {
 
 static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 {
-	int domain;
+	int domain, ret;
 	u32 version;
 	struct scmi_reset_info *pinfo;
 
-	ph->xops->version_get(ph, &version);
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
 
 	dev_dbg(ph->dev, "Reset Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -306,7 +308,9 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_reset_attributes_get(ph, pinfo);
+	ret = scmi_reset_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
 
 	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index cdbb287bd8bc..f37ac9824a87 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -966,7 +966,9 @@ static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 	int ret;
 	struct sensors_info *sinfo;
 
-	ph->xops->version_get(ph, &version);
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
 
 	dev_dbg(ph->dev, "Sensor Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index e5175ef73b40..cbfc19f7a463 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -113,10 +113,13 @@ static const struct scmi_protocol_events system_protocol_events = {
 
 static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 {
+	int ret;
 	u32 version;
 	struct scmi_system_info *pinfo;
 
-	ph->xops->version_get(ph, &version);
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
 
 	dev_dbg(ph->dev, "System Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
-- 
2.17.1

