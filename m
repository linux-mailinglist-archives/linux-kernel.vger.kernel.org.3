Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3554EC7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbiC3PIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347838AbiC3PIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5F129AE6D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7153215A1;
        Wed, 30 Mar 2022 08:06:38 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22FA83F73B;
        Wed, 30 Mar 2022 08:06:37 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 06/22] firmware: arm_scmi: Make name_get operations return a const
Date:   Wed, 30 Mar 2022 16:05:35 +0100
Message-Id: <20220330150551.2573938-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
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

A few protocol operations are available that returns a pointer to an
internal char array representing resources naming: make those functions
return a const pointer to such array.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/power.c | 5 +++--
 drivers/firmware/arm_scmi/reset.c | 4 ++--
 include/linux/scmi_protocol.h     | 6 ++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 0f0b94f0b624..5c04d63e7ff1 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -174,8 +174,9 @@ static int scmi_power_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
-static char *scmi_power_name_get(const struct scmi_protocol_handle *ph,
-				 u32 domain)
+static const char *
+scmi_power_name_get(const struct scmi_protocol_handle *ph,
+		    u32 domain)
 {
 	struct scmi_power_info *pi = ph->get_priv(ph);
 	struct power_dom_info *dom = pi->dom_info + domain;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 9cdbd133db10..b823a9f64af9 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -126,8 +126,8 @@ static int scmi_reset_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
-static char *scmi_reset_name_get(const struct scmi_protocol_handle *ph,
-				 u32 domain)
+static const char *
+scmi_reset_name_get(const struct scmi_protocol_handle *ph, u32 domain)
 {
 	struct scmi_reset_info *pi = ph->get_priv(ph);
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b87551f41f9f..ced37d1de1fe 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -146,7 +146,8 @@ struct scmi_perf_proto_ops {
  */
 struct scmi_power_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
-	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
+	const char *(*name_get)(const struct scmi_protocol_handle *ph,
+				u32 domain);
 #define SCMI_POWER_STATE_TYPE_SHIFT	30
 #define SCMI_POWER_STATE_ID_MASK	(BIT(28) - 1)
 #define SCMI_POWER_STATE_PARAM(type, id) \
@@ -484,7 +485,8 @@ struct scmi_sensor_proto_ops {
  */
 struct scmi_reset_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
-	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
+	const char *(*name_get)(const struct scmi_protocol_handle *ph,
+				u32 domain);
 	int (*latency_get)(const struct scmi_protocol_handle *ph, u32 domain);
 	int (*reset)(const struct scmi_protocol_handle *ph, u32 domain);
 	int (*assert)(const struct scmi_protocol_handle *ph, u32 domain);
-- 
2.32.0

