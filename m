Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C91557AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiFWMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiFWMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:48:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C707120BF9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:48:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12191570;
        Thu, 23 Jun 2022 05:48:01 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9753F534;
        Thu, 23 Jun 2022 05:48:00 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 3/5] firmware: arm_scmi: Add SCMIv3.1 SystemPower extensions
Date:   Thu, 23 Jun 2022 13:47:40 +0100
Message-Id: <20220623124742.2492164-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220623124742.2492164-1-cristian.marussi@arm.com>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
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

Add support for SCMIv3.1 SystemPower optional timeout field while
dispatching SYSTEM_POWER_STATE_NOTIFIER notification.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/system.c | 17 ++++++++++++++++-
 include/linux/scmi_protocol.h      |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 220e399118ad..9383d7584539 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -27,10 +27,12 @@ struct scmi_system_power_state_notifier_payld {
 	__le32 agent_id;
 	__le32 flags;
 	__le32 system_state;
+	__le32 timeout;
 };
 
 struct scmi_system_info {
 	u32 version;
+	bool graceful_timeout_supported;
 };
 
 static int scmi_system_request_notify(const struct scmi_protocol_handle *ph,
@@ -72,17 +74,27 @@ scmi_system_fill_custom_report(const struct scmi_protocol_handle *ph,
 			       const void *payld, size_t payld_sz,
 			       void *report, u32 *src_id)
 {
+	size_t expected_sz;
 	const struct scmi_system_power_state_notifier_payld *p = payld;
 	struct scmi_system_power_state_notifier_report *r = report;
+	struct scmi_system_info *pinfo = ph->get_priv(ph);
 
+	expected_sz = pinfo->graceful_timeout_supported ?
+			sizeof(*p) : sizeof(*p) - sizeof(__le32);
 	if (evt_id != SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER ||
-	    sizeof(*p) != payld_sz)
+	    payld_sz != expected_sz)
 		return NULL;
 
 	r->timestamp = timestamp;
 	r->agent_id = le32_to_cpu(p->agent_id);
 	r->flags = le32_to_cpu(p->flags);
 	r->system_state = le32_to_cpu(p->system_state);
+	if (pinfo->graceful_timeout_supported &&
+	    r->system_state == SCMI_SYSTEM_SHUTDOWN &&
+	    SCMI_SYSPOWER_IS_REQUEST_GRACEFUL(r->flags))
+		r->timeout = le32_to_cpu(p->timeout);
+	else
+		r->timeout = 0x00;
 	*src_id = 0;
 
 	return r;
@@ -129,6 +141,9 @@ static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 		return -ENOMEM;
 
 	pinfo->version = version;
+	if (PROTOCOL_REV_MAJOR(pinfo->version) >= 0x2)
+		pinfo->graceful_timeout_supported = true;
+
 	return ph->set_priv(ph, pinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a922707bdfe8..37d8603816c2 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -896,8 +896,10 @@ struct scmi_clock_rate_notif_report {
 struct scmi_system_power_state_notifier_report {
 	ktime_t		timestamp;
 	unsigned int	agent_id;
+#define SCMI_SYSPOWER_IS_REQUEST_GRACEFUL(flags)	((flags) & BIT(0))
 	unsigned int	flags;
 	unsigned int	system_state;
+	unsigned int	timeout;
 };
 
 struct scmi_perf_limits_report {
-- 
2.32.0

