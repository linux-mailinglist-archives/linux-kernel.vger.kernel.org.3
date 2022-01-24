Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59E0497CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiAXKEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:04:42 -0500
Received: from foss.arm.com ([217.140.110.172]:56064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237002AbiAXKER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:04:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C582E101E;
        Mon, 24 Jan 2022 02:04:16 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CA93F73B;
        Mon, 24 Jan 2022 02:04:14 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 5/6] [RFC] firmware: arm_scmi: Add support for clock_enable_latency
Date:   Mon, 24 Jan 2022 10:03:40 +0000
Message-Id: <20220124100341.41191-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124100341.41191-1-cristian.marussi@arm.com>
References: <20220124100341.41191-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI platform can optionally advertise an enable latency typically
associated with a specific clock resource: add support for parsing such
optional message field and export sich information in the usual publicly
accessible clock descriptor.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
RFC tag is due to the fact that this SCMI spec Clock protocol field
addition is still to be published.
---
 drivers/firmware/arm_scmi/clock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

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
-- 
2.17.1

