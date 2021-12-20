Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7E47B247
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhLTRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:42:23 -0500
Received: from foss.arm.com ([217.140.110.172]:60398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239737AbhLTRmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:42:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53184ED1;
        Mon, 20 Dec 2021 09:42:19 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164563F774;
        Mon, 20 Dec 2021 09:42:17 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 2/2] hwmon: (scmi) Filter out results wrongly interpreted as negatives
Date:   Mon, 20 Dec 2021 17:41:55 +0000
Message-Id: <20211220174155.40239-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220174155.40239-1-cristian.marussi@arm.com>
References: <20211220174155.40239-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI Sensor scmi_reading_get interface can report only unsigned values
while hwmon_ops.read allows for signed negative values to be passed on:
this has the undesired side effect of silently interpreting as negative
any big-enough positive reading reported by the SCMI interface.

Filter out such big positives reporting an error.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/hwmon/scmi-hwmon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index b1329a58ce40..0924d1b8a9ce 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -73,10 +73,24 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
 
 	sensor = *(scmi_sensors->info[type] + channel);
+	/*
+	 * Can fail with EIO if the backing SCMI Sensor FW version tried to
+	 * report a negative value.
+	 */
 	ret = sensor_ops->reading_get(scmi_sensors->ph, sensor->id, &value);
 	if (ret)
 		return ret;
 
+	/*
+	 * Cannot accept either valid positive values so big that would be
+	 * interpreted as negative by HWMON signed long *val return value.
+	 */
+	if (value & BIT(63)) {
+		dev_warn_once(dev,
+			      "Reported unsigned value too big.\n");
+		return -EIO;
+	}
+
 	ret = scmi_hwmon_scale(sensor, &value);
 	if (!ret)
 		*val = value;
-- 
2.17.1

