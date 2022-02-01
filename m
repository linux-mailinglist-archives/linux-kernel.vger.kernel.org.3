Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E904A6220
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiBARQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:16:50 -0500
Received: from foss.arm.com ([217.140.110.172]:53170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241108AbiBARQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:16:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E42D12FC;
        Tue,  1 Feb 2022 09:16:30 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFCD83F40C;
        Tue,  1 Feb 2022 09:16:28 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 8/9] [RFC] firmware: arm_scmi: Add support for clock_enable_latency
Date:   Tue,  1 Feb 2022 17:16:00 +0000
Message-Id: <20220201171601.53316-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201171601.53316-1-cristian.marussi@arm.com>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI platform can optionally advertise an enable latency typically
associated with a specific clock resource: add support for parsing such
optional message field and export such information in the usual publicly
accessible clock descriptor.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
RFC tag is due to the fact that this SCMI spec Clock protocol field
addition is still to be published.

v1 --> v2
- moved enable_latency flag definition from the previous commit
---
 drivers/firmware/arm_scmi/clock.c | 12 +++++++++---
 include/linux/scmi_protocol.h     |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 72f930c0e3e2..552610bfb91e 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -27,7 +27,8 @@ struct scmi_msg_resp_clock_protocol_attributes {
 struct scmi_msg_resp_clock_attributes {
 	__le32 attributes;
 #define	CLOCK_ENABLE	BIT(0)
-	    u8 name[SCMI_MAX_STR_SIZE];
+	u8 name[SCMI_MAX_STR_SIZE];
+	__le32 clock_enable_latency;
 };
 
 struct scmi_clock_set_config {
@@ -116,10 +117,15 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	attr = t->rx.buf;
 
 	ret = ph->xops->do_xfer(ph, t);
-	if (!ret)
+	if (!ret) {
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
-	else
+		/* TODO Use CLOCK Proto Versioning once SCMI spec is updated */
+		if (t->rx.len > sizeof(attr->attributes) + SCMI_MAX_STR_SIZE)
+			clk->enable_latency =
+				le32_to_cpu(attr->clock_enable_latency);
+	} else {
 		clk->name[0] = '\0';
+	}
 
 	ph->xops->xfer_put(ph, t);
 	return ret;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 306e576835f8..b87551f41f9f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -42,6 +42,7 @@ struct scmi_revision_info {
 
 struct scmi_clock_info {
 	char name[SCMI_MAX_STR_SIZE];
+	unsigned int enable_latency;
 	bool rate_discrete;
 	union {
 		struct {
-- 
2.17.1

