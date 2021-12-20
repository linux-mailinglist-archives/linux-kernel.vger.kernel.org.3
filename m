Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6647B246
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhLTRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:42:20 -0500
Received: from foss.arm.com ([217.140.110.172]:60388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233373AbhLTRmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:42:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5676D6E;
        Mon, 20 Dec 2021 09:42:17 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DB363F774;
        Mon, 20 Dec 2021 09:42:16 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 1/2] firmware: arm_scmi: Filter out negative results on scmi_reading_get
Date:   Mon, 20 Dec 2021 17:41:54 +0000
Message-Id: <20211220174155.40239-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220174155.40239-1-cristian.marussi@arm.com>
References: <20211220174155.40239-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the backing SCMI Platform supports a Sensor protocol whose version is
greater than SCMI v2.0 (0x10000), the underlying SCMI SENSOR_READING_GET
command will report sensors readings no more as unsigned but as signed
values.

A new scmi_reading_get_timestamped operation was added to properly handle
this and other changes like timestamps and multi-axis sensors; on the other
side the Sensor scmi_reading_get protocol operation was kepts as it was for
backward compatibility and so it stil reports values as unsigned, but no
check was added to detect the situation in which a newer FW could try to
report negative values over an unsigned quantity.

Filter out negative values in scmi_reading_get, reporting an error, when
the SCMI FW version is greater than V2.0 and a negative value has been
received.

Reported-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that, till now, HWMON SCMI driver was silently interpreting u64 as
s64, so after this change whenever a FW >2.0 is used it won't be possible
anymore to report negative values in HWMON.
---
 drivers/firmware/arm_scmi/sensors.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index cdbb287bd8bc..f3952f1d9f61 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -730,6 +730,14 @@ static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 			*value = get_unaligned_le64(t->rx.buf);
 	}
 
+	if (!ret && si->version > SCMIv2_SENSOR_PROTOCOL && *value & BIT(63)) {
+		dev_warn_once(ph->dev,
+			      "SCMI FW Sensor version:0x%X reported negative value %ld\n",
+			      si->version, (long)*value);
+		*value = 0;
+		ret = -EIO;
+	}
+
 	ph->xops->xfer_put(ph, t);
 	return ret;
 }
-- 
2.17.1

