Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A5462027
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351876AbhK2TTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:19:52 -0500
Received: from foss.arm.com ([217.140.110.172]:45638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345237AbhK2TRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:17:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6214C1435;
        Mon, 29 Nov 2021 11:12:39 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A963F5A1;
        Mon, 29 Nov 2021 11:12:37 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 05/16] firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
Date:   Mon, 29 Nov 2021 19:11:45 +0000
Message-Id: <20211129191156.29322-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new trace event to mark start of waiting for response section.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- removed atomic flag / poll is enough
- added timeout field
v4 --> v5
- consider atomic_enable flag too
---
 drivers/firmware/arm_scmi/driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9a8d6bfd4ebb..476b91845e40 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -757,6 +757,11 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 	struct device *dev = info->dev;
 	int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
 
+	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
+				      xfer->hdr.protocol_id, xfer->hdr.seq,
+				      timeout_ms,
+				      xfer->hdr.poll_completion);
+
 	if (xfer->hdr.poll_completion) {
 		ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
 
-- 
2.17.1

