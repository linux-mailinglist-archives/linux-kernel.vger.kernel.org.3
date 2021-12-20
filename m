Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D747B412
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhLTT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:57:55 -0500
Received: from foss.arm.com ([217.140.110.172]:34648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233320AbhLTT5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9648B1042;
        Mon, 20 Dec 2021 11:57:42 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C8D3F718;
        Mon, 20 Dec 2021 11:57:40 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v8 08/11] firmware: arm_scmi: Add new parameter to mark_txdone
Date:   Mon, 20 Dec 2021 19:56:43 +0000
Message-Id: <20211220195646.44498-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new xfer parameter to mark_txdone transport operation which enables
the SCMI core to optionally pass back into the transport layer a reference
to the xfer descriptor that is being handled.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- use __unused macro for new param in existing transports
---
 drivers/firmware/arm_scmi/common.h  | 3 ++-
 drivers/firmware/arm_scmi/driver.c  | 2 +-
 drivers/firmware/arm_scmi/mailbox.c | 3 ++-
 drivers/firmware/arm_scmi/optee.c   | 3 ++-
 drivers/firmware/arm_scmi/smc.c     | 3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 01d42c2069d4..4fda84bfab42 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -378,7 +378,8 @@ struct scmi_transport_ops {
 	unsigned int (*get_max_msg)(struct scmi_chan_info *base_cinfo);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
-	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
+	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret,
+			    struct scmi_xfer *xfer);
 	void (*fetch_response)(struct scmi_chan_info *cinfo,
 			       struct scmi_xfer *xfer);
 	void (*fetch_notification)(struct scmi_chan_info *cinfo,
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0406e030db1b..b4bbfe89368d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -902,7 +902,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		ret = scmi_to_linux_errno(xfer->hdr.status);
 
 	if (info->desc->ops->mark_txdone)
-		info->desc->ops->mark_txdone(cinfo, ret);
+		info->desc->ops->mark_txdone(cinfo, ret, xfer);
 
 	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
 			    xfer->hdr.protocol_id, xfer->hdr.seq, ret);
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index e09eb12bf421..08ff4d110beb 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -140,7 +140,8 @@ static int mailbox_send_message(struct scmi_chan_info *cinfo,
 	return ret;
 }
 
-static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret)
+static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret,
+				struct scmi_xfer *__unused)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index f460e12be4ea..734f1eeee161 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -441,7 +441,8 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 	shmem_fetch_response(shmem, xfer);
 }
 
-static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret)
+static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
+				   struct scmi_xfer *__unused)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 6c7871a40611..745acfdd0b3d 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -209,7 +209,8 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
 	shmem_fetch_response(scmi_info->shmem, xfer);
 }
 
-static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
+static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
+			    struct scmi_xfer *__unused)
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-- 
2.17.1

